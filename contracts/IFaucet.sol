//SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

//these cannot inherit from other smart contracts
//these can only inherit from other interface contracts

//these cannot declare a constructor
//these cannot declare state variables
//all declared functions have to be external

interface IFaucet { 
    function addFunds() external payable;
    function withdraw(uint withdrawAmount) external;
}