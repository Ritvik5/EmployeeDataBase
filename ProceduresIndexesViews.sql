--Creating Employee Payroll DATABASE--

CREATE DATABASE Employee_Payroll;

USE Employee_Payroll;

--Employee Table--

CREATE TABLE Employee(
	EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
	FirstName VARCHAR(20),
	LastName VARCHAR(20),
	DateOfBirth DATE,
	Gender CHAR(1),
	Address VARCHAR(50),
	ContactNumber VARCHAR(20),
	Email VARCHAR(30),
	HireDate DATE,
	DesignationID INT
	);

--Department Table--

CREATE TABLE Department(
	DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
	DepartmentName VARCHAR(30),
	EmployeeID INT FOREIGN KEY REFERENCES  Employee(EmployeeID)
	);

--Designation Table--

CREATE TABLE Designation(
	DesignationID INT IDENTITY(1,1) PRIMARY KEY,
	DesignationName VARCHAR(20)
	);

--Adding FOREIGN Key Constraint in Employee Table--

ALTER TABLE Employee
ADD FOREIGN KEY(DesignationID)
REFERENCES Designation(DesignationID);

--Salary Table--

CREATE TABLE Salary(
	SalaryID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT FOREIGN KEY REFERENCES  Employee(EmployeeID),
	PayrollPeriodID INT,
	BasicSalary MONEY,
	Allowances MONEY,
	Deductions MONEY,
	NetSalary AS (BasicSalary + Allowances - Deductions ) PERSISTED
	);

--PayrollPeriod Table--

CREATE TABLE PayrollPeriod(
	PayrollPeriodID INT IDENTITY(1,1) PRIMARY KEY,
	StartDate DATE,
	EndDate DATE
	);

--Adding FOREIGN KEY Constraint--

ALTER TABLE Salary
ADD FOREIGN KEY(PayrollPeriodID)
REFERENCES PayrollPeriod(PayrollPeriodID);

--Attendance Table--

CREATE TABLE Attendance(
	AttendanceID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT FOREIGN KEY REFERENCES  Employee(EmployeeID),
	AttendanceDate DATE,
	ClockIn TIME,
	ClockOut TIME
	);

--Leave Table--

CREATE TABLE Leave(
	LeaveID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT FOREIGN KEY REFERENCES  Employee(EmployeeID),
	LeaveType VARCHAR(20),
	StartDate DATE,
	EndDate DATE
	);

--Training Table--

CREATE TABLE Training(
	TrainingID INT IDENTITY(1,1) PRIMARY KEY,
	TrainingName VARCHAR(20),
	Description VARCHAR(20),
	Trainer VARCHAR(20),
	StartDate DATE,
	EndDate DATE,
	EmployeeID INT FOREIGN KEY REFERENCES  Employee(EmployeeID)
	);

--Inserting values in Tables--

INSERT INTO Designation(DesignationName) 
VALUES ('Junior Developer'),
	   ('Senior Developer 1'),
	   ('Senior Developer 2');

SELECT * FROM Designation;

INSERT INTO Employee(FirstName,LastName,DateOfBirth,Gender,Address,ContactNumber,Email,HireDate,DesignationID)
VALUES('Ross','Geller','1980-05-02','M','1st Street','9898989898','ross@gmail.com','2020-04-01',1);

SELECT * FROM Employee;

INSERT INTO Employee(FirstName,LastName,DateOfBirth,Gender,Address,ContactNumber,Email,HireDate,DesignationID)
VALUES('Joey','Tribbiani','1985-09-10','M','2nd Street','9696969696','joey@gmail.com','2021-05-01',1),
	  ('Rachel','Green','1982-08-16','F','3rd Street','9797979797','green@gmail.com','2022-09-05',3),
	  ('Monica','Geller','1980-02-11','F','1st Street','9595959595','monika@gmail.com','2023-07-17',2),
	  ('Chandler','Bing','1978-11-10','M','4rth Street','9494949494','bing@gmail.com','2019-08-01',3),
	  ('Phoebe','Buffay','1986-06-16','F','Main Street','9393939393','phoebe@gmail.com','2023-02-01',2),
	  ('Ben','Geller','1995-09-05','M','1st Street','9292929292','ben@gmail.com','2022-05-01',1),
	  ('Amy','Green','1987-09-07','F','3rd Street','9191919191','amy@gmail.com','2018-05-01',1),
	  ('Richard','Bruke','1980-09-10','M','Sixth Street','9090909090','richard@gmail.com','2015-05-01',2),
	  ('Jack','Geller','1975-09-10','M','1st Street','8989898989','jack@gmail.com','2012-05-01',3);


