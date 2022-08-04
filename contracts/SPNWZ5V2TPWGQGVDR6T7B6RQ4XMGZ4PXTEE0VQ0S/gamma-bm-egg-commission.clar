
(define-public (pay (id uint) (price uint))
    (begin
        (try! (stx-transfer? (/ (* price u500) u10000) tx-sender 'SPF1426KV10TKZ55BPCBDQFM6X4EJZMMF3JMKVY6))
        (try! (stx-transfer? (/ (* price u100) u10000) tx-sender 'SP2597NW8VYYVV4C22WQF3DK0WGQS8TAVDDPXQ5H8))
        (try! (stx-transfer? (/ (* price u100) u10000) tx-sender 'SP1GPNZB0JSC9RXJTXVBAMSPQE29WM1SE8V39R6K2))
        (try! (stx-transfer? (/ (* price u200) u10000) tx-sender 'SPNWZ5V2TPWGQGVDR6T7B6RQ4XMGZ4PXTEE0VQ0S))
        (ok true)))