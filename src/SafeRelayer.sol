// SPDX-License-Identifier: mit
pragma solidity 0.8.19;

import {
    GelatoRelayContext 
} from "@gelatonetwork/relay-context/contracts/GelatoRelayContext.sol";

import {
    GnosisSafe 
} from "@safe-global/safe-contracts/contracts/GnosisSafe.sol";

import {
    Enum 
} from "@safe-global/safe-contracts/contracts/common/Enum.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {
    SafeERC20
} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import {
    MultiSend
} from "@safe-global/safe-contracts/contracts/libraries/MultiSend.sol";



contract SafeRelayer is GelatoRelayContext {

    address immutable public MULTISEND;
    address immutable private _this;

    constructor() {
        MULTISEND = address(new MultiSend());
        _this = address(this);
    }

    function multiSend(address safe, bytes memory transactions) onlyGelatoRelay public payable {
        SafeRelayer(_this).pullFeesFrom(safe);
        (bool success,) = MULTISEND.delegatecall(abi.encodeWithSelector(MultiSend.multiSend.selector, transactions));
        require (success, "multiSend failed");
    }

    function pullFeesFrom(address safe) onlyGelatoRelay public {
        SafeERC20.safeTransferFrom(IERC20(_getFeeToken()), safe, _getFeeCollector(),_getFee());
    }

    function execTransaction(
        address payable safe,
        address to,
        uint256 value,
        bytes calldata data,
        Enum.Operation operation,
        uint256 safeTxGas,
        uint256 baseGas,
        uint256 gasPrice,
        address gasToken,
        address payable refundReceiver,
        bytes memory signatures
    ) public onlyGelatoRelay payable returns (bool success) {
        pullFeesFrom(safe);
        return GnosisSafe(safe).execTransaction(to, value, data, operation, safeTxGas, baseGas, gasPrice, gasToken, refundReceiver, signatures);
    }

}