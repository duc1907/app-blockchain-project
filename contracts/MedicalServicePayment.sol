// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalServicePayment {

    // Cấu trúc lưu trữ thông tin thanh toán dịch vụ khám bệnh
    struct Payment {
        uint payment_id;
        address patient;
        uint service_id;
        uint payment_date;
        uint amount;
        bool isPaid;
    }

    // Đếm số lượng thanh toán
    uint public paymentCount = 0;

    // Mapping để lưu trữ các khoản thanh toán dựa trên payment_id
    mapping(uint => Payment) public payments;

    // Sự kiện khi thanh toán dịch vụ khám bệnh thành công
    event PaymentMade(
        uint payment_id,
        address patient,
        uint service_id,
        uint payment_date,
        uint amount,
        bool isPaid
    );

    // Hàm để thực hiện thanh toán dịch vụ khám bệnh
    function payForService(uint _service_id, uint _payment_date, uint _amount) public payable {
        require(msg.value == _amount, "So tien thanh toan khong khop");

        paymentCount++;
        payments[paymentCount] = Payment(
            paymentCount,
            msg.sender,         // địa chỉ của bệnh nhân
            _service_id,
            _payment_date,
            _amount,
            true                // Thanh toán thành công
        );

        emit PaymentMade(paymentCount, msg.sender, _service_id, _payment_date, _amount, true);
    }

    // Hàm lấy thông tin thanh toán dựa trên payment_id
    function getPayment(uint _payment_id) public view returns (
        uint, address, uint, uint, uint, bool
    ) {
        Payment memory payment = payments[_payment_id];
        return (
            payment.payment_id,
            payment.patient,
            payment.service_id,
            payment.payment_date,
            payment.amount,
            payment.isPaid
        );
    }
}
