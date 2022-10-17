import { React, useState } from "react";
import styles from "./Wallet.module.css";

const Interactions = (props) => {
  const [transferHash, setTransferHash] = useState(null);

  const transferHandler = async (e) => {
    e.preventDefault(); //form submit edildiğinde sayfanın yenilenmesini engeller
    let transferAmount = e.target.sendAmount.value;
    let receiverAddress = e.target.receiverAddress.value;

    let text = await props.contract.transfer(receiverAddress, transferAmount);
    setTransferHash("Transfer confirmation hash: " + text.hash);
  };

  return (
    <div className={styles.interactionsCard}>
      <form onSubmit={transferHandler}>
        <h3> Transfer Coins</h3>
        <p>Reciever Address</p>
        <input
          type="text"
          id="recieverAddress"
          className={styles.addressInput}
        />
        <p> Send Amount </p>
        <input type="number" id="sendAmount" min="0" step="1" />
        <button type="submit" className={styles.button6}>
          Send
        </button>
        <div>{transferHash}</div>
      </form>
    </div>
  );
};

export default Interactions;
