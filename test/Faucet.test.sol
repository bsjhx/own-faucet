// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";

import "openzeppelin/token/ERC20/ERC20.sol";

import {Faucet} from "../src/Faucet.sol";
import {FirstToken} from "../src/FirstToken.sol";

import "forge-std/console.sol";

import {TestsConstants} from "./TestsConstants.sol";

contract FaucetTest is Test {

    event TokenRequested(address account, uint amount);

    address constant MOCKED_TOKEN_ADDRESS = address(1000);

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
        abi.encode(10 * TestsConstants.ONE_TOKEN)
      );

      vm.mockCall(
        MOCKED_TOKEN_ADDRESS,
        abi.encodeWithSelector(ERC20.transfer.selector, TestsConstants.ALICE, TestsConstants.ONE_TOKEN),
        abi.encode(true)
      );
    
      // when Alice requests for one token
      vm.prank(TestsConstants.ALICE);

      vm.expectEmit();
      emit TokenRequested(TestsConstants.ALICE, TestsConstants.ONE_TOKEN);

      assertTrue(faucet.requestTokens(TestsConstants.ONE_TOKEN));
    }
}