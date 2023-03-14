#!/bin/bash
# Script to install chaincode onto a peer node
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=101.43.206.180:7004
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/peers/peer2.org0.foodtrace.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=org0-foodtrace-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/users/Admin@org0.foodtrace.com/msp
cd /go/src/github.com/chaincode/simple

  go env -w GOPROXY=https://goproxy.cn,direct

if [ ! -f "simple_go_1.0.tar.gz" ]; then
  cd go
  GO111MODULE=on
  go mod vendor
  cd -
  peer lifecycle chaincode package simple_go_1.0.tar.gz \
    -p /go/src/github.com/chaincode/simple/go/ \
    --lang golang --label simple_1.0
fi

peer lifecycle chaincode install simple_go_1.0.tar.gz