INSERT INTO Department(DepartmentName,EmployeeID)
VALUES('Quality Managemnet',2),
	  ('Quality Managemnet',4),
	  ('Quality Managemnet',6),
	  ('Quality Managemnet',10),
	  ('Finance',3),
	  ('Finance',11),
	  ('Test Team',5),
	  ('Test Team',7),
	  ('Product Development',8),
	  ('Product Development',9);

SELECT * FROM Department;

INSERT INTO PayrollPeriod(StartDate,EndDate)
VALUES('2023-07-01', '2023-07-15'),
	  ('2023-07-16', '2023-07-31'),
	  ('2023-08-01', '2023-08-15');

SELECT * FROM PayrollPeriod;

INSERT INTO Salary(EmployeeID,PayrollPeriodID,BasicSalary,Allowances,Deductions)
VALUES(2,1,15000,3000,1500),
	  (3,2,18000,2000,1500),
	  (4,1,45000,5000,3500),
	  (5,3,30000,4000,2500),
	  (6,2,50000,4000,4500),
	  (7,1,32000,3500,2000),
	  (8,3,19000,2200,1500),
	  (9,2,17000,3200,1000),
	  (10,2,27000,6300,3600),
	  (11,2,56000,6500,1900);

SELECT * FROM Salary;

INSERT INTO Attendance(EmployeeID,AttendanceDate,ClockIn,ClockOut)
VALUES(2,'2023-07-24','09:50:00','18:15:00'),
	  (3,'2023-07-24','09:55:00','18:11:00'),
	  (4,'2023-07-24','09:52:00','18:00:00'),
	  (5,'2023-07-24','09:59:00','18:30:00'),
	  (6,'2023-07-24','10:05:00','18:50:00'),
	  (7,'2023-07-24','10:00:00','19:15:00'),
	  (8,'2023-07-24','10:50:00','18:30:00'),
	  (9,'2023-07-24','09:50:00','18:55:00'),
	  (10,'2023-07-24','10:30:00','20:00:00'),
	  (11,'2023-07-24','11:50:00','21:15:00');

SELECT * FROM Attendance;

INSERT INTO Leave(EmployeeID,LeaveType,StartDate,EndDate)
VALUES(2,'Sick','2023-07-13','2023-07-14'),
	  (5,'Vacation','2023-07-03','2023-07-07'),
	  (6,'Family Emergency','2023-07-10','2023-07-24'),
	  (8,'Accident','2023-07-05','2023-07-20');

SELECT * FROM Leave;

INSERT INTO Training(TrainingName,Description,Trainer,StartDate,EndDate,EmployeeID)
VALUES('AWS','Learning AWS Server','Amandeep','2023-05-01','2023-06-01',2),
	  ('MongoDB','Learning MongoDB','Arun','2023-05-01','2023-06-01',3),
	  ('DB Programing','Advance Sql learning','Amit','2023-07-26','2023-08-01',4),
	  ('React','Learning React','Ankit','2023-05-01','2023-06-01',5),
	  ('API','Creating APIs','Aayush','2023-05-01','2023-06-01',6),
	  ('Angular','Learning Angular','Aniket','2023-05-01','2023-06-01',7),
	  ('NOSQL','Learning NOSQL','Abhishek','2023-05-01','2023-06-01',8),
	  ('Docker','Learning Docker','Abhimanyu','2023-05-01','2023-06-01',9),
	  ('Python','Learning Python','Ankita','2023-05-01','2023-06-01',10),
	  ('Go Lan','Learning Go Language','Anchal','2023-05-01','2023-06-01',11);

SELECT * FROM Training;

--Basic Queries--

--Query to display last 5 Records from table--

SELECT TOP 5 * FROM Employee ORDER BY EmployeeID DESC;

--Query to fetch last record from the table--

SELECT TOP 1 * FROM Employee ORDER BY EmployeeID DESC;

--Query to fetch monthly Salary of Employee if annual salary is given

SELECT MAX(BasicSalary) As MaximumEmployeeSalary FROM Salary;

SELECT * 
FROM Salary
WHERE EmployeeID IN 
(SELECT EmployeeID FROM Employee
 WHERE Gender = 'F');

