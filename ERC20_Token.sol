//total supply,trasfer,trasferfrom,approve,balance
// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0;
contract  ERCToken{
    event Transfer(address from,address to,uint tokens);
    event Approval(address tokenOwner,address spender,uint tokens);

    string public constant name="VOH Coin";
    string public constant symbol="VOHN";
    uint8 public constant decimals=18;

    mapping(address=>uint256) public balances;
    mapping(address=>mapping(address=>uint256)) public allowed;

    uint256 totalSupply_;

    constructor(uint256 total){
        totalSupply_=total;
        balances[msg.sender]=totalSupply_;
    } 
    function totalSupply()public view returns(uint256){
            return totalSupply_;
    }
    function balanceOf(address owner)public view returns(uint256){
        return balances[owner];
    }
    function transfer(address receiver,uint numTokens)public returns(bool){
        require(numTokens<=balances[msg.sender],"Not required amount of Balance");
        balances[msg.sender]-=numTokens;
        balances[receiver]+=numTokens;
        emit Transfer(msg.sender,receiver,numTokens);
        return true;
    }
    function approve(address delegate,uint numTokens)public returns(bool){
        allowed[msg.sender][delegate]=numTokens;
        emit Approval(msg.sender,delegate,numTokens);
        return true;
    }
    function allowance(address owner,address delegate)public view returns(uint){
        return allowed[owner][delegate];
    }
    function transferFrom(address owner,address buyer, uint256 numTokens)public  returns(bool){
        require(balances[owner]>=numTokens);
        require(allowed[msg.sender][owner]>=numTokens);
        balances[owner]-=numTokens;
        allowed[msg.sender][owner]-=numTokens;
        balances[buyer]+=numTokens;
        emit Transfer(owner,buyer,numTokens);
        return true;

    }

}