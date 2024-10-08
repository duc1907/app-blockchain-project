// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessControlManagement {

    // Cấu trúc lưu trữ thông tin quyền truy cập
    struct Access {
        uint access_id;
        address user;
        string resource; // "PatientData", "Appointment", "Prescription", "Payment", etc.
        bool access_granted;
        uint date_granted;
    }

    // Đếm số lượng quyền truy cập đã cấp
    uint public accessCount = 0;

    // Mapping lưu trữ quyền truy cập dựa trên access_id
    mapping(uint => Access) public accessControlList;

    // Mapping để theo dõi quyền truy cập của mỗi người dùng với từng tài nguyên
    mapping(address => mapping(string => bool)) public userAccess;

    // Sự kiện khi quyền truy cập được cấp
    event AccessGranted(
        uint access_id,
        address user,
        string resource,
        bool access_granted,
        uint date_granted
    );

    // Hàm cấp quyền truy cập cho một người dùng đối với một tài nguyên cụ thể
    function grantAccess(address _user, string memory _resource, uint _date_granted) public {
        accessCount++;
        accessControlList[accessCount] = Access(
            accessCount,
            _user,
            _resource,
            true,  // Quyền truy cập được cấp
            _date_granted
        );

        userAccess[_user][_resource] = true;  // Cập nhật quyền truy cập của người dùng

        emit AccessGranted(accessCount, _user, _resource, true, _date_granted);
    }

    // Hàm hủy quyền truy cập của người dùng đối với tài nguyên cụ thể
    function revokeAccess(address _user, string memory _resource) public {
        userAccess[_user][_resource] = false;  // Hủy quyền truy cập
    }

    // Hàm kiểm tra xem một người dùng có quyền truy cập vào tài nguyên hay không
    function hasAccess(address _user, string memory _resource) public view returns (bool) {
        return userAccess[_user][_resource];
    }

    // Hàm lấy thông tin quyền truy cập dựa trên access_id
    function getAccess(uint _access_id) public view returns (
        uint, address, string memory, bool, uint
    ) {
        Access memory access = accessControlList[_access_id];
        return (
            access.access_id,
            access.user,
            access.resource,
            access.access_granted,
            access.date_granted
        );
    }
}
