-- Database DMS
DROP DATABASE IF EXISTS DMS;
CREATE DATABASE DMS;
USE DMS;


-- USER defined data-types

-- create type Weight_kg as (
	-- numeric(5,2) final);
-- create type Hiight_cm as (
	-- INT(3) final);
    
-- CREATE TYPE Name AS (
    -- first_name VARCHAR(50) NOT NULL,
    -- middle_name VARCHAR(50),
    -- last_name VARCHAR(50) NOT NULL);

-- CREATE TYPE Address AS (
    -- street VARCHAR(50),
    -- city VARCHAR(50),
    -- district VARCHAR(50),
    -- state VARCHAR(50),
    -- Pincode VARCHAR(50));

ALTER TABLE Vendor_contacts ADD COLUMN location JSON;

UPDATE Vendor_contacts SET location = JSON_OBJECT(
    'Country Code', contact_country_code
);

-- Employee
DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
  staff_id INT PRIMARY KEY,
  occupation VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  contact_number VARCHAR(20) NOT NULL,
  employment_status VARCHAR(20) NOT NULL,
  gender VARCHAR(10) NOT NULL,
  employment_date DATE NOT NULL
);

INSERT INTO Employee (staff_id, occupation, name, contact_number, employment_status, gender, employment_date) VALUES
(1001, 'Doctor', 'John Smith', '1234567890', 'Full-Time', 'Male', '2020-01-01'),
(1002, 'Nurse', 'Mary Johnson', '0987654321', 'Part-Time', 'Female', '2019-05-01'),
(1003, 'Admin', 'David Lee', '2345678901', 'Full-Time', 'Male', '2018-02-01'),
(1004, 'Doctor', 'Sarah Davis', '3456789012', 'Full-Time', 'Female', '2021-03-15'),
(1005, 'Receptionist', 'Karen Wilson', '4567890123', 'Part-Time', 'Female', '2022-01-01'),
(1006, 'Admin', 'Jason Kim', '5678901234', 'Full-Time', 'Male', '2021-05-01'),
(1007, 'Nurse', 'Lisa Garcia', '6789012345', 'Full-Time', 'Female', '2017-11-01'),
(1008, 'Doctor', 'Michael Chen', '7890123456', 'Part-Time', 'Male', '2016-08-01'),
(1009, 'Admin', 'Emily Wong', '8901234567', 'Full-Time', 'Female', '2020-09-01'),
(1010, 'Receptionist', 'Steven Brown', '9012345678', 'Part-Time', 'Male', '2019-04-01');

-- Medical Staff
DROP TABLE IF EXISTS Medical_staff;

CREATE TABLE Medical_staff (
  staff_id INT PRIMARY KEY,
  role VARCHAR(20) NOT NULL,
  qualification VARCHAR(255) NOT NULL,
  specialization VARCHAR(255) NOT NULL,
  license_issue_date DATE NOT NULL,
  home_contact VARCHAR(20) NOT NULL,
  FOREIGN KEY (staff_id) REFERENCES Employee(staff_id)
);

INSERT INTO Medical_staff (staff_id, role, qualification, specialization, license_issue_date, home_contact) VALUES
(1001, 'Doctor', 'MD', 'Cardiology', '2015-06-01', '555-555-5555'),
(1002, 'Nurse', 'BSN', 'Pediatrics', '2018-01-01', '555-555-5555'),
(1004, 'Doctor', 'MD', 'Dermatology', '2017-08-01', '555-555-5555'),
(1007, 'Nurse', 'BSN', 'Emergency', '2020-02-01', '555-555-5555'),
(1008, 'Doctor', 'MD', 'Oncology', '2014-05-01', '555-555-5555');

-- Management Staff
DROP TABLE IF EXISTS Management_staff;

CREATE TABLE Management_staff (
  staff_id INT PRIMARY KEY,
  role VARCHAR(20) NOT NULL,
  qualification VARCHAR(255) NOT NULL,
  specialization VARCHAR(255) NOT NULL,
  license_issue_date DATE NOT NULL,
  home_contact VARCHAR(20) NOT NULL,
  FOREIGN KEY (staff_id) REFERENCES Employee(staff_id)
);

