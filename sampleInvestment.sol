// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BaseBank {
    //質押代幣ERC20的interface
    IERC20 private _stakingToken;

    //質押的總數量
    uint256 private _totalSupply = 0;

    //個人質押數量
    mapping( address => uint256 ) private _balanceOf;

    //鎖質押 10 秒
    uint256 private _lockBaseTime = 10 seconds;
    //鎖質押的開始時間
    mapping( address => uint256 ) private _lockTimeStart;
    //鎖質押的結束時間
    mapping( address => uint256 ) private _lockTimeEnd;

    //回饋獎勵
    uint256 private _rewardRate = 1;
    //個人回饋的總獎勵
    mapping( address => uint256 ) private _rewardOf;

    //建構子
    constructor( IERC20 stakingToken ) {
        _stakingToken = stakingToken;
    }

    //存入多少代幣
    function deposit( uint256 coin ) public {
        //轉給合約多少代幣
        _stakingToken.transferFrom( msg.sender, address(this), coin );
        //加總合約代幣
        _totalSupply += coin;
        //加總合約的個人代幣
        _balanceOf[ msg.sender ] += coin;

        //設定個人存入的開始時間
        _lockTimeStart[ msg.sender ] = block.timestamp;
        //設定個人存入的結束時間
        _lockTimeEnd[ msg.sender ] = block.timestamp + _lockBaseTime;
    }

    function withdraw( uint256 coin ) external {
        //判斷取出時間是否大於存入的結束時間
        require( block.timestamp >= _lockTimeEnd[ msg.sender ] , "lock time..." );
        //判斷個人目前在合約的代幣是否比取出的代幣多
        require( _balanceOf[ msg.sender ] >= coin, "withdraw too much" );       

        //加總個人的回饋獎勵
        _rewardOf[ msg.sender ] += getReward();

        //從合約轉移代幣給個人
        _stakingToken.transfer( msg.sender, coin );
        //合約的代幣減少總量
        _totalSupply -= coin;
        //個人的合約代幣減少總量
        _balanceOf[ msg.sender ] -= coin;        
    }

    //回饋方式
    function getReward() public view returns ( uint256 ) {
        uint256 reward = block.timestamp - _lockTimeEnd[ msg.sender ];
        return reward * _rewardRate * _balanceOf[ msg.sender ];
    }

    //查看個人目前總回饋量
    function getTotalRewardOf( address owner ) public view returns ( uint256 ) {
        return _rewardOf[ owner ];
    }
    //查看目前合約代幣總量
    function getTotalSupply() public view returns( uint256 ){
        return _totalSupply;
    }
    //查看目前個人在合約的代幣量
    function getBalanceOf( address owner ) public view returns( uint256 ){
        return _balanceOf[ owner ];
    }
}