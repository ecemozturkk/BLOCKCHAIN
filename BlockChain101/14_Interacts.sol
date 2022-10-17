// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//akıllı kontratlar aracılığıyla farklı adreslerle etkileşim:

contract Interact {
    address public caller;
    mapping(address => uint256) public counts;

    function callThis() external {
        caller = msg.sender;
        counts[msg.sender]++; //Kontratı çağıran adreslerin kontratı kaçar defa çağırdığını görmüş olalım 
    }
}

contract Pay { //kullanıcıların kontrata para yatırmasına izin verelim
    mapping(address => uint256) public userBalances;

    function payEth(address _payer) external payable{ //payable olarak adlandırıyoruz ki bu fonksiyona ödeme yapabilelim
        userBalances[_payer] += msg.value;
    }
}

contract Caller { //üst iki kontratla etkileşecek
    Interact interact; //İlk contrat adından türetilen bir değişken tanımlaması yaptık

    constructor (address _interactContract) {
        interact = Interact(_interactContract);
    } //İlk contratla etkileşim

    function callInteract() external { //İlk kontratın içindeki fonksiyona erişim
        interact.callThis();
    }

    function readCaller() external returns (address) { //İlk kontrattaki değişkenleri okuyan fonksiyon
        //"caller" değişkeninde hangi adresin tutulduğuna bakmak istiyoruz
        return interact.caller();
    }

    function readCallerCount() public view returns (uint256) {
        return interact.counts(msg.sender);
    }

    //---------Pay Contractıyla etkileşim----------------
    function payToPay(address _payAddress) public payable {
        Pay pay =Pay(_payAddress); 
        pay.payEth{value: msg.value}(msg.sender); //Contractın payToPay fonksiyonuna bir transaction geldiğinde, bu transictiona gelen ether değeri (msg.value), doğrudan payEth() fonksiyonunu çağrılmakta kullanılacak

        //Yukarıdaki iki satır için diğer yazma yöntemi : 
        //Pay(_payAddress).payEth{value: msg.value}(msg.sender);
    }

    //Pay contract adresine de mesaj olarak ether yollanırsa contract bunu kabul eder mi?  
    function sendEthByTransfer() public payable{
        payable(address (interact)).transfer(msg.value);
    }
} 

//Eğer bir kontrat, başka bir kontratı çağırıyorsa,
// msg.sender -> A -> B === B kontratından bakıldığında B kontratına gelen mesajın msg.sender'ı A kontratıdır
//Bu yüzden Pay contractı içinde msg.sender userBalances içinde gönderildi

//msg.sender -> A (mesaj yollayan: msg.sender) -> B (mesaj yolayan : A adresi)



// Kaynak kod : https://www.youtube.com/watch?v=BWC-Rlkjs54&list=PLby2HXktGwN4Cof_6a8YwlMrboX8-hs73&index=15
