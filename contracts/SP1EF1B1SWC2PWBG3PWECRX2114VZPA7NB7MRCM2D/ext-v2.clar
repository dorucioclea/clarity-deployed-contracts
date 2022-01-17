(use-trait ft-trait 'SP1Z92MPDQEWZXW36VX71Q25HKF5K2EPCJ304F275.sip-010-v1a.sip-010-trait)
(use-trait liquidity-token 'SP1Z92MPDQEWZXW36VX71Q25HKF5K2EPCJ304F275.liquidity-token-trait-v4b.liquidity-token-trait)

(define-public (sweep-xxy (token1-amount uint) (token1 <ft-trait>) (token2 <ft-trait>) (token3 <ft-trait>) (lp12 <liquidity-token>) (lp23 <liquidity-token>) (lp13 <liquidity-token>))
  (begin
    (let ((token1-org-amount (stx-get-balance contract-caller)))
      (print {token1-org-amount: token1-org-amount})
      (try! (contract-call? 'SP1Z92MPDQEWZXW36VX71Q25HKF5K2EPCJ304F275.stackswap-swap-v5g swap-x-for-y token1 token2 lp12 token1-amount u0))
      (let ((token2-amount (unwrap-panic (contract-call? token2 get-balance contract-caller))))
        (print {token2-amount: token2-amount})
        (try! (contract-call? 'SP1Z92MPDQEWZXW36VX71Q25HKF5K2EPCJ304F275.stackswap-swap-v5g swap-x-for-y token2 token3 lp23 token2-amount u0))
        (let ((token3-amount (unwrap-panic (contract-call? token3 get-balance contract-caller))))
          (print {token3-amount: token3-amount})
          (try! (contract-call? 'SP1Z92MPDQEWZXW36VX71Q25HKF5K2EPCJ304F275.stackswap-swap-v5g swap-y-for-x token1 token3 lp13 token3-amount u0))
          (let ((token1-new-amount (stx-get-balance contract-caller)))
            (print {token1-new-amount: token1-new-amount})
            (if (> token1-new-amount (+ u500000 token1-org-amount))
              (ok true)
              (err u1001)
            )
          )
        )
      )
    )
  )
)

(define-public (sweep-xyy (token1-amount uint) (token1 <ft-trait>) (token2 <ft-trait>) (token3 <ft-trait>) (lp12 <liquidity-token>) (lp23 <liquidity-token>) (lp13 <liquidity-token>))
  (begin
    (let ((token1-org-amount (stx-get-balance contract-caller)))
      (print {token1-org-amount: token1-org-amount})
      (try! (contract-call? 'SP1Z92MPDQEWZXW36VX71Q25HKF5K2EPCJ304F275.stackswap-swap-v5g swap-x-for-y token1 token3 lp13 token1-amount u0))
      (let ((token3-amount (unwrap-panic (contract-call? token3 get-balance contract-caller))))
        (print {token3-amount: token3-amount})
        (try! (contract-call? 'SP1Z92MPDQEWZXW36VX71Q25HKF5K2EPCJ304F275.stackswap-swap-v5g swap-x-for-y token3 token2 lp23 token3-amount u0))
        (let ((token2-amount (unwrap-panic (contract-call? token2 get-balance contract-caller))))
          (print {token2-amount: token2-amount})
          (try! (contract-call? 'SP1Z92MPDQEWZXW36VX71Q25HKF5K2EPCJ304F275.stackswap-swap-v5g swap-y-for-x token1 token2 lp12 token2-amount u0))
          (let ((token1-new-amount (stx-get-balance contract-caller)))
            (print {token1-new-amount: token1-new-amount})
            (if (> token1-new-amount (+ u500000 token1-org-amount))
              (ok true)
              (err u1001)
            )
          )
        )
      )
    )
  )
)