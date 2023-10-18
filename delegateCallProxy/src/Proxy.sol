// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract ProxyStore {
    address public implementation;
    address public admin;
    uint256 public num;
    mapping(address => uint256) public myFavoriteNumber;

    constructor(address addr) {
        implementation = addr;
        admin = msg.sender;
    }

    fallback() external {
        // delegate here
        (bool success, ) = implementation.delegatecall(msg.data);
        require(success, "Delegate Call Failed");
    }

    function upgrade(address newImplementation) external {
        require(msg.sender == admin, "Only admin can call this function");
        implementation = newImplementation;
    }
}
