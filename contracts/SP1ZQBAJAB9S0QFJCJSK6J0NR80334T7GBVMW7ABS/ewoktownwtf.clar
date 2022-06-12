(impl-trait 'SP2PABAF9FTAJYNFZH93XENAJ8FVY99RRM50D2JG9.nft-trait.nft-trait) ;; for mainnet
;; (impl-trait .nft-trait.nft-trait)
(use-trait commission-trait 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.commission-trait.commission) ;; for mainnet
;; (use-trait commission-trait .commission-trait.commission)

(define-non-fungible-token ewoktownwtf uint)

;; Storage
(define-map token-count principal uint)
(define-map market uint {price: uint, commission: principal})
(define-map private-presale-count principal uint)
(define-map public-sale-count principal uint)

;; Define Constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-SOLD-OUT (err u300))
(define-constant ERR-WRONG-COMMISSION (err u301))
(define-constant ERR-INSUFFICIENT-FUNDS (err u400))
(define-constant ERR-NOT-AUTHORIZED (err u401))
(define-constant ERR-NOT-FOUND (err u404))
(define-constant ERR-SALE-NOT-ACTIVE (err u500))
(define-constant ERR-NO-MINTPASS-REMAINING (err u501))
(define-constant ERR-METADATA-FROZEN (err u505))
(define-constant ERR-MINT-ALREADY-SET (err u506))
(define-constant ERR-LISTING (err u507))
(define-constant ERR-ONE-MINT-PER-WALLET (err u508))
(define-constant ERR-BEFORE-MINT-TIME (err u509))
(define-constant ERR-AFTER-MINT-TIME (err u510))
(define-constant MINT-LIMIT u7)

;; Define Variables
(define-data-var last-id uint u0)
(define-data-var metadata-frozen bool false)
(define-data-var base-uri (string-ascii 100) "ipfs://QmerJH2Tg5grovimhGmgAcGiThWNRKgtT3NkBXiamdghZy/")
(define-data-var contract-uri (string-ascii 100) "ipfs://placeholder")

