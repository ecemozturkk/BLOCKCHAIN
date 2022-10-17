// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    uint public x;
    uint public y;
    
    function setX (uint _x) public {
        x = _x;
    }
    function setY (uint _y) public {
        y= _y;
    }
}

//Miras alma yöntemi : "is" anahtar kelimesi ile yapılır
contract B is A {

}

// Eğer miras alındığında değişim yapmak istiyorsak (A'nın mirasını alırken x'in 2 katını alıp y'nin aynı kalmasını istemek gibi)
// miras alınacak contract'taki değiştirebilmeyi istediğimiz fonksiyona VİRTUAL kelimesini ekliyoruz

contract C {
    uint public x;
    uint public y;
    
    function setX (uint _x) virtual public {
        x = _x;
    }
    function setY (uint _y) public {
        y= _y;
    }
}

contract D is C {
    uint public z;

    function setZ(uint _z) public {
        z = _z;
    }
    function setX (uint _x) override public { //C'yi miras alarak X üzerinde değişiklik yapmak istedik o yüzden OVERRIDE kelimesini de eklememiz gerekiyor
        x = _x + 2;
    }
}
//----------------------------------------------

contract Human {
    function sayHello() public pure virtual returns(string memory){
        return "Mesaji gormek icin once uye olmalisiniz";
    }
}
contract MemberHuman is Human {
    function sayHello() public pure override returns(string memory){
        return "Merhaba uye!";
    }
    function welcomeMsg(bool isMember) public pure returns (string memory){
        return isMember ? sayHello() : Human.sayHello(); // Human.sayHello() yerine super.sayHello() da yazılabilir 
    }
}

//-----------------------------------------------
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Wallet is Ownable {
    fallback() payable external {}

    function sendEther( address payable to, uint amount ) public {

    }
    function showBalance() public view returns (uint) {
        return address(this).balance;
    }
}


// Kaynak kod :https://www.youtube.com/watch?v=KSrhlrHlti4&list=PLby2HXktGwN4Cof_6a8YwlMrboX8-hs73&index=14