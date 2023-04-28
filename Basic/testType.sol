// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

contract TestType{

    bool public b = true;
    uint public u = 123;// uint256 2**256 -1
    
    int public i = -123;// int256 -2**255 t0 2 **255
    int public intInt = type(int).min;
    int public intMax = type(int).max;

    // 20bytes
    // address public addr = 0xdd;

    // bytes32 public b32 = 0x;
    // 輸入數量呈以2，
    bytes4 public b32 = 0x1A34567F;
}