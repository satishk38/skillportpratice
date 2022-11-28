create database sports_booking;

select now();

drop table members;
CREATE TABLE members(
id VARCHAR(255) PRIMARY KEY,
password VARCHAR(100) NOT NULL,
email VARCHAR(250) NOT NULL,
member_since TIMESTAMP DEFAULT NOW() NOT NULL,
payment_due FLOAT(5,3) DEFAULT NULL
);


drop table pending_terminations;
create table pending_terminations(

id VARCHAR(255) PRIMARY KEY,
password VARCHAR(100) NOT NULL,
email VARCHAR(250) NOT NULL,
payment_due FLOAT(5,3) DEFAULT NULL,
request_date  TIMESTAMP DEFAULT NOW() NOT NULL

);

drop table rooms;
create table rooms(
id VARCHAR(225) PRIMARY KEY,
room_type VARCHAR(225) NOT NULL,
price FLOAT(5,2) DEFAULT NULL
 
);

select * from rooms;

drop table bookings;
create table bookings
(
id INT primary key AUTO_INCREMENT,
room_id VARCHAR(225) not null,
booked_date DATE not null,
booked_time TIME not null,
member_id VARCHAR(225) not null,
datetime_of_booking TIMESTAMP DEFAULT NOW() NOT NULL,
payment_status VARCHAR(225)  DEFAULT 'Unpaid' NOT NULL,

CONSTRAINT uc1 UNIQUE(room_id,booked_date,booked_time),
CONSTRAINT fk1 FOREIGN KEY (member_id) REFERENCES members (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk2 FOREIGN KEY (room_id) REFERENCES rooms (id) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE bookings ADD CONSTRAINT uc1 UNIQUE(room_id,booked_date,booked_time);
 
ALTER TABLE bookings
  ADD CONSTRAINT fk1 FOREIGN KEY (member_id) REFERENCES
members (id) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT fk2 FOREIGN KEY (room_id) REFERENCES rooms
(id) ON DELETE CASCADE ON UPDATE CASCADE; 
 
 select * from members;
truncate table members;
delete from members where id='afeil';
INSERT INTO members (id, password, email, member_since,
payment_due) VALUES
('amely_18', 'loseweightin18', 'Amely.Bauch91@yahoo.com',
'2018-02-06 16:48:43', 0),
('bbahringer', 'iambeau17', 'Beaulah_Bahringer@yahoo.com',
'2017-12-28 05:36:50', 0),
('little31', 'whocares31', 'Anthony_Little31@gmail.com',
'2017-06-01 21:12:11', 10),
('macejkovic73', 'jadajeda12',
'Jada.Macejkovic73@gmail.com', '2017-05-30 17:30:22', 0),
('marvin1', 'if0909mar', 'Marvin_Schulist@gmail.com',
'2017-09-09 02:30:49', 10),
('nitzsche77', 'bret77@#', 'Bret_Nitzsche77@gmail.com',
'2018-01-09 17:36:49', 0),
('noah51', '18Oct1976#51', 'Noah51@gmail.com', '2017-12-16
22:59:46', 0),
('oreillys', 'reallycool#1', 'Martine_OReilly@yahoo.com',
'2017-10-12 05:39:20', 0),
('wyattgreat', 'wyatt111', 'Wyatt_Wisozk2@gmail.com',
'2017-07-18 16:28:35', 0);

select * from rooms;
INSERT INTO rooms (id, room_type, price) VALUES
('AR', 'Archery Range', 120),
('B1', 'Badminton Court', 8),
('B2', 'Badminton Court', 8),
('MPF1', 'Multi Purpose Field', 50),
('MPF2', 'Multi Purpose Field', 60),
('T1', 'Tennis Court', 10),
('T2', 'Tennis Court', 10);
INSERT INTO bookings (id, room_id, booked_date,
booked_time, member_id, datetime_of_booking,
payment_status) VALUES
(1, 'AR', '2017-12-26', '13:00:00', 'oreillys', '2017-12-20 20:31:27', 'Paid'),
(2, 'MPF1', '2017-12-30', '17:00:00', 'noah51', '2017-12-22 05:22:10', 'Paid'),
(3, 'T2', '2017-12-31', '16:00:00', 'macejkovic73', '2017-12-28 18:14:23', 'Paid'),
(4, 'T1', '2018-03-05', '08:00:00', 'little31', '2018-02-22 20:19:17', 'Unpaid'),
(5, 'MPF2', '2018-03-02', '11:00:00', 'marvin1', '2018-03-01 16:13:45', 'Paid'),
(6, 'B1', '2018-03-28', '16:00:00', 'marvin1', '2018-03-23 22:46:36', 'Paid'),
(7, 'B1', '2018-04-15', '14:00:00', 'macejkovic73', '2018-04-12 22:23:20', 'Cancelled'),
(8, 'T2', '2018-04-23', '13:00:00', 'macejkovic73', '2018-04-19 10:49:00', 'Cancelled'),
(9, 'T1', '2018-05-25', '10:00:00', 'marvin1', '2018-05-21 11:20:46', 'Unpaid'),
(10, 'B2', '2018-06-12', '15:00:00', 'bbahringer', '2018-05-30 14:40:23', 'Paid');


select count(*) from members;
select * from rooms;
select * from bookings;


drop view if exists member_bookings;

CREATE VIEW member_bookings AS
SELECT bookings.id, room_id, room_type, booked_date,
booked_time, member_id, datetime_of_booking, price,
payment_status
FROM
bookings JOIN rooms
ON
bookings.room_id = rooms.id
ORDER BY
bookings.id;

select count(*) from member_bookings;

SELECT * FROM sys.sys_config;

drop procedure if exists insert_new_member

delimiter $$
create procedure insert_new_member
(IN p_id VARCHAR(255),p_password VARCHAR(100),p_email VARCHAR(250))
begin

insert into members (id,password,email) values (p_id,p_password,p_email);


end $$
delimiter ;

call insert_new_member(1,'ramam','ram@gmail.com');

select * from members;

drop procedure if exists delete_member

delimiter $$
create procedure delete_member
(IN p_id VARCHAR(255))
begin

delete from members where id=p_id;
end $$
delimiter ;

call delete_member(1);

drop procedure if exists update_member_password

delimiter $$
create procedure  update_member_password
( p_id VARCHAR(255),  p_password VARCHAR(100))
begin 

update members set password=p_password where id=p_id;

end $$

delimiter ;

call update_member_password(1,'aabbccc');

drop procedure if exists update_member_email;

delimiter $$
create procedure update_member_email
( p_id VARCHAR(255),  p_email VARCHAR(100))
begin

update members set email=p_email where id=p_id;

end $$

delimiter ;

call update_member_email(1,'aabbccc@gmail.com');

drop procedure if exists make_booking;

delimiter $$
create procedure make_booking
(p_room_id VARCHAR(225), p_booked_date DATE,p_booked_time TIME,p_member_id VARCHAR(225))
begin

DECLARE  v_price FLOAT(5,2);
DECLARE  v_parameter_due FLOAT(5,3);

SELECT price INTO v_price FROM rooms WHERE id = p_room_id;

Insert into bookings (room_id, booked_date, booked_time , member_id)
values (p_room_id, p_booked_date, p_booked_time, p_member_id);

SELECT payment_due INTO v_parameter_due FROM members WHERE id = p_member_id;

update members set payment_due=v_parameter_due + v_price WHERE id = p_member_id;

end $$

delimiter ;

call make_booking('AR',STR_TO_DATE('11-26-2022','%m-%d-%Y'),'10:20:22','1');

drop procedure if exists update_payment
delimiter $$
create procedure update_payment (IN p_id INT)
begin

declare v_member_id VARCHAR(255);
declare v_payment_due FLOAT(5,3);
declare v_price FLOAT(5,2);

update bookings set payment_status='paid' where id=p_id;

SELECT member_id, price INTO v_member_id, v_price FROM
member_bookings WHERE id = p_id;


SELECT payment_due INTO v_payment_due FROM members WHERE
id = v_member_id;

  UPDATE members SET payment_due = v_payment_due - v_price
WHERE id = v_member_id;

select concat("member id:",v_member_id);
end $$

delimiter ;


call update_payment(3);


delimiter $$
create procedure view_bookings(IN p_id INT)
begin 

select * from member_bookings where id=p_id;

end $$

delimiter ;

call view_bookings(4);

DELIMITER $$
create procedure seach_room (IN  p_room_type VARCHAR(225), IN p_booked_date DATE,IN p_booked_time TIME)
BEGIN

select id,room_type,price from rooms where room_type=p_room_type and id not in (select room_id from bookings where booked_date = p_booked_date AND booked_time =
p_booked_time AND payment_status != 'Cancelled');


END $$

DELIMITER ;

 
call seach_room('Tennis Court','2017-12-26','13:00:00');


select * from bookings;