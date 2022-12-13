// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract GamePool {
    IERC20 public immutable USDTToken;

    address private owner;

    // Total staked
    uint256 public totalSupply;

    // deposit token amount
    mapping(address => uint256) depositTokenAmount;

    // User address => staked amount
    mapping(address => uint256) public balanceOf;

    // only for USDT token
    // address USDTAddress = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address USDTAddress = 0x5741532ABF2F1571535f1bBbf049328EF04d9E8E;

    event Deposit(address indexed sender, uint256 amount, uint256 balance);

    constructor() {
        owner = msg.sender;
        USDTToken = IERC20(USDTAddress);
    }

    modifier checkDeposit(address _account) {
        _;
    }

    function deposit(uint256 _amount) external checkDeposit(msg.sender) {
        require(_amount > 0, "amount = 0");

        USDTToken.transferFrom(msg.sender, address(this), _amount);
        balanceOf[msg.sender] += _amount;
        totalSupply += _amount;

        emit Deposit(msg.sender, _amount, address(this).balance);
    }

    function withdraw(address _toAddress,uint256 _amount) external {
        require(_amount > 0, "amount = 0");

        USDTToken.transfer(_toAddress, _amount);
        totalSupply -= _amount;
    }
}
