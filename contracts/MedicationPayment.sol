// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicationPayment {

    // Cấu trúc lưu trữ thông tin thanh toán tiền thuốc
    struct Payment {
        uint payment_id;
        address patient;
        uint medication_id;
        uint payment_date;
        uint amount;
        bool isPaid;
    }

    // Đếm số lượng thanh toán
    uint public paymentCount = 0;

    // Mapping để lưu trữ các khoản thanh toán dựa trên payment_id
    mapping(uint => Payment) public payments;

    // Sự kiện khi thanh toán tiền thuốc thành công
    event PaymentMade(
        uint payment_id,
        address patient,
        uint medication_id,
        uint payment_date,
        uint amount,
        bool isPaid
    );

    // Hàm để thực hiện thanh toán tiền thuốc
    function payForMedication(uint _medication_id, uint _payment_date, uint _amount) public payable {
        require(msg.value == _amount, "So tien thanh toan khong khop");

        paymentCount++;
        payments[paymentCount] = Payment(
            paymentCount,
            msg.sender,         // địa chỉ của bệnh nhân
            _medication_id,
            _payment_date,
            _amount,
            true                // Thanh toán thành công
        );

        emit PaymentMade(paymentCount, msg.sender, _medication_id, _payment_date, _amount, true);
    }

    // Hàm lấy thông tin thanh toán dựa trên payment_id
    function getPayment(uint _payment_id) public view returns (
        uint, address, uint, uint, uint, bool
    ) {
        Payment memory payment = payments[_payment_id];
        return (
            payment.payment_id,
            payment.patient,
            payment.medication_id,
            payment.payment_date,
            payment.amount,
            payment.isPaid
        );
    }
}
