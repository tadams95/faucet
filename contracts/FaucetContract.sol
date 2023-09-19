//SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {
    //this is a special function
    //it's called when you make a tx that doesn't specify
    //function name to call

    //External functions are part of the contract interface
    //which means they can be called via contracts and other txns
   
   address[] public funders;

   receive() external payable {}

   function addFunds() external payable {
    funders.push(msg.sender);
   }

   function getAllFunders() public view returns (address[] memory) {
    return funders;
   }

   function getFunderAtIndex(uint8 index) external view returns(address) {
    address[] memory _funders = getAllFunders();
    return _funders[index];
   }

    //pure, view - read-only call, no gas fee
    //view: it indicates that the function will not alter the storage state in any way
    //pure: even more strict, indicating that it won't even read the storage state

    //Transactions (can generate state changes) and requires gas fee

    //to talk to the node on the network, you can make JSON-RPC http calls

    //Block info
    //Nonce - a hash that when combined with the minHash proves that
    //the block has gone through proof of work(POW)
    // 8 BYTES => 64 BITS
}
