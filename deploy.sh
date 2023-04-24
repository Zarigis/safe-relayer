#!/bin/bash
forge build
forge create --rpc-url $RPC_URL --private-key $DEPLOYER_KEY $CONTRACT_NAME
