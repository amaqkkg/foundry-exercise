// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract StoreV2 {
    address public implementation;
    address public admin;
    uint256 public num;
    mapping(address => uint256) public myFavoriteNumber;

    function setNumber(uint256 number) public {
        num = 2 * number;
    }

    function setMyFavoriteNumber(uint256 number) public {
        myFavoriteNumber[msg.sender] = 2 * number;
    }
}
