// SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.18;

contract MultiSignWallet{
    // 感覺像是事件紀錄的狀態
    event Deposit(address indexed sender,uint amount);
    event Submit(uint indexed txId);
    event Approve(address indexed owner,uint  indexed txId);
    event Revoke(address indexed owner, uint indexed txId);
    event Execute(uint indexed txId);

    struct Transaction{
        address to;
        uint value;
        bytes data;
        bool executed;
    }

    // 需要幾個簽章
    address[] public owners;

    // 紀錄地址是否存在過?
    mapping(address => bool) public isOwner;

    // 幾個簽章
    uint public required;
    Transaction[] public transactions;

    // 這次交易有幾個同意?
    mapping(uint => mapping(address => bool)) public approved;
   
    modifier onlyOwner(){
        require(!isOwner[msg.sender],"not owner");
        _;
    }

    modifier txExists(uint _txId){
        require(_txId < transactions.length,"tx does not exist");
        _;
    }

    modifier notApproved(uint _txId){
        require(!approved[_txId][msg.sender],"tx already approved");
        _;
    }

    modifier notExecute(uint _txId){
        require(!transactions[_txId].executed,"tx already executed");
        _;
    }

    constructor(address[] memory _owners,uint _required){
        require(_owners.length > 0,"owners required.");
        require(
            _required >0 &&  _required <=_owners.length, 
            "required number must be than owners."
        );

        for(uint i; i < _owners.length; i++){
            address owner = _owners[i];

            require(owner != address(0),"invalid owner");
            require(!isOwner[owner],"owner is not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }
        required = _required;
    }


    receive() external payable{
        emit Deposit(msg.sender,msg.value);
    }

    function submit(address _to,uint _value,bytes calldata _data) 
        external 
        onlyOwner
    {
        transactions.push(Transaction({
            to:_to,
            value:_value,
            data:_data,
            executed: false
        }));
        emit Submit(transactions.length -1);
    }

    function approve(uint _txId) external 
        onlyOwner 
        txExists(_txId) 
        notApproved(_txId) 
        notExecute(_txId)
    {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender,_txId);
    }

    function _getApprovalCount(uint _txId) private view returns(uint count){
        for(uint i;i < owners.length; i++){
            if(approved[_txId][owners[i]]){
                count +=1;
            }
        }
    }

    function execute(uint _txId) external txExists(_txId) notExecute(_txId){
        require(_getApprovalCount(_txId) >= required,"approvals < required");
        Transaction storage transaction = transactions[_txId];

        transaction.executed = true;

        (bool success,) = transaction.to.call{value: transaction.value}(
          transaction.data
        );
        require(success,"tx fail");
        emit Execute(_txId);
    }

    function revoke(uint _txId)
        external
        onlyOwner 
        txExists(_txId) 
        notExecute(_txId)
    {
        require(approved[_txId][msg.sender],"tx fail");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender,_txId);
    }

}
