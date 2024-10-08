from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

class Patient(db.Model):
    __tablename__ = 'Patient'
    patient_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255))
    dob = db.Column(db.Date)
    gender = db.Column(db.String(10))
    address = db.Column(db.Text)
    phone = db.Column(db.String(20))
    email = db.Column(db.String(255))
    medical_history = db.Column(db.Text)

class Doctor(db.Model):
    __tablename__ = 'Doctor'
    doctor_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255))
    specialization = db.Column(db.String(255))
    phone = db.Column(db.String(20))
    email = db.Column(db.String(255))

class MedicalService(db.Model):
    __tablename__ = 'MedicalService'
    service_id = db.Column(db.Integer, primary_key=True)
    service_name = db.Column(db.String(255))
    description = db.Column(db.Text)
    price = db.Column(db.Numeric(10, 2))
    #doctor_id = db.Column(db.Integer, db.ForeignKey('doctor.doctor_id'))

class InsuranceService(db.Model):
    __tablename__ = 'InsuranceService'
    insurance_id = db.Column(db.Integer, primary_key=True)
    insurance_name = db.Column(db.String(255))
    coverage = db.Column(db.Text)
    price = db.Column(db.Numeric(10, 2))

class Medication(db.Model):
    __tablename__ = 'Medication'
    medication_id = db.Column(db.Integer, primary_key=True)
    medication_name = db.Column(db.String(255))
    description = db.Column(db.Text)
    price = db.Column(db.Numeric(10, 2))

# class Appointment(db.Model):
#     __tablename__ = 'appointments'

#     id = db.Column(db.Integer, primary_key=True, autoincrement=True)
#     patient_id = db.Column(db.Integer, db.ForeignKey('patients.id'), nullable=False)
#     doctor_id = db.Column(db.Integer, db.ForeignKey('doctors.doctor_id'), nullable=False)
#     service_id = db.Column(db.Integer, db.ForeignKey('medical_services.service_id'), nullable=False)
#     appointment_date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
#     on_chain_status = db.Column(db.String(50), nullable=False)

#     # Thiết lập quan hệ
#     patient = db.relationship('Patient', backref=db.backref('appointments', lazy=True))
#     doctor = db.relationship('Doctor', backref=db.backref('appointments', lazy=True))
#     service = db.relationship('MedicalService', backref=db.backref('appointments', lazy=True))

#     def __init__(self, patient_id, doctor_id, service_id, appointment_date, on_chain_status="Pending"):
#         self.patient_id = patient_id
#         self.doctor_id = doctor_id
#         self.service_id = service_id
#         self.appointment_date = appointment_date
#         self.on_chain_status = on_chain_status

# # Bảng bệnh nhân
# class Patient(db.Model):
#     __tablename__ = 'patients'
#     id = db.Column(db.Integer, primary_key=True)
#     full_name = db.Column(db.String(255), nullable=False)
#     date_of_birth = db.Column(db.Date, nullable=False)
#     gender = db.Column(db.String(10), nullable=False)
#     email = db.Column(db.String(255), nullable=False)
#     phone = db.Column(db.String(20), nullable=False)
#     encrypted_medical_records = db.Column(db.Text, nullable=False)
#     blockchain_address = db.Column(db.String(255), nullable=False)

# # Bảng hồ sơ y tế
# class MedicalRecord(db.Model):
#     __tablename__ = 'medical_records'
#     id = db.Column(db.Integer, primary_key=True)
#     patient_id = db.Column(db.Integer, db.ForeignKey('patients.id'), nullable=False)
#     doctor_id = db.Column(db.Integer, nullable=False)
#     encrypted_data = db.Column(db.Text, nullable=False)
#     cloud_storage_link = db.Column(db.String(255), nullable=False)
#     created_at = db.Column(db.DateTime, default=db.func.current_timestamp())
#     updated_at = db.Column(db.DateTime, default=db.func.current_timestamp(), onupdate=db.func.current_timestamp())

# # Bảng thanh toán
# class Payment(db.Model):
#     __tablename__ = 'payments'
#     id = db.Column(db.Integer, primary_key=True)
#     patient_id = db.Column(db.Integer, db.ForeignKey('patients.id'), nullable=False)
#     service_type = db.Column(db.String(255), nullable=False)
#     amount = db.Column(db.Float, nullable=False)
#     payment_status = db.Column(db.String(20), nullable=False)
#     payment_date = db.Column(db.DateTime, default=db.func.current_timestamp())

# # Bảng thông báo
# class Notification(db.Model):
#     __tablename__ = 'notifications'
#     id = db.Column(db.Integer, primary_key=True)
#     user_id = db.Column(db.Integer, nullable=False)
#     notification_type = db.Column(db.String(255), nullable=False)
#     message = db.Column(db.Text, nullable=False)
#     sent_at = db.Column(db.DateTime, default=db.func.current_timestamp())