SELECT SUM(Deductions) AS TotalDeductions
FROM Salary
WHERE EmployeeID IN 
(SELECT EmployeeID FROM Employee
 WHERE Gender = 'F');

--Display Even rows in Employee table--

SELECT *
FROM Employee
WHERE EmployeeID % 2 <> 0;

SELECT *
FROM Employee
WHERE EmployeeID % 2 = 0;

--Display last 50% records from Employee table--

SELECT TOP 50 PERCENT * 
FROM Employee
ORDER BY EmployeeID DESC;

--add the email validation using only one query--

SELECT *
FROM Employee
WHERE Email LIKE '^[A-Za-z]{3}([+.-])?([0-9]{3})?[@][A-Za-z0-9]+[.][a-z]{3}([.][a-z]{2,})?$';


SELECT TOP 1 FirstName, LEN(FirstName)
FROM Employee
ORDER BY LEN(FirstName) ASC , FirstName ASC;

SELECT * FROM SALARY;

SELECT EmployeeID , BasicSalary AS AnnualSalary ,BasicSalary/12 AS MonthlySalary
FROM Salary;

--JOINS--

--INNER JOIN--

--Using inner join joining Employee,Department and Designation Table--

SELECT Employee.EmployeeID,Employee.FirstName,Employee.LastName,Employee.Address,Employee.ContactNumber,Department.DepartmentName,Designation.DesignationName
FROM Employee
INNER JOIN Department
ON Employee.EmployeeID = Department.EmployeeID
INNER JOIN Designation
ON Employee.DesignationID = Designation.DesignationID;

--Using inner join joining Employee,Department,Designation,Leave,Salary,Attendance and Training Table--

SELECT Employee.EmployeeID,Employee.FirstName,Employee.LastName,Department.DepartmentName,Designation.DesignationName,Leave.LeaveType,Salary.BasicSalary,Attendance.AttendanceDate,Training.TrainingName,Training.Description
FROM Employee
INNER JOIN Department
ON Employee.EmployeeID = Department.EmployeeID
INNER JOIN Designation
ON Employee.DesignationID = Designation.DesignationID
INNER JOIN Leave
ON Employee.EmployeeID = Leave.EmployeeID
INNER JOIN Salary
ON Employee.EmployeeID = Salary.EmployeeID
INNER JOIN Attendance
ON Employee.EmployeeID = Attendance.EmployeeID
INNER JOIN Training
ON Employee.EmployeeID = Training.EmployeeID;

--LEFT JOIN--

SELECT Employee.EmployeeID,Employee.FirstName,Employee.LastName,Employee.DateOfBirth,Employee.Gender,Employee.ContactNumber,Employee.Email,Salary.BasicSalary,Salary.NetSalary
FROM Employee
LEFT JOIN Salary
ON Employee.EmployeeID = Salary.EmployeeID;

--RIGHT JOIN--

SELECT * 
FROM Salary
RIGHT JOIN Employee
ON Salary.EmployeeID = Employee.EmployeeID;

--FULL OUTER JOIN--

SELECT * 
FROM Employee
FULL OUTER JOIN Salary
ON Employee.EmployeeID = Salary.EmployeeID;

--SELF JOIN--

SELECT *
FROM Employee E1,Employee E2
WHERE E1.Gender = E2.Gender;

--Exception Handling Using Try Catch Block--


BEGIN TRY
	INSERT INTO Employee(EmployeeID) VALUES(2);
END TRY
BEGIN CATCH
  SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_STATE() AS ErrorState,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;
END CATCH;


---Stored Procedure for TotalSalary---


CREATE PROCEDURE SP_TotalSalary(
	@EmployeeID INT,
	@PayrollPeriodID INT,
	@TotalSalary INT OUTPUT
) AS
BEGIN
	SELECT 1 FROM Employee
	WHERE EmployeeID = @EmployeeID
	SELECT 1 FROM PayrollPeriod
	WHERE PayrollPeriodID = @PayrollPeriodID
	SELECT @TotalSalary = NetSalary
	FROM Salary
	WHERE EmployeeID = @EmployeeID AND PayrollPeriodID = @PayrollPeriodID;
END;

