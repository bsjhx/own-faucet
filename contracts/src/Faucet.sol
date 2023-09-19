// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin/access/AccessControl.sol";

import "./FirstToken.sol";

import "forge-std/console.sol";

contract Faucet is AccessControl {
    event TokenRequested(address account, uint amount);

    FirstToken private token;

    constructor(address _tokenAddress) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        token = FirstToken(_tokenAddress);
    }

    function requestTokens(uint _amount) external returns (bool) {
        require(
            token.balanceOf(address(this)) > _amount,
            "Insufficient faucet balance"
        );

        bool result = token.transfer(msg.sender, _amount);

        emit TokenRequested(msg.sender, _amount);

        return result;
    }
}
