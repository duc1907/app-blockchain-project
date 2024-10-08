// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AppointmentBooking {

    // Cấu trúc lưu trữ thông tin cuộc hẹn
    struct Appointment {
        uint appointment_id;
        address patient;
        uint doctor_id;
        uint service_id;
        uint date;
        string status; // "Pending", "Confirmed", "Completed"
    }

    // Đếm số lượng cuộc hẹn
    uint public appointmentCount = 0;

    // Mappings để lưu trữ các cuộc hẹn bằng ID
    mapping(uint => Appointment) public appointments;

    // Sự kiện khi một cuộc hẹn được đặt
    event AppointmentBooked(
        uint appointment_id,
        address patient,
        uint doctor_id,
        uint service_id,
        uint date,
        string status
    );

    // Hàm đặt lịch khám bệnh
    function bookAppointment(uint _doctor_id, uint _service_id, uint _date) public {
        appointmentCount++;
        appointments[appointmentCount] = Appointment(
            appointmentCount,
            msg.sender,        // địa chỉ của bệnh nhân
            _doctor_id,
            _service_id,
            _date,
            "Pending"          // Trạng thái ban đầu là "Pending"
        );
        emit AppointmentBooked(appointmentCount, msg.sender, _doctor_id, _service_id, _date, "Pending");
    }

    // Hàm cập nhật trạng thái cuộc hẹn
    function updateAppointmentStatus(uint _appointment_id, string memory _status) public {
        Appointment storage appointment = appointments[_appointment_id];
        appointment.status = _status;
    }

    // Hàm lấy thông tin cuộc hẹn dựa trên appointment_id
    function getAppointment(uint _appointment_id) public view returns (
        uint, address, uint, uint, uint, string memory
    ) {
        Appointment memory appointment = appointments[_appointment_id];
        return (
            appointment.appointment_id,
            appointment.patient,
            appointment.doctor_id,
            appointment.service_id,
            appointment.date,
            appointment.status
        );
    }
}