ALTER PROCEDURE SP_TotalSalary(
	@EmpID INT,
	@PayrollID INT,
	@TotalSalary MONEY OUTPUT
) AS
BEGIN
	BEGIN TRY
	SELECT @TotalSalary = SUM(BasicSalary + Allowances - Deductions)
	FROM Salary
	WHERE EmployeeID = @EmpID AND PayrollPeriodID = @PayrollID;
	END TRY
	BEGIN CATCH
	SELECT  
            ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage; 
	END CATCH
END;


DECLARE @TotalSalary1 AS MONEY; --Declaring Variable

EXEC SP_TotalSalary
	@EmpID = 10,
	@PayrollID = 2,
	@TotalSalary = @TotalSalary1 OUTPUT;

SELECT @TotalSalary1 AS 'Total Salary For Given EmployeeID and PayrollPeriodID';


---Validation Stored Procedure---


CREATE OR ALTER PROCEDURE SP_ValidateFirstName(
	@EmployID INT,
	@ErrorMessage NVARCHAR(50) OUTPUT
)AS
BEGIN
	BEGIN TRY
		SELECT *
		FROM Employee
		WHERE EmployeeID = @EmployID AND FirstName NOT LIKE '%[^a-zA-Z]%';
	END TRY
	BEGIN CATCH
		SET @ErrorMessage = 'First Name is Not valid';
		RETURN;
	END CATCH
END;

DECLARE @Error AS NVARCHAR(50)

EXECUTE SP_ValidateFirstName
		@EmployID = 2,
		@ErrorMessage = @Error OUTPUT;

SELECT @Error AS 'Failed Validation';


---Employee Data is Present or not---

CREATE OR ALTER PROCEDURE SP_CheckEmployeeData(
	@Employee_ID INT,
	@First_Name VARCHAR(20),
	@Last_Name VARCHAR(20),
	@Date_OF_Birth DATE,
	@Gender1 CHAR(1),
	@Address1 VARCHAR(50),
	@Contact_Number VARCHAR(20),
	@Email1 VARCHAR(30),
	@Hire_Date DATE,
	@Designation_ID INT
)AS
BEGIN
	IF EXISTS(SELECT 1 FROM Employee WHERE EmployeeID = @Employee_ID)
	BEGIN
		UPDATE Employee
		SET FirstName = @First_Name,
			LastName = @Last_Name,
			DateOfBirth = @Date_OF_Birth,
			Gender = @Gender1,
			Address = @Address1,
			ContactNumber = @Contact_Number,
			Email = @Email1,
			HireDate = @Hire_Date,
			DesignationID = @Designation_ID
		WHERE EmployeeID = @Employee_ID
		PRINT 'Data has been Updated';
	END
	ELSE
	BEGIN
		INSERT INTO Employee(EmployeeID,FirstName,LastName,DateOfBirth,Gender,Address,ContactNumber,Email,HireDate,DesignationID)
		VALUES(@Employee_ID,@First_Name,@Last_Name,@Date_OF_Birth,@Gender1,@Address1,@Contact_Number,@Email1,@Hire_Date,@Designation_ID);
		PRINT 'Data has been inserted';
	END
END;


EXECUTE SP_CheckEmployeeData
		@Employee_ID = 10,
		@First_Name = 'Snow',
		@Last_Name = 'John1',
		@Date_OF_Birth = '2001-09-06',
		@Gender1 = 'M',
		@Address1 = 'Church Street',
		@Contact_Number = '9090909090',
		@Email1 = 'snow@gmail.com',
		@Hire_Date = '2022-07-29',
		@Designation_ID = 1;


SELECT * FROM Employee;
SELECT * FROM Salary;

SELECT @@ROWCOUNT FROM Employee;

--INDEXES--

--Query using the IX_Employee_EmployeeID index to retrieve an employee by their ID--


CREATE NONCLUSTERED INDEX Ix_Employee_Name
ON Employee(FirstName,LastName);

SELECT EmployeeID,FirstName,LastName
FROM Employee
WHERE EmployeeID > 3;

EXECUTE  SP_HELPINDEX Employee;

DROP INDEX Employee.Ix_Employee_Name;

CREATE INDEX IX_Employee_EmployeeID
on Employee(EmployeeID);

SELECT *
FROM Employee
Where EmployeeID = 10;


--Query using an index on the StartDate column to improve performance in searching for leaves within a specific date range--

SELECT * 
FROM Leave;

CREATE NONCLUSTERED INDEX IX_Leave_LeaveBetweenDates
ON Leave(LeaveType,StartDate,EndDate);

EXECUTE SP_HELPINDEX Leave;

