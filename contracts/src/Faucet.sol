// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin/access/AccessControl.sol";

import "./FirstToken.sol";

import "forge-std/console.sol";

contract Faucet is AccessControl {
    event TokenRequested(address account, uint amount);

    FirstToken private token;

    mapping(address => uint256) private lastRequestedTimes;

    uint256 private timeBetweenRequests;

    constructor(address _tokenAddress, uint256 _timeBetweenRequests) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        token = FirstToken(_tokenAddress);
        timeBetweenRequests = _timeBetweenRequests;
    }

    function requestTokens(uint _amount) external returns (bool) {
        require(
            token.balanceOf(address(this)) > _amount,
            "Insufficient faucet balance"
        );
        require(
            block.timestamp >= lastRequestedTimes[msg.sender] + timeBetweenRequests,
            "Required time must pass before requesting token is allowed."
        );

        bool result = token.transfer(msg.sender, _amount);
        lastRequestedTimes[msg.sender] = block.timestamp;

        emit TokenRequested(msg.sender, _amount);

        return result;
    }
}
