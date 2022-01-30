---
title: "Contract stackswap-stacker4-v1d"
draft: true
---
Deployer: SP1Z92MPDQEWZXW36VX71Q25HKF5K2EPCJ304F275

SIP-009: false

SIP-010: false

Functions:
{"name":"enable-vault-withdrawals","access":"public","args":[{"name":"vault-id","type":"uint128"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"initiate-stacking","access":"public","args":[{"name":"pox-addr","type":{"tuple":[{"name":"hashbytes","type":{"buffer":{"length":20}}},{"name":"version","type":{"buffer":{"length":1}}}]}},{"name":"start-burn-ht","type":"uint128"},{"name":"lock-period","type":"uint128"}],"outputs":{"type":{"response":{"ok":"uint128","error":"uint128"}}}}, {"name":"return-stx","access":"public","args":[{"name":"ustx-amount","type":"uint128"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"get-stacking-stx-stacked","access":"read_only","args":[],"outputs":{"type":{"response":{"ok":"uint128","error":"none"}}}}, {"name":"get-stacking-unlock-burn-height","access":"read_only","args":[],"outputs":{"type":{"response":{"ok":"uint128","error":"none"}}}}, {"name":"get-stx-balance","access":"read_only","args":[],"outputs":{"type":"uint128"}}