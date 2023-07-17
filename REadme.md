MyToken Smart Contract
The MyToken smart contract is an implementation of an ERC20 token on a local HardHat network. It allows the contract owner to mint tokens to a provided address and allows any user to burn and transfer tokens.

Token Information
Name: MyToken
Symbol: MT
Decimals: 18 (1 ether = 10^18 tokens)
Initial Supply: Customizable at deployment
Functions
totalSupply()
Returns the total supply of tokens.
balanceOf(address account)
Returns the token balance of a specified address.
transfer(address to, uint256 value)
Transfers a specified amount of tokens from the caller's address to the provided address.
Reverts if the recipient address is invalid or the caller has an insufficient balance.
approve(address spender, uint256 value)
Allows a spender address to spend a specified amount of tokens on behalf of the caller.
Returns a boolean value indicating the success of the approval.
transferFrom(address from, address to, uint256 value)
Transfers a specified amount of tokens from one address (the from address) to another (the to address).
The transfer must be authorized by the from address through the approve() function beforehand.
Reverts if any of the addresses involved are invalid or if the transfer exceeds the allowed amount.
allowance(address owner, address spender)
Returns the amount of tokens allowed to be spent by the spender address on behalf of the owner address.
mint(address to, uint256 value)
Allows the contract owner to mint a specified amount of tokens to the provided address (to).
Reverts if the provided address is invalid.
burn(uint256 value)
Allows any user to burn (destroy) a specified amount of their own tokens.
Reverts if the user has an insufficient balance.
