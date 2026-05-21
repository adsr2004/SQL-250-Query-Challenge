CREATE DATABASE FoodOrderingDB;
USE FoodOrderingDB;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT
);

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    location VARCHAR(100),
    rating DECIMAL(2,1)
);

CREATE TABLE Menu (
    menu_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    item_name VARCHAR(100),
    price DECIMAL(10,2),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    menu_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (menu_id) REFERENCES Menu(menu_id)
);

INSERT INTO Users (name, email, phone, address) VALUES
('Rahul Sharma','rahul1@gmail.com','9000000001','Bangalore'),
('Anita Verma','anita2@gmail.com','9000000002','Delhi'),
('Karan Mehta','karan3@gmail.com','9000000003','Mumbai'),
('Priya Singh','priya4@gmail.com','9000000004','Chennai'),
('Arjun Rao','arjun5@gmail.com','9000000005','Hyderabad'),
('Sneha Reddy','sneha6@gmail.com','9000000006','Bangalore'),
('Vikram Patel','vikram7@gmail.com','9000000007','Ahmedabad'),
('Neha Gupta','neha8@gmail.com','9000000008','Pune'),
('Rohit Jain','rohit9@gmail.com','9000000009','Jaipur'),
('Pooja Nair','pooja10@gmail.com','9000000010','Kochi');

INSERT INTO Restaurants (name, location, rating) VALUES
('Spice Hub','Bangalore',4.5),
('Food Palace','Delhi',4.2),
('Tasty Treat','Mumbai',4.6),
('Urban Bites','Chennai',4.3),
('Royal Kitchen','Hyderabad',4.7);

INSERT INTO Menu (restaurant_id, item_name, price) VALUES
(1,'Pizza',250),(1,'Burger',120),(1,'Pasta',200),
(2,'Biryani',300),(2,'Naan',40),(2,'Paneer Butter Masala',220),
(3,'Vada Pav',50),(3,'Pav Bhaji',150),(3,'Sandwich',100),
(4,'Dosa',80),(4,'Idli',60),(4,'Uttapam',90),
(5,'Chicken Curry',280),(5,'Fried Rice',180),(5,'Noodles',160);

INSERT INTO Orders (user_id, order_date, total_amount) VALUES
(1,NOW(),370),(2,NOW(),300),(3,NOW(),150),
(4,NOW(),220),(5,NOW(),400),
(6,NOW(),180),(7,NOW(),260),
(8,NOW(),90),(9,NOW(),500),(10,NOW(),200);

INSERT INTO Order_Items (order_id, menu_id, quantity, subtotal) VALUES
(1,1,1,250),(1,2,1,120),
(2,4,1,300),
(3,8,1,150),
(4,6,1,220),
(5,13,1,280),(5,14,1,120),
(6,15,1,180),
(7,3,1,200),(7,2,1,60),
(8,11,1,60),(8,10,1,30),
(9,4,1,300),(9,6,1,200),
(10,9,1,100),(10,7,2,100);
