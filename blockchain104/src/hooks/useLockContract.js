import {useState, useEffect} from "react";
import {ethers} from "ethers";
import { LOCK_ADDRESS } from "../Constants/addresses";
import { LOCK_ABI } from "../Constants/abi";

//Uygulamanın farklı yerlerinde aynı kontratın farklı fonksyionları çağırılabilir
//Her seferde kontratı oluşturmak yerine bir kez oluşturulup kullanılabilir
//Bunun için bir hook oluşturulur
//Bu hook bir kez oluşturulup kullanılabilir
export const useLockContract = () => {
    const [contract, setContract] = useState(null); //useState ile "contract" adında bir state oluşturulur

    useEffect(() => { //useEffect ile "contract" state'i güncellenir
        const provider = new ethers.providers.Web3Provider(window.ethereum); //window.ethereum kullanılarak bir provider oluşturulur
        
        const signer = provider.getSigner(); //provider ile bir signer oluşturulur

        const _contract = new ethers.Contract(LOCK_ADDRESS, LOCK_ABI, signer); //Yarattığımız providerı kullanılarak yeni  bir contract instance'ı oluşturulur-- Contract(adres, abi, provider)
    
        setContract(_contract); //state'i güncelledik
    
    }, []); 
    return contract;


};
//useLookContract'ı kullanarak uygulamamızın her yerinde Lock Contract'ımızı çağırabilir hale geliyoruz