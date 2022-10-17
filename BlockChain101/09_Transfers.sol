//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

//Bu kontratta temel olarak yapmak istediğimiz şey, ether gönderimi ve ether çekilmesi

contract Bank{
    mapping(address => uint) balances; //adreslerin gönderdiği etherler tutulsun

    //ether göndermek için fonksiyon
    function sendEtherToContract() payable external { //PAYABLE = Fonksiyona değer gönderme işlemi yapılabilir--EXTERNAL = contract içerisinde çağırılmayacağı için 
        //ether gönderdikten sonra tanımladığımız mapping'deki çağıran kişinin değerini, gönderdiği miktar kadar arttırmak istiyoruz
        balances[msg.sender] = msg.value; //msg.sender=kişinin adresi ---msg.value= gönderdiği miktar
    }
    function showBalance() external view returns(uint){ //sahip olduğumuz değer döndürülecek.. sadece okuma yapılacağı için VİEW yazdık
        return balances[msg.sender];
    }

    //Contract'tan kendi cüzdan adresimize bir transfer gerçekleştiricez
    function withDraw() external {
        payable(msg.sender).transfer(balances[msg.sender]); //paramızı çektik-- PAYABLE OLMASI ÖNEMLİ!!!
        balances[msg.sender] = 0;//tüm paramızı gönderdiğimiz için sahip olduğumuz bakiye 0 olarak güncellenmeli
    }
    
    //withDraw() fonksiyonunun farklı yazımı:
    function witDraw2(address payable to, uint amount) external{ //(parayı göndermek istediğimiz kişi = to , göndermek istenilen miktar = amount
        require(balances[msg.sender] >= amount, "yetersiz bakiye"); //göndericeğimiz "amount" değerindeki para miktarına öncelikle biz sahip miyiz kontrolü
        to.transfer(amount); //gitmesini istediğimiz kişinin adresine amount kadar para gönder
        balances[msg.sender] -= amount; //gönderilen miktar kendi bakiyemizden düşsün
    }

    /*
    3 farklı ether gönderme yolu vardır:
        1- Transfer() : Kullanıldığında yeterli bakiye olmaması durumunda Revert (geri çevirme) işlemi gerçekleşir
        2- Send() : Fonksyon gerçekleştiyse true, gerçekleşmediyse false döner
        3- Call() : İki değer döndürür : true-false ve data

     
    */

    // send() örneği
    function sendOrnek(address payable to, uint amount) external returns(bool){
        bool ok = to.send(amount);
        balances[msg.sender] -= amount;
        return ok;
    }

    // call() örneği    
    function callOrnek(address payable to, uint amount) external returns(bool){
        (bool sent, bytes memory data) = to.call{value: amount}("");
        balances[msg.sender] -= amount;
        return sent;
    }

    uint public receiveCount =0; 
    receive() external payable {  //contract'ımıza ether geldiğinde kendiliğinden çalışacak--bir yerde bir transfer varsa onu PAYABLE olarak nitelendirmeyi unutmuyoruz
        receiveCount +=1;
    }

    uint public fallbackCount =0;
    fallback() external payable { //veri (data) gönderilen durumlarda bu fonksiyon çalışır
        fallbackCount +=1;
    }
    //Receive() ve Callback() yoksa kontrata ether gönderemeyiz.
    // Bu ikisi de varsa, verinin olmadığı durumlarda Reecive() fonksiyonu çalışırken, 
    // Verinin olduğu durumlarda Fallback() fonksiyonu çalışır.
    // Sadece fallback var ise hem verili hem verisiz durumda fallback çalışır
    // Yani kontrata ether gönderebilmemiz için Fallbackin kesin olarak olması gerekiyor

}

// Kod kaynak : https://www.youtube.com/watch?v=Im5Ae6D4uO0&list=PLby2HXktGwN4Cof_6a8YwlMrboX8-hs73&index=10
