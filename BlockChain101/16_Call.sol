// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Call'u diğer akıllı kontratları fallback() fonksiyonunu tetiklemek için ya da doğrudan bir ether değeri göndermek için kullanılırız.

Ayrıca Call methodu aracılığıyla diğer kontratları fonksiyonu eğer adını ve parametrelerini doğru biliyorsak çağırbiliriz
Bu da kontratın ABI'ına ve kontratın kendisine ihtiyaç olmadan akıllı kontratları çağırmaya yarıyor.
O yüzden akıllı kontratın tamamının bilinmediği durumlarda kullanmak yararlı olabilir.
*/

// 2 farklı kontrat yaratacağız
// İlk kontrat call methoduyla çağıracağımız Test isimli kontrat olacak
// Diğer kontrat da Caller isimli Call methodunu kullanarak Test kontratını çağıracağımız kontrat.

contract Test {
    uint256 public total = 0;
    string public incrementer;
    uint256 public fallbackCalled = 0;

    //fallback fonksiyonu ile diğer akıllı kontratların fallback fonksiyonlarını tetikleyeceğiz
    fallback() external payable {
        fallbackCalled += 1;
    }
    
    function inc(uint256 _amount, string memory _incrementer) external returns(uint256) { //total değişkenini ne kadar arttıracağımızı belirtsin
        total += _amount;
        incrementer = _incrementer;

        return total;
    }

}

contract Caller {
    function testCall(address _contract, uint256 _amount, string memory _incrementer) external returns (bool, uint256){
        (bool err, bytes memory res) = _contract.call(abi.encodeWithSignature("inc(uint256, string)", _amount, _incrementer)); //test contract'ını temsil ediyor
        uint256 _total = abi.decode(res, (uint256));
        return (err, _total);
    }
    function payToFallback (address _contract) external payable {
        (bool err, )= _contract.call{value: msg.value}(""); // başarılı olursa err true döner
        if(!err) revert(); //eğer false ise revert et(transictionu reddet)

    }
}





// Kaynak kod : https://www.youtube.com/watch?v=NBJIBoxDpDs&list=PLby2HXktGwN4Cof_6a8YwlMrboX8-hs73&index=17