DROP INDEX Leave.IX_Leave_StartDate;

SELECT *
FROM Leave
WHERE StartDate BETWEEN '2023-07-01' AND '2023-07-08'
   OR EndDate BETWEEN '2023-07-10' AND '2023-07-20';


--Query using an index on the DepartmentID column to optimize filtering employees by their department

SELECT * FROM Department;

CREATE NONCLUSTERED INDEX IX_Department_DepartmentName
ON Department(DepartmentName ASC);

EXECUTE SP_HELPINDEX Department;

DROP INDEX Department.IX_Department_DepartmentName;

CREATE INDEX IX_Department_DepartmentId
ON Department(DepartmentID);

SELECT Department.EmployeeID,Employee.FirstName,Employee.LastName
FROM Department
INNER JOIN Employee
ON Department.EmployeeID = Employee.EmployeeID
WHERE Department.DepartmentName = 'Quality Managemnet';

--Query using an index on the NetSalary column to speed up searching for employees with specific salary ranges--

SELECT * FROM Salary;

CREATE INDEX IX_Salary_NetSalary
ON Salary(NetSalary);

EXECUTE sp_helpindex Salary;

DROP INDEX Salary.IX_Salary_NetSalary;

CREATE INDEX IX_Salary_NetSalary
ON Salary(NetSalary ASC);

SELECT Salary.NetSalary,Employee.FirstName,Employee.LastName
FROM Salary
JOIN Employee
ON Salary.EmployeeID = Employee.EmployeeID
WHERE NetSalary >= 40000 AND NetSalary <= 61000;

--Query using an index on the DesignationName column to quickly search for employees with a specific job designation--

SELECT * FROM Designation;

CREATE INDEX IX_Designation_DesignationName
ON Designation(DesignationName);

EXECUTE SP_HELPINDEX Designation;

SELECT Employee.FirstName,Employee.LastName,Designation.DesignationName
FROM Designation
JOIN Employee
ON Designation.DesignationID = Employee.DesignationID
ORDER BY DesignationName ASC ;

--VIEWS--

--Query using the EmployeeDetails view to get employee details along with department and manager information--

CREATE VIEW vWEmployeeDetailByDepartment
AS
SELECT Employee.FirstName,Employee.LastName,Department.DepartmentID,Department.DepartmentName
FROM Employee
JOIN Department
ON Employee.EmployeeID = Department.EmployeeID;

SELECT *
FROM vWEmployeeDetailByDepartment;

--Query using a view to get employees who have taken leaves within a specific date range--

SELECT *
FROM Leave;

CREATE VIEW vWEmployeeDetailByLeave
AS
SELECT Employee.FirstName,Employee.LastName,Employee.EmployeeID,Leave.LeaveType,Leave.StartDate,Leave.EndDate
FROM Employee
JOIN Leave
ON Employee.EmployeeID = Leave.EmployeeID
WHERE Leave.StartDate BETWEEN '2023-07-01' AND '2023-07-08'
   OR Leave.EndDate BETWEEN '2023-07-10' AND '2023-07-20';

SELECT * FROM vWEmployeeDetailByLeave;

--Query using a view to get employees who are managers along with their department names--
--Query using a view to get employees with their respective department and designation names--

CREATE VIEW vWEmployeeDetailByDepartmentAndDesignation
AS
SELECT Employee.EmployeeID,Employee.FirstName,Employee.LastName,Department.DepartmentName,Designation.DesignationName
FROM Employee
JOIN Department
ON Employee.EmployeeID = Department.EmployeeID
JOIN Designation
ON Employee.DesignationID = Designation.DesignationID;

SELECT * FROM vWEmployeeDetailByDepartmentAndDesignation;


--FUNCTIONS--

--Query using the CalculateAge function to retrieve the age of employees--

CREATE FUNCTION CalculateEmployeeAge(@DOB DATE)
RETURNS INT
AS
BEGIN
	DECLARE @Age INT

	SET @Age = DATEDIFF(YEAR , @DOB, GETDATE())
	RETURN @Age

END;

SELECT FirstName,LastName, dbo.CalculateEmployeeAge(DateOfBirth) AS Age
FROM Employee;

SELECT * FROM Employee;

--Query using a custom function to calculate the total salary for an employee--

