CREATE TABLE `school` (
	`no` INT(11) NOT NULL AUTO_INCREMENT,
	`schoolname` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`address` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`schoolcode` CHAR(10) NOT NULL COLLATE 'utf8mb3_general_ci',
	`studentcount` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`schoolcode`) USING BTREE,
	INDEX `no` (`no`) USING BTREE
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB
;
