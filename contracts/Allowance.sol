// SPDX-License-Identifier: GPL-3.0

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

pragma solidity >=0.7.4;

contract Allowance is Ownable {
    using SafeMath for uint256;

    event AllowanceChanged(
        address indexed _forWho,
        address indexed _byWhom,
        uint256 _oldAmount,
        uint256 _newAmount
    );
    mapping(address => uint256) public allowance;

    function isOwner() internal view returns (bool) {
        return owner() == msg.sender;
    }

    function setAllowance(address _who, uint256 _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
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
        emit AllowanceChanged(
            _who,
            msg.sender,
            allowance[_who],
            allowance[_who].sub(_amount)
        );
        allowance[_who] = allowance[_who].sub(_amount);
    }
}
