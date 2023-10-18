// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Store} from "../src/Store.sol";
import {StoreV2} from "../src/StoreV2.sol";
import {ProxyStore} from "../src/Proxy.sol";

contract ProxyTest is Test {
    Store public store;
    StoreV2 public storeV2;
    ProxyStore public proxyStore;

    function setUp() public {
        store = new Store();
        storeV2 = new StoreV2();
        proxyStore = new ProxyStore(address(store));
    }

    function test_proxySetNumber() public {
        (bool success, ) = address(proxyStore).call(
            abi.encodeWithSignature("setNumber(uint256)", 12)
        );
        require(success, "Delegate call failed");
        assertEq(proxyStore.num(), 12);
    }

    function testFail_proxyAssertState() public {
        (bool success, ) = address(proxyStore).call(
            abi.encodeWithSignature("setNumber(uint256)", 34)
        );
        require(success, "Delegate call failed");
        // store.num() state still equal to 20
        assertEq(store.num(), 34);
    }

    // function test_proxySetMyFavNumber() public {
    //     vm.startPrank(address(123));
    //     (bool success, ) = address(proxyStore).call(
    //         abi.encodeWithSignature("setMyFavoriteNumber(uint256)", 37)
    //     );
    //     require(success, "Delegate call failed");
    //     assertEq(proxyStore.myFavoriteNumber(msg.sender), 37);
    // }

    function test_upgradeToV2() public {
        // initiate contract upgrade to storeV2
        proxyStore.upgrade(address(storeV2));
        // check if proxy state still the same: num == 0;
        assertEq(proxyStore.num(), 0);
    }

    function test_upgradeToV2ThenUpdateNum() public {
        // first we set num to 12
        test_proxySetNumber();
        // initiate contract upgrade to storeV2
        proxyStore.upgrade(address(storeV2));
        // check if proxy state still the same: num == 12;
        assertEq(proxyStore.num(), 12);
        // invoke function with value 20, the final num should be 40, 20 multiplied with 2 using storeV2
        (bool success, ) = address(proxyStore).call(
            abi.encodeWithSignature("setNumber(uint256)", 20)
        );
        require(success, "Delegate call failed");
        // check if the num value successfully multiplied by 2
        assertEq(proxyStore.num(), 40);
    }
}
