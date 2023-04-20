// SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.18;

contract Require{

    error Unauthorized();

    function TestRequire() pure external{
        // 1.會變字串內容 是不是符合編碼
        // 2.false 才會revert the error msg
        // 3.不知道鏈費會怎麼扣
        require(true,"test ! Require");
    }

    function TestRevert() pure external{
        // 1.沒有true or false就是一定會觸發
        // 2.不知道鏈費會怎麼扣
        revert("revert 1");
    }

    function TestAssert() pure public{
        // 一樣是false會跳出錯誤，多用在嚴重、內部錯誤。
        assert(false);
    }

    // 不知道怎麼用
    function TestRevertUnauthorized() pure external{
        revert Unauthorized();
    }
}