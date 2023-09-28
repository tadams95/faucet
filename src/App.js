import { useEffect, useState } from "react";
import "./App.css";
import Web3 from "web3";

function App() {
  // eslint-disable-next-line no-undef, no-unused-vars
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    web3: null,
  });

  const [account, setAccount] = useState(null);

  useEffect(() => {
    const loadProvider = async () => {
      let provider = null;
      if (window.ethereum) {
        provider = window.ethereum;

        // Prompt user for account access
        try {
          await provider.request({ method: "eth_requestAccounts" });
        } catch {
          console.log("User denied account access");
        }
      } // If the user is using CBW, then we want to use their provider
      // instead of the one specified here.
      if (window.ethereum) {
        provider = window.ethereum;
      }
      // If CBW is not available, but the user is using Mist, then we
      // want to use their provider instead of the one specified here.
      else if (window.web3) {
        provider = window.web3.currentProvider;
      }
      // check if in development environment
      else if (!process.env.production) {
        provider = new Web3.providers.HttpProvider("http://localhost:7545");
      }

      setWeb3Api({
        web3: new Web3(provider),
        provider,
      });
    };
    loadProvider();
  }, []);

  useEffect(() => {
    if (web3Api.web3) {
      const getAccount = async () => {
        // Get all accounts
        const accounts = await web3Api.web3.eth.getAccounts();
        // Set the first account as the current account
        setAccount(accounts[0]);
      };
      getAccount();
    }
  }, [web3Api.web3]);

  return (
    <>
     <div className="faucet-wrapper">
        <div className="faucet">
          <div className="is-flex is-align-items-center">
            <span>
              <strong className="mr-2">Account: </strong>
            </span>
              { account ?
                <div>{account}</div> :
                <button
                  className="button is-small"
                  onClick={() =>
                    web3Api.provider.request({method: "eth_requestAccounts"}
                  )}
                >
                  Connect Wallet
                </button>
              }
          </div>
          <div className="balance-view is-size-2 my-4">
            Current Balance: <strong>10</strong> ETH
          </div>
          <button
            className="button is-link mr-2">Donate</button>
          <button
            className="button is-primary">Withdraw</button>
        </div>
      </div>
    </>
  );
}

export default App;
