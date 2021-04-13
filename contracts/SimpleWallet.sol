// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.4;

contract SmipleWallet {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You are not allowed");
        _;
    }

    function withdrawMoney(address payable _to, uint256 _amount)
        public
        onlyOwner
    {
        _to.transfer(_amount);
    }

    // function() external payable {}
}
