//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract IfElse {
    /*
    global değişkende bir şifre tutalım;
    şifreyi string olarak değil bytes32 olarak tutacağız
    çünkü solidit'de doğrudan stringlerin karşılaştırılmasını sağlayan bir method yok.
    Karşılaştırma işlemi string'lerin hash'lerinin alınarak karşılaştırılmasıyla yapılır.
    */
    bytes32 private hashedPassword;
    
    constructor(string memory _password) { //memory'de alınması bu değişkenin bu fonksiyon içinde kalmasını ve blockchain'e kaydedilmemesini sağlıyor.
        hashedPassword = keccak256(abi.encode(_password)); //hashlenmiş şifre'yi hashedPassword'e atadık.

    }
    function login(string memory _password) public returns (bool) {
        if(hashedPassword == keccak256(abi.encode(_password))) {
            return true;
        }
        else {
            return false;
        }
        /*
        if-else kullanmak yerine kısayol:
        return (hashedPassword == keccak256(abi.encode(_password));
        ya da
        return  (hashedPassword == keccak256(abi.encode(_password)) ? 1 : 0 ;
        */

    }
    //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    uint256[15] public numbers0;
    uint256[15] public numbers1;

    function listByFor() public {
        uint256[15] memory nums = numbers0;
        for(uint256 i=0; i<nums.length; i++){
            nums[i] =i;
        }
        numbers0 = nums;
    }
    function getArr0() public view returns(uint[15] memory){
        return numbers0;
    }

    





}