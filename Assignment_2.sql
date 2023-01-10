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
--   all primary and foreign key integrity constraints.CREATE TABLE Emp(
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

--4. Write an SQL statement to add John Doe as an employee with eid = 101, age = 32 and salary = 15,000.INSERT INTO Emp VALUES (101,'John Doe',32,15000);--5. Write an SQL statement to give every employee a 10 percent raise.UPDATE emp SET salary *= 1.1;--6. Write an SQL statement to delete the Toy department.DELETE FROM Dept WHERE dname = 'Toy';------------- Question 2 -----------------------/*
Consider the following schema:
Suppliers( sid: integer, sname: string, address: string)
Parts(pid: integer, pname: string, color: string)
Catalog( sid: integer, pid: integer, cost: real)*/CREATE TABLE Suppliers(_sid INTEGER NOT NULL,sname VARCHAR(100) NOT NULL,_address VARCHAR(100) NOT NULL,PRIMARY KEY (_sid));CREATE TABLE Parts(pid INTEGER NOT NULL,pname VARCHAR(100) NOT NULL,color VARCHAR(100) NOT NULL,PRIMARY KEY (pid));CREATE TABLE Catalog_ (_sid INTEGER NOT NULL,pid INTEGER NOT NULL,cost REAL NOT NULL,FOREIGN KEY (_sid) REFERENCES Suppliers(_sid),FOREIGN KEY (pid) REFERENCES Parts(pid));--1. Find the pnames of parts for which there is some supplier.SELECT DISTINCT pnameFROM Parts,Catalog_WHERE Parts.pid = Catalog_.pid;--2. Find the snames of suppliers who supply every part.SELECT DISTINCT snameFROM Suppliers,Catalog_ WHERE Suppliers._sid = Catalog_._sid;--3. Find the snames of Suppliers who supply every red part.SELECT DISTINCT snameFROM Suppliers S,Catalog_ C, Parts PWHERE S._sid = C._sid AND C.pid = P.pid AND P.color = 'red';--4. Find the pnames of Parts supplied by Acme Widget Suppliers AND no one else.SELECT pnameFROM Parts P, Catalog_ C, Suppliers SWHERE P.pid = C.pid AND C._sid = S._sid AND S.sname = 'Acme Widget Suppliers';--5. Find the sids of Suppliers who supplied only red parts.SELECT DISTINCT S._sidFROM Suppliers S,Catalog_ C, Parts PWHERE S._sid = C._sid AND C.pid = P.pid AND P.color = 'red'EXCEPTSELECT DISTINCT S._sidFROM Suppliers S,Catalog_ C, Parts PWHERE S._sid = C._sid AND C.pid = P.pid AND P.color != 'red';--6. Find the sids of suppliers who supply a red part AND a green partSELECT DISTINCT S._sidFROM Suppliers S,Catalog_ C, Parts PWHERE S._sid = C._sid AND C.pid = P.pid AND P.color = 'red'INTERSECTSELECT DISTINCT S._sidFROM Suppliers S,Catalog_ C, Parts PWHERE S._sid = C._sid AND C.pid = P.pid AND P.color = 'green';--7. Find the sids of suppliers who supply a red part OR a green partSELECT DISTINCT S._sidFROM Suppliers S,Catalog_ C, Parts PWHERE S._sid = C._sid AND C.pid = P.pid AND (P.color = 'red' OR P.color = 'green');----------------- Question 3 ----------------------------/*
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

--1. For each pilot who is certified for more than three aircraft, find the eid and the maximum --   cruisingrange of the aircraft for which she or he is certified.SELECT E.eid, MAX(cruisingrange) AS 'Max Cruising Range'FROM Employees E,Certified C, Aircraft AWHERE E.eid = C.eid AND C.aid = A.aid GROUP BY E.eidHAVING  COUNT (*) > 2;--2. Find the names of pilots whose salary is less than the price of the cheapest route from Los Angeles--   to Honolulu.SELECT DISTINCT enameFROM Employees WHERE salary < (SELECT MIN(price) FROM Flights WHERE _from = 'Los Angeles' AND _to = 'Honolulu');--3. Find the aids of all aircraft that can be used on roads from Los Angeles to Chicago.SELECT aidFROM AircraftWHERE cruisingrange > (SELECT MAX(distance) FROM Flights WHERE _from = 'Los Angeles' AND _to = 'Chicago');--4.  Print the names of employees who are certified only on aircrafts with cruising range longer than 1000
--    miles.SELECT DISTINCT E.enameFROM Employees E, Certified C, Aircraft AWHERE E.eid = C.eid AND C.aid = A.aid AND A.cruisingrange > 1000