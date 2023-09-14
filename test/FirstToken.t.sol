// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

import {FirstToken} from "../src/FirstToken.sol";

contract FirstTokenTest is Test {
    uint constant ONE_TOKEN = (1 * 10) ^ 18;
    address constant ALICE = address(1);

    FirstToken public firstToken;

    function setUp() public {
        firstToken = new FirstToken();
    }

    function test_mint() public {
        // given
        uint totalSupplyBefore = firstToken.totalSupply();
        uint aliceBalanceBefore = firstToken.balanceOf(ALICE);

        // when
        firstToken.mint(ALICE, ONE_TOKEN);

        // then
        uint totalSupplyAfter = firstToken.totalSupply();
        assertEq(totalSupplyAfter - totalSupplyBefore, ONE_TOKEN);

        uint aliceBalanceAfter = firstToken.balanceOf(ALICE);
        assertEq(aliceBalanceAfter - aliceBalanceBefore, ONE_TOKEN);
    }

    function testRevert_mintCalledByNotMinter() public {
        address nonMinterAddress = address(0);

        vm.prank(nonMinterAddress);
        vm.expectRevert();

        firstToken.mint(ALICE, ONE_TOKEN);
    }
}
