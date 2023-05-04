// SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.19;

library TestLibrary{
    // library cannot have state variables.
    // uint u = 12;
    function TestSum(uint[] calldata b) pure public{
        uint[] calldata a = b;
        a.length;
    }
}

contract AccessLibraryTest{
    function TestSum(uint[] calldata a) public{
    }
}