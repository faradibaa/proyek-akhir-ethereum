// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not ERC20 compatible and cannot be expected to talk to other
// coin/token contracts.

contract MetaCoin {
	//Menyimpan fundraise
    FundraiseCampaign[] public fundraises;
    //ID dengan nilai default nol
    uint256 id = 0;

    struct FundraiseCampaign {
        string description;
        uint256 id;
        uint256 goal;
        uint256 current;
        string name;
        string imageUrl;
        address payable owner;
    }

    event FundraiseCampaignCreated (uint256 id);

    event DonateSuccessful (uint256 id);

    event WithdrawSuccessful (uint256 id);

    function getFundraises() external view returns (FundraiseCampaign[] memory) {
        return fundraises;
    }

    function addFundraiseCampaign(
        string memory description,
        uint goal,
        string memory name,
        string memory imageUrl
    ) external {
        uint256 newId = id + 1;
        address payable owner = payable(msg.sender);

        FundraiseCampaign memory newCampaign = FundraiseCampaign(description, id, goal, 0, name, imageUrl, owner);
        fundraises.push(newCampaign);

        id = newId;
        emit FundraiseCampaignCreated(id);
    }

    //Donate uang ke fundraise ID
    function donate(uint256 fundraiseId) external payable {
        FundraiseCampaign storage fundraise = fundraises[fundraiseId];
        fundraise.current += msg.value;
        emit DonateSuccessful(fundraiseId);
    }

    //Withdraw yang hanya dapat dilakukan oleh owner (fundraiser)
    function withdraw(uint256 fundraiseId) external {
        FundraiseCampaign storage fundraise = fundraises[fundraiseId];
        address payable owner = fundraise.owner;

        require(owner == msg.sender, "Only owner can withdraw");

        owner.transfer(fundraise.current);

        fundraise.current = 0;

        emit WithdrawSuccessful(fundraise.id);
    }

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convertWeiToEth(getBalance(addr));
	}

	function getBalance(address addr) public view returns(uint) { // mendapatkan info saldo yang sama seperti di ganache
		return addr.balance;
	}

	function getAddress() public view returns(address) {
		return address(this);
	}
}
