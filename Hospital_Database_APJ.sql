USE HospitalDatabase;
CREATE TABLE Patient
( PatientID       VARCHAR(10) PRIMARY KEY,  
  FirstName       VARCHAR(20) NOT NULL,
  LastName        VARCHAR(15) NOT NULL,
  DateOfBirth     DATE,
  Address      	  VARCHAR(100),
  PhoneNo         VARCHAR(8),
  PatientStatus   ENUM('Healthy', 'Sick')
);

CREATE TABLE Doctor
  ( DoctorID      	VARCHAR(10) PRIMARY KEY,
    FirstName       VARCHAR(20) NOT NULL,
    LastName        VARCHAR(15) NOT NULL,
    DateOfBirth   	DATE,
    Address      	VARCHAR(100),
    PhoneNo       	VARCHAR(8)
  );

CREATE TABLE Nurse
  ( NurseID     	VARCHAR(10) PRIMARY KEY,
    FirstName   	VARCHAR(20) NOT NULL,
	LastName   		VARCHAR(20) NOT NULL,
    DateOfBirth 	DATE,
    Address      	VARCHAR(100),
    PhoneNo     	VARCHAR(8)
  );
  
CREATE TABLE ReportsTo
( NurseID     VARCHAR(10),
  DoctorID    VARCHAR(10),
  PRIMARY KEY(DoctorID, NurseID),
  FOREIGN KEY (NurseID) REFERENCES Nurse(NurseID) ON DELETE CASCADE ,
  FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID) ON DELETE CASCADE
);

CREATE TABLE Treatment
( TreatmentID    		 VARCHAR(5),
  TreatmentDescription   VARCHAR(200),
  PRIMARY KEY(TreatmentID)
);


CREATE TABLE Consults
  ( ConsultationID    VARCHAR(5) PRIMARY KEY,
    DoctorID          VARCHAR(10),
    PatientID         VARCHAR(10),
    RoomNo            VARCHAR(5),
    StartTime         DATETIME,
    EndTime           DATETIME,
    Log               VARCHAR(500), 
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID) ON DELETE CASCADE
  );
  
  CREATE TABLE Prescribes
  ( PatientID    		VARCHAR(10),
    DoctorID   			VARCHAR(10),
    TreatmentID 		VARCHAR(5),
    StartTime       	DATETIME,
    PrescriptionStatus 	ENUM('Active','Expired'),
    PRIMARY KEY(DoctorID,PatientID,TreatmentID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID) ON DELETE CASCADE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) ON DELETE CASCADE
    ,
  FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID) ON DELETE CASCADE
);

CREATE TABLE Treats
(   NurseID       VARCHAR(10),
    TimeSlot      DATETIME,
    TreatmentID   VARCHAR(5),
    PatientID     VARCHAR(10),
    RoomNo        VARCHAR(5),
    PRIMARY KEY(NurseID, TimeSlot,TreatmentID),
    FOREIGN KEY (NurseID) REFERENCES Nurse(NurseID) ON DELETE CASCADE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) ON DELETE CASCADE,
    FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID) ON DELETE CASCADE
);