INSERT INTO Management_staff (staff_id, role, qualification, specialization, license_issue_date, home_contact) VALUES
(1003, 'Admin', 'MBA', 'Human Resources', '2016-03-01', '555-555-5555'),
(1006, 'Admin', 'MBA', 'Marketing', '2019-09-01', '555-555-5555'),
(1009, 'Admin', 'MBA', 'Operations', '2021-01-01', '555-555-5555'),
(1010, 'Receptionist', 'High School Diploma', 'N/A', '2021-01-01', '555-555-5555');

-- Insurance
DROP TABLE IF EXISTS Insurance;

CREATE TABLE Insurance (
    insurance_code INT PRIMARY KEY,
    insurance_status VARCHAR(50) NOT NULL DEFAULT 'active',
    insurance_provider VARCHAR(50) NOT NULL,
    insurace_issue_date DATE NOT NULL,
    insurace_expiry_date DATE NOT NULL,
    CONSTRAINT chk_dates CHECK (insurace_issue_date <= insurace_expiry_date)
);

INSERT INTO Insurance (insurance_code, insurance_status, insurance_provider, insurace_issue_date, insurace_expiry_date) VALUES
(1001, 'active', 'ABC Insurance', '2022-01-01', '2022-12-31'),
(1002, 'active', 'XYZ Insurance', '2022-03-01', '2023-02-28'),
(1003, 'active', 'PQR Insurance', '2022-02-15', '2023-02-14'),
(1004, 'active', 'DEF Insurance', '2022-01-01', '2022-12-31'),
(1005, 'active', 'GHI Insurance', '2022-06-01', '2023-05-31'),
(1006, 'active', 'JKL Insurance', '2022-01-15', '2023-01-14'),
(1007, 'active', 'MNO Insurance', '2022-07-01', '2023-06-30'),
(1008, 'active', 'STU Insurance', '2022-01-01', '2022-12-31'),
(1009, 'active', 'VWX Insurance', '2022-04-01', '2023-03-31'),
(1010, 'active', 'YZA Insurance', '2022-08-01', '2023-07-31');


-- Patient details Insurance(FK)
DROP TABLE IF EXISTS Patient;

CREATE TABLE Patient (
    patient_code INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    age INT,
    birth_date DATE,
    gender CHAR(1),
    height INT,
    weight INT,
    -- contact_number VARCHAR(20),
    email VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50),
    district VARCHAR(50),
    state VARCHAR(50),
    Pincode VARCHAR(50),
    occupation VARCHAR(50),
    medical_history VARCHAR(500),
    remarks VARCHAR(500),
    insurance_code INT,
    FOREIGN KEY (insurance_code) REFERENCES Insurance (insurance_code)
);

INSERT INTO Patient (patient_code, first_name, middle_name, last_name, age, birth_date, gender, height, weight, email, street, city, district, state, Pincode, occupation, medical_history, remarks, insurance_code)
VALUES
(1, 'John', 'W', 'Doe', 35, '1987-05-12', 'M', 180, 80, 'john.doe@example.com', 'Main St.', 'New York', 'Manhattan', 'NY', 10001, 'Software Engineer', 'None', 'None', 1001),
(2, 'Jane', '', 'Smith', 45, '1977-02-28', 'F', 165, 65, 'jane.smith@example.com', 'Broadway', 'New York', 'Manhattan', 'NY', 10002, 'Doctor', 'Allergies', 'None', 1005),
(3, 'David', 'J', 'Brown', 25, '1997-10-05', 'M', 175, 75, 'david.brown@example.com', 'Main St.', 'Boston', 'Suffolk', 'MA', 02108, 'Student', 'None', 'None', 1007),
(4, 'Samantha', '', 'Lee', 32, '1990-08-15', 'F', 160, 60, 'samantha.lee@example.com', 'King St.', 'Toronto', 'Toronto', 'ON', 'M5V 3L2', 'Designer', 'Asthma', 'None', 1002),
(5, 'Michael', 'R', 'Wilson', 50, '1972-04-18', 'M', 185, 90, 'michael.wilson@example.com', 'Queen St.', 'Vancouver', 'Greater Vancouver', 'BC', 'V6B 6G9', 'Businessman', 'None', 'None', 1001),
(6, 'Emily', '', 'Clark', 28, '1994-12-23', 'F', 170, 55, 'emily.clark@example.com', 'Washington St.', 'Los Angeles', 'Los Angeles', 'CA', 90001, 'Artist', 'Depression', 'None', 1006),
(7, 'Robert', 'T', 'Miller', 42, '1980-09-08', 'M', 190, 100, 'robert.miller@example.com', 'Market St.', 'San Francisco', 'San Francisco', 'CA', 94103, 'Accountant', 'None', 'None', 1002),
(8, 'Rachel', '', 'Green', 26, '1996-02-11', 'F', 163, 55, 'rachel.green@example.com', 'Broadway', 'New York', 'Manhattan', 'NY', 10003, 'Waitress', 'None', 'None', 1005),
(9, 'Matthew', 'P', 'Davis', 31, '1991-11-28', 'M', 175, 80, 'matthew.davis@example.com', 'Main St.', 'Seattle', 'King', 'WA', 98101, 'Engineer', 'None', 'None', 1001),
(10, 'Olivia', '', 'Moore', 29, '1993-07-09', 'F', 168, 60, 'olivia.moore@example.com', 'Oak St.', 'Portland', 'Multnomah', 'OR', 97204, 'Graphic Designer', 'None', 'None', 1002);


