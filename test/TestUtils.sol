// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";

abstract contract TestUtils is Test {

    event TokenRequested(address account, uint amount);

    uint constant internal ONE_TOKEN = 1 * (10 ^ 18);

    address constant internal ALICE = address(1);
    address constant internal BOB = address(2);
    address constant internal CHARLIE = address(3);
    address constant internal EVE = address(4);
    address constant internal DAVID = address(5);
        
    address constant internal MOCKED_TOKEN_ADDRESS = address(1000);

}
