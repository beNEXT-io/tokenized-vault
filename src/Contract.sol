// SPDX-License-Identifier: APACHE

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

/**
 * @title TokenizedVault
 * @dev This contract is a concrete implementation of ERC4626.
 */
contract TokenizedVault is ERC4626, Ownable {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     * @dev Sets the values for {name}, {symbol} and {_decimals}
     */
    constructor(
        IERC20 asset_,
        string memory name_,
        string memory symbol_
    ) ERC4626(asset_) ERC20(name_, symbol_) Ownable() {
        _name = name_;
        _symbol = symbol_;
        _decimals = ERC20(address(asset_)).decimals();
    }

    /**
     * @dev Returns the name of the token.
     */
    function name()
        public
        view
        virtual
        override(ERC20, IERC20Metadata)
        returns (string memory)
    {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol()
        public
        view
        virtual
        override(ERC20, IERC20Metadata)
        returns (string memory)
    {
        return _symbol;
    }

    /**
     * @dev Returns the amount of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * This function has been updated to return the value of `_decimals`,
     * which is set to match the decimals of the underlying asset in the constructor.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override(ERC4626) returns (uint8) {
        return _decimals;
    }
}