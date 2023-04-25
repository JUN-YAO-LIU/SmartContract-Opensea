// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;

contract ReceiveETH{

    event LogReceive(uint256 price,address from);

    function Receive()external payable{
        emit LogReceive(msg.value,msg.sender);
    }

    function GetBalance() view public returns (uint){
        return address(this).balance;
    }

    receive() external payable {}
}