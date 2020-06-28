
create database android default character set utf8;
use android;
CREATE TABLE IF NOT EXISTS members(
   idx int(11) primary key auto_increment,
   userID varchar(60) not null unique,
   userNM varchar(30) not null,
   email varchar(60) default null,
   passwd varchar(80) not null,
   salt varchar(10) not null,
   telNO varchar(16) default null,
   mobileNO varchar(34) default null,
   phoneSE varchar(50) default null,
   OStype tinyint(2) NOT NULL DEFAULT '0',
   admin tinyint(4) NOT NULL DEFAULT '0',
   auth tinyint(4) NOT NULL DEFAULT '0',
   level int(11) NOT NULL DEFAULT '0',
   created_at datetime,
   regdate char(8) default null
);

use mysql;
create user android@localhost;
grant all privileges on android.* to android@localhost identified by '!android@';
flush privileges;

