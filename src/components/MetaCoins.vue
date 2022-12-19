<template>
  <div id="content">
    <h2>Dompet KamuBisa</h2>
    <p>Dengan fitur Dompet KamuBisa, kirim donasi jadi lebih mudah! <br><br><br></p>
    
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
      <input v-model="addr" type="text" placeholder="Masukkan address dompetmu" class="wallet-address">
      <button @click="getCoinInformation" class="bid-button"> Cek Saldo </button>
      <p> Saldo sekarang: {{ myCoin }} ETH </p>
    </div>

  </div>
</template>

<script>
import Web3 from 'web3';
import MetaCoin from '../../build/contracts/MetaCoin.json' // import file JSON untuk mengambil data ABI dan address

/*const web3 = new Web3(window.ethereum);
window.ethereum.enable();
let abi = MetaCoin.abi; 
let contractAddress = MetaCoin.networks['5777'].address; // address dari deployed contract, bisa dilihat di ganache bagian Contracts

let contract = new web3.eth.Contract(abi, contractAddress);*/

export default {
  name: 'MetaCoins',
  props: {
    msg: String
  },
  data() {
    return {
      connected: false,
      myCoin: 0,
      myAddrs: '',
      amount_of_sending: 0,
      receiverAddress: '',
    }
  },
  methods: {
    // memanggil fungsi dalam smart contract(?)
    async getCoinInformation() {
      const web3 = new Web3(window.ethereum);
      await window.ethereum.enable();
      let abi = MetaCoin.abi; 
      let contractAddress = MetaCoin.networks['5777'].address; // address dari deployed contract, bisa dilihat di ganache bagian Contracts

      let contract = new web3.eth.Contract(abi, contractAddress);

      this.myAddrs = this.addr;

      const result = await contract.methods.getBalanceInEth(this.myAddrs).call({from: contractAddress});
      this.myCoin = result;
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
