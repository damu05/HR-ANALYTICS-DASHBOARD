CREATE DATABASE hr_analytics;
USE hr_analytics;
CREATE TABLE Employee (
    EmployeeID VARCHAR(20) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(20),
    Age INT,
    BusinessTravel VARCHAR(50),
    Department VARCHAR(100),
    DistanceFromHome_KM INT,
    State VARCHAR(50),
    Ethnicity VARCHAR(100),
    Education VARCHAR(50),
    EducationField VARCHAR(100),
    JobRole VARCHAR(100),
    MaritalStatus VARCHAR(50),
    Salary INT,
    StockOptionLevel INT,
    OverTime VARCHAR(10),
    HireDate DATE,
    Attrition VARCHAR(10),
    YearsAtCompany INT,
    YearsInMostRecentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);
select* from employee;
SELECT COUNT(*) FROM employee;

CREATE TABLE PerformanceRating (
    PerformanceID VARCHAR(20) PRIMARY KEY,
    EmployeeID VARCHAR(20),
    ReviewDate DATE,
    EnvironmentSatisfaction INT,
    JobSatisfaction INT,
    RelationshipSatisfaction INT,
    TrainingOpportunitiesWithinYear INT,
    TrainingOpportunitiesTaken INT,
    WorkLifeBalance INT,
    SelfRating INT,
    ManagerRating INT
  );
CREATE TABLE SatisfiedLevel (
    SatisfactionID INT PRIMARY KEY,
    SatisfactionLevel VARCHAR(50)
);
select* from satisfiedlevel;

CREATE TABLE RatingLevel (
    RatingID INT PRIMARY KEY,
    RatingLevel VARCHAR(50)
);
CREATE TABLE EducationLevel (
    EducationLevelID INT PRIMARY KEY,
    EducationLevel VARCHAR(100)
);
SELECT COUNT(*) FROM performancerating;
 
 #Create a Clean Final Table Using JOINs
 CREATE VIEW CleanedEmployeeData AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Gender,
    e.Age,
    el.EducationLevel,
    e.EducationField,
    e.Department,
    e.JobRole,
    e.Salary,
    e.state,
    e.HireDate,
    e.OverTime,
    e.MaritalStatus,
    e.YearsAtCompany,
    e.Attrition,
    e.YearsInMostRecentRole,
    e.YearsSinceLastPromotion,
    e.YearsWithCurrManager,
    pr.ReviewDate,
    pr.EnvironmentSatisfaction,
    sl.SatisfactionLevel AS JobSatisfactionLabel,
    pr.JobSatisfaction,
    pr.RelationshipSatisfaction,
    pr.TrainingOpportunitiesWithinYear,
    pr.TrainingOpportunitiesTaken,
    pr.WorkLifeBalance,
    pr.SelfRating,
    pr.ManagerRating,
    rl.RatingLevel AS OverallPerformanceLabel
FROM Employee e
LEFT JOIN PerformanceRating pr ON e.EmployeeID = pr.EmployeeID
LEFT JOIN SatisfiedLevel sl ON pr.JobSatisfaction = sl.SatisfactionID
LEFT JOIN RatingLevel rl ON pr.ManagerRating = rl.RatingID
LEFT JOIN EducationLevel el ON e.Education = el.EducationLevelID;

-- Count missing ratings or satisfaction
SELECT COUNT(*) FROM CleanedEmployeeData WHERE OverallPerformanceLabel IS NULL;

-- Check age ranges
SELECT MIN(Age), MAX(Age) FROM CleanedEmployeeData;

-- Find employees without performance reviews
SELECT * FROM CleanedEmployeeData WHERE ReviewDate IS NUll;


SELECT * FROM CleanedEmployeeData LIMIT 5;
DROP VIEW IF EXISTS CleanedEmployeeData;
describe  cleanedemployeedata;
use hr_analytics;
describe performancerating;