# Tokenized Vault

ETH Mainnet (beNEXT) - https://mainnet.infura.io/v3/f8feeb97f68642c2a1469058c4f367ec  
ETH Testnet (beNEXT) - https://goerli.infura.io/v3/f8feeb97f68642c2a1469058c4f367ec

Tokenized Vault (TVLT) - https://goerli.etherscan.io/address/0x0cc77e7c4432490cf5cecd1f777665035eb4bb3f 

```sh
forge build
forge test
forge create --rpc-url <rpc_url> \
    --constructor-args "<asset_address>" "<name>" "<symbol>" \
    --private-key <your_private_key> \
    --etherscan-api-key <your_etherscan_api_key> \
    --verify \
    src/Contract.sol:TokenizedVault
```



**Example:**

```sh
forge create --rpc-url https://goerli.infura.io/v3/f8feeb97f68642c2a1469058c4f367ec \
    --constructor-args "0x07865c6e87b9f70255377e024ace6630c1eaa37f" "TokenVault" "TVLT" \
    --private-key xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \
    --etherscan-api-key QDA5R13YCMUMDASVXN28RJRAR152ARHSR9 \
    --verify \
    src/Contract.sol:TokenizedVault
```



## Depositing USDC into ERC4626 Contract via Etherscan

Before a user can deposit their USDC into your ERC4626 contract, they need to "approve" the contract to spend their tokens. Here is how a user can do this using Etherscan:

1. **Approve**:
   
   The user needs to first go to the Etherscan page for the USDC token. They can do this by searching for the token in the Etherscan search bar.

   - Once on the USDC page, click on the `Contract` tab and then click `Write Contract`.
   - Connect to Web3 (this is typically done through a MetaMask pop-up).
   - Find the `approve` function in the list of available functions. 
   - For the `spender` parameter, input the contract address of your ERC4626 contract. 
   - For the `amount` parameter, input the amount of USDC they wish to approve your contract to use. This value needs to be in the token's smallest unit, so they will need to include the appropriate number of decimal places for USDC (which is 6). For example, to approve 100 USDC, they would input `100000000`.
   - Click `Write` and confirm the transaction in their wallet. 


2. **Deposit**:

   Now the user is ready to deposit their USDC into your ERC4626 contract. 

   - They need to navigate to your contract's page on Etherscan (they can search for the contract address in the Etherscan search bar). 
   - Click on the `Contract` tab and then click `Write Contract`.
   - Connect to Web3 again.
   - Find the `deposit` function. They will need to input the amount of USDC they wish to deposit (again, in the smallest unit so with 6 decimal places) and the receiver address (usually their own address).
   - Click `Write` and confirm the transaction in their wallet.

After the deposit transaction has been confirmed, the user's USDC balance will have decreased and their balance of your ERC4626 tokens will have increased correspondingly. They can check their balance in your contract by using the `balanceOf` function in the `Read Contract` section of your contract's Etherscan page.

