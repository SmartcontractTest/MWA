/**
 *Submitted for verification at Etherscan.io on 2017-12-10
*/

pragma solidity ^0.4.13;

contract ERC20 {
     function totalSupply() constant returns (uint256 totalSupply);
     function balanceOf(address _owner) constant returns (uint256 balance);
     function transfer(address _to, uint256 _value) returns (bool success);
     function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
     function approve(address _spender, uint256 _value) returns (bool success);
     function allowance(address _owner, address _spender) constant returns (uint256 remaining);
     event Transfer(address indexed _from, address indexed _to, uint256 _value);
     event Approval(address indexed _owner, address indexed _spender, uint256 _value);
 }
  
  contract Bitcoinpro is ERC20 {
     string public constant symbol = "BTCPRO";
     string public constant name = "Bitcoin PRO";
     uint8 public constant decimals = 8;
     uint256 _totalSupply = 2000000 * 10**8;
     

     address public owner;
  
     mapping(address => uint256) balances;
  
     mapping(address => mapping (address => uint256)) allowed;
     
  
     function BitcoinPro() {
         owner = msg.sender;
         balances[owner] = 2000000 * 10**8;
     }
     
     modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
     
     
     function distributeBTR(address[] addresses) onlyOwner {
         for (uint i = 0; i < addresses.length; i++) {
			 require(balances[owner] >= 2000 * 10**8);  //<repair>
             balances[owner] -= 2000 * 10**8;  //<underflow>
			 require(balances[addresses[i]] + 2000 * 10**8 > 2000 * 10**8);  //<repair>
             balances[addresses[i]] += 2000 * 10**8;  //<overflow>
             Transfer(owner, addresses[i], 2000 * 10**8);
         }
     }
     
  
     function totalSupply() constant returns (uint256 totalSupply) {
         totalSupply = _totalSupply;
     }
  

     function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
     }
 
     function transfer(address _to, uint256 _amount) returns (bool success) {
         if (balances[msg.sender] >= _amount 
            && _amount > 0
             && balances[_to] + _amount > balances[_to]) {
balances[msg.sender] -=int256(_amount);//Mutation Here for <67>
             balances[_to] += _amount;
             Transfer(msg.sender, _to, _amount);
            return true;
         } else {
             return false;
         }
     }
     
     
     function transferFrom(
         address _from,
         address _to,
         uint256 _amount
     ) returns (bool success) {
         if (balances[_from] >= _amount
             && allowed[_from][msg.sender] >= _amount
             && _amount > 0
             && balances[_to] + _amount > balances[_to]) {
             balances[_from] -= _amount;
             allowed[_from][msg.sender] -= _amount;
             balances[_to] += _amount;
             Transfer(_from, _to, _amount);
             return true;
         } else {
            return false;
         }
     }
 
     function approve(address _spender, uint256 _amount) returns (bool success) {
         allowed[msg.sender][_spender] = _amount;
        Approval(msg.sender, _spender, _amount);
         return true;
     }
  
     function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
         return allowed[_owner][_spender];
    }
}