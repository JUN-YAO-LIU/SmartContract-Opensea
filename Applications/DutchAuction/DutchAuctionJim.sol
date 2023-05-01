// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

// 一個商品資訊struct, include original price name.
// 自動降價或是人工降價
// 誰出價錢 時間內給予金錢購買，買到就是成立

contract DutchAuctionJim{

    // 格式timestamp
    function getBlockTime()external view returns(uint){
        return block.timestamp;
    }

    // 每次計算價錢，不存在鏈上用算的。新思維：不用定時更新到資料庫，而是讀取時就是最新的。
    function getPrice()external pure returns(uint){

    }


}

// note:
// 1. how to refer the ERC721 code
// 2. convert to datetime
// 3. constructor build 