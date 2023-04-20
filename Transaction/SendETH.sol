// SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.18;

contract SendEther {
    function Transfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function Send(address payable _to) public payable {
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function Call(address payable _to) public payable {
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}