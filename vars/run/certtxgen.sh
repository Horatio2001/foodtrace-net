#!/bin/bash
cd $FABRIC_CFG_PATH
# cryptogen generate --config crypto-config.yaml --output keyfiles
configtxgen -profile OrdererGenesis -outputBlock genesis.block -channelID systemchannel

configtxgen -printOrg org0-foodtrace-com > JoinRequest_org0-foodtrace-com.json
configtxgen -printOrg org1-foodtrace-com > JoinRequest_org1-foodtrace-com.json
configtxgen -printOrg org2-foodtrace-com > JoinRequest_org2-foodtrace-com.json
