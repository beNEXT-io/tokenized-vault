# Tokenized Vault

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

ETH Mainnet (beNEXT) - https://mainnet.infura.io/v3/f8feeb97f68642c2a1469058c4f367ec

ETH Testnet (beNEXT) - https://goerli.infura.io/v3/f8feeb97f68642c2a1469058c4f367ec

example:

```sh
forge create --rpc-url https://goerli.infura.io/v3/f8feeb97f68642c2a1469058c4f367ec \
    --constructor-args "0x07865c6e87b9f70255377e024ace6630c1eaa37f" "TokenVault" "TVLT" \
    --private-key xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \
    --etherscan-api-key QDA5R13YCMUMDASVXN28RJRAR152ARHSR9 \
    --verify \
    src/Contract.sol:TokenizedVault
```

