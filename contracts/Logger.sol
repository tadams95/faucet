//SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

//it's a way for a designer to say that
//"any child of the abstract contract has to implement specifed methods"

abstract contract Logger {
    uint public testNum;

    constructor() {
        testNum = 1000;
    }

    function emitLog() public pure virtual returns (bytes32);

    function test3() public pure returns (uint) {
        return 100;
    }

    function test5() external pure returns(uint) {
        test3();
        return 10;
    }
}
