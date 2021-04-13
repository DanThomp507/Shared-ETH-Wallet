// SPDX-License-Identifier: GPL-3.0

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Allowance.sol";

pragma solidity >=0.7.4;

contract SharedWallet is Allowance {
    function withdrawMoney(address payable _to, uint256 _amount)
        public
        ownerOrAllowed(_amount)
    {
        require(
            _amount <= address(this).balance,
            "Contract doesn't own enough money"
        );
        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }

    receive() external payable {}
}
