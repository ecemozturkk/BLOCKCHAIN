// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BEEToken is ERC20 {
    constructor() ERC20("BEE Token", "BEE") { // ERC20 = protokol standardıdır "Ethereum Request for Comments"
        _mint(msg.sender, 1773000 * 10 ** decimals()); //tokendan arz oluşturuluyor
                    //token adedi * (wei değeri(10 üzeri 18))
    }
}
