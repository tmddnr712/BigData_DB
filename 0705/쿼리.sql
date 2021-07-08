CREATE TABLE member(
memberid VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
NAME VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
addr VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci'
)
COLLATE ='utf8mb3_general_ci'
ENGINE =INNODB
;

CREATE TABLE clubid(
clubid VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
clubname VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
roomno VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
loc VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci'
)
COLLATE ='utf8mb3_general_ci'
ENGINE =INNODB
;

CREATE TABLE memberClubtbl(
UniqueID VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
memberid VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
clubid VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci'
)
COLLATE ='utf8mb3_general_ci'
ENGINE =INNODB
;