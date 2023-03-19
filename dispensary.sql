DROP DATABASE IF EXISTS dispensary;
CREATE DATABASE dispensary;
USE dispensary;

DROP TABLE IF EXISTS Patients;
CREATE TABLE Patients (
    ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Age INT NOT NULL,
    ContactNumber VARCHAR(20)
);

INSERT INTO Patients (ID, Name, Gender, Age, ContactNumber) VALUES
    (11, 'Rakesh Kumar', 'Male', 45, '+91-9999988888'),
    (12, 'Sunita Gupta', 'Female', 34, '+91-8888877777'),
    (13, 'Anjali Sharma', 'Female', 28, '+91-7777766666'),
    (14, 'Abhishek Singh', 'Male', 32, '+91-6666655555'),
    (15, 'Deepak Verma', 'Male', 29, '+91-5555544444'),
    (16, 'Shreya Singh', 'Female', 22, '+91-4444433333'),
    (17, 'Rohit Jain', 'Male', 48, '+91-3333322222'),
    (18, 'Pooja Patel', 'Female', 25, '+91-2222211111'),
    (19, 'Prashant Kumar', 'Male', 36, '+91-1111100000'),
    (20, 'Ankita Tiwari', 'Female', 31, '+91-0000099999');
    
DROP TABLE IF EXISTS `Medical staff`;
CREATE TABLE `Medical staff` (
  `Employee ID` INT(11) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Role` VARCHAR(50) NOT NULL,
  `Specialization` VARCHAR(50) NOT NULL,
  `Contact_number` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Employee ID`)
);

INSERT INTO `Medical staff` (`Employee ID`, `Name`, `Role`, `Specialization`, `Contact_number`) VALUES
(101, 'Dr. Anupama Singh', 'Medical Director', 'General Medicine', '+91-9999988888'),
(102, 'Dr. Rohan Mehra', 'Physician', 'Cardiology', '+91-8888877777'),
(103, 'Dr. Priya Sharma', 'Surgeon', 'Neurosurgery', '+91-7777766666'),
(104, 'Dr. Ramesh Singh', 'Pediatrician', 'Pediatrics', '+91-6666655555'),
(105, 'Dr. Sneha Kapoor', 'Dermatologist', 'Dermatology', '+91-5555544444'),
(106, 'Dr. Akash Verma', 'Oncologist', 'Medical Oncology', '+91-4444433333'),
(107, 'Dr. Nisha Singh', 'Gynecologist', 'Obstetrics', '+91-3333322222'),
(108, 'Dr. Kunal Sharma', 'Psychiatrist', 'Psychiatry', '+91-2222211111'),
(109, 'Dr. Rahul Gupta', 'Orthopedician', 'Orthopedics', '+91-1111100000'),
(110, 'Dr. Swati Tiwari', 'Ophthalmologist', 'Ophthalmology', '+91-0000099999');

DROP TABLE IF EXISTS Vendors;
CREATE TABLE Vendors (
  Vendor_ID INT(3) NOT NULL,
  Name VARCHAR(50) NOT NULL,
  Vendor_Specialization VARCHAR(50) NOT NULL,
  Contact_Number VARCHAR(15) NOT NULL,
  PRIMARY KEY (Vendor_ID)
);

INSERT INTO Vendors (Vendor_ID, Name, Vendor_Specialization, Contact_Number) VALUES
(101, 'ABC Medicals', 'Pharmaceuticals', '+91-9999988888'),
(102, 'Medico Surgical Company', 'Medical Equipment', '+91-8888877777'),
(103, 'XYZ Health Products', 'Herbal Medicine', '+91-7777766666'),
(104, 'Delta Diagnostics', 'Diagnostic Equipment', '+91-6666655555'),
(105, 'Health Line Pharma', 'Pharmaceuticals', '+91-5555544444'),
(106, 'Royal Surgicals', 'Surgical Equipment', '+91-4444433333'),
(107, 'Medilink', 'Medical Equipment', '+91-3333322222'),
(108, 'MediCure', 'Pharmaceuticals', '+91-2222211111'),
(109, 'Lifecare', 'Pharmaceuticals', '+91-1111100000'),
(110, 'BioGen', 'Pharmaceuticals', '+91-0000099999');

DROP TABLE IF EXISTS Medical_inventory;
CREATE TABLE Medical_inventory (
  Medicine_ID INT(3) NOT NULL,
  Medicine_Name VARCHAR(50) NOT NULL,
  Price FLOAT(6,2) NOT NULL,
  Stock INT(5) NOT NULL,
  PRIMARY KEY (Medicine_ID)
);

INSERT INTO Medical_inventory (Medicine_ID, Medicine_Name, Price, Stock) VALUES
(301, 'Paracetamol', 5.00, 100),
(302, 'Ciprofloxacin', 20.00, 50),
(303, 'Ibuprofen', 8.00, 75),
(304, 'Aspirin', 3.50, 200),
(305, 'Amoxicillin', 15.00, 60),
(306, 'Omeprazole', 10.00, 80),
(307, 'Metformin', 7.50, 90),
(308, 'Losartan', 12.00, 50),
(309, 'Atorvastatin', 18.00, 40),
(310, 'Montelukast', 25.00, 30);

DROP TABLE IF EXISTS Equipment;
CREATE TABLE Equipment (
  Equipment_ID INT(3) NOT NULL,
  Equipment_Name VARCHAR(50) NOT NULL,
  Category VARCHAR(20) NOT NULL,
  Brand VARCHAR(20) NOT NULL,
  PRIMARY KEY (Equipment_ID)
);

INSERT INTO Equipment (Equipment_ID, Equipment_Name, Category, Brand) VALUES
(201, 'ECG Machine', 'Diagnostic', 'GE'),
(202, 'Stethoscope', 'Diagnostic', 'Littmann'),
(203, 'Infusion Pump', 'Medical', 'Philips'),
(204, 'Hospital Bed', 'Furniture', 'KI'),
(205, 'Nebulizer', 'Medical', 'Omron'),
(206, 'Defibrillator', 'Diagnostic', 'Physio-Control'),
(207, 'Otoscope', 'Diagnostic', 'Welch Allyn'),
(208, 'X-ray Machine', 'Diagnostic', 'Siemens'),
(209, 'Blood Pressure Monitor', 'Diagnostic', 'Omron'),
(210, 'Surgical Instruments', 'Surgical', 'Stryker');
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  Order_ID INT NOT NULL,
  Date DATE NOT NULL,
  Total_Cost DECIMAL(10,2) NOT NULL,
  Payment_Due DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (Order_ID)
);

INSERT INTO Orders (Order_ID, Date, Total_Cost, Payment_Due)
VALUES 
(1001, '2023-03-15', 500.00, 0.00),
(1002, '2023-03-14', 1200.00, 600.00),
(1003, '2023-03-14', 750.00, 0.00),
(1004, '2023-03-13', 900.00, 900.00),
(1005, '2023-03-12', 2500.00, 500.00),
(1006, '2023-03-11', 1500.00, 500.00),
(1007, '2023-03-10', 800.00, 800.00),
(1008, '2023-03-09', 1800.00, 1800.00),
(1009, '2023-03-08', 3000.00, 1500.00),
(1010, '2023-03-07', 650.00, 0.00);