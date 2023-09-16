// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";

import "openzeppelin/token/ERC20/ERC20.sol";

import {Faucet} from "../src/Faucet.sol";
import {FirstToken} from "../src/FirstToken.sol";

import "forge-std/console.sol";

contract FaucetTest is Test {

    uint constant ONE_TOKEN = 1 * (10 ^ 18);
    
    address constant ALICE = address(1);
    address constant MOCKED_TOKEN_ADDRESS = address(1000);

    Faucet private faucet;

    function setUp() public {
        faucet = new Faucet(MOCKED_TOKEN_ADDRESS);
    }

    function test_requestsToken() public {
      // given

      // mock faucet balance
      console.log(address(faucet));
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
    
      // when
      vm.prank(ALICE);
      faucet.requestTokens(ONE_TOKEN);
       
      // then

    }
}