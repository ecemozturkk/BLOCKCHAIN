//SPDX-License_Identifier: Unlicensed
pragma solidity ^0.8.0;

contract variables {
    
    // FIXED-SZIE TYPES (Sabit Boyutlu Değişkenler)
    bool isTrue = true;
    bool isFalse; //eğer eşitlenmezse default olarak FALSE değeri atar
    int number = 10;
    uint number2 = 12; // 0 to 2^256

    address myAddress = 0x0482B491EDB0140D3b6eB792A3bB2F8a292BDc9B; //cüzdan adresi

    // DYNAMIC-SIZE TYPES

    string name2= "blockchain";

    uint[] array = [1,2,3,4]; // array[3]=4

    //bir anahtar kelime var ve bu anahtar kelime bir veriyi tutuyor
    //mapping(int => string) public list; //bir numara söylüyorum ve bu numara bir isim tutuyor
    mapping(address => uint) public addressMap;
    //list[3] = "ecem";
    
    // USER DEFINED VALUE TYPES
    struct Human  {
        uint ID;
        string name;
        uint age;
    }
    Human person1; //Human artık bir ver tipi
    person1.ID = 44;
    person1.name = "Ecem";
    person1.age = 23;

    enum trafficLight {
        RED,
        YELLOW,
        GREEN
    }
    //trafficLight.GREEN;

    // STATE VARIABLES
    string public bestClub = "blockchain club";

    function show() public view returns(string memory){
        return bestClub
    } 

}
