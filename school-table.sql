CREATE DATABASE school;
USE school;
CREATE TABLE schools(
    School_ID INT AUTO_INCREMENT,
    Name VARCHAR(40),
    Address VARCHAR(40),
    PRIMARY KEY(School_ID)
);
CREATE TABLE teachers(
    Teacher_ID INT AUTO_INCREMENT,
    School_ID INT,
    Level ENUM("1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th"),
    Firstname VARCHAR(20),
    Lastname VARCHAR(40),
    Email VARCHAR(40),
    Subject ENUM("Math", "Biology", "Chemistry", "Physics", "Languages", "Arts", "Sports", "Politics"),
    PRIMARY KEY(Teacher_ID),
    FOREIGN KEY(School_ID) REFERENCES schools(School_ID)
);
CREATE TABLE students(
    Student_ID INT AUTO_INCREMENT,
    School_ID INT,
    Level ENUM("1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th"),
    Firstname VARCHAR(20),
    Lastname VARCHAR(40),
    Email VARCHAR(40),
    PRIMARY KEY(Student_ID),
    FOREIGN KEY(School_ID) REFERENCES schools(School_ID)
); 
CREATE TABLE grades(
    Student_ID INT,
    School_ID INT,
    Level ENUM("1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th"),
    Math DECIMAL(2,1),
    Biology DECIMAL(2,1),
    Chemistry DECIMAL(2,1),
    Physics DECIMAL(2,1),
    Languages DECIMAL(2,1),
    Arts DECIMAL(2,1),
    Sports DECIMAL(2,1),
    Politics DECIMAL(2,1),
    PRIMARY KEY(Student_ID, Level, School_ID),
    FOREIGN KEY(Student_ID) REFERENCES students(Student_ID),
    FOREIGN KEY(School_ID) REFERENCES schools(School_ID)
);