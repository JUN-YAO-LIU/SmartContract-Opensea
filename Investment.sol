// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Investment {
    // invest amount
    uint8 private minAmount;

    uint8 private maxAmount;

    // duration
    uint8 private apdurationr;

    // apr
    uint8 private apr;

    // invesment type

    // which address registered the investment.
    mapping(address => mapping(uint8 => uint256)) userRegisterIvtAmt;

    // how to calculate the turndays?

    constructor() {}

    // register the investment and input the amount.
    function registerInvestment() public payable {}

    // cancel the investment
    function cancelInvestment() public payable {}
}