CREATE FUNCTION CalculateTotalSalary(@EMPLOYEEID INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @TOTAL_SALARY MONEY
	SELECT @TOTAL_SALARY = SUM(BasicSalary + Allowances - Deductions)
	FROM Salary
	WHERE Salary.EmployeeID = @EMPLOYEEID
	RETURN @TOTAL_SALARY
END;

DROP FUNCTION CalculateTotalSalary;

SELECT * FROM Salary;

SELECT Employee.FirstName,Employee.LastName,Salary.BasicSalary,Salary.Allowances,Salary.Deductions,dbo.CalculateTotalSalary(Employee.EmployeeID) AS TotalSalary
FROM Salary
JOIN Employee
ON Salary.EmployeeID = Employee.EmployeeID;


--Query using a function to get the number of employees in a specific department--

SELECT * FROM Department;

CREATE FUNCTION EmployeeNumberInDepartment(@DEPARTMENTNAME VARCHAR(30))
RETURNS INT
AS
BEGIN
	DECLARE @Emp_Num_In_Department INT
	SELECT  @Emp_Num_In_Department = COUNT(EmployeeID)
	FROM Department
	WHERE DepartmentName = @DEPARTMENTNAME
	RETURN @Emp_Num_In_Department
END;

DROP FUNCTION EmployeeNumberInDepartment;

SELECT DISTINCT DepartmentName, dbo.EmployeeNumberInDepartment(Department.DepartmentName) AS EmployeeCount
FROM Department;

--Query using a function to get the number of leaves taken by an employee--

SELECT * FROM Leave;

CREATE FUNCTION EmployeeCountByLeaveTaken(@LEAVETYPE VARCHAR(20))
RETURNS INT
AS
BEGIN
	DECLARE @EMPCOUNT INT 
	SELECT @EMPCOUNT = COUNT(EmployeeID)
	FROM Leave
	WHERE Leave.LeaveType = @LEAVETYPE
	RETURN @EMPCOUNT
END;

SELECT DISTINCT LeaveType, dbo.EmployeeCountByLeaveTaken(Leave.LeaveType) AS EmpCount
FROM Leave;


--TRIGGERS--

--Trigger to automatically update the HireDate of an employee when their record is inserted--

SELECT * FROM Employee;

ALTER TRIGGER tr_Employee_ForInsert
ON Employee
FOR INSERT
AS
BEGIN
	UPDATE Employee
	SET HireDate = GETDATE()
	WHERE EmployeeID IN (SELECT EmployeeID FROM inserted)
END;

INSERT INTO Employee(FirstName,LastName,DateOfBirth,Gender,Address,ContactNumber,Email,HireDate,DesignationID)
VALUES('Jimmy','James','1989-07-09','M','2nd Cross','8818181818','Jimmy@gmail.com','2018-12-06',2);


--Trigger to delete salary records of an employee when they are deleted from the Employee table--

SELECT * FROM Salary;
SELECT * FROM Employee;
SELECT * FROM PayrollPeriod;

INSERT INTO Salary(EmployeeID,PayrollPeriodID,BasicSalary,Allowances,Deductions)
VALUES(12,2,65000,3000,1500);

DELETE FROM Salary
WHERE EmployeeID = 12

CREATE TRIGGER tr_Salary_ForDelete
ON Employee
FOR DELETE
AS
BEGIN
	 DELETE FROM Salary
	 WHERE EmployeeID IN (SELECT EmployeeID FROM deleted)
END;

DELETE FROM Employee
WHERE EmployeeID = 12;

ALTER TABLE Salary
DROP CONSTRAINT FK__Salary__Employee__3E52440B;

ALTER TABLE Salary
ADD FOREIGN KEY(EmployeeID)
REFERENCES Employee(EmployeeID)
ON DELETE CASCADE;

--Trigger to enforce a constraint where the EndDate of a leave must be greater than or equal to the StartDate--

SELECT * FROM Leave;

CREATE TRIGGER tr_LeaveDateConstraint_InsteadOfInsert
ON Leave
INSTEAD OF INSERT
AS
BEGIN
	IF EXISTS ( SELECT 1 
			   FROM inserted
			   WHERE StartDate >= EndDate
			 )
	BEGIN
		RAISERROR('EndDate must be greater or equal than StartDate',16,1)
		RETURN
	END;

	INSERT INTO Leave(EmployeeID,LeaveType,StartDate,EndDate)
	SELECT EmployeeID,LeaveType,StartDate,EndDate
	FROM inserted
END;

INSERT INTO Leave(EmployeeID,LeaveType,StartDate,EndDate)
VALUES(10,'Sick','2023-07-09','2023-07-14');


-- Queries for Cursors: --

-- Query using a cursor to fetch and display all employees' names --

DECLARE @FIRSTName VARCHAR(30);
DECLARE @LASTName VARCHAR(30);


DECLARE EmployeeNameCursor CURSOR FOR
SELECT FirstName,LastName
FROM Employee

OPEN EmployeeNameCursor

FETCH NEXT FROM EmployeeNameCursor INTO @FIRSTName, @LASTName

WHILE(@@FETCH_STATUS = 0)
BEGIN
	PRINT 'FirstName = ' + @FIRSTName +' And LastName = '+@LASTName
	FETCH NEXT FROM EmployeeNameCursor INTO @FIRSTName, @LASTName
END

CLOSE EmployeeNameCursor
DEALLOCATE EmployeeNameCursor;

--Query using a cursor to update the basic salary of all employees by a certain percentage--

SELECT * FROM Salary;

DECLARE @EMPID INT;
DECLARE @CurrentSalary MONEY;
DECLARE @IncreasePercentage DECIMAL(5,2) = 0.10;

DECLARE IncreasedSalaryCursor CURSOR FOR
SELECT EmployeeID,BasicSalary
FROM Salary

OPEN IncreasedSalaryCursor

FETCH NEXT FROM IncreasedSalaryCursor INTO @EMPID,@CurrentSalary

WHILE(@@FETCH_STATUS = 0)
BEGIN
	DECLARE @NewSalary MONEY = @CurrentSalary + (@CurrentSalary * @IncreasePercentage);

	UPDATE Salary
	SET BasicSalary = @NewSalary
	WHERE EmployeeID = @EMPID

	FETCH NEXT FROM IncreasedSalaryCursor INTO @EMPID,@CurrentSalary
END
CLOSE IncreasedSalaryCursor
DEALLOCATE IncreasedSalaryCursor

--Query using a cursor to update employee designations based on their years of service--

SELECT * FROM Employee;
SELECT * FROM Designation;

DECLARE @EmployeeId INT;
DECLARE @HIREDate DATE;
DECLARE @DESIGNATIONID INT;
DECLARE @YearsOfService INT;
DECLARE @DesignationNAME VARCHAR(30);


DECLARE EmployeeCursor CURSOR FOR
SELECT EmployeeID,HireDate,DesignationID
FROM Employee

OPEN EmployeeCursor

FETCH NEXT FROM EmployeeCursor INTO @EmployeeId,@HIREDate,@DESIGNATIONID

WHILE(@@FETCH_STATUS = 0)
BEGIN
	SET @YearsOfService = DATEDIFF(YEAR,@HIREDate,GETDATE());

	SELECT @DesignationNAME = DesignationName 
	FROM Designation
	WHERE DesignationID = @DESIGNATIONID

	IF @YearsOfService >= 4
		SET @DesignationNAME = 'Senior Developer 2'
	ELSE IF @YearsOfService >=3
		SET @DesignationNAME = 'Senior Developer 1'
	ELSE
		SET @DesignationNAME = 'Junior Developer'

	UPDATE Employee
	SET DesignationID = (SELECT DesignationID FROM Designation WHERE DesignationName = @DesignationNAME)
	WHERE EmployeeID = @EmployeeId;

	FETCH NEXT FROM EmployeeCursor INTO @EmployeeId,@HIREDate,@DESIGNATIONID;
END
CLOSE EmployeeCursor
DEALLOCATE EmployeeCursor

--Query using a cursor to calculate the total salary for each employee and display the results--

SELECT * FROM Salary;

DECLARE @EmployeeID1 INT;
DECLARE @BASICSalary MONEY;
DECLARE @ALLOWANCES MONEY;
DECLARE @DEDUCTIONS MONEY;
DECLARE @TotalSalary MONEY;

CREATE TABLE #EmployeeTotalSalary (
    EmployeeID INT PRIMARY KEY,
    TotalSalary MONEY
);