(define-data-var commission-percentage uint u1000) 
(define-data-var commission-address principal 'SP7NW9XVEG45SW1367SAHHZG67BFA4GMA9DVGZ0F)
(define-data-var royalty (list 1000 uint) (list u1800 u1800 u1800 u1800 u1800 ))
(define-data-var artist-address (list 1000 principal) (list 'SP1VZ743H2Y4K983JNN4DE13BB6410A7R8N16WAXF 'SP1ZQBAJAB9S0QFJCJSK6J0NR80334T7GBVMW7ABS 'SP312R8WPKAGF3E5WJ7YHMFP8EDF1E3NJEZ11NB8J 'SP7NNN9PRQ0E0JDACV74F6TBKXY3476QEWRXAP3B 'SP218P6TAB7GXHV6G43GZM42NSXFHR6YB9VKC43XV )) 

(define-data-var private-sale-active bool true)
(define-data-var sale-active bool true)
(define-data-var private-target-block-height uint u1000000000000000)
(define-data-var public-target-block-height uint u65924)
(define-data-var admin principal tx-sender)

(define-data-var stx-cost-per-mint uint u420690000)
;; Get mint limit
(define-read-only (get-mint-limit)
  MINT-LIMIT
)

;; Token count for account
(define-read-only (get-balance (account principal))
  (default-to u0
    (map-get? token-count account)))

(define-private (trnsfr (id uint) (sender principal) (recipient principal))
  (match (nft-transfer? ewoktownwtf id sender recipient)
        success
          (let
            ((sender-balance (get-balance sender))
            (recipient-balance (get-balance recipient)))
              (map-set token-count
                    sender
                    (- sender-balance u1))
              (map-set token-count
                    recipient
                    (+ recipient-balance u1))
              (ok success))
        error (err error)))

;; SIP009: Transfer token to a specified principal
(define-public (transfer (id uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) ERR-NOT-AUTHORIZED)
    (asserts! (is-none (map-get? market id)) ERR-LISTING)
    (trnsfr id sender recipient)))

;; SIP009: Get the owner of the specified token ID
(define-read-only (get-owner (id uint))
  ;; Make sure to replace ewoktownwtf
  (ok (nft-get-owner? ewoktownwtf id)))

;; SIP009: Get the last token ID
(define-read-only (get-last-token-id)
    (ok (var-get last-id))
)

;; SIP009: Get the token URI. You can set it to any other URI
(define-read-only (get-token-uri (token-id uint))
  (if (< token-id u5001)
    (ok (some (concat (concat (var-get base-uri) (unwrap-panic (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.conversion lookup token-id))) ".json")))
    (ok (some (concat (concat (var-get base-uri) (unwrap-panic (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.conversion-v2 lookup (- token-id u5001)))) ".json")))
    )
)

(define-read-only (get-contract-uri)
  (ok (var-get contract-uri)))

;; Mint new NFT
;; can only be called from the Mint
(define-private (mint (new-owner principal))
    (let (
        (next-id (+ u1 (var-get last-id)))
    )
      (asserts! (< (var-get last-id) MINT-LIMIT) ERR-SOLD-OUT)
      (match (nft-mint? ewoktownwtf next-id new-owner)
        success
        (let
        ((current-balance (get-balance new-owner)))
          (begin
            ;; (print payout)
            (try! (payout-all))
            (var-set last-id next-id)
            (map-set token-count
              new-owner
              (+ current-balance u1)
            )
            (ok true)))
        error (err (* error u10000)))))

(define-private (payout-all)
  (let (
    (price (var-get stx-cost-per-mint))
    (commission-amount (/ (* price (var-get commission-percentage)) u10000))
    (price-list (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.uint-lists lookup price (len (var-get royalty))))
    (divider-list (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.uint-lists lookup u10000 (len (var-get royalty))))
    (royalty-amounts (map * (var-get royalty) price-list))
    (payout-amounts (map / royalty-amounts divider-list))
  )
    (asserts! (>= (stx-get-balance tx-sender) price) ERR-INSUFFICIENT-FUNDS)
    (try! (stx-transfer? commission-amount tx-sender (var-get commission-address)))
    (map payout (var-get artist-address) payout-amounts)
    (ok payout-amounts)
  )
)

(define-private (payout (receiver principal) (amount uint))
  (stx-transfer? amount tx-sender receiver)
)

(define-public (burn (id uint) (owner principal))
    (let (
        (token-owner (unwrap-panic (unwrap-panic (get-owner id))))
    )
    (asserts! (is-none (map-get? market id)) ERR-LISTING)
    (asserts! (is-eq tx-sender owner) ERR-NOT-AUTHORIZED)
    (asserts! (is-eq tx-sender token-owner) ERR-NOT-AUTHORIZED)
    (match (nft-burn? ewoktownwtf id owner)
        success
        (let
        ((current-balance (get-balance owner)))
          (begin
            (map-set token-count
              owner
              (- current-balance u1)
            )
            (ok true)))
        error (err (* error u10000)))
    )
)

(define-private (is-sender-owner (id uint))
  (let ((owner (unwrap! (nft-get-owner? ewoktownwtf id) false)))
    (or (is-eq tx-sender owner) (is-eq contract-caller owner))))

(define-read-only (get-listing-in-ustx (id uint))
  (map-get? market id))

(define-public (list-in-ustx (id uint) (price uint) (comm <commission-trait>))
  (let ((listing  {price: price, commission: (contract-of comm)}))
    (asserts! (is-sender-owner id) ERR-NOT-AUTHORIZED)
    (map-set market id listing)
    (print (merge listing {a: "list-in-ustx", id: id}))
    (ok true)))

(define-public (unlist-in-ustx (id uint))
  (begin
    (asserts! (is-sender-owner id) ERR-NOT-AUTHORIZED)
    (map-delete market id)
    (print {a: "unlist-in-ustx", id: id})
    (ok true)))

(define-public (buy-in-ustx (id uint) (comm <commission-trait>))
  (let ((owner (unwrap! (nft-get-owner? ewoktownwtf id) ERR-NOT-FOUND))
      (listing (unwrap! (map-get? market id) ERR-LISTING))
      (price (get price listing)))
    (asserts! (is-eq (contract-of comm) (get commission listing)) ERR-WRONG-COMMISSION)
    (try! (stx-transfer? price tx-sender owner))
    (try! (contract-call? comm pay id price))
    (try! (trnsfr id owner tx-sender))
    (map-delete market id)
    (print {a: "buy-in-ustx", id: id})
    (ok true)))

;; Set base uri
(define-public (set-base-uri (new-base-uri (string-ascii 100)))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) ERR-NOT-AUTHORIZED)
    (asserts! (not (var-get metadata-frozen)) ERR-METADATA-FROZEN)
    (var-set base-uri new-base-uri)
    (ok true)))

