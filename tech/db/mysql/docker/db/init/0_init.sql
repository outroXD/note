CREATE DATABASE keisuke CHARACTER SET utf8mb4;

-- create local qme user
USE keisuke;
CREATE USER "keisuke";
GRANT ALL PRIVILEGES ON keisuke.* TO keisuke@"%" IDENTIFIED BY 'password' WITH GRANT OPTION;

UPDATE mysql.user SET Super_priv='Y' WHERE user = 'keisuke';