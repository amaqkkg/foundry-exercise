// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Store} from "../src/Store.sol";
import {ProxyStore} from "../src/Proxy.sol";

contract ProxyTest is Test {
    Store public store;
    ProxyStore public proxyStore;

    function setUp() public {
        store = new Store();
        proxyStore = new ProxyStore(address(store));
    }

    function test_proxySetNumber() public {
        (bool success, ) = address(proxyStore).call{value: 0 ether}(
            abi.encodeWithSignature("setNumber(uint256)", 12)
        );
        require(success, "Delegate call failed");
        assertEq(proxyStore.num(), 12);
    }

    function testFail_proxyAssertState() public {
        (bool success, ) = address(proxyStore).call{value: 0 ether}(
            abi.encodeWithSignature("setNumber(uint256)", 34)
        );
        require(success, "Delegate call failed");
        // store.num() state still equal to 20
        assertEq(store.num(), 34);
    }
}
