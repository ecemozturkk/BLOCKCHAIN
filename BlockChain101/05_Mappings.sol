//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Mapping {
    mapping (address => bool) public registered;
    mapping (address => int256) public favNums;
    
    function register(int256 _favNum) public {
        require(!registered[msg.sender], "Hata! Kullanici daha once giris yapti."); //Eğer parantez içine yazılan koşul true değilse, fonksiyonun çağrılmasını engeller 
        registered[msg.sender] = true; //msg.sender transiction'u gönderen cüzdan adresini işaret eder
        favNums[msg.sender] = _favNum;
    }

    //doğrudan mapping'den veri okuyalım
    function isRegistered() public view returns(bool) {
        return registered[msg.sender];
    }

    //mapping'den değer silelim
    function removeRegistered() public {
        require(isRegistered(), "Kullaniciniz kayitli degil.");//Kayıt kontrolü
        delete(registered[msg.sender]);
        delete(favNums[msg.sender]);
    } 
}
contract NestedMapping {
    mapping(address => mapping(address => uint256)) public debts;

    function incDebt(address _borrower, uint256 _amount) public {
        debts[msg.sender][_borrower] += _amount;
    }

    function decDebt(address _borrower, uint256 _amount) public {
        require(debts[msg.sender][_borrower] >= _amount, "Not enough debt.");
        debts[msg.sender][_borrower] -= _amount;
    }

    function getDebt(address _borrower) public view returns (uint256) {
        return debts[msg.sender][_borrower];
    }
}