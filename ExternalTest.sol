// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ExternalTest {
    constructor() {}

    function externalModifierTest() external pure returns(uint8){
        return 2;
    }
}
