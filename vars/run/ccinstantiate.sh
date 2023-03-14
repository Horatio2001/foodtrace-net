#!/bin/bash
# Script to instantiate chaincode
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=101.43.206.180:7004
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/peers/peer2.org0.foodtrace.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=org0-foodtrace-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/users/Admin@org0.foodtrace.com/msp
export ORDERER_ADDRESS=101.43.206.180:7010
export ORDERER_TLS_CA=/vars/keyfiles/ordererOrganizations/foodtrace.com/orderers/orderer2.foodtrace.com/tls/ca.crt

peer chaincode invoke -o $ORDERER_ADDRESS --isInit \
  --cafile $ORDERER_TLS_CA --tls -C mychannel -n simple \
  --peerAddresses 101.43.206.180:7004 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/org0.foodtrace.com/peers/peer2.org0.foodtrace.com/tls/ca.crt \
  --peerAddresses 101.43.206.180:7005 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/org1.foodtrace.com/peers/peer1.org1.foodtrace.com/tls/ca.crt \
  --peerAddresses 101.43.206.180:7007 \
  --tlsRootCertFiles /vars/keyfiles/peerOrganizations/org2.foodtrace.com/peers/peer1.org2.foodtrace.com/tls/ca.crt \
  -c '{"Args":[ "init","a","200","b","300" ]}' --waitForEvent
