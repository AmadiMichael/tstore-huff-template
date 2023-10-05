// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "lib/foundry-huff/src/HuffDeployer.sol";

interface SimpleTStore {
    function tstore(uint256 slot, uint256 value) external;
    function tload(uint256 slot) external view returns (uint256);
}

contract TestSimpleTStore is Test {
    SimpleTStore simpleTstore;

    function setUp() public {
        simpleTstore = SimpleTStore(HuffDeployer.deploy("SimpleTStore"));
        console.logBytes(address(simpleTstore).code);
    }

    function testSimpleTstore() public {
        simpleTstore.tstore(0, 1);
        assertEq(simpleTstore.tload(0), 1);
    }
}