DECLARE TotalSalaryCursor CURSOR FOR
SELECT EmployeeID,BasicSalary,Allowances,Deductions
FROM Salary

OPEN TotalSalaryCursor 

FETCH NEXT FROM TotalSalaryCursor INTO @EmployeeID1,@BASICSalary,@ALLOWANCES,@DEDUCTIONS
WHILE(@@FETCH_STATUS = 0)
BEGIN
	SET @TotalSalary = SUM(@BASICSalary + @ALLOWANCES - @DEDUCTIONS)

	INSERT INTO #EmployeeTotalSalary(EmployeeID,TotalSalary)
	VALUES(@EmployeeID1,@TotalSalary)

	FETCH NEXT FROM TotalSalaryCursor INTO @EmployeeID1,@BASICSalary,@ALLOWANCES,@DEDUCTIONS
END

CLOSE TotalSalaryCursor
DEALLOCATE TotalSalaryCursor

SELECT *
FROM #EmployeeTotalSalary	

--Query using a cursor to delete all employees who have left the organization

SELECT * FROM PayrollPeriod;

SELECT * FROM Salary;

select * from Employee WHERE EmployeeID NOT IN (select distinct EmployeeID from Salary)

DECLARE @EmPliD INT

DECLARE LeftOrganizationCusror CURSOR FOR
SELECT EmployeeID
FROM Employee

