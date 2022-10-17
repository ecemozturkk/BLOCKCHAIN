import { useEffect, useState } from "react";


export const useRandomUser = () => {
    const [state, setState] = useState(null);

    //Amaç : API'a sorgu atıp dönen response'u state'e atmak

    //Önce state oluşturulur
    /*
    const [state, setState] = useState(null);

    useEffect(() => {
        const result = fetch("https://randomuser.me/api/")
        .then((response) => response.json())
        .then((data) => console.log(data));
    }, []);

    return {state};
    */

    useEffect(() => {
        const fn = async () => {
          const result = await fetch("https://randomuser.me/api/");
          const json = await result.json();
          setState(json.results[0]);
        };
        console.log("hjere");
        fn();
      }, []);
    
      return { state };
    };