-- Patient Contact
DROP TABLE IF EXISTS Patient_contact_number;

CREATE TABLE Patient_contact_number (
    patient_code INT,
    contact_number VARCHAR(20) NOT NULL,
    FOREIGN KEY (patient_code) REFERENCES Patient(patient_code)
);

INSERT INTO Patient_contact_number (patient_code, contact_number) VALUES
(1, '9876543210'),
(2, '9998887776'),
(3, '8899776655'),
(4, '7788990011'),
(4, '9988776655'),
(5, '7788990069'),
(6, '7788990022'),
(7, '8899776611'),
(8, '7777888811'),
(9, '9966554433'),
(10, '8899776699');

-- Medical Products
DROP TABLE IF EXISTS Medical_Products;

CREATE TABLE Medical_Products (
    medical_id INT PRIMARY KEY,
    cost INT,
    item_name VARCHAR(50) NOT NULL
    -- staff_id INT,
    -- vendor_id INT,
    -- FOREIGN KEY (staff_id) REFERENCES Employee (staff_id)
    -- FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
);

INSERT INTO Medical_Products (medical_id, cost, item_name) VALUES
(10001, 500, 'Aspirin'),
(10002, 1000, 'Antibiotics'),
(10003, 200, 'Painkiller'),
(10004, 1500, 'Antidepressants'),
(10005, 300, 'Bandages'),
(10006, 10000, 'MRI Machine'),
(10007, 5000, 'Ultrasound Machine'),
(10008, 8000, 'X-Ray Machine'),
(10009, 15000, 'Surgical Robot'),
(10010, 500, 'Thermometer');

-- Medicine 
DROP TABLE IF EXISTS Medicine;

CREATE TABLE Medicine (
    medical_id INT PRIMARY KEY,
    form VARCHAR(50) NOT NULL,
    active_ingredients VARCHAR(100),
    recommended_dosage VARCHAR(50),
    manufacturing_date DATE NOT NULL,
    shelf_life VARCHAR(50),
    expiry_date DATE NOT NULL,
    FOREIGN KEY (medical_id) REFERENCES Medical_Products(medical_id)
);

INSERT INTO Medicine (medical_id, form, active_ingredients, recommended_dosage, manufacturing_date, shelf_life, expiry_date) VALUES
(10001, 'Tablet', 'Acetylsalicylic acid', '1-2 tablets every 4-6 hours', '2021-01-01', '3 years', '2024-01-01'),
(10002, 'Capsule', 'Penicillin', '1 capsule every 8 hours', '2022-02-01', '2 years', '2024-02-01'),
(10003, 'Injection', 'Morphine', '1 injection every 6 hours', '2021-07-01', '1 year', '2022-07-01'),
(10004, 'Tablet', 'Serotonin-norepinephrine reuptake inhibitors', '1-2 tablets every day', '2022-01-01', '2 years', '2024-01-01');

-- Equipment
DROP TABLE IF EXISTS Equipment;

CREATE TABLE Equipment (
    medical_id INT PRIMARY KEY,
    equipment_category VARCHAR(50) NOT NULL,
    manufacturing_brand VARCHAR(50),
    requirement_for VARCHAR(50),
    FOREIGN KEY (medical_id) REFERENCES Medical_Products(medical_id)
);

