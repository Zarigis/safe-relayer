#!/bin/bash
forge test && forge create --rpc-url $RPC_URL --constructor-args $OPERATOR --private-key $DEPLOYER_KEY $CONTRACT_NAME --gas-price $GAS_PRICE
