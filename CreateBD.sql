create database if not exists taif_company;
use taif_company;

CREATE TABLE client (
	id INT PRIMARY KEY auto_increment,
    name VARCHAR(255),
    cpf varchar(11)
);

CREATE TABLE car (
	id INT PRIMARY KEY auto_increment,
    model VARCHAR(255),
    launch_date DATE
);

CREATE TABLE sale (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    car_id INT,
    sale_date DATE,
    FOREIGN KEY (client_id) REFERENCES client(id),
    FOREIGN KEY (car_id) REFERENCES car(id)
);