#!/bin/bash
set -x
forge verify-contract --num-of-optimizations 200 --watch --chain $CHAIN_NAME $1 $CONTRACT_NAME
