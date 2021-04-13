// SPDX-License-Identifier: GPL-3.0

import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity >=0.7.4;

contract SmipleWallet is Ownable {
    function withdrawMoney(address payable _to, uint256 _amount)
        public
        onlyOwner
    {
        _to.transfer(_amount);
    }

    // function() external payable {}
}
