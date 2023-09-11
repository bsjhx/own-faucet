// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {FDemo} from "../src/FDemo.sol";

contract CounterTest is Test {
    FDemo public fdemo;

    function setUp() public {
        fdemo = new FDemo();
    }

    function testMint() public { 
        string memory dummyTokenUri = "ipfs://metadata_url";
        uint256 tokenId = fdemo.mint(dummyTokenUri);

        assertEq(dummyTokenUri, fdemo.tokenURI(tokenId));
    }
}
