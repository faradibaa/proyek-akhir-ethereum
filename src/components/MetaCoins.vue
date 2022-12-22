<template>
  <br>
  <div class="card"
              style="
              width: 500px;
              height: 600px;
              /* background-color: blue; */
              padding: 10px;
              border: 2px solid #198754;
              position:absolute;
              top:50%;
              left:50%;
              margin-left:-250px;/* half width*/
              margin-top:-300px;/* half height*/
              " id="content">
    <!-- <center> -->
      <div v-if="menu_collapse" style=" float: right;
                                        width: 100%;
                                        height: 100px;">
        <h2><center><font-awesome-icon class="text-success" icon="fa-solid fa-wallet" /> Dompet <span class="text-success">Kamu</span>Bisa</center></h2>
        <p><center>Dengan fitur <font-awesome-icon class="text-success" icon="fa-solid fa-wallet" /> Dompet <span class="text-success">Kamu</span>Bisa,<br> kirim donasi jadi lebih mudah!</center></p>
      </div>
      <div v-if="!menu_collapse">
        <div style="float: left;
                    width: 70%;
                    height: 100%;">
          <h2><center><font-awesome-icon class="text-success" icon="fa-solid fa-wallet" /> Dompet <span class="text-success">Kamu</span>Bisa</center></h2>
          <p><center>Dengan fitur <font-awesome-icon class="text-success" icon="fa-solid fa-wallet" /> Dompet <span class="text-success">Kamu</span>Bisa,<br> kirim donasi jadi lebih mudah!</center></p>
        </div>
        <div v-if="!target_amount_fulfilled" class="card" style=" float: right;
                                  width: 30%;
                                  height: 80%;
                                  border: 1px solid #198754;
                                  "><h1><center>{{ total_donation }} ETH</center></h1>
                                  <!-- <hr style="line-height: 1px;"> -->
                                  <p><center>Target: 100 ETH</center></p>
        </div>
        <div v-else class="card" style=" float: right;
                                  width: 30%;
                                  height: 80%;
                                  border: 1px solid #198754;
                                  
                                  "><h4><center>Target terpenuhi!</center></h4>
                                  <!-- <hr style="line-height: 1px;"> -->
                                  <p><center>{{ total_donation }}/100 ETH</center></p>
        </div>
      </div>
    
    
    <!-- <hr style="border-color: #198754; height: 1px;"> -->
    <hr>
    <br>
    <!-- <div class="collapse py-2" id="collapseTarget">
      This is the toggle-able content!
    </div> -->

    <!-- <div class="collapse py-2" id="collapseTarget"> -->
      <!-- Send Coin -->
      <div v-if="!target_amount_fulfilled">
        <!-- <button @click="target_amount_fulfilled = !target_amount_fulfilled">Toggle</button> -->
        <div v-if="menu_collapse">
          <center>
            <div class="card" style=" width: 80%;
                                      justify-content: center;
                                      padding: 10px;
                                      border: 1px solid #198754;">
              <!-- <img src="./assets/logo.png"> -->
              <img :src="require('../assets/background.jpg')"/>
              <!-- test -->
            </div>
          </center>
          <br>
          <center><button @click="menu_collapse = !menu_collapse"
            class="btn btn-success" 
            data-bs-target="#collapseTarget" 
            data-bs-toggle="collapse">
            Jadi donatur!
          </button></center>
        </div>
        <div class="collapse py-2" id="collapseTarget">
        <div>
          <!-- <p>Address</p> -->
          <center>
              <!--<input v-model="addr" type="text" placeholder="Masukkan address dompetmu" class="wallet-address card" style=" padding: 10px;
                                                                                                                            border: 1px solid #198754;"/><br>-->
          </center>
        </div>
      <!-- Cek Saldo -->
      <div class="get-balance">
        <p style="line-height: 70%">Tekan tombol di bawah ini jika ingin mengecek saldo kamu.</p>
        <button @click="getCoinInformation" class="btn btn-success"> Cek Saldo </button>
        <p> Saldo sekarang: {{ myCoin }} ETH </p>
      </div>
      <br><br>
      <div class="send-coin">
        <p style="line-height: 70%">Silakan isi kotak di bawah ini jika ingin mengirim donasi.</p>
        <input v-model="coins" type="text" placeholder="Masukkan nominal donasi" class="form-donasi card" style=" padding: 10px;
                                                                                                                  border: 1px solid #198754;">
        <button @click="sendCoinsAmount" class="btn btn-success"> Kirim Koin Donasi </button>
      </div>

      <div class="amount-of-sending">
        <p> Jumlah uang yang didonasikan: {{ donate_amount }}</p>
      </div>
      <br><br>
      <!-- </center> -->
    </div>
    </div>
    <div v-else style="padding: 20px">
      <h3 class="text-success" style="display: flex; justify-content: center;">
        Mohon maaf, donasi kali ini sudah ditutup. <br>
        Terimakasih kepada para donatur atas partisipasinya.
      </h3>
    </div>
    </div>
</template>

<script>
import Web3 from 'web3';
import MetaCoin from '../../build/contracts/MetaCoin.json' // import file JSON untuk mengambil data ABI dan address
//const { ethereum } = window // https://stackoverflow.com/questions/58121048/metamask-web3-ethereum-not-defined
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
      donate_amount: 0,
      receiverAddress: '',
      local_balance: 0,
      print_balance: 0,
      total_donation: 0,
      target_amount_fulfilled: false,
      menu_collapse: true,
      fundDesc: 'penggalangan dana korban gempa',
      fundGoal: 5,
      fundName: 'penggalangan yayasan brawijaya',
      fundImage: 'www.google.com',
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

      // get accounts
      let accounts = await window.ethereum.request({method: 'eth_requestAccounts'});
      this.myAddrs = accounts[0]

      // add campaign di sini aja
      /*await contract.methods.addFundraiseCampaign(
        this.fundDesc,
        this.fundGoal,
        this.fundName,
        this.fundImage
      ).sendTransaction({ from: contractAddress })*/

      // donate
      let campaignList = await contract.methods.getFundraises().call({from: contractAddress});
      console.log(campaignList);
      await contract.methods
        .donate(campaignList[0]['id'], {from: accounts[1], value:web3.utils.toWei(this.donate_amount, 'ether')})
        .sendTransaction({ from: contractAddress }); // donasi ke campaign ke-0
      
      // withdraw ke address ke-0
      await contract.methods
        .donate(campaignList[0]['id'])
        .sendTransaction({ from: contractAddress });
      
      //
      const result = await contract.methods.getBalanceInEth(this.myAddrs).call({from: contractAddress});
      let temp = parseInt(result) + parseInt(this.local_balance);
      this.myCoin = temp;
    },
    //
    sendCoinsAmount() {
      this.donate_amount = parseInt(this.coins);
      if(this.donate_amount == this.donate_amount){
        this.donate_amount = parseInt(this.coins);
        this.local_balance = parseInt(this.local_balance) - parseInt(this.donate_amount);
        this.total_donation = this.donate_amount + this.total_donation;
        if(this.total_donation > 100 - 1){
          this.target_amount_fulfilled = true;
        }
      }
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
