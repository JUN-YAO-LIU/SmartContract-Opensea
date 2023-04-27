// SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.18;

contract SendEther {

    constructor() payable {}

    function Transfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function Send(address payable _to) public payable {
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function Call(address payable _to) public payable {
        // bytes memory data，沒用到的變數可以用以下方式省略。
        (bool sent,) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}

contract ReceiveETH{

    event LogReceive(uint256 price,address from);

    function GetBalance() view public returns (uint){
        return address(this).balance;
    }

    receive() external payable {
        emit LogReceive(msg.value,msg.sender);
    }
}