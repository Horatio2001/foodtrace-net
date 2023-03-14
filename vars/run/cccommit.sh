#!/bin/bash
# Script to instantiate chaincode
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=101.43.206.180:7003
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/peers/peer1.org0.foodtrace.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=org0-foodtrace-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/users/Admin@org0.foodtrace.com/msp
export ORDERER_ADDRESS=101.43.206.180:7011
export ORDERER_TLS_CA=/vars/keyfiles/ordererOrganizations/foodtrace.com/orderers/orderer3.foodtrace.com/tls/ca.crt
SID=$(peer lifecycle chaincode querycommitted -C mychannel -O json \
  | jq -r '.chaincode_definitions|.[]|select(.name=="simple")|.sequence' || true)

if [[ -z $SID ]]; then
  SEQUENCE=1
else
  SEQUENCE=$((1+$SID))
fi

peer lifecycle chaincode commit -o $ORDERER_ADDRESS --channelID mychannel \
  --name simple --version 1.0 --sequence $SEQUENCE \
  --peerAddresses 101.43.206.180:7004 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/org0.foodtrace.com/peers/peer2.org0.foodtrace.com/tls/ca.crt \
  --peerAddresses 101.43.206.180:7006 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/org1.foodtrace.com/peers/peer2.org1.foodtrace.com/tls/ca.crt \
  --peerAddresses 101.43.206.180:7008 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/org2.foodtrace.com/peers/peer2.org2.foodtrace.com/tls/ca.crt \
  --init-required \
  --cafile $ORDERER_TLS_CA --tls
