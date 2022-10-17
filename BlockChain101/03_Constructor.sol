
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Constructor olarak tanımladığımız fonksiyon biz kontratı deploy ederken başlangıçta sadece bir defa çalışır.
contract Constructor{
    string public tokenName;
    uint public totalSupply;

    //Yukarıdaki değişkenlerin başlangıçta bir defa belirlenmesini, daha sonra değişmemesini istiyoruz.
    constructor(string memory name, uint number) { //dışardan iki tane input alalım
        tokenName = name;
        totalSupply = number;
    }
    function set(uint number) public { //yeni bir fonksiyon yazarak değişken değerini değiştirebiliyoruz.
        totalSupply = number;
    }


    // PEKİ VERİLEN DEĞERİN HİÇ DEĞİŞMEMESİNİ İSTERSEK?
    //constant ve immutable kullanıyoruz.
    uint public constant number2=10;

    //değiştirmeye çalışalım:
    
    // function deneme(uint num) public {
    //     number2 = num;
    // }
    
    //HATA VERDİ, deploy edemedik.

    //Constant yerine Immutable olarak tanımlandığında yine değerinin değişmeyeceğini söylemiş oluruz.
    //Farkı immutable olarak belirlendiğinde değerini başlangıçta değil de constructor içinde verebiliyoruz.

    uint public immutable number3;
    constructor(uint num3){
        number3 = num3;
    }
}