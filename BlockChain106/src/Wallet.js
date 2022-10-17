import { React, useState, useEffect } from "react";
import { ethers } from "ethers";
import styles from "./Wallet.module.css";
import simple_token_abi from "./Contracts/simple_token_abi.json";
import Interactions from "./Interactions";

const Wallet = () => {
    const contractAddress = "0x7d56017f1A2e47c9f89F4F5965336BD4E77c07Ab"; //ganache
    const [tokenName, setTokenName] = useState("Token");
    const [connectButtonText, setConnectButtonText] = useState("Connect Wallet");
    const [errorMessages, setErrorMessages] = useState(null);
    const [defaultAccount, setDefaultAccount] = useState(null);
    const [balance, setBalance] = useState(null);
    
    const [provider, setProvider] = useState(null);
    const [signer, setSigner] = useState(null);
    const [contract, setContract] = useState(null);
  
    const connectWalletHandler = () => {
      //butona basıldığında tetiklenecek fonksiyon
      if (window.ethereum && window.ethereum.isMetaMask) {
        window.ethereum  //window.ethereum, metamask'in tarayıcıya eklediği bir API, kullanıcıların blockchain ile etkileşmesine izin verir
          .request({ method: "eth_requestAccounts" }) //promise döndürür
          .then((result) => {
            accountChangedHandler(result[0]);
            setConnectButtonText("Wallet Connected");
          })
          .catch((error) => {
            setErrorMessages(error.message);
          });
      } else {
        console.log("need to install metamask");
        setErrorMessages("Please install MetaMask");
      }
    };
  
    const accountChangedHandler = (newAddress) => {
        setDefaultAccount(newAddress);
        updateEthers();
    };
    const updateEthers = () => {
      let tempProvider = new ethers.providers.Web3Provider(window.ethereum); //blockchain'den okuma yapılacak
      let tempSigner = tempProvider.getSigner(); //blockchain'e yazma yapılacak
      let tempContract = new ethers.Contract(contractAddress, simple_token_abi, tempSigner); // we get the contract built with the abi and the signer(write access)

      setProvider(tempProvider);
      setSigner(tempSigner);
      setContract(tempContract);
    };
    //provider => metamask hesabı ile bağlantı kurar, sadece okuma yapabilir
    //signer => read-write işlemler için kullanılır,değişimler yapabilen signer'dır, metamask ile etkileşir

    //componentin ilk render oluşunda tetiklenecek, ardından her [contract] değiştiğinde tetiklenecek
    useEffect(() => {
      if (contract != null){
        updateBalance();
        updateTokenName();
      }
    }, [contract]);
    

  const updateBalance = async () => {
		let balanceBigN = await contract.balanceOf(defaultAccount);
    console.log(balanceBigN);

    let balance = ethers.utils.formatEther(balanceBigN);
    setBalance(balance);
		// let balanceNumber = balanceBigN.toNumber();

		// let tokenDecimals = await contract.decimals();

		// let tokenBalance = balanceNumber / Math.pow(10, tokenDecimals);

		// setBalance(tokenBalance);	
    // setBalance(balanceBigN);	

   
	}


    const updateTokenName = async () => {
      setTokenName(await contract.name());
    };
  return (
    <div>
      <h2>{tokenName + "ERC-20 Wallet"}</h2>
      <button className={styles.button6} onClick={connectWalletHandler}>{connectButtonText}</button>
      <div className={styles.walletCard}>
        <div>
            <h3>Account Address: {defaultAccount}</h3>
        </div>
        <div>
            <h3>{tokenName} Balance: {balance}</h3>
        </div>
        {errorMessages}
      </div>
      <Interactions contract= {contract}/>
    </div>
  );
};

export default Wallet;
