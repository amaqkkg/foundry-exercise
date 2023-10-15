// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract ProxyStore {
    uint256 public num;
    address public implementation;

    constructor(address addr) {
        implementation = addr;
    }

    fallback() external {
        // delegate here
        (bool success, ) = implementation.delegatecall(msg.data);
        require(success, "Delegate Call Failed");
    }
}
