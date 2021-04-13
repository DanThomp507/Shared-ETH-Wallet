// SPDX-License-Identifier: GPL-3.0

import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity >=0.7.4;

contract SmipleWallet is Ownable {
    mapping(address => uint256) public allowance;

    function isOwner() private view returns (bool) {
        return owner() == msg.sender;
    }

    function addAllowance(address _who, uint256 _amount) public onlyOwner {
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint256 _amount) {
        require(
            isOwner() || allowance[msg.sender] >= _amount,
            "You are not allowed"
        );
        _;
    }

    function withdrawMoney(address payable _to, uint256 _amount)
        public
        ownerOrAllowed(_amount)
    {
        _to.transfer(_amount);
    }

    // function() external payable {}
}
