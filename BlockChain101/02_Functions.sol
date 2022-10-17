//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Functions {
    
    uint luckyNumber = 7;
    function showNumber() public view returns(uint) {
        return luckyNumber;
    }
    // YA DA KISALTACAK OLURSAK;
    uint public luckyNUMBER = 12;


    //SAYI DEĞİŞTİRME FONKSİYONU
    function setNumber(uint newNumber) public {
        luckyNumber = newNumber;
    }

    function add(uint a, uint b) public pure returns(uint){
        return a+b;
    }
    function add2(uint c, uint d) public pure returns(uint){
        return add(c,d);
    }

    function publicKeyword() public pure returns (string memory){
        return "Bu bir public fonksiyondur";
    }
    function callPublicKeyword() public pure returns (string memory){
        return publicKeyword();
    }
}
