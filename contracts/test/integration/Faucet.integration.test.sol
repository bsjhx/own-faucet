// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin/token/ERC20/ERC20.sol";

import {Faucet} from "../../src/Faucet.sol";
import {FirstToken} from "../../src/FirstToken.sol";
import {TestUtils} from "../TestUtils.sol";

import "forge-std/console.sol";

contract FaucetTest is TestUtils {
    Faucet private faucet;
    FirstToken private token;

    function setUp() public {
        token = new FirstToken();
        faucet = new Faucet(address(token));
    }

    function test_requesTokensByFewAccountStory() public {
        // Faucet is credited with 10 tokens
        token.mint(address(faucet), 10 * ONE_TOKEN);
        assertEq(token.balanceOf(address(faucet)), 10 * ONE_TOKEN);
        assertEq(token.totalSupply(), 10 * ONE_TOKEN);

        // Alice requests 1 token
        vm.prank(ALICE);
        faucet.requestTokens(ONE_TOKEN);

        // Faucet now has 9 tokens and Alice 1
        assertEq(token.balanceOf(address(faucet)), 9 * ONE_TOKEN);
        assertEq(token.balanceOf(ALICE), ONE_TOKEN);

        // Bob requests 5 tokens
        vm.prank(BOB);
        faucet.requestTokens(5 * ONE_TOKEN);

        // Faucet now has 4 tokens, Alice 1 and Bob 5 tokens
        assertEq(token.balanceOf(address(faucet)), 4 * ONE_TOKEN);
        assertEq(token.balanceOf(ALICE), ONE_TOKEN);
        assertEq(token.balanceOf(BOB), 5 * ONE_TOKEN);

        // Charlie requests 5 tokens - Faucet should revert
        vm.expectRevert(bytes(abi.encodePacked("Insufficient faucet balance")));
        vm.prank(CHARLIE);
        faucet.requestTokens(5 * ONE_TOKEN);

        // Balances and total supply are without changes
        assertEq(token.balanceOf(address(faucet)), 4 * ONE_TOKEN);
        assertEq(token.balanceOf(ALICE), ONE_TOKEN);
        assertEq(token.balanceOf(BOB), 5 * ONE_TOKEN);
        assertEq(token.totalSupply(), 10 * ONE_TOKEN);
    }
}
