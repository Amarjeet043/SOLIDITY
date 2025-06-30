// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Contract.sol"; 
import {console} from  "forge-std/console.sol";

// contract TestCounter is Test {
//     Contract c;

//     function setUp() public {
//         c = new Contract(5);
//     }

    // function testBar() public {
    //     assertEq(uint256(1), uint256(1), "ok");
    // }

    // function testFoo(uint256 x) public {
    //     vm.assume(x < type(uint128).max);
    //     assertEq(x + x, x * 2);
    // }
//     function testInc() public{
//         c.increament();
//         c.increament();
//         assertEq(c.num(),7,"ok");

//     }
//     function testDec() public{
//         c.decreament();
//         c.decreament();
//         assertEq(c.num(),3,"Ok");

//     }
//     function test_Revert()public{
//         c.decreament();
//         c.decreament();
//         c.decreament();
//         c.decreament();
//         c.decreament();
//         c.decreament();
//         c.decreament();


//     }
// }

contract AMARCOIN is Test{
    mytoken c;
     event Transfer(address indexed from, address indexed to, uint256 amount);
      event Approval(address indexed owner, address indexed spender, uint256 value);
    function setUp() public{
        c=new mytoken();

    }

 
    function testMint()public{
            
        console.log("Hi There");
        c.mint(address(this),100);
        assertEq(c.balanceOf(address(this)), 100,"OK");
        // assertEq(c.balanceOf(0x49963B291bd212702ae6Fc79556086B52F41622F), 100,"OK");

    }
    function testTransfer() public {
        c.mint(address(this), 100);
        c.transfer(0x49963B291bd212702ae6Fc79556086B52F41622F, 50);
        
        assertEq(c.balanceOf(address(this)), 50);
        assertEq(c.balanceOf(0x49963B291bd212702ae6Fc79556086B52F41622F), 50);

        vm.prank(0x49963B291bd212702ae6Fc79556086B52F41622F);
       c.transfer(address(this), 20);
    //    c.transfer(address(this), 30);



        // vm.prank(address(this));
        
        c.transfer(address(0x49963B291bd212702ae6Fc79556086B52F41622F), 30);

        assertEq(c.balanceOf(address(this)), 40);
        assertEq(c.balanceOf(0x49963B291bd212702ae6Fc79556086B52F41622F), 60);
    }
    function testApprovals()public{
        c.mint(address(this),100);
        c.approve(0x49963B291bd212702ae6Fc79556086B52F41622F,20);
      
       assertEq(c.allowance(address(this),0x49963B291bd212702ae6Fc79556086B52F41622F),20);
       assertEq(c.allowance(0x49963B291bd212702ae6Fc79556086B52F41622F,address(this)),0);

        vm.prank(0x49963B291bd212702ae6Fc79556086B52F41622F);
       //Now this address can call transferFrom()
       c.transferFrom(address(this),0x49963B291bd212702ae6Fc79556086B52F41622F,10);
       assertEq(c.balanceOf(address(this)),90,"OK");
       assertEq(c.balanceOf(0x49963B291bd212702ae6Fc79556086B52F41622F),10,"OK");
       assertEq(c.allowance(address(this),0x49963B291bd212702ae6Fc79556086B52F41622F),10);

    }
    function test_Revert_MoreSending()public{
       
        c.mint(address(this),100);
        c.approve(0x49963B291bd212702ae6Fc79556086B52F41622F,20);
        vm.prank(0x49963B291bd212702ae6Fc79556086B52F41622F);
         vm.expectRevert();
        c.transferFrom(address(this),0x49963B291bd212702ae6Fc79556086B52F41622F,30);




    }
    function test_Revert_FailTransfer()public{
        c.mint(address(this),40);
         vm.expectRevert();
        c.transfer(0x49963B291bd212702ae6Fc79556086B52F41622F,100);
    }

    function test_ExpectEmit() public {
        c.mint(address(this), 100);
        // Check that topic 1, topic 2, and data are the same as the following emitted event.
        // Checking topic 3 here doesn't matter, because `Transfer` only has 2 indexed topics.
        vm.expectEmit(true, true, false, true);
        // The event we expect
        emit Transfer(address(this), 0x075c299cf3b9FCF7C9fD5272cd2ed21A4688bEeD, 100);
        // The event we get
        c.transfer(0x075c299cf3b9FCF7C9fD5272cd2ed21A4688bEeD, 100);
    }
    
    function test_ExpectEmitApprove() public {
        c.mint(address(this), 100);
        
        vm.expectEmit(true, true, false, true);
        emit Approval(address(this), 0x075c299cf3b9FCF7C9fD5272cd2ed21A4688bEeD, 100);

        c.approve(0x075c299cf3b9FCF7C9fD5272cd2ed21A4688bEeD, 100);
        vm.prank(0x075c299cf3b9FCF7C9fD5272cd2ed21A4688bEeD);
        c.transferFrom(address(this), 0x075c299cf3b9FCF7C9fD5272cd2ed21A4688bEeD, 100);
    }
    


}