OPEN LeftOrganizationCusror

FETCH NEXT FROM LeftOrganizationCusror INTO @EmPliD
WHILE(@@FETCH_STATUS = 0)
BEGIN
	DELETE FROM Employee
	WHERE EmployeeID = @EmPliD AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM Salary)

	FETCH NEXT FROM LeftOrganizationCusror INTO @EmPliD
END

CLOSE LeftOrganizationCusror
DEALLOCATE LeftOrganizationCusror


--Cursor to update the salary of employees based on their performance rating:--

CREATE TABLE EmployeePerformance(
	PerformanceID INT IDENTITY(1,1) PRIMARY KEY,
	PerformanceRating VARCHAR(20),
	EmployeeID INT FOREIGN KEY REFERENCES  Employee(EmployeeID)
	);

SELECT * FROM EmployeePerformance;

SELECT * FROM Salary;

INSERT INTO EmployeePerformance(PerformanceRating,EmployeeID) 
VALUES('Excellent',2),
	  ('Good',3),
	  ('Good',5),
	  ('Average',7),
	  ('Excellent',9),
	  ('Average',11);


DECLARE @EMPLOYEE1ID INT;
DECLARE @PERFORMANCERATING VARCHAR(20);
DECLARE @SALARY MONEY;
DECLARE @INCREASEFACTOR DECIMAL(5,4);


DECLARE UpdateSalaryCursor CURSOR FOR
SELECT EmployeePerformance.EmployeeID,EmployeePerformance.PerformanceRating,Salary.BasicSalary
FROM EmployeePerformance
JOIN Salary
ON EmployeePerformance.EmployeeID = Salary.EmployeeID

OPEN UpdateSalaryCursor

FETCH NEXT FROM UpdateSalaryCursor INTO @EMPLOYEE1ID,@PERFORMANCERATING,@SALARY;
WHILE(@@FETCH_STATUS = 0)
BEGIN
	SET @INCREASEFACTOR = 
		CASE
			WHEN @PERFORMANCERATING = 'Excellent' THEN 1.10
			WHEN @PERFORMANCERATING = 'Good' THEN 1.05
			WHEN @PERFORMANCERATING = 'Average' THEN 1.02
			ELSE 1.00
		END;

	UPDATE Salary
	SET BasicSalary = @SALARY * @INCREASEFACTOR
	WHERE EmployeeID = @EMPLOYEE1ID;
	
	FETCH NEXT FROM UpdateSalaryCursor INTO @EMPLOYEE1ID,@PERFORMANCERATING,@SALARY;
END
CLOSE UpdateSalaryCursor;
DEALLOCATE UpdateSalaryCursor;


--Cursor to assign a default department for employees who don't have one:

SELECT * FROM Employee;

DECLARE @DEPARTMENTID INT;
DECLARE @DefaultEmployeeID INT = 1;

DECLARE DefaultCursor CURSOR FOR
SELECT DepartmentID
FROM Department
WHERE EmployeeID IS NULL;

OPEN DefaultCursor
	FETCH NEXT FROM DefaultCursor INTO @DEPARTMENTID
WHILE(@@FETCH_STATUS = 0)
BEGIN
	UPDATE Department
	SET EmployeeID = @DefaultEmployeeID
	WHERE DepartmentID = @DEPARTMENTID;

	FETCH NEXT FROM DefaultCursor INTO @DEPARTMENTID
END
CLOSE DefaultCursor
DEALLOCATE DefaultCursor