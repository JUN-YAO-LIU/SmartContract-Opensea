// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

/*
1.safe math
2.custom errors
3.functions
4.import (symbol1 as alias symbol2) from "filename"
5.salted contract creations /create2
*/

// under flow revert error.
contract SafeMath{
    function testUnderflow() public pure returns (uint)
    {
        uint x=0;
        x--;
        return x;
    }

    function testUncheckUnderflow() public pure returns (uint)
    {
        uint x=0;

        // 內建方法
        unchecked {x--;} 
        return x;
    }
}

// custom error
contract VendingMachine{

    // 創建時也是一個msg.sender。
    address payable owner = payable(msg.sender);

    // 定義error 錯誤。
    error CustomError(string);

    function withdraw() public {
        if(msg.sender != owner){
            // gas revert類型 會依照輸入的自不同，而有不同gas。
            // 2578 gas
            // revert("error");
            // execution cost 2596 gas
            revert("error error error error error error error");
            //revert CustomError("error error error error error error error");
        }
        owner.transfer(address(this).balance);
    }

    function getOwner() view public returns(address){
        return owner;
    }
    // ....
}
// note: 1. address(this)
// 2.owner.transfer(address(this).balance); 轉給發布者? 

// import functions 
function helper(uint x) pure returns(uint){
   return x * 2;
}

contract TestHelper{
    uint foo;

    function test()external pure returns(uint){
        return helper(123);
    }
}

// 4.

// 5.salted contract creations /create2