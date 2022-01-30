---
title: "Contract arkadiko-sip10-reserve-v1-1"
draft: true
---
Deployer: SP2C2YFP12AJZB4MABJBAJ55XECVS7E4PMMZ89YZR

SIP-009: false

SIP-010: false

Functions:
{"name":"burn","access":"public","args":[{"name":"token","type":"trait_reference"},{"name":"vault-owner","type":"principal"},{"name":"collateral-to-return","type":"uint128"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"burn-xstx","access":"public","args":[{"name":"ustx-amount","type":"uint128"},{"name":"sender","type":"principal"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"calculate-current-collateral-to-debt-ratio","access":"public","args":[{"name":"token","type":{"string-ascii":{"length":12}}},{"name":"debt","type":"uint128"},{"name":"ucollateral","type":"uint128"},{"name":"oracle","type":"trait_reference"}],"outputs":{"type":{"response":{"ok":"uint128","error":"uint128"}}}}, {"name":"calculate-usda-count","access":"public","args":[{"name":"token","type":{"string-ascii":{"length":12}}},{"name":"ucollateral-amount","type":"uint128"},{"name":"collateralization-ratio","type":"uint128"},{"name":"oracle","type":"trait_reference"}],"outputs":{"type":{"response":{"ok":"uint128","error":"none"}}}}, {"name":"collateralize-and-mint","access":"public","args":[{"name":"token","type":"trait_reference"},{"name":"token-string","type":{"string-ascii":{"length":12}}},{"name":"ucollateral-amount","type":"uint128"},{"name":"debt","type":"uint128"},{"name":"sender","type":"principal"},{"name":"stacker-name","type":{"string-ascii":{"length":256}}},{"name":"stack-pox","type":"bool"}],"outputs":{"type":{"response":{"ok":"uint128","error":"uint128"}}}}, {"name":"deposit","access":"public","args":[{"name":"token","type":"trait_reference"},{"name":"token-string","type":{"string-ascii":{"length":12}}},{"name":"additional-ucollateral-amount","type":"uint128"},{"name":"stacker-name","type":{"string-ascii":{"length":256}}}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"migrate-funds","access":"public","args":[{"name":"new-vault","type":"trait_reference"},{"name":"token","type":"trait_reference"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"mint","access":"public","args":[{"name":"token-string","type":{"string-ascii":{"length":12}}},{"name":"vault-owner","type":"principal"},{"name":"ucollateral-amount","type":"uint128"},{"name":"current-debt","type":"uint128"},{"name":"extra-debt","type":"uint128"},{"name":"collateralization-ratio","type":"uint128"},{"name":"oracle","type":"trait_reference"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"mint-xstx","access":"public","args":[{"name":"collateral","type":"uint128"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"redeem-collateral","access":"public","args":[{"name":"token","type":"trait_reference"},{"name":"token-string","type":{"string-ascii":{"length":12}}},{"name":"ucollateral","type":"uint128"},{"name":"owner","type":"principal"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"withdraw","access":"public","args":[{"name":"token","type":"trait_reference"},{"name":"token-string","type":{"string-ascii":{"length":12}}},{"name":"vault-owner","type":"principal"},{"name":"ucollateral-amount","type":"uint128"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}