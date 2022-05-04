CREATE DATABASE  IF NOT EXISTS `buyme`;
USE `buyme`;

CREATE TABLE End_User (
    Username VARCHAR(20),
    Email VARCHAR(40),
    Password VARCHAR(40),
    PRIMARY KEY (Username)
);

CREATE TABLE Buyer (
    Username VARCHAR(20),
    PRIMARY KEY (Username),
    FOREIGN KEY (username)
        REFERENCES End_user (username)
);

CREATE TABLE Seller (
    Username VARCHAR(20),
    PRIMARY KEY (Username),
    FOREIGN KEY (username)
        REFERENCES End_user (username)
);
CREATE TABLE Item (
	Item_ID INT UNSIGNED AUTO_INCREMENT,
    Category_Level1 VARCHAR(20),
    Category_level2 VARCHAR(20),
    Item_Condition VARCHAR(10),
    CHECK (Item_Condition IN ('New','Used','Refurbished')),
    PRIMARY KEY (Item_ID)
);
CREATE TABLE Auction (
    Auction_ID INT UNSIGNED AUTO_INCREMENT,
    Inital_Price DECIMAL(14 , 2 ),
    Minimum_Price DECIMAL(14 , 2 ),
    Closing_Time DATETIME,
    PRIMARY KEY (Auction_ID)
);
CREATE TABLE Post (
	Post_ID INT UNSIGNED AUTO_INCREMENT,
    Item_ID INT UNSIGNED NOT NULL,
    Username VARCHAR(20) NOT NULL,
    Auction_ID INT UNSIGNED NOT NULL,
    Description TEXT,
    PRIMARY KEY (Post_ID), 
    UNIQUE (Item_ID , Username , Auction_ID),
    FOREIGN KEY (username)
        REFERENCES Seller (username),
    FOREIGN KEY (Auction_ID)
        REFERENCES Auction (Auction_ID),
	FOREIGN KEY (Item_ID )
        REFERENCES Item (Item_ID )
);
CREATE TABLE Search_History (
    Username VARCHAR(20),
    Post_ID INT UNSIGNED,
    PRIMARY KEY (Username, Post_ID),
    FOREIGN KEY (username)
        REFERENCES End_user (username),
    FOREIGN KEY (Post_ID) 
        REFERENCES Post (Post_ID)
);
CREATE TABLE Bid (
    Bid_ID INT UNSIGNED AUTO_INCREMENT,
    Username VARCHAR(20),
    Auction_ID INT UNSIGNED NOT NULL,
    Price DECIMAL(14 , 2 ), /*new field*/
    Upper_Limit DECIMAL(14 , 2 ),
    PRIMARY KEY (Bid_ID),
    FOREIGN KEY (username)
        REFERENCES Buyer (username),
    FOREIGN KEY (Auction_ID)
        REFERENCES Auction (Auction_ID)
);
CREATE TABLE Alert (
    Alert_ID INT UNSIGNED AUTO_INCREMENT,
    Username VARCHAR(20),
    Item_ID INT UNSIGNED,
    UNIQUE (Username , Item_ID),
    PRIMARY KEY (Alert_ID),
    FOREIGN KEY (username)
        REFERENCES Buyer (username),
    FOREIGN KEY (Item_ID)
        REFERENCES Item (Item_ID)
);
CREATE TABLE Admin_Staff(
	Username VARCHAR(20),
    Email VARCHAR(40),
    Password VARCHAR(40),
    PRIMARY KEY (Username)
);
CREATE TABLE Customer_Representative(
	Username VARCHAR(20),
    Email VARCHAR(40),
    Password VARCHAR(40),
    Created_by VARCHAR(20) NOT NULL,
    PRIMARY KEY (Username),
    FOREIGN KEY (Created_by) REFERENCES Admin_Staff(UserName)
);
CREATE TABLE Question (
    Question_ID INT UNSIGNED AUTO_INCREMENT,
    End_User VARCHAR(20) NOT NULL,
    Description TEXT,
    PRIMARY KEY (Question_ID),
    FOREIGN KEY (End_User)
        REFERENCES End_User (Username)
);

CREATE TABLE Answer(
	Answer_ID INT UNSIGNED AUTO_INCREMENT,
    Question_ID INT UNSIGNED NOT NULL,
    End_User VARCHAR(20) NOT NULL,
    Customer_Representative VARCHAR(20) NOT NULL,
    Description TEXT,
    PRIMARY KEY (Answer_ID),
	FOREIGN KEY (Question_ID) REFERENCES Question(Question_ID),
    FOREIGN KEY (Customer_Representative) REFERENCES Customer_Representative(Username)
);

INSERT INTO end_user
VALUES ("test_user_1", "test_user_1@gmail.com", "test_password_1");

SELECT * FROM end_user WHERE Username = 'test_user_1';
SELECT * FROM Auction ;  
SELECT * FROM Item ; 
ALTER TABLE Item 
ADD  make VARCHAR(20)
AFTER Item_ID ;
ALTER TABLE Item 
ADD  model VARCHAR(20)
AFTER make ;
ALTER TABLE Item 
ADD  yearofcar VARCHAR(20)
AFTER make ;
ALTER TABLE Item
DROP column Category_Level1 ;

ALTER TABLE Item
DROP column Category_Level2 ;
