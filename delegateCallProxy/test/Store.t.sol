// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Store} from "../src/Store.sol";

contract StoreTest is Test {
    Store public store;

    function setUp() public {
        store = new Store();
    }

    function test_DefaultNumber() public {
        assertEq(store.num(), 20);
    }

    function test_SetNumber() public {
        store.setNumber(0);
        assertEq(store.num(), 0);
    }

    function testFuzz_SetNumber(uint256 x) public {
        store.setNumber(x);
        assertEq(store.num(), x);
    }
}
