CREATE TABLE `student` (
	`bunho` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`kor` TINYINT(4) NULL DEFAULT NULL,
	`mat` TINYINT(4) NULL DEFAULT NULL,
	`eng` TINYINT(4) NULL DEFAULT NULL,
	`total` SMALLINT(6) NULL DEFAULT NULL,
	`average` FLOAT NULL DEFAULT NULL,
	`grade` CHAR(1) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`schoolcode` CHAR(10) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	PRIMARY KEY (`bunho`) USING BTREE,
	INDEX `name` (`name`) USING BTREE,
	INDEX `FK__school` (`schoolcode`) USING BTREE,
	CONSTRAINT `FK__school` FOREIGN KEY (`schoolcode`) REFERENCES `sungjuk`.`school` (`schoolcode`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB
;
