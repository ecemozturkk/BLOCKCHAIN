// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./Token.sol";

contract Lock {
    BEEToken Token;
    uint256 public lockerCount; //Kaç kullanıcının içeride parası kitli
    uint256 public totalLocked; //Toplam kitlenen miktar
    mapping(address => uint256) public lockers; //Kullanıcının kitlenen miktarı(bakiyesi)
    
    constructor(address tokenAddress) {
        Token = BEEToken(tokenAddress);
    }
    
    //Token'ı kilitler , amount kadar token'ı kilitler
    function lockTokens(uint256 amount) external {
        require(amount >0 , "Token miktari 0'dan buyuk olmali");//Kimse amount'ı 0 veya daha az gönderemez

      

        if(!(lockers[msg.sender] > 0 )) lockerCount++; //Kullanıcı sayısını arttır
        totalLocked += amount; //Toplam kitlenen miktarı arttır
        lockers[msg.sender] += amount; //Kullanıcının kitlenen miktarını arttır

        //TOKEN TRANSFER İŞLEMİ
        Token.transferFrom(msg.sender, address(this), amount); //(kimden para alınıyor, kime para gönderiliyor, miktar)
      

    }

    //Token'ı kilidi açar
    function withdrawTokens() external {
        require (lockers[msg.sender] > 0, "Kilitli token yok");//Kullanıcının kilitli token'ı (bakiyesi) olmalı

        uint256 amount = lockers[msg.sender]; //Kullanıcının kilitli token'ı (bakiyesi)
        delete(lockers[msg.sender]);
        totalLocked -= amount; //Toplam kitlenen miktarı azalt
        lockerCount--; //Kullanıcı sayısını azalt


        require (Token.transfer(msg.sender, amount), "Transfer failed"); //(miktar, kime gönderilecek)
    }
    
}

