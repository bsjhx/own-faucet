// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin/token/ERC20/ERC20.sol";

import {Faucet} from "../../src/Faucet.sol";
import {FirstToken} from "../../src/FirstToken.sol";

import {TestUtils} from "../TestUtils.sol";

import "forge-std/console.sol";

contract FaucetTest is TestUtils {
    Faucet private faucet;

    function setUp() public {
        faucet = new Faucet(MOCKED_TOKEN_ADDRESS);
    }

    function test_requestsToken() public {
        // given

        // mock faucet balance
        vm.mockCall(
            MOCKED_TOKEN_ADDRESS,
            abi.encodeWithSelector(ERC20.balanceOf.selector, address(faucet)),
            abi.encode(10 * ONE_TOKEN)
        );

        vm.mockCall(
            MOCKED_TOKEN_ADDRESS,
            abi.encodeWithSelector(ERC20.transfer.selector, ALICE, ONE_TOKEN),
            abi.encode(true)
        );

        // when & then Alice requests for one token
        vm.prank(ALICE);

        // Event should be emitted
        vm.expectEmit();
        emit TokenRequested(ALICE, ONE_TOKEN);

        assertTrue(faucet.requestTokens(ONE_TOKEN));
    }

    function testRevert_faucetBalanceIsInsufficient() public {
        // given
        // mock faucet balance (ONE_TOKEN)
        vm.mockCall(
            MOCKED_TOKEN_ADDRESS,
            abi.encodeWithSelector(ERC20.balanceOf.selector, address(faucet)),
            abi.encode(ONE_TOKEN)
        );

        // revert is expected when
        vm.expectRevert(bytes(abi.encodePacked("Insufficient faucet balance")));

        // 2 tokens are requested
        faucet.requestTokens(2 * ONE_TOKEN);
    }
}
