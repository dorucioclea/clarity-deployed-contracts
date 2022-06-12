;; A multi-signature wallet

(use-trait executor-trait .traits.executor-trait)
(use-trait wallet-trait .traits.wallet-trait)

(impl-trait .traits.wallet-trait)

;; errors
(define-constant ERR-CALLER-MUST-BE-SELF (err u100))
(define-constant ERR-OWNER-ALREADY-EXISTS (err u110))
(define-constant ERR-OWNER-NOT-EXISTS (err u120))
(define-constant ERR-UNAUTHORIZED-SENDER (err u130))
(define-constant ERR-TX-NOT-FOUND (err u140))
(define-constant ERR-TX-ALREADY-CONFIRMED-BY-OWNER (err u150))
(define-constant ERR-TX-INVALID-EXECUTOR (err u160))
(define-constant ERR-INVALID-WALLET (err u170))
(define-constant ERR-TX-CONFIRMED (err u180))
(define-constant ERR-TX-NOT-CONFIRMED-BY-SENDER (err u190))

;; version
(define-constant VERSION "0.0.1.alpha")

(define-read-only (get-version)
    VERSION
)

;; principal of the deployed contract
(define-constant self (as-contract tx-sender))


;; owners
(define-data-var owners (list 50 principal) (list))

(define-read-only (get-owners)
    (var-get owners)
)

(define-read-only (is-validator (validator principal))
    (is-some (index-of (var-get owners) validator))
)

(define-private (add-owner-internal (owner principal))
    (var-set owners (unwrap-panic (as-max-len? (append (var-get owners) owner) u50)))
)

(define-public (add-owner (owner principal))
    (begin
        (asserts! (is-eq tx-sender self) ERR-CALLER-MUST-BE-SELF)
        (asserts! (is-none (index-of (var-get owners) owner)) ERR-OWNER-ALREADY-EXISTS)
        (ok (add-owner-internal owner))
    )
)

(define-data-var rem-owner principal tx-sender)

(define-private (remove-owner-filter (o principal)) (not (is-eq o (var-get rem-owner))))

(define-public (remove-owner (owner principal))
    (begin
        (asserts! (is-eq tx-sender self) ERR-CALLER-MUST-BE-SELF)
        (asserts! (not ( is-none (index-of (var-get owners) owner) )) ERR-OWNER-NOT-EXISTS)
        (var-set rem-owner owner)
        (ok (var-set owners (unwrap-panic (as-max-len? (filter remove-owner-filter (var-get owners)) u50))))
    )
)


;; minimum confirmation requirement
(define-data-var min-confirmation uint u0)

(define-read-only (get-min-confirmation)
    (var-get min-confirmation)
)

(define-private (set-min-confirmation-internal (value uint))
    (var-set min-confirmation value)
)

(define-public (set-min-confirmation (value uint))
    (begin
        (asserts! (is-eq tx-sender self) ERR-CALLER-MUST-BE-SELF)
        (ok (set-min-confirmation-internal value))
    )
)

;; nonce
(define-data-var nonce uint u0)

(define-read-only (get-nonce)
    (var-get nonce)
)

(define-private (increase-nonce)
    (var-set nonce (+ (var-get nonce) u1))
)

;; transactions
(define-map transactions
    uint
    {
        executor: principal,
        confirmations: (list 50 principal),
        confirmed: bool,
        arg-p: principal,
        arg-u: uint,
        arg-buff: (buff 256),
        arg-bool: bool
    }
)

(define-private (add (executor <executor-trait>) (arg-p principal) (arg-u uint) (arg-buff (buff 256)) (arg-bool bool))
    (let
        (
            (tx-id (get-nonce))
        )
        (map-insert transactions tx-id {executor: (contract-of executor), confirmations: (list), confirmed: false, arg-p: arg-p, arg-u: arg-u, arg-buff: arg-buff, arg-bool: arg-bool})
        (increase-nonce)
        tx-id
    )
)

(define-read-only (get-transaction (tx-id uint))
    (unwrap-panic (map-get? transactions tx-id))
)

(define-read-only (get-transactions (tx-ids (list 20 uint)))
    (map get-transaction tx-ids)
)

