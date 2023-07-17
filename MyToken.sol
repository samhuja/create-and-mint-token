// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 private _totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event TokensMinted(address indexed to, uint256 value);
    event TokensBurned(address indexed from, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor(string memory tokenName, string memory tokenSymbol, uint8 tokenDecimals, uint256 initialSupply) {
        name = tokenName;
        symbol = tokenSymbol;
        decimals = tokenDecimals;
        _totalSupply = initialSupply * 10**uint256(decimals);
        _balances[msg.sender] = _totalSupply;
        owner = msg.sender;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(to != address(0), "Invalid recipient address");
        require(value <= _balances[msg.sender], "Insufficient balance");

        _balances[msg.sender] -= value;
        _balances[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        require(spender != address(0), "Invalid spender address");

        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(from != address(0), "Invalid sender address");
        require(to != address(0), "Invalid recipient address");
        require(value <= _balances[from], "Insufficient balance");
        require(value <= _allowances[from][msg.sender], "Allowance exceeded");

        _balances[from] -= value;
        _balances[to] += value;
        _allowances[from][msg.sender] -= value;

        emit Transfer(from, to, value);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function mint(address to, uint256 value) public onlyOwner {
        require(to != address(0), "Invalid recipient address");
        _totalSupply += value;
        _balances[to] += value;
        emit TokensMinted(to, value);
        emit Transfer(address(0), to, value);
    }

    function burn(uint256 value) public {
        require(value <= _balances[msg.sender], "Insufficient balance");
        _totalSupply -= value;
        _balances[msg.sender] -= value;
        emit TokensBurned(msg.sender, value);
        emit Transfer(msg.sender, address(0), value);
    }
}
