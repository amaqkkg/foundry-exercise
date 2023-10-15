// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Store {
    uint256 public num;

    constructor() {
        // this state is neglected in the Proxy Contract state
        num = 20;
    }

    function setNumber(uint256 number) public {
        num = number;
    }
}
