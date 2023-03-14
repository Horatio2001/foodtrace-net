#!/bin/bash
# Script to discover endorsers and channel config
cd /vars

export PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/users/Admin@org0.foodtrace.com/tls/ca.crt
export ADMINPRIVATEKEY=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/users/Admin@org0.foodtrace.com/msp/keystore/priv_sk
export ADMINCERT=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/users/Admin@org0.foodtrace.com/msp/signcerts/Admin@org0.foodtrace.com-cert.pem

discover endorsers --peerTLSCA $PEER_TLS_ROOTCERT_FILE \
  --userKey $ADMINPRIVATEKEY \
  --userCert $ADMINCERT \
  --MSP org0-foodtrace-com --channel mychannel \
  --server 101.43.206.180:7004 \
  --chaincode simple | jq '.[0]' | \
  jq 'del(.. | .Identity?)' | jq 'del(.. | .LedgerHeight?)' \
  > /vars/discover/mychannel_simple_endorsers.json

discover config --peerTLSCA $PEER_TLS_ROOTCERT_FILE \
  --userKey $ADMINPRIVATEKEY \
  --userCert $ADMINCERT \
  --MSP org0-foodtrace-com --channel mychannel \
  --server 101.43.206.180:7004 > /vars/discover/mychannel_config.json
