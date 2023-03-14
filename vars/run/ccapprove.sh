#!/bin/bash
# Script to approve chaincode
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ID=cli
export CORE_PEER_ADDRESS=101.43.206.180:7003
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/peers/peer1.org0.foodtrace.com/tls/ca.crt
export CORE_PEER_LOCALMSPID=org0-foodtrace-com
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/users/Admin@org0.foodtrace.com/msp
export ORDERER_ADDRESS=101.43.206.180:7009
export ORDERER_TLS_CA=/vars/keyfiles/ordererOrganizations/foodtrace.com/orderers/orderer1.foodtrace.com/tls/ca.crt

peer lifecycle chaincode queryinstalled -O json | jq -r '.installed_chaincodes | .[] | select(.package_id|startswith("simple_1.0:"))' > ccstatus.json

PKID=$(jq '.package_id' ccstatus.json | xargs)
REF=$(jq '.references.mychannel' ccstatus.json)

SID=$(peer lifecycle chaincode querycommitted -C mychannel -O json \
  | jq -r '.chaincode_definitions|.[]|select(.name=="simple")|.sequence' || true)
if [[ -z $SID ]]; then
  SEQUENCE=1
elif [[ -z $REF ]]; then
  SEQUENCE=$SID
else
  SEQUENCE=$((1+$SID))
fi


export CORE_PEER_LOCALMSPID=org0-foodtrace-com
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/peers/peer2.org0.foodtrace.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/org0.foodtrace.com/users/Admin@org0.foodtrace.com/msp
export CORE_PEER_ADDRESS=101.43.206.180:7004

# approved=$(peer lifecycle chaincode checkcommitreadiness --channelID mychannel \
#   --name simple --version 1.0 --init-required --sequence $SEQUENCE --tls \
#   --cafile $ORDERER_TLS_CA --output json | jq -r '.approvals.org0-foodtrace-com')

# if [[ "$approved" == "false" ]]; then
  peer lifecycle chaincode approveformyorg --channelID mychannel --name simple \
    --version 1.0 --package-id $PKID \
  --init-required \
    --sequence $SEQUENCE -o $ORDERER_ADDRESS --tls --cafile $ORDERER_TLS_CA
# fi

export CORE_PEER_LOCALMSPID=org1-foodtrace-com
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/org1.foodtrace.com/peers/peer1.org1.foodtrace.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/org1.foodtrace.com/users/Admin@org1.foodtrace.com/msp
export CORE_PEER_ADDRESS=101.43.206.180:7005

# approved=$(peer lifecycle chaincode checkcommitreadiness --channelID mychannel \
#   --name simple --version 1.0 --init-required --sequence $SEQUENCE --tls \
#   --cafile $ORDERER_TLS_CA --output json | jq -r '.approvals.org1-foodtrace-com')

# if [[ "$approved" == "false" ]]; then
  peer lifecycle chaincode approveformyorg --channelID mychannel --name simple \
    --version 1.0 --package-id $PKID \
  --init-required \
    --sequence $SEQUENCE -o $ORDERER_ADDRESS --tls --cafile $ORDERER_TLS_CA
# fi

export CORE_PEER_LOCALMSPID=org2-foodtrace-com
export CORE_PEER_TLS_ROOTCERT_FILE=/vars/keyfiles/peerOrganizations/org2.foodtrace.com/peers/peer2.org2.foodtrace.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/vars/keyfiles/peerOrganizations/org2.foodtrace.com/users/Admin@org2.foodtrace.com/msp
export CORE_PEER_ADDRESS=101.43.206.180:7008

# approved=$(peer lifecycle chaincode checkcommitreadiness --channelID mychannel \
#   --name simple --version 1.0 --init-required --sequence $SEQUENCE --tls \
#   --cafile $ORDERER_TLS_CA --output json | jq -r '.approvals.org2-foodtrace-com')

# if [[ "$approved" == "false" ]]; then
  peer lifecycle chaincode approveformyorg --channelID mychannel --name simple \
    --version 1.0 --package-id $PKID \
  --init-required \
    --sequence $SEQUENCE -o $ORDERER_ADDRESS --tls --cafile $ORDERER_TLS_CA
# fi
