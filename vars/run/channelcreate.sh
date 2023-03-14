#!/bin/bash
# Script to create channel block 0 and then create channel
cp $FABRIC_CFG_PATH/core.yaml /vars/core.yaml
cd /vars
export FABRIC_CFG_PATH=/vars
configtxgen -profile OrgChannel \
  -outputCreateChannelTx mychannel.tx -channelID mychannel

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=101.43.206.180:7004
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/peers/peer2.org0.foodtrace.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=org0-foodtrace-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/users/Admin@org0.foodtrace.com/msp
export ORDERER_ADDRESS=101.43.206.180:7011
export ORDERER_TLS_CA=/vars/keyfiles/ordererOrganizations/foodtrace.com/orderers/orderer3.foodtrace.com/tls/ca.crt
peer channel create -c mychannel -f mychannel.tx -o $ORDERER_ADDRESS \
  --cafile $ORDERER_TLS_CA --tls
