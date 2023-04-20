// SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.18;
// contract 合約
// 0xc20430026a1A336C769C48CDf5aF6076304Ef6aE
contract TestEvent{
    event Log(string msg,int value);
    event LogIndex(string indexed msg,int value);

    event Deposit(
        address indexed from,
        bytes32 indexed id,
        uint value
    );

    function testEventFun() public{
        // modified the state.
        emit Log("test",123);
    }

    function testIndexEventFun() public{
        // modified the state.
        emit LogIndex("test index",1234);
    }

    
    function deposit(bytes32 id) public payable {
        // Events are emitted using `emit`, followed by
        // the name of the event and the arguments
        // (if any) in parentheses. Any such invocation
        // (even deeply nested) can be detected from
        // the JavaScript API by filtering for `Deposit`.
        emit Deposit(msg.sender, id, msg.value);
    }

}