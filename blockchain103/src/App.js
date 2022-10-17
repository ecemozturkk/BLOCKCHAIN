import './App.css';
import {ethers} from 'ethers';
import {useCallback, useEffect, useState, useMemo, useRef} from 'react';
import { useRandomUser } from './Hooks/useRandomUser';
// cd  C:\Users\ecem.ozturk\Desktop\blockchain103
function App() {
  function connect() {
    if (!window.ethereum) {
      alert("Metamask indirilmedi");
      return;
    }
    const provider = new ethers.providers.Web3Provider(window.ethereum); //provider -metamask(window.etherum) ile bağlantı kuruldu 

    //Yeni provider objesi oluşturduktan sonra accountları almak için provider.sent ile bir method gönderiyoruz
    provider
    .send("eth_requestAccounts", [])
    .then((accounts)=> console.log(accounts));

    /*
    window.ethereum
    .request({ method: 'eth_requestAccounts' })
    .then((accounts) => console.log(accounts))
    .catch((error) => {
      if (error.code === 4001) {
        // EIP-1193 userRejectedRequest error
        console.log('Please connect to MetaMask.');
      } else {
        console.error(error);
      }
    });
    */
  }
return (
    <div className="App">
      <button onClick={connect}>Connect</button>
    </div>
)

}
export default App;
