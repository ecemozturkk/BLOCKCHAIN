//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract StructEnum { //sipariş alma süreci oluşturalım
    
     //Struct, içinde farklı veri tipleri bulunduran, bunları paketleyip bütün bir şekilde ele almamızı sağlayan bir veri tipidir. 
    struct Order { //siparişi kimin oluşturduğuna dair bilgiler
        address customer;
        string zipCode;
        uint256[] products;
        Status status; //oluşturduğumuz enum'ı struct'ın içine yerleştirdik
    }
    
    //Enum, normal bir sayı değişkeni oluşturduk, ancak bu sayı değişkeninin olabileceği değerleri kısıtladığımız bir veri tipidir.
    enum Status { //siparişin durum bilgileri
        Taken, // 0
        Preparing, // 1
        Boxed, // 2
        Shipped // 3
    }

   

    Order[] public orders; //struct array'i
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function createOrder(string memory _zipCode, uint256[] memory _products) external returns(uint256) { //returns(uint256)=sipariş ID'si dönsün 
        require(_products.length > 0, "No products."); //parametrelerin boş olmamasının kontrolü

        Order memory order;
        order.customer = msg.sender;
        order.zipCode = _zipCode;
        order.products = _products;
        order.status = Status.Taken;
        orders.push(order); //lokal olarak oluşturulan order değişkenini orders array'ine eklemiş olduk


        //2.OLUŞTURMA SEÇENEĞİ :
        /*
         orders.push(
             Order({
                 customer: msg.sender,
                 zipCode: _zipCode,
                 products: _products,
                 status: Status.Taken
             })
         );
        */

        //3. OLUŞTURMA SEÇENEĞİ: 
         /*
         orders.push(Order(msg.sender, _zipCode, _products, Status.Taken));
        */
        
        return orders.length - 1; // 0 1 2 3
    }

    function advanceOrder(uint256 _orderId) external { //mesjı yollayan kişi yetkili mi kontrolü

        require(owner == msg.sender, "Yetkili degilsiniz.");
        require(_orderId < orders.length, "Order ID gecerli degil.");

        Order storage order = orders[_orderId]; //struct elemanına erişiyoruz----order'da yapıcağımız değişimler fonksyion bittikten sonra da "storage" sayesinde hayatta kalacak
        require(order.status != Status.Shipped, "Siparis kargoda.");

        if (order.status == Status.Taken) {
            order.status = Status.Preparing;
        } else if (order.status == Status.Preparing) {
            order.status = Status.Boxed;
        } else if (order.status == Status.Boxed) {
            order.status = Status.Shipped;
        }
    }

    function getOrder(uint256 _orderId) external view returns (Order memory) { //yalnızca dışarıdan erişileceği için EXTERNAL kullandık.
        require(_orderId < orders.length, "Order Id gecersiz.");
        
        /*
        Order memory order = orders[_orderId];
        return order;
        */

        return orders[_orderId];
    }

    function updateZip(uint256 _orderId, string memory _zip) external { //varış noktasını değiştirme
        require(_orderId < orders.length, "Order Id gecersiz.");
        Order storage order = orders[_orderId];
        require(order.customer == msg.sender, "Siparis sizin degil.");
        order.zipCode = _zip;
    }

}