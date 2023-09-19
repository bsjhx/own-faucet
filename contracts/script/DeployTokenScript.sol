// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import {FirstToken} from "../src/FirstToken.sol";

contract DeployTokenScript is Script {
    function setUp() public {}

    function run() public {
        console2.log("Weszlo.pl");
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast();

        //deploying token
        FirstToken token = new FirstToken();
        console2.log("Token deployed. Address: ");
        console2.log(address(token));

        vm.stopBroadcast();
    }
}
