;; MinoTauri-Multipliers-v2
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-NOT-AUTHORIZED u401)

(define-data-var multipliers (list 5000 uint) (list
u11250
u10400
u10150
u15500
u10250
u12500
u11250
u10250
u12500
u10000
u10000
u10500
u10900
u13500
u12400
u10400
u10300
u10150
u10750
u10400
u10250
u10500
u10500
u10000
u11000
u10000
u10000
u10750
u10250
u10000
u10000
u10000
u10000
u10000
u10150
u10500
u10500
u10000
u10150
u15250
u11250
u10000
u10150
u11500
u10150
u10500
u10250
u11250
u10000
u10250
u10000
u10000
u10150
u10000
u11400
u11000
u10000
u11250
u10000
u10500
u11750
u10250
u10150
u10000
u10150
u10500
u10750
u10150
u10400
u11500
u15250
u10750
u10000
u10500
u13000
u10000
u10250
u10150
u10000
u10900
u10000
u10000
u10250
u11150
u10650
u10500
u10400
u10000
u10000
u10500
u11250
u10000
u10750
u10000
u10000
u10750
u11900
u10750
u11250
u10750
u11250
u10000
u10000
u10000
u10500
u10000
u10800
u10000
u12500
u16750
u10650
u10000
u10150
u10500
u12500
u10500
u11000
u10000
u10000
u10000
u10500
u10150
u11000
u11400
u14250
u10150
u10500
u11000
u11750
u12750
u10000
u10000
u10150
u10250
u10500
u10000
u10500
u10000
u10750
u11650
u10150
u12500
u10750
u10000
u14500
u13000
u11750
u10500
u12500
u10500
u10150
u10250
u10500
u16250
u10650
u10150
u10900
u10900
u10750
u10900
u10500
u10000
u11250
u10500
u10250
u10250
u10750
u10000
u10500
u10000
u14150
u10000
u10000
u10000
u10000
u12500
u10750
u10150
u10000
u10750
u10000
u10150
u10000
u10150
u11000
u11250
u10000
u13000
u10750
u10500
u10000
u10150
u10000
u10150
u10750
u10000
u10000
u10150
u10000
u10000
u10000
u10150
u10000
u10150
u13000
u10000
u10250
u11400
u11400
u15000
u10000
u10750
u10500
u10150
u12650
u10500
u11250
u10800
u11150
u10400
u10750
u10150
u11250
u10250
u12250
u10150
u10000
u10250
u12150
u10250
u11250
u10150
u10750
u12000
u10650
u10000
u10000
u11250
u10150
u10000
u12500
u11250
u10000
u10300
u10500
u10750
u10250
u10000
u10000
u10750
u12500
u10300
u11750
u10150
u12500
u10000
u10150
u10000
u10500
u10300
u10000
u10500
u10150
u10000
u10250
u11400
u10000
u10000
u10750
u10550
u10000
u10500
u10750
u10400
u10750
u10500
u10250
u10250
u10000
u10000
u10000
u10000
u10000
u10250
u10500
u10250
u10000
u10000
u17500
u10150
u10250
u10000
u10150
u10000
u10500
u10500
u10000
u11400
u11000
u11400
u10000
u13400
u10750
u10750
u10000
u10000
u10000
u10000
u10300
u11250
u13650
u10250
u11250
u10000
u10000
u10500
u10400
u10250
u10750
u10000
u11250
u10500
u10500
u11250
u10750
u11650
u10900
u10500
u10750
u10500
u11000
u10250
u10000
u11250
u10900
u11750
u10500
u11750
u11250
u15000
u10000
u10000
u10000
u10000
u10500
u12650
u10750
u11250
u10000
u10150
u16250
u10400
u10000
u10500
u10000
u10000
u11250
u10500
u13000
u10500
u10250
u10000
u10650
u10000
u11250
u10150
u11300
u11250
u10650
u10000
u11400
u11000
u10000
u10500
u10650
u10150
u10750
u10000
u10000
u11000
u10000
u10150
u10000
u10250
u10750
u12650
u10150
u12750
u10250
u10750
u10000
u10750
u10000
u10000
u10500
u11250
u11250
u11150
u10650
u11000
u11500
u10650
u10250
u10400
u10000
u10400
u11750
u10000
u10250
u10000
u10750
u10000
u11000
u10750
u10000
u10000
u12500
u13250
u10900
u11750
u10650
u10500
u10500
u12900
u12500
u10400
u10300
u12500
u10900
u10250
u10000
u10000
u15750
u13750
u10900
u10900
u10000
u11000
u10500
u10500
u10000
u10500
u10000
u10150
u10250
u10000
u13750
u10000
u10000
u10000
u10150
u10000
u11750
u10250
u10000
u10000
u10650
u10000
u10000
u11750
u10500
u11000
u10000
u10000
u10000
u10500
u10000
u11000
u10000
u11000
u10750
u10150
u11000
u10250
u10250
u15150
u10000
u10250
u10000
u12650
u10000
u11250
u10000
u10000
u10500
u12500
u10150
u11250
u17500
u12650
u11000
u11500
u10250
u10500
u10000
u15000
u10650
u12500
u10650
u15000
u10500
u10000
u15650
u10650
u10900
u10000
u10000
u10000
u10500
u11250
u12500
u10750
u10250
u10150
u11000
u13150
u13000
u10000
u10900
u10150
u10000
u10150
u10750
u11050
u10000
u10250
u13250
u11400
u10150
u10000
u10150
u10000
u10150
u11400
u10750
u10000
u10000
u10650
u15150
u12650
u10250
u11250
u10750
u10000
u10000
u16000
u10750
u11000
u10000
u10000
u13000
u10000
u12800
u10150
u10500
u10000
u10750
u10000
u10650
u10150
u10000
u10500
u10000
u10000
u10000
u10750
u10500
u12500
u10250
u10000
u10000
u10500
u10150
u15000
u10000
u10000
u10650
u17500
u10250
u12000
u11250
u10650
u10150
u10000
u10000
u10000
u10250
u13000
u11250
u10750
u11250
u10000
u12500
u10650
u11400
u17500
u10500
u10250
u13000
u10150
u11250
u10500
u10750
u10650
u10000
u10500
u10000
u10000
u10000
u16000
u11650
u11900
u10250
u10500
u11250
u10000
u12400
u10150
u10150
u10150
u10500
u13750
u11000
u10000
u12500
u10750
u10000
u10650
u11000
u11250
u10650
u10000
u10000
u10000
u10000
u11250
u10000
u10000
u16250
u10000
u11500
u10250
u15000
u10250
u10500
u15000
u11400
u13150
u10150
u11250
u11300
u10150
u12500
u10500
u10750
u10900
u10000
u10750
u10000
u11000
u13250
u13250
u10250
u10000
u15750
u10150
u17500
u10750
u10000
u12000
u11400
u10000
u10000
u10000
u10150
u10750
u10500
u10250
u10750
u10000
u10750
u10750
u10150
u10650
u10150
u10000
u12500
u10750
u12650
u10750
u17500
u10000
u10250
u10000
u11000
u10150
u10550
u10000
u10250
u10150
u10000
u11500
u10000
u10900
u10400
u10150
u10000
u10500
u10500
u10400
u10750
u10400
u12500
u10750
u10500
u11000
u10650
u10000
u10150
u10750
u10750
u10000
u10500
u12500
u10000
u12500
u10000
u10500
u10000
u10150
u10150
u10500
u10650
u10500
u10000
u11400
u10500
u15000
u11000
u10150
u11000
u10000
u10400
u10000
u10000
u10500
u10500
u10000
u10000
u10150
u15500
u10900
u10900
u10000
u10000
u10000
u10900
u10000
u10000
u11550
u10650
u10000
u10000
u10750
u10250
u10000
u13250
u10000
u10000
u10000
u10000
u10500
u10750
u10000
u10000
u10000
u10150
u10300
u11250
u10250
u10750
u10900
u13750
u10650
u10750
u10000
u10000
u10500
u10650
u10500
u10000
u11250
u10000
u10000
u10250
u10000
u10000
u10150
u10400
u10000
u10000
u10000
u10000
u11500
u10150
u10000
u10000
u10750
u10000
u10550
u10000
u10250
u10000
u10750
u11500
u10250
u10250
u10150
u11250
u10650
u10000
u10150
u12800
u10000
u10250
u10250
u10650
u10400
u10000
u12500
u10000
u10000
u10150
u10500
u10150
u10000
u11250
u10750
u11250
u10000
u10000
u11250
u11750
u10400
u10250
u10750
u10000
u10800
u10000
u10750
u15000
u10000
u10150
u10000
u10650
u17500
u11500
u10250
u12000
u10500
u10250
u10150
u10000
u10000
u10750
u11500
u10650
u10150
u11500
u11500
u10150
u11000
u10500
u11500
u10250
u10500
u10250
u10250
u14250
u11400
u15500
u10000
u10250
u10750
u12250
u10500
u10150
u15000
u11400
u10750
u11250
u10000
u11750
u10150
u10000
u13500
u11250
u11250
u10500
u10750
u15150
u10150
u10000
u11500
u11250
u10150
u10000
u10250
u11000
u10000
u15000
u10400
u10500
u10500
u10500
u11250
u11750
u11250
u10000
u10000
u10150
u10000
u10650
u10000
u10000
u10750
u10000
u10750
u10500
u10000
u10400
u14000
u10750
u10000
u11750
u11150
u10000
u10000
u11500
u10400
u12650
u10000
u10000
u11250
u11750
u10000
u10500
u10000
u10500
u12650
u15500
u11550
u10750
u10150
u10000
u10150
u10750
u10500
u10000
u10150
u10250
u10000
u10250
u10250
u11250
u10750
u13250
u10900
u10750
u10550
u10000
u11250
u10000
u10500
u10150
u12500
u10750
u10000
u11750
u10500
u11000
u11500
u10000
u10150
u10000
u10150
u11250
u10650
u10750
u10000
u11250
u10750
u10000
u10000
u10250
u10000
u10750
u11000
u11500
u10000
u10000
u10500
u10000
u10650
u12000
u10000
u13250
u10000
u10400
u10650
u10500
u10150
u10150
u10000
u11250
u11250
u10000
u10000
u10650
u10000
u12250
u10150
u10150
u15500
u10000
u11250
u10250
u10500
u11250
u10150
u11250
u12750
u10000
u10000
u10000
u11250
u11250
u10000
u10500
u10500
u10000
u11900
u12650
u10000
u15500
u10750
u10500
u12500
u10150
u10000
u10750
u10500
u11400
u10750
u10000
u10000
u10000
u10750
u10250
u13250
u10300
u10500
u10150
u10750
u10000
u10150
u10000
u11750
u17500
u10000
u10250
u10000
u11750
u10250
u11000
u10500
u10000
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u0
u11250
u10000
u10000
u12500
u10000
u10500
u10500
u11250
u10500
u11750
u10250
u10250
u15000
u10500
u10500
u15900
u10250
u11000
u10150
u10150
u10550
u10000
u10150
u10000
u10250
u12500
u10650
u10150
u11250
u11750
u10750
u11500
u10500
u10750
u10500
u11250
u10150
u10000
u12650
u11250
u10650
u10000
u10150
u13000
u10150
u10250
u10250
u10500
u15000
u10150
u12150
u10000
u10000
u10500
u11750
u10150
u10150
u10150
u10750
u10000
u11650
u10500
u10650
u10000
u10400
u10500
u10750
u10800
u11500
u11250
u10000
u10150
u10750
u10650
u10500
u10750
u10900
u13500
u15000
u12500
u11000
u10150
u10900
u10000
u10000
u10000
u10000
u10750
u10900
u10650
u10500
u10500
u11250
u10000
u10250
u10150
u11250
u10150
u10000
u10500
u10000
u15150
u10000
u10750
u10150
u10250
u10150
u10000
u10750
u10650
u10000
u10000
u11250
u12000
u10250
u10750
u17500
u10000
u10650
u10000
u10000
u10500
u10150
u10000
u12150
u11500
u10000
u10300
u10000
u10500
u10000
u10000
u11250
u11000
u10150
u10500
u10750
u10000
u10750
u10500
u10000
u12000
u10650
u10000
u10250
u10000
u10150
u11000
u10250
u10150
u10150
u10000
u10250
u10000
u10250
u10750
u10500
u10000
u10000
u10500
u13000
u10500
u11250
u15250
u10000
u10150
u10250
u10150
u12750
u11750
u11000
u10650
u10750
u10000
u10650
u10150
u11250
u10150
u10000
u10500
u10400
u10750
u10000
u15500
u10000
u11250
u10000
u11750
u10150
u11750
u10000
u12000
u10400
u10000
u10250
u10500
u10750
u10000
u10500
u10150
u10150
u13750
u10900
u11750
u10750
u11000
u10500
u10000
u10500
u10500
u10500
u11050
u10400
u11000
u10900
u10900
u10150
u10000
u10000
u11250
u10500
u10400
u10500
u10000
u10750
u10250
u12500
u10500
u10000
u12500
u10150
u12400
u10150
u10750
u10500
u11250
u10250
u12750
u10150
u10000
u10000
u10000
u10000
u10000
u13000
u10750
u10750
u10150
u13500
u11250
u10000
u10000
u10900
u11250
u10250
u10000
u10500
u10500
u10650
u10500
u11500
u10750
u10500
u10000
u10500
u10500
u11250
u11250
u10250
u10000
u10500
u10000
u11000
u10000
u10000
u10000
u10500
u10250
u10000
u10500
u10000
u12500
u10500
u10500
u10000
u11250
u11750
u11000
u10400
u17500
u10250
u10650
u10650
u10750
u10000
u11400
u10500
u12750
u10150
u10000
u10000
u10500
u10900
u10000
u10250
u10000
u10650
u10000
u10750
u10000
u12000
u10250
u12250
u10000
u10000
u10900
u10000
u10650
u10000
u10000
u10500
u10250
u10750
u11250
u11250
u12500
u10000
u10400
u10000
u10900
u10150
u10250
u13750
u11500
u10750
u10750
u11150
u10250
u11250
u11000
u10500
u11000
u10000
u10000
u10500
u10000
u10000
u10000
u10000
u12000
u10150
u10650
u10750
u12500
u10250
u10000
u10000
u10000
u10000
u10000
u10000
u11000
u10550
u10000
u10750
u10500
u10150
u10150
u10800
u11250
u10000
u10250
u10150
u10500
u10500
u10150
u11250
u11000
u10650
u12500
u11500
u11250
u10250
u10000
u10000
u10000
u11400
u10900
u10000
u10150
u10000
u10000
u10000
u12750
u12500
u10750
u10000
u10000
u10150
u10500
u10000
u10000
u10000
u10250
u11750
u10500
u12150
u10500
u11000
u10500
u10300
u10500
u12250
u10650
u10250
u12000
u11000
u10000
u14000
u10150
u10500
u10150
u10500
))

(define-public (new-list (new-multipliers (list 5000 uint)))
    (begin
        (asserts! (is-eq tx-sender CONTRACT-OWNER) (err ERR-NOT-AUTHORIZED))
        (var-set multipliers new-multipliers)
        (ok new-multipliers)
    )
)

(define-read-only (lookup (uid uint))
    (ok (unwrap-panic (element-at (var-get multipliers) uid)))
)