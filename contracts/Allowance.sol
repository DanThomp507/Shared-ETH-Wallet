// SPDX-License-Identifier: GPL-3.0

import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity >=0.7.4;

contract Allowance is Ownable {
    function isOwner() internal view returns (bool) {
        return owner() == msg.sender;
    }

    mapping(address => uint256) public allowance;

    function setAllowance(address _who, uint256 _amount) public onlyOwner {
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint256 _amount) {
        require(
            isOwner() || allowance[msg.sender] >= _amount,
            "You are not allowed!"
        );
        _;
    }

    function reduceAllowance(address _who, uint256 _amount)
        internal
        ownerOrAllowed(_amount)
    {
        allowance[_who] -= _amount;
    }
}