(define-data-var rem-confirmation principal tx-sender)

(define-private (remove-confirmation-filter (o principal)) (not (is-eq o (var-get rem-confirmation))))

(define-public (revoke (tx-id uint))
    (let
        (
            (tx (unwrap! (map-get? transactions tx-id) ERR-TX-NOT-FOUND))
            (confirmations (get confirmations tx))
        )
        (asserts! (is-eq (get confirmed tx) false) ERR-TX-CONFIRMED)
        (asserts! (is-some (index-of confirmations contract-caller)) ERR-TX-NOT-CONFIRMED-BY-SENDER)
        (var-set rem-confirmation contract-caller)
        (let
            (
                (new-confirmations  (unwrap-panic (as-max-len? (filter remove-confirmation-filter confirmations) u50)))
                (new-tx (merge tx {confirmations: new-confirmations}))
            )
            (map-set transactions tx-id new-tx)
            (ok true)
        )
    )
)

(define-public (confirm (tx-id uint) (executor <executor-trait>) (wallet <wallet-trait>))
    (begin
        (asserts! (is-some (index-of (var-get owners) contract-caller)) ERR-UNAUTHORIZED-SENDER)
        (asserts! (is-eq (contract-of wallet) self) ERR-INVALID-WALLET)
        (let
            (
                (tx (unwrap! (map-get? transactions tx-id) ERR-TX-NOT-FOUND))
                (confirmations (get confirmations tx))
            )

            (asserts! (is-none (index-of confirmations contract-caller)) ERR-TX-ALREADY-CONFIRMED-BY-OWNER)
            (asserts! (is-eq (get executor tx) (contract-of executor)) ERR-TX-INVALID-EXECUTOR)

            (let
                (
                    (new-confirmations (unwrap-panic (as-max-len? (append confirmations contract-caller) u50)))
                    (confirmed (>= (len new-confirmations) (var-get min-confirmation)))
                    (new-tx (merge tx {confirmations: new-confirmations, confirmed: confirmed}))
                )
                (map-set transactions tx-id new-tx)
                (if confirmed
                    (try! (as-contract (contract-call? executor execute wallet (get arg-p tx) (get arg-u tx) (get arg-buff tx) (get arg-bool tx))))
                    false
                )
                (ok confirmed)
            )
        )
    )
)

(define-public (submit (executor <executor-trait>) (wallet <wallet-trait>) (arg-p principal) (arg-u uint) (arg-buff (buff 256)) (arg-bool bool))
    (begin
        (asserts! (is-some (index-of (var-get owners) contract-caller)) ERR-UNAUTHORIZED-SENDER)
        (asserts! (is-eq (contract-of wallet) self) ERR-INVALID-WALLET)
        (let
            ((tx-id (add executor arg-p arg-u arg-buff arg-bool)))
            (unwrap-panic (confirm tx-id executor wallet))
            (ok tx-id)
        )
    )
)

;; bridge
(define-map valid-chain (buff 256) bool)

(define-read-only (is-valid-chain (chain (buff 256)))
    (unwrap! (map-get? valid-chain chain) false)
)

(define-private (set-valid-chain-internal (chain (buff 256)) (valid bool))
    (map-set valid-chain chain valid)
)

(define-public (set-valid-chain (chain (buff 256)) (valid bool))
    (begin
        (asserts! (is-eq tx-sender self) ERR-CALLER-MUST-BE-SELF)
        (ok (set-valid-chain-internal chain valid))
    )
)

;; init
(define-private (init (o (list 50 principal)) (m uint))
    (begin
        (map add-owner-internal o)
        (set-min-confirmation-internal m)
    )
)

;; TODO : validator list
(init (list
    'STF5P8H4XN3P2CD9CWDVA0BSG0S088GTSG7GNYHF
    'ST2GBPSY9VN3K9PX0KJ2PCKB13FW1D1NE548DHNRW
) u2)

(set-valid-chain-internal 0x455448 true) ;; ETH
(set-valid-chain-internal 0x4b4c4159544e true) ;; KLAYTN
(set-valid-chain-internal 0x4d41544943 true) ;; MATIC