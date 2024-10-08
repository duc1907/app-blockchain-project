// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsurancePackageRegistration {

    // Cấu trúc lưu trữ thông tin đăng ký gói bảo hiểm
    struct InsuranceRegistration {
        uint registration_id;
        address patient;
        uint package_id;
        uint registration_date;
        string status; // "Pending", "Approved", "Active", "Expired"
    }

    // Đếm số lượng đăng ký gói bảo hiểm
    uint public registrationCount = 0;

    // Mapping lưu trữ các đăng ký bảo hiểm dựa trên registration_id
    mapping(uint => InsuranceRegistration) public insuranceRegistrations;

    // Sự kiện khi một gói bảo hiểm được đăng ký
    event InsuranceRegistered(
        uint registration_id,
        address patient,
        uint package_id,
        uint registration_date,
        string status
    );

    // Hàm đăng ký gói bảo hiểm
    function registerInsurance(uint _package_id, uint _registration_date) public {
        registrationCount++;
        insuranceRegistrations[registrationCount] = InsuranceRegistration(
            registrationCount,
            msg.sender,        // địa chỉ của bệnh nhân
            _package_id,
            _registration_date,
            "Pending"          // Trạng thái ban đầu là "Pending"
        );
        emit InsuranceRegistered(registrationCount, msg.sender, _package_id, _registration_date, "Pending");
    }

    // Hàm cập nhật trạng thái đăng ký gói bảo hiểm
    function updateInsuranceStatus(uint _registration_id, string memory _status) public {
        InsuranceRegistration storage registration = insuranceRegistrations[_registration_id];
        registration.status = _status;
    }

    // Hàm lấy thông tin đăng ký bảo hiểm dựa trên registration_id
    function getInsuranceRegistration(uint _registration_id) public view returns (
        uint, address, uint, uint, string memory
    ) {
        InsuranceRegistration memory registration = insuranceRegistrations[_registration_id];
        return (
            registration.registration_id,
            registration.patient,
            registration.package_id,
            registration.registration_date,
            registration.status
        );
    }
}
