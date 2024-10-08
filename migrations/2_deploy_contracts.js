const AppointmentBooking = artifacts.require("AppointmentBooking");
const MedicalServiceRegistration = artifacts.require("MedicalServiceRegistration");
const InsurancePackageRegistration = artifacts.require("InsurancePackageRegistration");
const InsurancePayment = artifacts.require("InsurancePayment");
const MedicalServicePayment = artifacts.require("MedicalServicePayment");
const MedicationPayment = artifacts.require("MedicationPayment");
const AccessControlManagement = artifacts.require("AccessControlManagement");
const Prescription = artifacts.require("Prescription");

module.exports = function(deployer) {
  deployer.deploy(AppointmentBooking);
  deployer.deploy(MedicalServiceRegistration);
  deployer.deploy(InsurancePackageRegistration);
  deployer.deploy(InsurancePayment);
  deployer.deploy(MedicalServicePayment);
  deployer.deploy(MedicationPayment);
  deployer.deploy(AccessControlManagement);
  deployer.deploy(Prescription);
};
