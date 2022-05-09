DROP DATABASE IF EXISTS `buyme`;
CREATE DATABASE IF NOT EXISTS `buyme`;
USE `buyme`;

CREATE TABLE End_User (
    Username VARCHAR(20),
    Email VARCHAR(40),
    Password VARCHAR(40),
    PRIMARY KEY (Username)
);

CREATE TABLE Buyer (
    Username VARCHAR(20),
    last_read_time DATETIME,
    PRIMARY KEY (Username),
    FOREIGN KEY (username)
        REFERENCES End_user (username)
	ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Seller (
    Username VARCHAR(20),
    PRIMARY KEY (Username),
    FOREIGN KEY (username)
        REFERENCES End_user (username)
	ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Item (
	Item_ID INT UNSIGNED AUTO_INCREMENT,
  Make VARCHAR(20),
  Model VARCHAR(20),
  Year VARCHAR(20),
  Item_Condition VARCHAR(20),
  CHECK (Item_Condition IN ('New','Used','Refurbished')),
  PRIMARY KEY (Item_ID)
);

CREATE TABLE Auction (
    Auction_ID INT UNSIGNED AUTO_INCREMENT,
	Item_ID INT UNSIGNED NOT NULL, -- added
    Initial_Price DECIMAL(14 , 2 ),
    Minimum_Price DECIMAL(14 , 2 ),
    Closing_Price DECIMAL(14 , 2 ),
    Start_Time DATETIME,
    Closing_Time DATETIME,
    Winner VARCHAR(20) REFERENCES Buyer(Username),
    PRIMARY KEY (Auction_ID),
    FOREIGN KEY (Item_ID)
        REFERENCES Item (Item_ID )
);

CREATE TABLE Post (
	Post_ID INT UNSIGNED AUTO_INCREMENT,
	Auction_ID INT UNSIGNED NOT NULL,
    Username VARCHAR(20) NOT NULL,
    Description TEXT,
    PRIMARY KEY (Post_ID), 
    FOREIGN KEY (username)
        REFERENCES Seller (username)
	ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Auction_ID)
        REFERENCES Auction (Auction_ID)
	ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Search_History (
    Username VARCHAR(20),
    Post_ID INT UNSIGNED,
    PRIMARY KEY (Username, Post_ID),
    FOREIGN KEY (username)
        REFERENCES End_user (username)
	ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Post_ID) 
        REFERENCES Post (Post_ID)
	ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Bid (
    Bid_ID INT UNSIGNED AUTO_INCREMENT,
	Auction_ID INT UNSIGNED NOT NULL,
    Username VARCHAR(20),
    Price DECIMAL(14 , 2 ),
    Biding_Time DATETIME,
    PRIMARY KEY (Bid_ID),
    FOREIGN KEY (username)
        REFERENCES Buyer (username)
	ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Auction_ID)
        REFERENCES Auction (Auction_ID)
	ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Auto_Bid (
	Auto_Bid_ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Auction_ID INT UNSIGNED NOT NULL,
    Username VARCHAR(20),
	Upper_Limit DECIMAL(14 , 2 ),
    Increment DECIMAL(14 , 2 ),
    Creation_Time DATETIME,
    FOREIGN KEY (username)
        REFERENCES Buyer (username)
	ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Auction_ID)
        REFERENCES Auction (Auction_ID)
	ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Alert (
    Alert_ID INT UNSIGNED AUTO_INCREMENT,
    Username VARCHAR(20),
	Message TEXT,
    Sent_Time DATETIME,

    PRIMARY KEY (Alert_ID),
    FOREIGN KEY (username)
        REFERENCES Buyer (username)
	ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Item_Alert_Manager (
    Alert_ID INT UNSIGNED AUTO_INCREMENT,
    Username VARCHAR(20),
    Make VARCHAR(20),
    Model VARCHAR(20),
    Year VARCHAR(20),
    PRIMARY KEY (Alert_ID),
     FOREIGN KEY (username)
        REFERENCES Buyer (username)
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
	ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Answer(
	Answer_ID INT UNSIGNED AUTO_INCREMENT,
    Question_ID INT UNSIGNED NOT NULL,
    End_User VARCHAR(20) NOT NULL,
    Customer_Representative VARCHAR(20) NOT NULL,
    Description TEXT,
    PRIMARY KEY (Answer_ID),
	FOREIGN KEY (Question_ID) REFERENCES Question(Question_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Customer_Representative) REFERENCES Customer_Representative(Username)
);

-- sample data
INSERT INTO end_user VALUES ("testuser1", "testuser1@gmail.com", "testpassword");
INSERT INTO end_user VALUES ("testuser2", "testuser2@gmail.com", "testpassword");
INSERT INTO end_user VALUES ("testuser3", "testuser3@gmail.com", "testpassword");
INSERT INTO end_user VALUES ("testuser4", "testuser4@gmail.com", "testpassword");
INSERT INTO end_user VALUES ("testuser5", "testuser5@gmail.com", "testpassword");

INSERT INTO buyer VALUES ("testuser1", NULL);
INSERT INTO buyer VALUES ("testuser2", NULL);
INSERT INTO buyer VALUES ("testuser3", NULL);
INSERT INTO buyer VALUES ("testuser4", NULL);

INSERT INTO seller VALUES ("testuser3");
INSERT INTO seller VALUES ("testuser4");
INSERT INTO seller VALUES ("testuser5");

INSERT INTO item VALUES (NULL, "Toyota", "Corolla", "2017", "Used");
INSERT INTO item VALUES (NULL, "Honda", "Fit", "2010", "Refurbished");
INSERT INTO item VALUES (NULL, "Nissan", "Altima", "2022", "New");

INSERT INTO Auction VALUES (NULL, 1, 15000, NULL, NULL, STR_TO_DATE('2022-05-01 19:00:00', '%Y-%m-%d %T'), STR_TO_DATE('2022-05-20 00:00:00', '%Y-%m-%d %T'), NULL);
INSERT INTO Post VALUES (NULL, 1, 'testuser3', 'selling car for upgrade. Located in New Brunswick, NJ');
INSERT INTO Bid VALUES (NULL, 1, 'testuser1', 15000,  STR_TO_DATE('2022-05-05 19:00:00', '%Y-%m-%d %T'));
INSERT INTO Bid VALUES (NULL, 1, 'testuser2', 16000, STR_TO_DATE('2022-05-06 20:00:00', '%Y-%m-%d %T'));
INSERT INTO Bid VALUES (NULL, 1, 'testuser1', 17000, STR_TO_DATE('2022-05-06 21:00:00', '%Y-%m-%d %T'));

INSERT INTO Auction VALUES (NULL, 2, 11000, NULL, NULL, STR_TO_DATE('2022-05-01 19:00:00', '%Y-%m-%d %T'), STR_TO_DATE('2022-06-20', '%Y-%m-%d'), NULL);
INSERT INTO Post VALUES (NULL, 2, 'testuser4', 'selling red fit dealer refurbished car.');
INSERT INTO Bid VALUES (NULL, 2, 'testuser1', 11000, STR_TO_DATE('2022-06-05 19:00:00', '%Y-%m-%d %T'));
INSERT INTO Bid VALUES (NULL, 2, 'testuser2', 12000, STR_TO_DATE('2022-06-06 20:00:00', '%Y-%m-%d %T'));
INSERT INTO Bid VALUES (NULL, 2, 'testuser1', 17000, STR_TO_DATE('2022-06-06 21:00:00', '%Y-%m-%d %T'));

INSERT INTO Auction VALUES (NULL, 3, 20000, NULL, NULL, STR_TO_DATE('2022-05-01 19:00:00', '%Y-%m-%d %T'), STR_TO_DATE('2022-05-15', '%Y-%m-%d'), NULL);
INSERT INTO Post VALUES (NULL, 3, 'testuser5', 'new car deal located in Edison, NJ');
INSERT INTO Bid VALUES (NULL, 3, 'testuser1', 20000, STR_TO_DATE('2022-05-01 19:00:00', '%Y-%m-%d %T'));
INSERT INTO Bid VALUES (NULL, 3, 'testuser3', 21001, STR_TO_DATE('2022-05-06 20:00:00', '%Y-%m-%d %T'));

INSERT INTO Auction VALUES (NULL, 2, 15000, NULL, NULL,STR_TO_DATE('2022-05-01 19:00:00', '%Y-%m-%d %T'), STR_TO_DATE('2022-06-15', '%Y-%m-%d'), NULL);
INSERT INTO Post VALUES (NULL, 4, 'testuser4', 'selling a Blue refurbished car located in Jersey City, NJ');

INSERT INTO Auction VALUES (NULL, 2, 11000, NULL, NULL,STR_TO_DATE('2022-06-05 19:00:00', '%Y-%m-%d %T'), STR_TO_DATE('2022-06-20', '%Y-%m-%d'), NULL);
INSERT INTO Post VALUES (NULL, 5, 'testuser4', 'selling another red fit dealer refurbished car.');


INSERT INTO question VALUES (NULL, 'testuser1', 'How do i buy?');
INSERT INTO admin_staff VALUES ('administrator', NULL, 'admin_password_123');
INSERT INTO customer_representative VALUES ('rep1', NULL, 'testpassword','administrator');
INSERT INTO answer VALUES (NULL, 1, 'testuser1', 'rep1', 'please follow our instructions.');
INSERT INTO AUCTION VALUES (NULL, 2, 11000, NULL, 50000, STR_TO_DATE('2022-04-30 19:00:00', '%Y-%m-%d %T'), STR_TO_DATE('2022-05-01', '%Y-%m-%d'), 'testuser3');
INSERT INTO AUCTION VALUES (NULL, 3, 11000, NULL, 50000, STR_TO_DATE('2022-04-30 19:00:00', '%Y-%m-%d %T'), STR_TO_DATE('2022-05-01', '%Y-%m-%d'), 'testuser3');
INSERT INTO AUCTION VALUES (NULL, 3, 11000, NULL, 50000, STR_TO_DATE('2022-04-30 19:00:00', '%Y-%m-%d %T'), STR_TO_DATE('2022-05-01', '%Y-%m-%d'), 'testuser4');
