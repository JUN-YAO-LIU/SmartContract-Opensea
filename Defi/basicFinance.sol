// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

contract basicFinance{

    // 金錢匯入紀錄
    mapping(address => uint) Record;

    function ExportPrice(address to) public {
    }

    function ImportPrice() public payable{
        Record[msg.sender] = msg.value;
    }

}