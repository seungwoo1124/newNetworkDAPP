//SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.7.0;
contract auction {
    address owner;
    address public highestBidder;
    uint public highestBid;
    uint public deadline;
    bool public end;

    constructor(uint duration) payable {
        end = false;
        owner = msg.sender;
        highestBidder = msg.sender;
        highestBid = 0;
        deadline = block.timestamp + duration;
    }

    function Bid() payable public {
        require(msg.value > highestBid);
        require(end == false);

        uint refundAmmount = highestBid;
        address refundAddress = highestBidder;

        highestBid = msg.value;
        highestBidder = msg.sender;

        if (!payable(refundAddress).send(refundAmmount)) {
            revert();
        }
    }

    function endAuction() public returns(bool) {
        if (block.timestamp <= deadline) {
            return false;
        }
        end = true;

        if (!payable(owner).send(address(this).balance)) {
            revert();
        }
        return true;
    }
}
