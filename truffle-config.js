module.exports = {
  // Mạng phát triển cục bộ để triển khai hợp đồng thông minh
  networks: {
    development: {
      host: "127.0.0.1",   // Địa chỉ node blockchain (ở đây là localhost)
      port: 7545,          // Port mặc định của Ganache hoặc node Ethereum
      network_id: "*",     // Mạng nào cũng được (phù hợp với tất cả network id)
    },
  },

  // Cấu hình cho trình biên dịch Solidity
  compilers: {
    solc: {
      version: "0.8.0",    // Phiên bản của Solidity compiler (có thể tùy chỉnh)
    },
  },

  // Mục đích cấu hình nâng cao khác (ví dụ: gas, gasPrice)
  mocha: {
    // Timeout và cấu hình cho mocha testing
    timeout: 100000
  },
};
