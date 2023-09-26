//SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Owned.sol";
import "./Logger.sol";
import "./IFaucet.sol";

contract Faucet is Owned, Logger, IFaucet {
    //this is a special function
    //it's called when you make a tx that doesn't specify
    //function name to call

    //External functions are part of the contract interface
    //which means they can be called via contracts and other txns
    uint public numOfFunders;
    mapping(address => bool) private funders;
    mapping(uint => address) private lutFunders;

    modifier limitWithdraw(uint withdrawAmount) {
        require(
            withdrawAmount <= 100000000000000000,
            "Cannot withdraw more than 0.1 ETH"
        );
        _;
    }

    receive() external payable {}

    function emitLog() public pure override returns (bytes32) {
        return "Hello World";
    }

    function transferOwnership(address newOwner) external onlyOwner {
        owner = newOwner;
    }

    function addFunds() external payable {
        address funder = msg.sender;
       test3();

        if (!funders[funder]) {
            uint index = numOfFunders++;
            funders[funder] = true;
            lutFunders[index] = funder;
        }
    }

    function test1() external onlyOwner {
        //some managing stuff that only admin should have access to
    }

    function test2() external onlyOwner {
        //some managing stuff that only admin should have access to
    }

    function withdraw(
        uint withdrawAmount
    ) external limitWithdraw(withdrawAmount) {
        payable(msg.sender).transfer(withdrawAmount);
    }

    function getAllFunders() public view returns (address[] memory) {
        address[] memory _funders = new address[](numOfFunders);

        for (uint i = 0; i < numOfFunders; i++) {
            _funders[i] = lutFunders[i];
        }
        return _funders;
    }

    function getFunderAtIndex(uint8 index) external view returns (address) {
        return lutFunders[index];
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

    //const instance = await Faucet.deployed();
    //instance.addFunds({from: accounts[0], value: "2000000000000000000"})
    //instance.addFunds({from: accounts[1], value: "2000000000000000000"})

    //instance.withdraw("500000000000000000", {from: accounts[1]})
    //instance.getFunderAtIndex(0)
    //instance.getAllFunders()
}
