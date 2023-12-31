// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Store {
    address public implementation;
    address public admin;
    uint256 public num;
    mapping(address => uint256) public myFavoriteNumber;

    constructor() {
        // this state is neglected in the Proxy Contract state
        num = 20;
    }

    function setNumber(uint256 number) public {
        num = number;
    }

    function setMyFavoriteNumber(uint256 number) public {
        myFavoriteNumber[msg.sender] = number;
    }
}
