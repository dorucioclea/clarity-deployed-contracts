---
title: "Contract stacks-art-auctions"
draft: true
---
Deployer: SPJW1XE278YMCEYMXB8ZFGJMH8ZVAAEDP2S2PJYG

SIP-009: false

SIP-010: false

Functions:
{"name":"add-auction","access":"public","args":[{"name":"stacks-art-id","type":"uint128"},{"name":"minimum-price","type":"uint128"},{"name":"block-length","type":"uint128"},{"name":"type","type":"uint128"}],"outputs":{"type":{"response":{"ok":"uint128","error":"uint128"}}}}, {"name":"admin-remove-bid","access":"public","args":[{"name":"auction-id","type":"uint128"}],"outputs":{"type":{"response":{"ok":"uint128","error":"uint128"}}}}, {"name":"admin-unlist","access":"public","args":[{"name":"auction-id","type":"uint128"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"bid-auction","access":"public","args":[{"name":"auction-id","type":"uint128"},{"name":"amount","type":"uint128"}],"outputs":{"type":{"response":{"ok":"uint128","error":"uint128"}}}}, {"name":"end-auction","access":"public","args":[{"name":"auction-id","type":"uint128"}],"outputs":{"type":{"response":{"ok":"uint128","error":"uint128"}}}}, {"name":"set-commission","access":"public","args":[{"name":"auction-id","type":"uint128"},{"name":"commission","type":"uint128"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"set-contract-owner","access":"public","args":[{"name":"owner","type":"principal"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"set-enforce-frozen-metadata","access":"public","args":[],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"set-royalty","access":"public","args":[{"name":"auction-id","type":"uint128"},{"name":"royalty","type":"uint128"}],"outputs":{"type":{"response":{"ok":"bool","error":"uint128"}}}}, {"name":"get-auction","access":"read_only","args":[{"name":"auction-id","type":"uint128"}],"outputs":{"type":{"tuple":[{"name":"block-length","type":"uint128"},{"name":"commission","type":"uint128"},{"name":"end-block-height","type":{"optional":"uint128"}},{"name":"listed","type":"bool"},{"name":"minimum-price","type":"uint128"},{"name":"royalty","type":"uint128"},{"name":"seller","type":"principal"},{"name":"stacks-art-id","type":"uint128"},{"name":"type","type":"uint128"}]}}}, {"name":"get-auction-bid","access":"read_only","args":[{"name":"auction-id","type":"uint128"}],"outputs":{"type":{"tuple":[{"name":"buyer","type":"principal"},{"name":"offer","type":"uint128"}]}}}