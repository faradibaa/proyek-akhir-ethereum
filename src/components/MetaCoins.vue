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
      <p> Jumlah uang yang didonasikan: {{ amount_of_sending }}</p>
    </div>

    <!-- Cek Saldo -->
    <div class="get-balance">
      <p><br>Pencet tombol di bawah ini jika ingin mengecek saldo kamu.</p>
      <button class="bid-button"> Cek Saldo </button>
    </div>
  </div>
</template>

<script>
import Web3 from 'web3';
import MetaCoin from '../../build/contracts/MetaCoin.json'

let web3 = new Web3(window.ethereum);
let abi = MetaCoin.abi;
let contractAddress = MetaCoin.network.address;

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
      amount_of_sending: 0,
      trySeeingResult: '',
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
    sendCoins() {
      contract.methods.sendCoin().call()
        .then(result => this.trySeeingResult = result);
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