INSERT INTO Equipment (medical_id, equipment_category, manufacturing_brand, requirement_for) VALUES
(10005, 'Imaging', 'XE Healthcare', 'Diagnosing diseases'),
(10006, 'Imaging', 'GE Healthcare', 'Diagnosing diseases'),
(10007, 'Imaging', 'Philips', 'Diagnosing diseases'),
(10008, 'Imaging', 'Siemens', 'Diagnosing diseases'),
(10009, 'Surgical', 'Intuitive Surgical', 'Minimally invasive surgery'),
(10010, 'Diagnostic', 'Braun', 'Measuring body temperature');

-- Medical Inventory Medical_products(FK)
DROP TABLE IF EXISTS Medical_inventory;

CREATE TABLE Medical_inventory (
    medical_id INT PRIMARY KEY,
    stocks INT NOT NULL DEFAULT 0,
    availability VARCHAR(50) NOT NULL DEFAULT 'available',
    FOREIGN KEY (medical_id) REFERENCES Medical_Products(medical_id)
);

INSERT INTO Medical_inventory (medical_id, stocks, availability) VALUES
(10001, 50, 'available'),
(10002, 100, 'available'),
(10003, 25, 'available'),
(10004, 75, 'available'),
(10005, 200, 'available'),
(10006, 3, 'available'),
(10007, 2, 'available'),
(10008, 4, 'available'),
(10009, 1, 'available'),
(10010, 100, 'available');

-- Prescription Medicine(FK) Patient(FK) Employee(FK) 
DROP TABLE IF EXISTS Prescription;

CREATE TABLE Prescription (
    prescription_id INT PRIMARY KEY,
    patient_code INT NOT NULL,
    staff_id INT NOT NULL,
    date DATE NOT NULL,
    -- medicine VARCHAR(100),
    medical_id INT NOT NULL,
    -- type_of_medicine VARCHAR(50),
    FOREIGN KEY (medical_id) REFERENCES Medicine(medical_id),
    FOREIGN KEY (patient_code) REFERENCES Patient(patient_code),
    FOREIGN KEY (staff_id) REFERENCES Employee(staff_id)
);

INSERT INTO Prescription (prescription_id, patient_code, staff_id, date, medical_id)
VALUES
(1, 1, 1002, '2022-01-01', 10001),
(2, 2, 1002, '2022-01-02', 10002),
(3, 6, 1010, '2022-01-03', 10003),
(4, 3, 1001, '2022-01-04', 10004),
(5, 7, 1004, '2022-01-05', 10001),
(6, 4, 1008, '2022-01-06', 10002),
(7, 5, 1005, '2022-01-07', 10003),
(8, 9, 1001, '2022-01-08', 10004),
(9, 10, 1005, '2022-01-09', 10001),
(10, 8, 1008, '2022-01-10', 10002);


-- General Visit Prescription(FK)
DROP TABLE IF EXISTS General_visit;

CREATE TABLE General_visit (
    visit_id INT PRIMARY KEY,
    prescription_id INT,
    visit_time TIME,
    visit_date DATE,
    visit_status VARCHAR(50),
    visit_number INT,
    reference VARCHAR(50),
    new_visit VARCHAR(10),
    FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id)
);

INSERT INTO General_visit (visit_id, prescription_id, visit_time, visit_date, visit_status, visit_number, reference, new_visit)
VALUES
(1, 1, '10:30:00', '2022-01-01', 'complete', 1, 'ref-001', 'no'),
(2, 2, '11:15:00', '2022-01-02', 'in progress', 1, 'ref-002', 'no'),
(3, 3, '14:45:00', '2022-01-03', 'complete', 1, 'ref-003', 'no'),
(4, 4, '09:00:00', '2022-01-04', 'cancelled', 1, 'ref-004', 'yes'),
(5, 5, '13:30:00', '2022-01-05', 'in progress', 2, 'ref-005', 'no'),
(6, 6, '16:00:00', '2022-01-06', 'complete', 1, 'ref-006', 'no'),
(7, 7, '10:00:00', '2022-01-07', 'complete', 1, 'ref-007', 'no'),
(8, 8, '12:45:00', '2022-01-08', 'cancelled', 1, 'ref-008', 'yes'),
(9, 9, '15:30:00', '2022-01-09', 'in progress', 2, 'ref-009', 'no'),
(10, 10, '11:30:00', '2022-01-10', 'complete', 1, 'ref-010', 'no');

-- Vendor
DROP TABLE IF EXISTS Vendor;

