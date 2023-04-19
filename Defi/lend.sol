// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;

contract Lend{

    // 狀態
    // 放貸多久，通常時間單位？天？ 閏月問題？計算今天幾月幾號？
    // days is one of the time unit. 
    uint256 public dayLong;

    // 期數類型
    // enum termType;

    uint8 public startAt;

    uint8 public endAt;

    int256 public price;

    int8 public lendRate;

    // 方法
    // 申請放貸
    // 拿回金額
    // 查詢放貸金額

}