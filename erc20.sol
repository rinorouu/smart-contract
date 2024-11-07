// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract AdvancedToken is ERC20, Ownable, Pausable {
    uint256 public transactionFee = 10; // Fee dalam basis poin (0.1%)
    address public feeRecipient;
    mapping(address => bool) private blacklist;

    constructor(address _feeRecipient) ERC20("RouuToken", "ROU") {
        feeRecipient = _feeRecipient;

        // Set total supply awal dan berikan seluruhnya kepada owner
        uint256 initialSupply = 1000_000_000 * 10 ** decimals();
        _mint(msg.sender, initialSupply);
    }

    // Fungsi untuk melihat total supply
    function getTotalSupply() external view returns (uint256) {
        return totalSupply();
    }

    // Fungsi untuk mengubah alamat penerima fee
    function setFeeRecipient(address _feeRecipient) external onlyOwner {
        feeRecipient = _feeRecipient;
    }

    // Fungsi untuk mengubah biaya transaksi
    function setTransactionFee(uint256 _fee) external onlyOwner {
        require(_fee <= 100, "Fee cannot exceed 1%");
        transactionFee = _fee;
    }

    // Fungsi untuk menambah atau menghapus dari daftar blacklist
    function setBlacklist(address account, bool value) external onlyOwner {
        blacklist[account] = value;
    }

    // Fungsi untuk mencetak koin baru
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Fungsi untuk membakar koin
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // Fungsi untuk menghentikan sementara transaksi
    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    // Override transfer untuk menambahkan biaya transaksi dan pengecekan blacklist
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override whenNotPaused {
        require(!blacklist[from] && !blacklist[to], "Address is blacklisted");
        super._beforeTokenTransfer(from, to, amount);
    }

    function _transfer(address sender, address recipient, uint256 amount) internal override {
        uint256 feeAmount = (amount * transactionFee) / 10000;
        uint256 amountAfterFee = amount - feeAmount;

        // Transfer fee ke feeRecipient dan sisa amount ke penerima
        if (feeAmount > 0) {
            super._transfer(sender, feeRecipient, feeAmount);
        }
        super._transfer(sender, recipient, amountAfterFee);
    }
}
