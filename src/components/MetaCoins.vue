<template>
  <br>
  <div class="card" style="
              width: 500px;
              height: 600px;
              /* background-color: blue; */

              padding: 10px;
              box-shadow: 10px;

              position:absolute;
              top:50%;
              left:50%;
              margin-left:-250px;/* half width*/
              margin-top:-300px;/* half height*/
              " id="content">
    <!-- <center> -->
    <button class="btn" 
      data-bs-target="#collapseTarget" 
      data-bs-toggle="collapse"><h2><font-awesome-icon class="text-success" icon="fa-solid fa-wallet" /> Dompet KamuBisa</h2></button>
    <p><center>Dengan fitur Dompet KamuBisa, kirim donasi jadi lebih mudah!</center></p>
    
    <!-- <button 
      class="btn btn-primary" 
      data-bs-target="#collapseTarget" 
      data-bs-toggle="collapse">
      Bootstrap collapse
    </button>
    <div class="collapse py-2" id="collapseTarget">
      This is the toggle-able content!
    </div> -->

    <div class="collapse py-2" id="collapseTarget">
      <!-- Send Coin -->
      <div>
        <!-- <p>Address</p> -->
        <center>
          <input v-model="addr" type="text" placeholder="Masukkan address dompetmu" class="wallet-address card" style="padding: 10px"/><br>
      </center>
      </div>
      <div class="send-coin">
        <p>Silakan isi kotak di bawah ini jika ingin mengirim donasi.</p>
        <input v-model="coins" type="text" placeholder="Masukkan nominal donasi" class="form-donasi card" style="padding: 10px;">
        <button @click="sendCoinsAmount" class="btn btn-success"> Kirim Koin Donasi </button>
      </div>

      <div class="amount-of-sending">
        <p> Jumlah uang yang didonasikan: {{ amount_of_sending}}<br></p>
      </div>
    
      <!-- Cek Saldo -->
      <div class="get-balance">
        <p><br>Tekan tombol di bawah ini jika ingin mengecek saldo kamu.</p>
        <button @click="getCoinInformation" class="btn btn-success"> Cek Saldo </button>
        <p> Saldo sekarang: {{ myCoin }} ETH </p>
      </div>
      <!-- </center> -->
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
      donate_amount: 0, 
      local_balance: 0,
      print_balance: 0,
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
      let temp = parseInt(result) + parseInt(this.local_balance);
      this.myCoin = temp;
    },
    //
    sendCoinsAmount() {
      this.amount_of_sending = this.coins;
      this.donate_amount = parseInt(this.coins);
      this.local_balance = parseInt(this.local_balance) + parseInt(this.donate_amount);
    }
  }
};

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
