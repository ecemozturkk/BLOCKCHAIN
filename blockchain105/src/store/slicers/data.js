import { createSlice } from "@reduxjs/toolkit";
//Slicer'lar bizim "reducer" objesinin içine vereceğimiz değerler olacak
//Slicer'lar içinde reducers ve initialState'imiz bulunmakta
//reducers, state'i değiştirmek için kullanacağımız fonksiyonlar olacak
//initialState ise state'imizin başlangıç değerleri olacak

const initialState = { //Başta tutmak istediğimiz değerler
    provider: null,
    signer: null,
    address: null,
    account: null,
};


export const dataSlice = createSlice({
    name: "data",
    initialState,
    reducers: {
      setProvider: (state, action) => { //Bir yerde setProvider({})'ı çağırıp içine değişken verdiğimizde o değere göre state'i değiştirecek
        state.provider = action.payload;
      },
      setSigner: (state, action) => {
        state.signer = action.payload; ////state.provider ile o an state'teki provider değerine ulaşılır, aciton.payload ile bu değer değiştirilir
      },
      setAddress: (state, action) => {
        state.address = action.payload;
      },
      setAccount: (state, action) => {
        state.account = action.payload;
      },
    },
  });





  export const { setProvider, setSigner, setAddress, setAccount } =
  dataSlice.actions;

export default dataSlice.reducer;