CREATE TABLE Vendor (
    vendor_id INT PRIMARY KEY,
    -- order_id INT,
    vendor_type VARCHAR(50),
    vendor_name VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50),
    district VARCHAR(50),
    state VARCHAR(50),
    pincode INT,
    bank_account_number VARCHAR(50)
    -- FOREIGN KEY (order_id) REFERENCES Purchase_order(order_id)
);

INSERT INTO Vendor (vendor_id, vendor_type, vendor_name, street, city, district, state, pincode, bank_account_number)
VALUES
(1, 'Equipment', 'Medical Supplier Inc.', '123 Main St.', 'Los Angeles', 'Downtown', 'CA', 90012, '1234567890'),
(2, 'Pharmaceuticals', 'Pharma Solutions LLC', '456 Oak Ave.', 'New York', 'Queens', 'NY', 11377, '0987654321'),
(3, 'Equipment', 'Medtech Corporation', '789 Pine St.', 'Chicago', 'Northside', 'IL', 60610, '1357908642'),
(4, 'Supplies', 'Hospice Care Supplies', '246 Elm St.', 'San Francisco', 'Mission', 'CA', 94110, '2468135790'),
(5, 'Pharmaceuticals', 'Medicine Mart', '101 Market St.', 'Miami', 'Downtown', 'FL', 33130, '9876543210'),
(6, 'Supplies', 'Medical Supply Depot', '222 1st Ave.', 'Seattle', 'Capitol Hill', 'WA', 98102, '0123456789'),
(7, 'Equipment', 'Healthtech Inc.', '333 Chestnut St.', 'Boston', 'Back Bay', 'MA', 02116, '9876543210'),
(8, 'Pharmaceuticals', 'RxCare Solutions', '444 Broadway', 'Houston', 'Downtown', 'TX', 77002, '2468013579'),
(9, 'Supplies', 'Hospitality Medical Supply', '555 State St.', 'Philadelphia', 'Center City', 'PA', 19103, '1357924680'),
(10, 'Equipment', 'Medical Machines Corp.', '666 Elm St.', 'Denver', 'LoDo', 'CO', 80202, '0123456789');

-- Vendor Contact
DROP TABLE IF EXISTS Vendor_contacts;

CREATE TABLE Vendor_contacts (
    vendor_id INT,
    contact VARCHAR(20) NOT NULL,
    -- user defined data_type
    contact_country_code VARCHAR(20),
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
);

INSERT INTO Vendor_contacts (vendor_id, contact)
VALUES
(1, '123-456-7890'),
(1, '111-222-3333'),
(2, '222-333-4444'),
(2, '444-555-6666'),
(3, '555-666-7777'),
(4, '777-888-9999'),
(5, '111-222-3333'),
(6, '333-444-5555'),
(6, '555-666-7777'),
(7, '777-888-9999');

-- Purchase order Employee(FK) Vendor(FK) Medical_products(FK)
DROP TABLE IF EXISTS Purchase_order;

CREATE TABLE Purchase_order (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    staff_id INT NOT NULL,
    vendor_id INT NOT NULL,
    medical_id INT NOT NULL,
    purchase_cost INT NOT NULL,
    gross_total INT NOT NULL,
    purchase_id_name VARCHAR(50) NOT NULL,
    discount INT DEFAULT 0,
    net_total INT NOT NULL,
    amount_paid INT DEFAULT 0,
    pending_amount INT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES Employee(staff_id),
    FOREIGN KEY (vendor_id) REFERENCES Vendor (vendor_id),
    FOREIGN KEY (medical_id) REFERENCES Medical_Products (medical_id)
);

INSERT INTO Purchase_order (order_id, order_date, staff_id, vendor_id, medical_id, purchase_cost, gross_total, purchase_id_name, discount, net_total, amount_paid, pending_amount)
VALUES 
(1, '2022-01-01', 1009, 1, 10005, 5000, 5500, 'order01', 10, 4950, 0, 4950),
(2, '2022-01-02', 1010, 2, 10002, 7000, 7700, 'order02', 5, 7315, 7315, 0),
(3, '2022-01-05', 1009, 1, 10008, 4000, 4200, 'order03', 0, 4200, 2100, 2100),
(4, '2022-01-06', 1009, 4, 10002, 2500, 2750, 'order04', 0, 2750, 2750, 0),
(5, '2022-01-07', 1010, 5, 10003, 6000, 6300, 'order05', 0, 6300, 6300, 0),
(6, '2022-01-10', 1009, 6, 10007, 3500, 3850, 'order06', 8, 3542, 2000, 1542),
(7, '2022-01-12', 1009, 1, 10005, 8000, 8400, 'order07', 0, 8400, 4200, 4200),
(8, '2022-01-15', 1010, 8, 10009, 4500, 4500, 'order08', 15, 3825, 0, 3825),
(9, '2022-01-16', 1009, 9, 10009, 9000, 9450, 'order09', 0, 9450, 7000, 2450),
(10, '2022-01-20',1009, 9, 10001, 3500, 3850, 'order10', 0, 3850, 3850, 0);

