// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.19;

import {
    GelatoRelayContext 
} from "@gelatonetwork/relay-context/contracts/GelatoRelayContext.sol";



contract SafeRelayer is GelatoRelayContext {
    constructor() {}

    function executeTransaction() external onlyGelatoRelay {
        _transferRelayFee();

    }

}