const Web3 = require('web3');

// create a new web3 object using the HTTP provider
const web3 = new Web3('http://10.30.122.216:8545');

// get the current block number
web3.eth.getBlockNumber().then(console.log);

// get the balance of an Ethereum address
web3.eth.getBalance('0x1234567890123456789012345678901234567890').then(console.log);
