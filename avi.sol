// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract AVICoin {
    mapping(address => uint256) private balances;

    // Event emitted on deposit
    event Deposit(address indexed user, uint256 amount);

    // Event emitted on withdrawal
    event Withdrawal(address indexed user, uint256 amount);

    // Accept Ether and credit to sender's balance
    receive() external payable {
        require(msg.value > 0, "Send some Ether to deposit");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Check the balance of the caller
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    // Withdraw specified amount of Ether from sender's balance
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }
}
