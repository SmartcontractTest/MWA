/*
 * @source: https://consensys.github.io/smart-contract-best-practices/known_attacks/#front-running-aka-transaction-ordering-dependence
 * @author: consensys
 * @vulnerable_at_lines: 17,19
 */

pragma solidity ^0.4.0;

contract IntegerOverflowAdd {
    mapping (address => uint256) public balanceOf;

    // INSECURE
    function transfer(address _to, uint256 _value) public{
        /* Check if sender has balance */
        require(balanceOf[msg.sender] >= _value);
balanceOf[msg.sender] -=int256(_value);//Mutation Here for <16>
        // <yes> <report> ARITHMETIC
        balanceOf[_to] += _value;  //<overflow>
		require(balanceOf[_to] > _value);  //<repair>
}

}
