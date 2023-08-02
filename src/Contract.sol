// SPDX-License-Identifier: APACHE

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/IAccessControl.sol";

/**
 * @title TokenizedVault
 * @dev This contract is a concrete implementation of ERC4626.
 */
contract TokenizedVault is ERC4626, Ownable, IAccessControl {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    // Define roles
    bytes32 public constant DEPOSITOR_ROLE = keccak256("DEPOSITOR_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant WITHDRAWER_ROLE = keccak256("WITHDRAWER_ROLE");
    bytes32 public constant REDEEMER_ROLE = keccak256("REDEEMER_ROLE");

    /**
     * @dev Sets the values for {name}, {symbol} and {_decimals}
     */
    constructor(
        IERC20 asset_,
        string memory name_,
        string memory symbol_
    ) ERC4626(asset_) ERC20(name_, symbol_) Ownable() {
        // Set name, symbol and decimals for contract
        _name = name_;
        _symbol = symbol_;
        _decimals = ERC20(address(asset_)).decimals();

        // Grant roles to msg.sender
        _setupRole(DEPOSITOR_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender);
        _setupRole(WITHDRAWER_ROLE, msg.sender);
        _setupRole(REDEEMER_ROLE, msg.sender);
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

    /**
     * @dev Deposits `amount` of the underlying asset into the contract.
     * Only accounts with the DEPOSITOR_ROLE can call this function.
     */
    function deposit(
        uint256 amount,
        address receiver
    ) public override onlyRole(DEPOSITOR_ROLE, msg.sender) {
        super.deposit(amount, receiver);
    }

    /**
     * @dev Mints `shares` of the underlying asset into the contract.
     * Only accounts with the MINTER_ROLE can call this function.
     */
    function mint(
        uint256 shares,
        address receiver
    ) public override onlyRole(MINTER_ROLE, msg.sender) {
        super.deposit(shares, receiver);
    }

    /**
     * @dev Withdraws `amount` of the underlying asset from the contract.
     * Only accounts with the WITHDRAWER_ROLE can call this function.
     */
    function withdraw(
        uint256 amount,
        address receiver
    ) public override onlyRole(WITHDRAWER_ROLE, msg.sender) {
        super.withdraw(amount, receiver);
    }

    /**
     * @dev Redeems `shares` of the underlying asset from the contract.
     * Only accounts with the REDEEMER_ROLE can call this function.
     */
    function redeem(
        uint256 shares,
        address receiver
    ) public override onlyRole(REDEEMER_ROLE, msg.sender) {
        super.redeem(shares, receiver);
    }

}
