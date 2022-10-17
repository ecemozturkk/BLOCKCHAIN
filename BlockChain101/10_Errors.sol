//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

//Hata methodlarını kullanarak bazı fonksiyonların çalışması engellenecek ve dışarıya hata mesajı yollanacak
//Bu sayede kullanıcılar etkileşmeye çalıştığı fonksiyonlarda hataların nereden kaynaklandığını gözlemleyebilecekler 
contract Errors {
    //Basit bir cüzdan (para yatırma-para çekme) uygulaması oluşturalım
    
    uint256 public totalBalance;
    mapping(address => uint256) public userBalances;// her bir kullanıcı ne kadar para yatırdı görülsün

    error ExceedingAmount(address user, uint256 exceedingAmount); //Hata tanımlaması, miktar aşıldı hatası
    error Deny(string reason); //receive ya da fallback aracılığıyla para sokulmak istendiğinde bu işlem reddedilsin
    
    receive() external payable{
        revert Deny("Odeme direkt sekilde degil");
    }
    fallback() external payable {
        revert Deny("Odeme direkt sekilde degil");
    }   

    function pay() noZero(msg.value) external payable { //kullanıcıların para yatırmasını sağlayan fonksiyon
        require(msg.value == 1 ether, "Sadece 1 ether odeme yapabilirsiniz");    //ödemenin yalnızca 1 ether olarak yapılması kontrolü
        
        totalBalance += 1 ether; //1 ether = 1e18 , 0.5 ether = 1e17
        userBalances[msg.sender] += 1 ether;    
    }
    function withdraw (uint256 _amount) noZero(_amount) external { //Yatırılan paranın çekilmesini sağlayan fonksiyon
        uint256 initialBalance = totalBalance;
        //çekmek istenen miktar, yatırılan miktardan büyük olamaz
        if (userBalances[msg.sender] < _amount) {
            //revert("Yetersiz bakiye"); //eğer çekilmek istenen miktar, yatırılan miktardan fazlaysa fonksiyonu revert et, yani kontratın bu fonksiyonunun transictionda çalışmasını engelle 
            revert ExceedingAmount(msg.sender, _amount - userBalances[msg.sender]);
        }

        totalBalance -= _amount;
        userBalances[msg.sender] -= _amount;
        payable (msg.sender).transfer(_amount);

        assert(totalBalance < initialBalance);

    }
    modifier noZero(uint256 _amount){ //hiçbir zaman 0 etherli bir ödeme-çekim yapılmaması
        require(_amount != 0);
        _;
    } 
}

// Kod kaynak : https://www.youtube.com/watch?v=TUQzMu4DYjc&list=PLby2HXktGwN4Cof_6a8YwlMrboX8-hs73&index=11
