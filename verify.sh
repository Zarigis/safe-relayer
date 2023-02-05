#!/bin/bash
forge verify-contract --num-of-optimizations 200 --watch --constructor-args $(cast abi-encode "constructor(address)" $OPERATOR) --chain $CHAIN_NAME $1 $CONTRACT_NAME $ETHERSCAN_KEY 
