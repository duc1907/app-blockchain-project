// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalServiceRegistration {

    // Cấu trúc lưu trữ thông tin đăng ký dịch vụ khám bệnh
    struct ServiceRegistration {
        uint registration_id;
        address patient;
        uint service_id;
        uint registration_date;
        string status; // "Pending", "Approved", "Completed"
    }

    // Đếm số lượng đăng ký dịch vụ khám
    uint public registrationCount = 0;

    // Mapping để lưu trữ các đăng ký dịch vụ khám bệnh
    mapping(uint => ServiceRegistration) public serviceRegistrations;

    // Sự kiện khi một dịch vụ khám bệnh được đăng ký
    event ServiceRegistered(
        uint registration_id,
        address patient,
        uint service_id,
        uint registration_date,
        string status
    );

    // Hàm đăng ký dịch vụ khám bệnh
    function registerService(uint _service_id, uint _registration_date) public {
        registrationCount++;
        serviceRegistrations[registrationCount] = ServiceRegistration(
            registrationCount,
            msg.sender,        // địa chỉ của bệnh nhân
            _service_id,
            _registration_date,
            "Pending"          // Trạng thái ban đầu là "Pending"
        );
        emit ServiceRegistered(registrationCount, msg.sender, _service_id, _registration_date, "Pending");
    }

    // Hàm cập nhật trạng thái của dịch vụ đăng ký
    function updateRegistrationStatus(uint _registration_id, string memory _status) public {
        ServiceRegistration storage registration = serviceRegistrations[_registration_id];
        registration.status = _status;
    }

    // Hàm lấy thông tin đăng ký dịch vụ khám dựa trên registration_id
    function getRegistration(uint _registration_id) public view returns (
        uint, address, uint, uint, string memory
    ) {
        ServiceRegistration memory registration = serviceRegistrations[_registration_id];
        return (
            registration.registration_id,
            registration.patient,
            registration.service_id,
            registration.registration_date,
            registration.status
        );
    }
}
