// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Prescription {

    // Cấu trúc lưu trữ thông tin đơn thuốc
    struct PrescriptionData {
        uint prescription_id;
        address patient;
        uint doctor_id;
        uint[] medication_ids;  // Mảng chứa danh sách ID thuốc
        uint date_issued;
    }

    // Đếm số lượng đơn thuốc
    uint public prescriptionCount = 0;

    // Mapping lưu trữ đơn thuốc dựa trên prescription_id
    mapping(uint => PrescriptionData) public prescriptions;

    // Sự kiện khi đơn thuốc được tạo
    event PrescriptionCreated(
        uint prescription_id,
        address patient,
        uint doctor_id,
        uint[] medication_ids,
        uint date_issued
    );

    // Hàm tạo đơn thuốc mới
    function createPrescription(
        address _patient,
        uint _doctor_id,
        uint[] memory _medication_ids,
        uint _date_issued
    ) public {
        prescriptionCount++;
        prescriptions[prescriptionCount] = PrescriptionData(
            prescriptionCount,
            _patient,
            _doctor_id,
            _medication_ids,
            _date_issued
        );
        emit PrescriptionCreated(prescriptionCount, _patient, _doctor_id, _medication_ids, _date_issued);
    }

    // Hàm lấy thông tin đơn thuốc dựa trên prescription_id
    function getPrescription(uint _prescription_id) public view returns (
        uint, address, uint, uint[] memory, uint
    ) {
        PrescriptionData memory prescription = prescriptions[_prescription_id];
        return (
            prescription.prescription_id,
            prescription.patient,
            prescription.doctor_id,
            prescription.medication_ids,
            prescription.date_issued
        );
    }
}
