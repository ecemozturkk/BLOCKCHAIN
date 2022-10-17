from hashlib import sha256
import time

class Block:
    def __init__(self, timeStamp, data, prevHash=''):
        self.timeStamp = timeStamp
        self.data = data
        self.prevHash = prevHash
        self.kuvvet = 0
        self.hash = self.hesapla()
    
    def hesapla(self): #kurala uyduğu ana kadar bilgisayara iş yükü bindirmemiz lazım
        while True:
            self.kuvvet = self.kuvvet +1
            ozet = sha256((str(self.timeStamp)+str(self.data)+str(self.prevHash)+str(self.kuvvet)).encode()).hexdigest()
            if ozet[0:2] == "00":
                break
        return ozet

class blockChain:
    def __init__(self): #self anahtar sözcüğü (keyword) __init__ metodu ile gelen ve class içinden türetmiş olduğumuz nesnelere ulaşmamızı sağlayan bir kavramdır
        self.chain=[self.genesisOlustur()]
    
    def genesisOlustur(self):
        return Block(time.ctime(),"ornekData","") #(timeStamp, data, prevhash)
    def blockEkle(self,data):
        node = Block(time.ctime(),data,self.chain[-1].hash) #genesis'den farklı olarak bir önceki chain'in hash'ini (chain[-1]) de gönderdik
        self.chain.append(node) #zincire eklendi
    def kontrol(self): #Bir önceki bloğun hash'i ile prevhash'in değeri aynı mı diye kontrol edildi
        for i in range(len(self.chain)): #tüm bloklarda chain'in uzunluğu kadar kontrol
            if i!=0:
                ilk = self.chain[i-1].hash
                guncel = self.chain[i].prevHash
                if ilk != guncel:
                    return "Zincir kopmuş"
                if sha256((str(self.chain[i].timeStamp)+str(self.chain[i].data)+str(self.chain[i].prevHash)+str(self.chain[i].kuvvet)).encode()).hexdigest() != self.chain[i].hash:
                    return "Zincir kopmuş"
        return "Zincir sağlam"
    def listeleme(self): #bloklarımızı göreceğimiz listeleme
        print("BlockChain = \n")
        for i in range(len(self.chain)):
            print("Block =>",i,"\n Hash =>",str(self.chain[i].hash),"\n Zaman Damgası =>", str(self.chain[i].timeStamp),"\n Data =>", str(self.chain[i].data),"\n Kuvvet =>",str(self.chain[i].kuvvet))

#EcemCoin Oluşturulması
EcemCoin = blockChain()
while True:
    print("Lütfen seçiminizi yapın \n 1. Block Ekle \n 2. Zinciri Listele \n 3. Zinciri Kontrol Et \n 4. Çıkış")
    data = input("Seçiminiz: ")
    if data == "1":
        data = input("Lütfen gönderilen miktarı giriniz: ")
        EcemCoin.blockEkle(data)
    elif data == "2":
        EcemCoin.listeleme()
    elif data == "3":
        print(str(EcemCoin.kontrol()))
    elif data == "4":
        break
    else:
        print("Geçersiz seçim")

#Kaynak Kod : https://www.youtube.com/watch?v=DqUbLvN_Fcs