;; Set contract uri
(define-public (set-contract-uri (new-contract-uri (string-ascii 100)))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) ERR-NOT-AUTHORIZED)
    (asserts! (not (var-get metadata-frozen)) ERR-METADATA-FROZEN)
    (var-set contract-uri new-contract-uri)
    (ok true))
)

;; Freeze metadata
(define-public (freeze-metadata)
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) ERR-NOT-AUTHORIZED)
    (var-set metadata-frozen true)
    (ok true)))

(define-public (set-stx-cost (amount uint))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) ERR-NOT-AUTHORIZED)
    (var-set stx-cost-per-mint amount)
    (ok true)))

(define-public (set-artist-addresses (addresses (list 1000 principal)))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) ERR-NOT-AUTHORIZED)
    (var-set artist-address addresses)
    (ok true)))

(define-public (set-royalties (royalties (list 1000 uint)))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) ERR-NOT-AUTHORIZED)
    (var-set royalty royalties)
    (ok true)))

(define-public (set-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) ERR-NOT-AUTHORIZED)
    (var-set admin new-admin)
    (ok true)
  )
)

(define-private (not-live)
  (begin
    (asserts! (var-get sale-active) ERR-SALE-NOT-ACTIVE)
    (asserts! (var-get private-sale-active) ERR-SALE-NOT-ACTIVE)
    (ok false)
  )
)

;; Claim a new NFT
(define-public (claim)
  (if (var-get sale-active)
    (public-mint tx-sender)
      (if (var-get private-sale-active)
        (private-mintpass-mint tx-sender)
        (not-live)
      )
  )
)

;; Set public sale flag
(define-public (flip-private-sale)
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) ERR-NOT-AUTHORIZED)
    ;; Disable the Public sale
    (var-set sale-active false)
    (var-set private-sale-active (not (var-get private-sale-active)))
    (ok (var-get private-sale-active))))

;; Set public sale flag
(define-public (flip-sale)
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) ERR-NOT-AUTHORIZED)
    (var-set private-sale-active false)
    (var-set sale-active (not (var-get sale-active)))
    (ok (var-get sale-active))))

(define-read-only (get-sale-status)
  (list 
    (and (var-get private-sale-active) (>= block-height (var-get private-target-block-height)))  
    (and (var-get sale-active) (>= block-height (var-get public-target-block-height)))
  )
)

(define-read-only (get-private-target-block-height)
  (var-get private-target-block-height)
)

(define-read-only (get-public-target-block-height)
  (var-get public-target-block-height)
)

(define-read-only (get-private-presale-balance (account principal))
  (default-to u0
    (map-get? private-presale-count account)))

(define-read-only (get-public-balance (account principal))
  (default-to u0
    (map-get? public-sale-count account)))

;; Internal - Mint NFT using Mintpass mechanism
(define-private (private-mintpass-mint (new-owner principal))
  (let ((mint-count (get-private-presale-balance new-owner)))
    (asserts! (var-get private-sale-active) ERR-SALE-NOT-ACTIVE)
    (asserts! (>= block-height (var-get private-target-block-height)) ERR-BEFORE-MINT-TIME)
    (asserts! (> mint-count u0) ERR-NO-MINTPASS-REMAINING)
    (map-set private-presale-count
              new-owner
              (- mint-count u1))
    (mint new-owner) 
  )
)

