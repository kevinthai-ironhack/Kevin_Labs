CREATE DATABASE IF NOT EXISTS lab_mysql;

CREATE TABLE IF NOT EXISTS Cars (
	ID int,
	VIN varchar(255),
	Manufacturer  varchar(255),
    Model varchar(255),
    Year int,
    Color varchar(255)
);

CREATE TABLE IF NOT EXISTS Customers (
	ID int,
    CustomerID int,
	Name varchar(255),
	Phone  varchar(255),
    Email varchar(255),
    Address varchar(255),
    City varchar(255),
    State varchar(255),
    Country varchar(255),
    Postal int
);

CREATE TABLE IF NOT EXISTS Salespersons (
	ID int,
	StaffID int,
	Name  varchar(255),
    Store varchar(255)
);
CREATE TABLE IF NOT EXISTS Invoices (
	ID int,
	Invoice int,
	Date  varchar(255),
    Car int,
    Customer int,
    Sales_person int
);

