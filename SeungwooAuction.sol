//SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.7.0;
contract auction {
    address owner;
    address public highestBidder;
    uint public highestBid;
    uint public deadline;
    bool end;

    constructor(uint duration) payable {
        end = false;
        owner = msg.sender;
        highestBidder = msg.sender;
        highestBid = 0;
        deadline = block.timestamp + duration;
    }

    function Bid() payable public {
        require(msg.value > highestBid);

        uint refundAmmount = highestBid;
        address refundAddress = highestBidder;

        highestBid = msg.value;
        highestBidder = msg.sender;

        if (!payable(refundAddress).send(refundAmmount)) {
            revert();
        }
    }

    function isEnd() public returns(bool) {
        end = (block.timestamp > deadline);
        return end;
    }

    function endAuction() public {
        if (end == false) {
            revert();
        }

        if (!payable(owner).send(address(this).balance)) {
            revert();
        }

        selfdestruct(payable(owner));
    }
}
