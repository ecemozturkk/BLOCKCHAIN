// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Akıllı kontratları deploy etmemize yarayan methodlardan biri de başka bir akıllı kontrat yoluyla deploy'u gerçekleştirmek.
//Bir akıllı kontrat tipinden farklı yerlerde kullanmak üzere birçok sonsuz sayıda örneğe ihtiyacımız varsa burada bir FACTORY CONTRACT oluşturarak diğer örnekleri kolayca deploy edebiliriz.

//Bir kasa uygulaması oluşturacağız, bu kasa uygulamasına bir factory contract inşa ederek bu kontratla istediğimiz kadar kasa akıllı kontratı oluşturmaya çalışıcaz


//Önce kasa akıllı kontratını (contract Vault) oluşturup detaylandırdık,
//Ardından contract VaultFactory'yi oluşturup detaylandırdık

contract VaultFactory {

    mapping(address => Vault[]) public userVaults ; //Her kullanıcının deploy ettiği contract adresleri tutulsun

    function createVault() external {
        Vault vault = new Vault(msg.sender); //kontrat cinsinden değişken tanımladık, Vault contractında constructor address parametresi aldığı için (msg.sender) parametresini giriyoruz
        userVaults[msg.sender].push(vault);
    }
}


contract Vault {

    uint256 public balance ;//kontrata yatırdığımız değerleri tutacak değişken
    address public owner; //deploy anında konfigüre edebilmemiz için owner değişkeninin değerini constructor içinde vermemiz gerekiyor

    constructor (address _owner) {
        owner = _owner;
    }

    fallback() external payable { //fallback'e düşen paralar da bakiyeye eklensin
        balance += msg.value;
    }

    receive() external payable { 
        balance += msg.value;
    } 
    
    function getBalance() external view returns (uint256){
        return balance;
    }

    function deposit() external payable{ //bu fonksiyon aracılığıyla akıllı kontratımıza para yatıracağız
        balance += msg.value;
    }
    function withDraw(uint256 _amount) external { 
        require (msg.sender == owner, "Hesap sahibi degilsiniz"); //işlemi yapan owner mı kontrolü
        balance -= _amount;
        payable(owner).transfer(_amount);
    }
}


// Kaynak kod :https://www.youtube.com/watch?v=hxkpHnYqQFg&list=PLby2HXktGwN4Cof_6a8YwlMrboX8-hs73&index=18