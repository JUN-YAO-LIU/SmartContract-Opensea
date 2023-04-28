// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract TestAddress{

    address myAddress;

    function testAddress1()public pure returns(address){
        return address(123);
    }

    function testAddress()public returns(address){
        myAddress = address(0x3519bb0BbeBb0829BF4e8B43866C1A52a01d4bd7);
        return myAddress;
    }
}