#!/bin/bash
# Script to join a peer to a channel
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=101.43.206.180:7006
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/org1.foodtrace.com/peers/peer2.org1.foodtrace.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=org1-foodtrace-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/org1.foodtrace.com/users/Admin@org1.foodtrace.com/msp
export ORDERER_ADDRESS=101.43.206.180:7009
export ORDERER_TLS_CA=/vars/keyfiles/ordererOrganizations/foodtrace.com/orderers/orderer1.foodtrace.com/tls/ca.crt
if [ ! -f "mychannel.genesis.block" ]; then
  peer channel fetch oldest -o $ORDERER_ADDRESS --cafile $ORDERER_TLS_CA \
  --tls -c mychannel /vars/mychannel.genesis.block
fi

peer channel join -b /vars/mychannel.genesis.block \
  -o $ORDERER_ADDRESS --cafile $ORDERER_TLS_CA --tls
