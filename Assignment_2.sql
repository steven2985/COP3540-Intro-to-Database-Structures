CREATE DATABASE Assignment2;

USE Assignment2;

------------- Question 1 -----------------------
/*
The questions are based on the
following relational schema:
Emp( eid: integer, ename: string, age: integer, salary: real)
Works( eid: integer, did: integer, pet_time: integer)
Dept(did: integer, dname: string, budget: real, managerid: integer)
*/

--1.Give an example of a foreign key constraint that involves Dept relation.
ALTER TABLE Works
ADD CONSTRAINT FK_did FOREIGN KEY (did)
    REFERENCES Dept(did);

--2. Write the SQL statements required to create the preceding relations, including appropriate versions of
--   all primary and foreign key integrity constraints.
eid INTEGER NOT NULL,
ename VARCHAR(100) NOT NULL,
age INTEGER NOT NULL,
salary REAL NOT NULL,
PRIMARY KEY (eid));

CREATE TABLE Dept(
did INTEGER NOT NULL,
dname VARCHAR(100) NOT NULL,
budget REAL NOT NULL,
managerid INTEGER NOT NULL,
PRIMARY KEY (did));

CREATE TABLE Works(
eid INTEGER NOT NULL,
did INTEGER NOT NULL,
pet_time INTEGER NOT NULL,
FOREIGN KEY (eid) REFERENCES Emp(eid),
FOREIGN KEY (did) REFERENCES Dept(did));

--3. Define the Dept relation in SQL so that every department is guaranteed to have a manager.
CREATE TABLE Dept(
did INTEGER NOT NULL,
dname VARCHAR(100) NOT NULL,
budget REAL NOT NULL,
managerid INTEGER NOT NULL DEFAULT 1,
PRIMARY KEY (did));
/*"DEFAULT" keyword guarantees that if we left the "managerid" column blank in an insert query, this column
will be filled with a number 1*/

--4. Write an SQL statement to add John Doe as an employee with eid = 101, age = 32 and salary = 15,000.
Consider the following schema:
Suppliers( sid: integer, sname: string, address: string)
Parts(pid: integer, pname: string, color: string)
Catalog( sid: integer, pid: integer, cost: real)
The following relations keep track of airline flight information:
Flights (flno:integer, from:string, to:string, distance: integer, departs:time, arrives:time, price:real)
Aircraft (aid:integer, aname:string, cruisingrange:integer)
Certified (eid:integer, aid:integer)
Employees (eid:integer, ename:string, salary:integer)
*/

CREATE TABLE Flights(
flno INTEGER NOT NULL,
_from VARCHAR(100) NOT NULL,
_to VARCHAR(100) NOT NULL,
distance INTEGER NOT NULL,
departs TIME NOT NULL,
arrives TIME NOT NULL, 
price REAL NOT NULL,
PRIMARY KEY (flno));

CREATE TABLE Aircraft(
aid INTEGER NOT NULL,
aname VARCHAR(100) NOT NULL,
cruisingrange INTEGER NOT NULL,
PRIMARY KEY (aid));

CREATE TABLE Employees(
eid INTEGER NOT NULL,
ename VARCHAR(100) NOT NULL,
salary INTEGER NOT NULL,
PRIMARY KEY (eid));

CREATE TABLE Certified(
eid INTEGER NOT NULL,
aid INTEGER NOT NULL,
FOREIGN KEY (eid) REFERENCES Employees(eid),
FOREIGN KEY (aid) REFERENCES Aircraft(aid));

--1. For each pilot who is certified for more than three aircraft, find the eid and the maximum 
--    miles.