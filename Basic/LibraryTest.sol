// SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.19;

// relevant-source-part-starts-here-and-spans-across-multiple-lines 這錯誤是因為沒有pure
library TestLibrary{
    // library cannot have state variables.
    // uint u = 12;
    function TestSum(uint[] calldata b) pure public returns(uint){
        uint[] calldata a = b;
        return a.length;
    }
}

contract AccessLibraryTest{
    function TestSum(uint[] calldata a) pure public returns(uint b){
      b = TestLibrary.TestSum(a);
    }
}