;; Internal - Mint public sale NFT
(define-private (public-mint (new-owner principal))
  (let ((mint-count (get-public-balance new-owner)))
    (asserts! (var-get sale-active) ERR-SALE-NOT-ACTIVE)
    (asserts! (>= block-height (var-get public-target-block-height)) ERR-BEFORE-MINT-TIME)
    (mint new-owner)
  )
)

;; update pre-sale counts
(define-public (set-private-wl (address principal) (limit uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (map-set private-presale-count address limit)
    (ok true)
  )
)

(define-public (bulk-set-private-wl (addresses (list 1000 principal)) (limits (list 1000 uint)))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (print (map set-private-wl addresses limits))
    (ok true)
  )
)

(define-public (set-public-target-block-height (target uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (var-set public-target-block-height target)
    (ok true)
  )
)

(define-public (set-private-target-block-height (target uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (var-set private-target-block-height target)
    (ok true)
  )
)

;; ###### BEGIN: commissions template code ##################################################
(define-data-var secondary-commission uint u250)

(define-public (pay (id uint) (price uint))
    (if (> (var-get secondary-commission) u0)
        (begin  
                (try! (stx-transfer? (/ (* price (var-get secondary-commission)) u10000) tx-sender (var-get commission-address)))
                ;; total of 5% = u500
                  (try! (stx-transfer? (/ (* price u250) u10000) tx-sender 'SP1VZ743H2Y4K983JNN4DE13BB6410A7R8N16WAXF))
  (try! (stx-transfer? (/ (* price u100) u10000) tx-sender 'SP1ZQBAJAB9S0QFJCJSK6J0NR80334T7GBVMW7ABS))
  (try! (stx-transfer? (/ (* price u100) u10000) tx-sender 'SP312R8WPKAGF3E5WJ7YHMFP8EDF1E3NJEZ11NB8J))
  (try! (stx-transfer? (/ (* price u100) u10000) tx-sender 'SP7NNN9PRQ0E0JDACV74F6TBKXY3476QEWRXAP3B))
  (try! (stx-transfer? (/ (* price u100) u10000) tx-sender 'SP218P6TAB7GXHV6G43GZM42NSXFHR6YB9VKC43XV))

                (ok true)
        )
        (ok true)
    )
)

(define-public (set-commission (amount uint))
    (begin
        (asserts! (is-eq tx-sender (var-get commission-address)) ERR-NOT-AUTHORIZED)
        (var-set secondary-commission amount)
        (ok true)
    )
)

(define-public (set-commission-address (address principal))
    (begin
        (asserts! (is-eq tx-sender (var-get commission-address)) ERR-NOT-AUTHORIZED)
        (var-set commission-address address)
        (ok true)
    )
)

(define-public (get-commission)
    (ok (var-get secondary-commission))
)

(define-public (get-commission-address)
    (ok (var-get commission-address))
)
;; ###### END: commission template code ##################################################

;; ###### BEGIN: fungible token mint template code ##################################################
(define-data-var xbtc-cost-per-mint uint u420069000000)

(define-private (xbtc-mint (new-owner principal))
    (let (
        (next-id (+ u1 (var-get last-id)))
    )
      (asserts! (< (var-get last-id) MINT-LIMIT) ERR-SOLD-OUT)
      (match (nft-mint? ewoktownwtf next-id new-owner)
        success
        (let
        ((current-balance (get-balance new-owner)))
          (begin
            ;; (print payout)
            (try! (xbtc-payout))
            (var-set last-id next-id)
            (map-set token-count
              new-owner
              (+ current-balance u1)
            )
            (ok true)))
        error (err (* error u10000)))))

(define-private (xbtc-payout)
  (let (
    (price (var-get xbtc-cost-per-mint))
    (commission-amount (/ (* price (var-get commission-percentage)) u10000))
    (price-list (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.uint-lists lookup price (len (var-get royalty))))
    (divider-list (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.uint-lists lookup u10000 (len (var-get royalty))))
    (royalty-amounts (map * (var-get royalty) price-list))
    (payout-amounts (map / royalty-amounts divider-list))
  )
    (asserts! (>= (unwrap-panic (contract-call? 'SP3DX3H4FEYZJZ586MFBS25ZW3HZDMEW92260R2PR.Wrapped-Bitcoin get-balance tx-sender)) price) ERR-INSUFFICIENT-FUNDS)
    (map xbtc-pay (var-get artist-address) payout-amounts)
    (try! (contract-call? 'SP3DX3H4FEYZJZ586MFBS25ZW3HZDMEW92260R2PR.Wrapped-Bitcoin transfer commission-amount tx-sender (var-get commission-address) (some 0x00)))
    (ok payout-amounts)
  )
)

(define-private (xbtc-pay (receiver principal) (amount uint))
  (contract-call? 'SP3DX3H4FEYZJZ586MFBS25ZW3HZDMEW92260R2PR.Wrapped-Bitcoin transfer amount tx-sender receiver (some 0x00))
)

(define-public (set-xbtc-cost (amount uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (var-set xbtc-cost-per-mint amount)
    (ok true)))

;; Claim a new NFT
(define-public (claim-xbtc)
  (if (var-get sale-active)
    (xbtc-public-mint tx-sender)
      (if (var-get private-sale-active)
        (xbtc-private-mintpass-mint tx-sender)
        (not-live)
      )
  )
)

;; Internal - Mint NFT using Mintpass mechanism
(define-private (xbtc-private-mintpass-mint (new-owner principal))
  (let ((mint-count (get-private-presale-balance new-owner)))
    (asserts! (var-get private-sale-active) ERR-SALE-NOT-ACTIVE)
    (asserts! (> mint-count u0) ERR-NO-MINTPASS-REMAINING)
    (map-set private-presale-count
              new-owner
              (- mint-count u1))
    (xbtc-mint new-owner) 
  )
)

;; Internal - Mint public sale NFT
(define-private (xbtc-public-mint (new-owner principal))
  (let ((mint-count (get-public-balance new-owner)))
    (asserts! (var-get sale-active) ERR-SALE-NOT-ACTIVE)
    (xbtc-mint new-owner)
  )
)
;; ###### END: fungible token mint template code ##################################################

;; ###### BEGIN: fungible token mint template code ##################################################
(define-data-var xusd-cost-per-mint uint u569000000)

(define-private (xusd-mint (new-owner principal))
    (let (
        (next-id (+ u1 (var-get last-id)))
    )
      (asserts! (< (var-get last-id) MINT-LIMIT) ERR-SOLD-OUT)
      (match (nft-mint? ewoktownwtf next-id new-owner)
        success
        (let
        ((current-balance (get-balance new-owner)))
          (begin
            ;; (print payout)
            (try! (xusd-payout))
            (var-set last-id next-id)
            (map-set token-count
              new-owner
              (+ current-balance u1)
            )
            (ok true)))
        error (err (* error u10000)))))

(define-private (xusd-payout)
  (let (
    (price (var-get xusd-cost-per-mint))
    (commission-amount (/ (* price (var-get commission-percentage)) u10000))
    (price-list (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.uint-lists lookup price (len (var-get royalty))))
    (divider-list (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.uint-lists lookup u10000 (len (var-get royalty))))
    (royalty-amounts (map * (var-get royalty) price-list))
    (payout-amounts (map / royalty-amounts divider-list))
  )
    (asserts! (>= (unwrap-panic (contract-call? 'SP2TZK01NKDC89J6TA56SA47SDF7RTHYEQ79AAB9A.Wrapped-USD get-balance tx-sender)) price) ERR-INSUFFICIENT-FUNDS)
    (map xusd-pay (var-get artist-address) payout-amounts)
    (try! (contract-call? 'SP2TZK01NKDC89J6TA56SA47SDF7RTHYEQ79AAB9A.Wrapped-USD transfer commission-amount tx-sender (var-get commission-address) (some 0x00)))
    (ok payout-amounts)
  )
)

(define-private (xusd-pay (receiver principal) (amount uint))
  (contract-call? 'SP2TZK01NKDC89J6TA56SA47SDF7RTHYEQ79AAB9A.Wrapped-USD transfer amount tx-sender receiver (some 0x00))
)

(define-public (set-xusd-cost (amount uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (var-set xusd-cost-per-mint amount)
    (ok true)))

;; Claim a new NFT
(define-public (claim-xusd)
  (if (var-get sale-active)
    (xusd-public-mint tx-sender)
      (if (var-get private-sale-active)
        (xusd-private-mintpass-mint tx-sender)
        (not-live)
      )
  )
)

;; Internal - Mint NFT using Mintpass mechanism
(define-private (xusd-private-mintpass-mint (new-owner principal))
  (let ((mint-count (get-private-presale-balance new-owner)))
    (asserts! (var-get private-sale-active) ERR-SALE-NOT-ACTIVE)
    (asserts! (> mint-count u0) ERR-NO-MINTPASS-REMAINING)
    (map-set private-presale-count
              new-owner
              (- mint-count u1))
    (xusd-mint new-owner) 
  )
)

;; Internal - Mint public sale NFT
(define-private (xusd-public-mint (new-owner principal))
  (let ((mint-count (get-public-balance new-owner)))
    (asserts! (var-get sale-active) ERR-SALE-NOT-ACTIVE)
    (xusd-mint new-owner)
  )
)
;; ###### END: fungible token mint template code ##################################################

;; ###### BEGIN: fungible token mint template code ##################################################
(define-data-var banana-cost-per-mint uint u696969420000000)

(define-private (banana-mint (new-owner principal))
    (let (
        (next-id (+ u1 (var-get last-id)))
    )
      (asserts! (< (var-get last-id) MINT-LIMIT) ERR-SOLD-OUT)
      (match (nft-mint? ewoktownwtf next-id new-owner)
        success
        (let
        ((current-balance (get-balance new-owner)))
          (begin
            ;; (print payout)
            (try! (banana-payout))
            (var-set last-id next-id)
            (map-set token-count
              new-owner
              (+ current-balance u1)
            )
            (ok true)))
        error (err (* error u10000)))))

(define-private (banana-payout)
  (let (
    (price (var-get banana-cost-per-mint))
    (commission-amount (/ (* price (var-get commission-percentage)) u10000))
    (price-list (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.uint-lists lookup price (len (var-get royalty))))
    (divider-list (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.uint-lists lookup u10000 (len (var-get royalty))))
    (royalty-amounts (map * (var-get royalty) price-list))
    (payout-amounts (map / royalty-amounts divider-list))
  )
    (asserts! (>= (unwrap-panic (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.btc-monkeys-bananas get-balance tx-sender)) price) ERR-INSUFFICIENT-FUNDS)
    (map banana-pay (var-get artist-address) payout-amounts)
    (try! (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.btc-monkeys-bananas transfer commission-amount tx-sender (var-get commission-address) (some 0x00)))
    (ok payout-amounts)
  )
)

(define-private (banana-pay (receiver principal) (amount uint))
  (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.btc-monkeys-bananas transfer amount tx-sender receiver (some 0x00))
)

(define-public (set-banana-cost (amount uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (var-set banana-cost-per-mint amount)
    (ok true)))

;; Claim a new NFT
(define-public (claim-banana)
  (if (var-get sale-active)
    (banana-public-mint tx-sender)
      (if (var-get private-sale-active)
        (banana-private-mintpass-mint tx-sender)
        (not-live)
      )
  )
)

;; Internal - Mint NFT using Mintpass mechanism
(define-private (banana-private-mintpass-mint (new-owner principal))
  (let ((mint-count (get-private-presale-balance new-owner)))
    (asserts! (var-get private-sale-active) ERR-SALE-NOT-ACTIVE)
    (asserts! (> mint-count u0) ERR-NO-MINTPASS-REMAINING)
    (map-set private-presale-count
              new-owner
              (- mint-count u1))
    (banana-mint new-owner) 
  )
)

;; Internal - Mint public sale NFT
(define-private (banana-public-mint (new-owner principal))
  (let ((mint-count (get-public-balance new-owner)))
    (asserts! (var-get sale-active) ERR-SALE-NOT-ACTIVE)
    (banana-mint new-owner)
  )
)
;; ###### END: fungible token mint template code ##################################################

;; ###### BEGIN: fungible token mint template code ##################################################
(define-data-var slime-cost-per-mint uint u50000000)

(define-public (slime-mint (new-owner principal))
    (let (
        (next-id (+ u1 (var-get last-id)))
    )
      (asserts! (< (var-get last-id) MINT-LIMIT) ERR-SOLD-OUT)
      (match (nft-mint? ewoktownwtf next-id new-owner)
        success
        (let
        ((current-balance (get-balance new-owner)))
          (begin
            ;; (print payout)
            (try! (slime-payout))
            (var-set last-id next-id)
            (map-set token-count
              new-owner
              (+ current-balance u1)
            )
            (ok true)))
        error (err (* error u10000)))))

(define-private (slime-payout)
  (let (
    (price (var-get slime-cost-per-mint))
    (commission-amount (/ (* price (var-get commission-percentage)) u10000))
    (price-list (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.uint-lists lookup price (len (var-get royalty))))
    (divider-list (contract-call? 'SP2KAF9RF86PVX3NEE27DFV1CQX0T4WGR41X3S45C.uint-lists lookup u10000 (len (var-get royalty))))
    (royalty-amounts (map * (var-get royalty) price-list))
    (payout-amounts (map / royalty-amounts divider-list))
  )
    (asserts! (>= (unwrap-panic (contract-call? 'SP125J1ADVYWGWB9NQRCVGKYAG73R17ZNMV17XEJ7.slime-token get-balance tx-sender)) price) ERR-INSUFFICIENT-FUNDS)
    (map slime-pay (var-get artist-address) payout-amounts)
    (try! (contract-call? 'SP125J1ADVYWGWB9NQRCVGKYAG73R17ZNMV17XEJ7.slime-token transfer commission-amount tx-sender (var-get commission-address) (some 0x00)))
    (ok payout-amounts)
  )
)

(define-private (slime-pay (receiver principal) (amount uint))
  (contract-call? 'SP125J1ADVYWGWB9NQRCVGKYAG73R17ZNMV17XEJ7.slime-token transfer amount tx-sender receiver (some 0x00))
)

(define-public (set-slime-cost (amount uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
    (var-set slime-cost-per-mint amount)
    (ok true)))

;; Claim a new NFT
(define-public (claim-slime)
  (if (var-get sale-active)
    (slime-public-mint tx-sender)
      (if (var-get private-sale-active)
        (slime-private-mintpass-mint tx-sender)
        (not-live)
      )
  )
)

;; Internal - Mint NFT using Mintpass mechanism
(define-private (slime-private-mintpass-mint (new-owner principal))
  (let ((mint-count (get-private-presale-balance new-owner)))
    (asserts! (var-get private-sale-active) ERR-SALE-NOT-ACTIVE)
    (asserts! (> mint-count u0) ERR-NO-MINTPASS-REMAINING)
    (map-set private-presale-count
              new-owner
              (- mint-count u1))
    (slime-mint new-owner) 
  )
)

;; Internal - Mint public sale NFT
(define-private (slime-public-mint (new-owner principal))
  (let ((mint-count (get-public-balance new-owner)))
    (asserts! (var-get sale-active) ERR-SALE-NOT-ACTIVE)
    (slime-mint new-owner)
  )
)
;; ###### END: fungible token mint template code ##################################################