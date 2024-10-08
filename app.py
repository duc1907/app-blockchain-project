from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from config import Config
# Import các mô hình từ file models.py
from models import *

# Khởi tạo Flask app và cấu hình
app = Flask(__name__)
app.config.from_object('config.Config')

# Khởi tạo SQLAlchemy
db.init_app(app)

# Tạo bảng dữ liệu nếu chưa có
with app.app_context():
    db.create_all()
    print("Database tables created successfully.")

# API để thêm bệnh nhân mới
@app.route('/patients', methods=['POST'])
def add_patient():
    data = request.get_json()
    new_patient = Patient(
        name=data['name'],
        dob=data['dob'],
        gender=data['gender'],
        address=data['address'],
        phone=data['phone'],
        email=data['email'],
        medical_history=data['medical_history']
    )
    db.session.add(new_patient)
    db.session.commit()
    return jsonify({"message": "Patient added successfully!"}), 201

# API để lấy danh sách bệnh nhân
@app.route('/patients', methods=['GET'])
def get_patients():
    patients = Patient.query.all()
    output = []
    for patient in patients:
        patient_data = {
            'patient_id': patient.patient_id,
            'name': patient.name,
            'dob': str(patient.dob),
            'gender': patient.gender,
            'address': patient.address,
            'phone': patient.phone,
            'email': patient.email,
            'medical_history': patient.medical_history
        }
        output.append(patient_data)
    return jsonify({'patients': output})

# API để xóa bệnh nhân dựa trên ID
@app.route('/patients/<int:patient_id>', methods=['DELETE'])
def delete_patient(patient_id):
    # Tìm bệnh nhân dựa trên ID
    patient = Patient.query.get(patient_id)

    if not patient:
        return jsonify({"message": "Patient not found"}), 404

    try:
        # Xóa bệnh nhân khỏi cơ sở dữ liệu
        db.session.delete(patient)
        db.session.commit()
        return jsonify({"message": "Patient deleted successfully!"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": f"An error occurred: {e}"}), 500

# API để thêm dịch vụ khám chữa bệnh mới
@app.route('/medical_services', methods=['POST'])
def add_medical_service():
    data = request.get_json()
    new_service = MedicalService(
        service_name=data['service_name'],
        description=data.get('description', ''),
        price=data['price'],
        doctor_id=data.get('doctor_id')
    )
    db.session.add(new_service)
    db.session.commit()
    return jsonify({"message": "Medical service added successfully!"}), 201

# API để lấy danh sách dịch vụ khám chữa bệnh
@app.route('/medical_services', methods=['GET'])
def get_medical_services():
    services = MedicalService.query.all()
    output = []
    for service in services:
        service_data = {
            'service_id': service.service_id,
            'service_name': service.service_name,
            'description': service.description,
            'price': str(service.price),
            'doctor_id': service.doctor_id
        }
        output.append(service_data)
    return jsonify({'medical_services': output})

# API để thêm dịch vụ bảo hiểm mới
@app.route('/insurance_services', methods=['POST'])
def add_insurance_service():
    data = request.get_json()
    new_service = InsuranceService(
        insurance_name=data['insurance_name'],
        coverage=data['coverage'],
        price=data['price']
    )
    db.session.add(new_service)
    db.session.commit()
    return jsonify({"message": "Insurance service added successfully!"}), 201

# API để lấy danh sách dịch vụ bảo hiểm
@app.route('/insurance_services', methods=['GET'])
def get_insurance_services():
    services = InsuranceService.query.all()
    output = []
    for service in services:
        service_data = {
            'insurance_id': service.insurance_id,
            'insurance_name': service.insurance_name,
            'coverage': service.coverage,
            'price': str(service.price)
        }
        output.append(service_data)
    return jsonify({'insurance_services': output})

# API để thêm thuốc mới
@app.route('/medications', methods=['POST'])
def add_medication():
    data = request.get_json()
    new_medication = Medication(
        medication_name=data['medication_name'],
        description=data.get('description', ''),
        price=data['price']
    )
    db.session.add(new_medication)
    db.session.commit()
    return jsonify({"message": "Medication added successfully!"}), 201

# API để lấy danh sách thuốc
@app.route('/medications', methods=['GET'])
def get_medications():
    medications = Medication.query.all()
    output = []
    for medication in medications:
        medication_data = {
            'medication_id': medication.medication_id,
            'medication_name': medication.medication_name,
            'description': medication.description,
            'price': str(medication.price)
        }
        output.append(medication_data)
    return jsonify({'medications': output})

# API để thêm bác sĩ mới
@app.route('/doctors', methods=['POST'])
def add_doctor():
    data = request.get_json()
    new_doctor = Doctor(
        name=data['name'],
        specialization=data.get('specialization', ''),
        phone=data['phone'],
        email=data['email']
    )
    db.session.add(new_doctor)
    db.session.commit()
    return jsonify({"message": "Doctor added successfully!"}), 201

# API để lấy danh sách bác sĩ
@app.route('/doctors', methods=['GET'])
def get_doctors():
    doctors = Doctor.query.all()
    output = []
    for doctor in doctors:
        doctor_data = {
            'doctor_id': doctor.doctor_id,
            'name': doctor.name,
            'specialization': doctor.specialization,
            'phone': doctor.phone,
            'email': doctor.email
        }
        output.append(doctor_data)
    return jsonify({'doctors': output})

if __name__ == '__main__':
    app.run(debug=True)
