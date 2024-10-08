from flask import Flask, request, jsonify
from web3 import Web3
from config import Config

# Khởi tạo Flask app
app = Flask(__name__)
app.config.from_object(Config)

# Kết nối với mạng Ethereum thông qua Web3
w3 = Web3(Web3.HTTPProvider(app.config['WEB3_PROVIDER']))

# Địa chỉ hợp đồng và ABI của smart contract
contract_address = "0xYourContractAddress"
contract_abi = [...]  # ABI của hợp đồng

# Tải hợp đồng
contract = w3.eth.contract(address=contract_address, abi=contract_abi)

# API để thêm bệnh nhân vào blockchain
@app.route('/add_patient_onchain', methods=['POST'])
def add_patient_onchain():
    data = request.json
    tx_hash = contract.functions.addPatient(
        data['patient_address'], data['full_name']
    ).transact({
        'from': w3.eth.accounts[0]
    })
    return jsonify({"message": "Patient added on blockchain", "tx_hash": tx_hash.hex()})

if __name__ == '__main__':
    app.run(debug=True)