-- indexing
CREATE INDEX emp_idx ON employee(name, occupation);
CREATE INDEX manageStaff_idx ON management_staff(role,specialization);
CREATE FULLTEXT INDEX patient_remark_idx ON patient(remarks);
CREATE INDEX medicalStaff_idx ON medical_staff(role, specialization);
CREATE INDEX medical_name_idx ON medical_products(item_name);
CREATE INDEX medicine_form_idx ON medicine(form);
CREATE INDEX equipment_idx ON equipment(equipment_category, requirement_for);
CREATE INDEX purchase_id_idx ON purchase_order(net_total);
CREATE INDEX vendor_idx ON vendor(vendor_name);
CREATE INDEX prescription_idx ON prescription(prescription_id);
CREATE INDEX insurance_idx ON insurance(insurance_provider);
CREATE INDEX medical_inv_idx ON medical_inventory(medical_id);

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL
);

INSERT INTO users (name, email, password, role) VALUES
    ('Rakesh Kumar', 'rakesh.kumar@gmail.com', '123456', 'patient'),
    ('Sunita Gupta', 'sunita.gupta@gmail.com', '123456', 'patient'),
    ('Anupama Singh', 'anupama.singh@gmail.com', '123456', 'doctor'),
    ('Rohan Mehra', 'rohan.mehta@gmail.com', '123456', 'doctor'),
    ('Yash Kokane', 'yash.kokane@gmail.com', '123456', 'admin');

-- table extension
DROP TABLE IF EXISTS Pharma_Vendors;
-- CREATE TABLE Pharma_Vendors LIKE vendor;
CREATE TABLE pharma_vendors as
            (SELECT * 
             FROM vendor
             WHERE vendor.vendor_type = 'Pharmaceuticals');

      
CREATE TABLE equipment_vendors as
            (SELECT * 
             FROM vendor
             WHERE (vendor.vendor_type = 'Equipment') or (vendor.vendor_type ='Supplies'));


CREATE TABLE male_patients as
            (SELECT * 
             FROM patient
             WHERE patient.gender = 'M');


CREATE TABLE female_patients as
            (SELECT * 
             FROM patient
             WHERE patient.gender = 'F');


CREATE TABLE doctors as
            (SELECT * 
             FROM employee
             WHERE employee.occupation = 'Doctor');
             
CREATE TABLE nurses as
            (SELECT * 
             FROM employee
             WHERE employee.occupation = 'Nurse');

CREATE TABLE storing_images (
idpic INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
caption VARCHAR(45) NOT NULL,
img LONGBLOB default null,
PRIMARY KEY(idpic)
);

