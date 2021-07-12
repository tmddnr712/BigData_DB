CREATE TABLE `gradeinfo` (
	`code` VARCHAR(50) NOT NULL COLLATE 'utf8mb3_general_ci',
	`name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`mat` INT(11) NULL DEFAULT NULL,
	`kor` INT(11) NULL DEFAULT NULL,
	`eng` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`code`) USING BTREE
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB
;
