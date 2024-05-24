// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract PriceConverter {
    AggregatorV3Interface internal dataFeed;
    /**
     * Network: Sepolia
     * Aggregator: ETH/USD
     * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
     */
    constructor() {
        dataFeed = AggregatorV3Interface(
           0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }
   
    function getPrice() public view returns (int) {
        (
            /* uint80 roundID */,
            int answer, 
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer * 1e10;
    }

    function getConversionRate(int ethAmount) public view returns (int) {
       int ethPrice = getPrice();
       int amountInUsd = ethAmount * ethPrice / 1e18 ; //(we have to divide by 1e18 since eth price is returned in wei (1e18)
       return amountInUsd;
    }

   
}