INSERT INTO storing_images(caption, img) VALUE('aspirin','https://e7.pngegg.com/pngimages/116/9/png-clipart-bayer-aspirin-box-box-of-aspirin-and-tablets-miscellaneous-aspirin-thumbnail.png');
INSERT INTO storing_images(caption, img) VALUE('antibiotics','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqTzNOL5Hs6_uj0_G71cb4-A371XLY9yI4iQ&usqp=CAU');
INSERT INTO storing_images(caption, img) VALUE('painkiller','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6mzHqr7NfJfvM5OAv_aq7_r3Is7mX58B4Q7d4d2U&s');
INSERT INTO storing_images(caption, img) VALUE('antidepressants','https://novarecoverycenter.com/wp-content/uploads/2019/09/antidepressants-addiction.jpg');
INSERT INTO storing_images(caption, img) VALUE('bandages','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3QIoWC0P20JsD8oPq6GSbmP__kgUJVg_lhA&usqp=CAU');
INSERT INTO storing_images(caption, img) VALUE('ultrasound Machine','https://m9m2s9g3.rocketcdn.me/wp-content/uploads/2019/11/DC-90_portrait_full_3qtrL_001c_CDI_kidney_web_650x434-200x300.jpg');
INSERT INTO storing_images(caption, img) VALUE('X-ray machine','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSr4FNwlXj8hH0LHORhr0PVUljTbmzP4t00aQ&usqp=CAU');
INSERT INTO storing_images(caption, img) VALUE('medical robot','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ5JRUDl4lJbfF4M0ErbOaBWls9xng86yhDw&usqp=CAU');
INSERT INTO storing_images(caption, img) VALUE('thermometer','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-IymEOOGPBzb2td86MiAjyUTa9O26yKtvBA&usqp=CAU');
INSERT INTO storing_images(caption, img) VALUE('morphine','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTIXaoe_wE941EyIZGfjFi2qUXqxIrphYMzw&usqp=CAU
');

-- COMMIT
COMMIT;


-- selecting images
SELECT * FROM storing_images;

-- creating view1
drop view if exists view1;
create view view1 as
select first_name as 'First_Name',
last_name as 'Last_Name',
date as "Prescription_date",
mp.item_name as "Prescribed_medicine", 
m.form as "Medicine_type", 
m.recommended_dosage, 
e.name as 'Prescribed_by', 
e.occupation as 'Role', 
e.contact_number as "Staff_Contact_Number"
from (((Prescription pr join Patient p using(patient_code)) 
join Employee e using(staff_id)) 
join Medical_products mp using(medical_id))
join Medicine m using(medical_id);

-- make order details, include data about: Order id, order date, ordered items, vendor_name, vendor address, contact as vendor contact e.name (ordered by), staff role (Staff role), net_amount as Order Amount, pending_amount as amount pending
-- drop view if exists view2;
-- create view view2 as 
-- select order_id as "Order ID", order_date as "Order Date", mp.item_name as "Ordered Item", vendor_name as "Vendor", vc.contact as "Vendor Contact Number", e.name as "Ordered by", e.occupation as "Role", e.contact_number as "Staff Contact Number", net_total as "Order Amount", pending_amount as "Payment Pending"
-- from (((purchase_order join vendor v using (vendor_id) join employee e using (staff_id)) join medical_products mp using (medical_id)) join vendor_contacts vc using (vendor_id)); 
-- SET foreign_key_checks = 0;


-- creating view2
drop view if exists view2;
create view view2 as 
select order_id as "Order_ID", 
order_date as "Order_Date", 
vendor_name as "Vendor", 
net_total as "Order_Amount", 
pending_amount as "Payment_Pending"
from purchase_order join vendor v using(vendor_id);

-- Create a user named "user1" with the password "password1".
DROP USER user1;
CREATE USER user1 IDENTIFIED BY 'password1';

-- Grant "user1" SELECT, UPDATE, and DELETE permissions on "table1"
GRANT SELECT, UPDATE, DELETE ON medical_inventory TO user1;

-- Select operation on table1
SELECT * FROM medical_inventory; 

-- Update operation on table1
UPDATE medical_inventory SET stocks = 200 WHERE medical_id = 10001; 

-- Delete operation on table1
DELETE FROM medical_inventory WHERE stocks = 100;
use dms  ;

GRANT SELECT ON view1 TO user1;
SELECT * FROM view1; 

-- Update operation on table1
UPDATE view1 SET Medicine_type = 'Tablet' WHERE First_Name = 'Rachel' ; 

-- Delete operation on table1
-- DELETE FROM view1 WHERE First_Name = 'Olivia';
-- Delete FROM view2 WHERE Order_Amount = 4950;

-- DELETE FROM view1;
-- DELETE FROM view2 WHERE order_id = 1;


SELECT * FROM medical_inventory; 

-- Update operation on table1
UPDATE medical_inventory SET stocks = 400 WHERE medical_id = 10001; 

-- Delete operation on table1
DELETE FROM medical_inventory WHERE stocks = 100;


-- Select operation on table1
SELECT * FROM medical_inventory; 

-- Revoke the UPDATE and DELETE permissions on "table1" for "user1"
REVOKE UPDATE, DELETE ON medical_inventory FROM user1;

select * from medical_inventory;

UPDATE medical_inventory SET stocks = 200 WHERE medical_id = 10004; 

DELETE FROM medical_inventory WHERE stocks = 100;

