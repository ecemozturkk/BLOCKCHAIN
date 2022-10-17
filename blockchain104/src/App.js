import { BigNumber, Contract, ethers } from "ethers";
import { formatEther, parseEther } from "ethers/lib/utils";
import { useState } from "react";
import "./App.css";
import { useLockContract } from "./hooks/useLockContract";
import { useAllowance } from "./hooks/useAllowance";

function App() {
  const lockContract = useLockContract(); //useLockContract hook'ını kullanarak lockContract adında bir değişken oluşturduk

  const [totalLockedAmount, setTotalLockedAmount] = useState(BigNumber.from(0)); 





  const getTotalLocked = async () => { //bu fonksyiyon getContract'tan değer okuyacak
    
    if(!lockContract) return; //lockContract yoksa fonksyiyonu sonlandır
    
    const result = await lockContract?.totalLocked(); //lockContract ve totalLocked Remix'ten geliyor
    setTotalLockedAmount(result);
    
  };

  const [value, setValue] = useState("");

  const {approve, allowance, isApproving} = useAllowance(); //useAllowance hook'ını kullanarak approve ve allowance adında değişkenler oluşturduk

  //Amacımız Remix'teki Lock.sol dosyasındaki "lockTokens" fonksiyonunu çalıştırmak ve bunun içine bir "amount" göndermek.
  //Bu amount bizim kitleyeceğimiz para olacak
  //Kontrat içindeki bir fonksiyonu çağırmak istiyorsak bunu asenkron bir şekilde çağırmalıyız
  const lock = async() => {
    const _value = ethers.utils.parseEther(value); //value'yu ether cinsinden parse ettik
    await Contract.lockTokens();
  };



  console.log(totalLockedAmount);
  return (
    <div className="App">
      <button onClick={getTotalLocked}>Get total locked</button>
      <h1>Total locked amount is : {ethers.utils.formatEther(totalLockedAmount)}</h1> 
      <h1>Total locked şu şekilde de bastırılabilir : {ethers.utils.formatUnits(totalLockedAmount,18)}</h1>
      <input
        placeholder="Enter amount"
        value={value}
        onChange={(e) => setValue(e.target.value)}
      />
      <button onClick={lock}>Lock tokens</button>
      <button onClick={approve}>Approve</button>
      <div>
        <h4>Allowance : {formatEther(allowance)}</h4>
      </div>
    </div>
  );
}

export default App;

