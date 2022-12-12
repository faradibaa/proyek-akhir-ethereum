<template>
  <div id="content">
    <h2>Dompet KamuBisa</h2>
    <p>Dengan fitur Dompet KamuBisa, kirim donasi jadi lebih mudah! <br><br><br></p>

    <!--Connect MetaMask-->
    <p>Konek dulu ke MetaMask, ya!</p>
    <button v-if="!connected" @click="connectWallet" class="connecting">Connect to MetaMask</button>
    <p>Connecting: {{connected}} <br><br></p>
    
    <!-- Send Coin -->
    <div class="send-coin">
      <p>Silakan isi kotak di bawah ini jika ingin mengirim donasi.</p>
      <input v-model="coins" type="text" placeholder="Masukkan nominal donasi" class="form-donasi">
      <button @click="sendCoinsAmount" class="bid-button"> Kirim Koin Donasi </button>
    </div>

    <div class="amount-of-sending">
      <p> Jumlah uang yang didonasikan: {{ amount_of_sending }}<br></p>
    </div>

    <!-- Cek Saldo -->
    <div class="get-balance">
      <p><br>Pencet tombol di bawah ini jika ingin mengecek saldo kamu.</p>
      <button @click="getCoinInfo" class="bid-button"> Cek Saldo </button>
      <p> Saldo sekarang: {{ myCoin }}</p>
    </div>
  </div>
</template>

<script>
import Web3 from 'web3';
import MetaCoin from '../../build/contracts/MetaCoin.json' // import file JSON untuk mengambil data ABI dan address

let web3 = new Web3(window.ethereum);
let abi = MetaCoin.abi; 
let contractAddress = MetaCoin.networks['5777'].address; // address dari deployed contract, bisa dilihat di ganache bagian Contracts

let contract = new web3.eth.Contract(abi, contractAddress);

export default {
  name: 'MetaCoins',
  props: {
    msg: String
  },
  data() {
    return {
      connected: false,
      coins: '',
      myCoin: 0,
      addr: '0x2a705f636bF49A9B62756Ac1e193124dAE8A7003',
      myAddrs: '0x9B24e6f09DE2407990Af0E7113783dE5E0cD436a',
      amount_of_sending: 0,
      trySeeingResult: '',
      receiverAddress: '',
    }
  },
  methods: {
    // connect ke akun MetaMask (untuk orang yang mau melakukan bidding)
    connectWallet() {
      if(window.ethereum) {
        window.ethereum.request({ method: 'eth_requestAccounts' })
          .then(() => {
            this.connected = true;
          });
      }
    },
    // memanggil fungsi dalam smart contract(?)
    /*sendCoins(receiver, amount) {
      contract.methods
      .sendCoin(receiver, amount)
      .call()
      .then();
    },*/
    getCoinInfo() {
      contract.methods
      .getBalance(this.myAddrs)
      .call()
      .then(() => {
        this.myCoin = 100; // test aja
      })
    },
    //
    sendCoinsAmount() {
      this.amount_of_sending = this.coins;
    }
  }
};

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
