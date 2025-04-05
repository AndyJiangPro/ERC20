// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import {console} from "forge-std/console.sol";
import {MyERC20} from "../MyERC20.sol";

contract BaseSetup is Test {
    address internal alice;
    address internal bob;
    MyERC20 myERC20Token;

    function setUp() public virtual {
        alice = vm.addr(1);
        bob = vm.addr(2);
        vm.label(alice, "Alice");
        vm.label(bob, "Bob");
        myERC20Token = new MyERC20();
    }

    function testTokenTransfer() public {
        console.log(myERC20Token.balanceOf(address(this)));
        assertTrue(myERC20Token.balanceOf(address(this)) == 10000 ether);
        assertTrue(myERC20Token.balanceOf(alice) == 0);
        assertTrue(myERC20Token.balanceOf(bob) == 0);
        myERC20Token.transfer(alice, 1 ether);
        assertEq(myERC20Token.balanceOf(address(this)), 9999 ether);
        assertEq(myERC20Token.balanceOf(alice), 1 ether);
        assertEq(myERC20Token.balanceOf(bob), 0);
        console.log("this token balance: ", myERC20Token.balanceOf(address(this)));
        console.log("alice token balance: ", myERC20Token.balanceOf(alice));
        console.log("bob token balance: ", myERC20Token.balanceOf(bob));

        // alice transfer 0.5 token to bob
        vm.startPrank(alice);
        myERC20Token.transfer(bob, 0.5 ether);
        vm.stopPrank();
        assertEq(myERC20Token.balanceOf(address(this)), 9999 ether);
        assertEq(myERC20Token.balanceOf(alice), 0.5 ether);
        assertEq(myERC20Token.balanceOf(bob), 0.5 ether);
        console.log("this token balance: ", myERC20Token.balanceOf(address(this)));
        console.log("alice token balance: ", myERC20Token.balanceOf(alice));
        console.log("bob token balance: ", myERC20Token.balanceOf(bob));

   }
}