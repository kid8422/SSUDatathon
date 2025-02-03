DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`year_month_count_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE TRIGGER `hardcoding3`.`year_month_count_AFTER_INSERT`
AFTER INSERT ON `year_month_count`
FOR EACH ROW
BEGIN
    CALL update_timestamp('year_month_count');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`year_month_count_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE TRIGGER `hardcoding3`.`year_month_count_AFTER_UPDATE`
AFTER UPDATE ON `year_month_count`
FOR EACH ROW
BEGIN
    CALL update_timestamp('year_month_count');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`rent_count_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`rent_count_AFTER_INSERT`
AFTER INSERT ON `rent_count`
FOR EACH ROW
BEGIN
    CALL update_timestamp('rent_count');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`rent_count_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`rent_count_AFTER_UPDATE`
AFTER UPDATE ON `rent_count`
FOR EACH ROW
BEGIN
    CALL update_timestamp('rent_count');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`recent_rent_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`recent_rent_AFTER_INSERT`
AFTER INSERT ON `recent_rent`
FOR EACH ROW
BEGIN
    CALL update_timestamp('recent_rent');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`recent_rent_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`recent_rent_AFTER_UPDATE`
AFTER UPDATE ON `recent_rent`
FOR EACH ROW
BEGIN
    CALL update_timestamp('recent_rent');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`ISBN_rent_count_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`ISBN_rent_count_AFTER_INSERT`
AFTER INSERT ON `ISBN_rent_count`
FOR EACH ROW
BEGIN
    CALL update_timestamp('ISBN_rent_count');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`ISBN_rent_count_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`ISBN_rent_count_AFTER_UPDATE`
AFTER UPDATE ON `ISBN_rent_count`
FOR EACH ROW
BEGIN
    CALL update_timestamp('ISBN_rent_count');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`None_ISBN_rent_count_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`None_ISBN_rent_count_AFTER_INSERT`
AFTER INSERT ON `None_ISBN_rent_count`
FOR EACH ROW
BEGIN
    CALL update_timestamp('None_ISBN_rent_count');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`None_ISBN_rent_count_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`None_ISBN_rent_count_AFTER_UPDATE`
AFTER UPDATE ON `None_ISBN_rent_count`
FOR EACH ROW
BEGIN
    CALL update_timestamp('None_ISBN_rent_count');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`large_classification_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`large_classification_AFTER_INSERT`
AFTER INSERT ON `large_classification`
FOR EACH ROW
BEGIN
    CALL update_timestamp('large_classification');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`large_classification_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`large_classification_AFTER_UPDATE`
AFTER UPDATE ON `large_classification`
FOR EACH ROW
BEGIN
    CALL update_timestamp('large_classification');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`middle_classification_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`middle_classification_AFTER_INSERT`
AFTER INSERT ON `middle_classification`
FOR EACH ROW
BEGIN
    CALL update_timestamp('middle_classification');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`middle_classification_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`middle_classification_AFTER_UPDATE`
AFTER UPDATE ON `middle_classification`
FOR EACH ROW
BEGIN
    CALL update_timestamp('middle_classification');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`rent_info_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`rent_info_AFTER_INSERT`
AFTER INSERT ON `rent_info`
FOR EACH ROW
BEGIN
    CALL update_timestamp('rent_info');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`rent_info_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`rent_info_AFTER_UPDATE`
AFTER UPDATE ON `rent_info`
FOR EACH ROW
BEGIN
    CALL update_timestamp('rent_info');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`DDC_ratio_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`DDC_ratio_AFTER_INSERT`
AFTER INSERT ON `DDC_ratio`
FOR EACH ROW
BEGIN
    CALL update_timestamp('DDC_ratio');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `hardcoding3`$$
DROP TRIGGER IF EXISTS `hardcoding3`.`DDC_ratio_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding3`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding3`.`DDC_ratio_AFTER_UPDATE`
AFTER UPDATE ON `DDC_ratio`
FOR EACH ROW
BEGIN
    -- book 테이블 timestamp 갱신 (예시)
    CALL update_timestamp('book');
END$$
SHOW WARNINGS$$

DELIMITER ;

-- -----------------------------------------------------
-- 8. 설정 복원
-- -----------------------------------------------------
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- 9. 인덱스, 테이블 초기 설정
-- -----------------------------------------------------
ALTER TABLE book ADD FULLTEXT(bulli);
ALTER TABLE book ADD FULLTEXT(title);
ALTER TABLE book ADD FULLTEXT(jaum);
CREATE INDEX rent_time_idx ON `hardcoding3`.`rent_info` (`rent_time`);

SET GLOBAL innodb_stats_persistent = ON;

INSERT INTO `hardcoding3`.`timestamp` (`table`) VALUES
('DDC_ratio'), ('ISBN_rent_count'), ('None_ISBN_rent_count'), ('book'),
('large_classification'), ('middle_classification'), ('recent_rent'), ('rent'),
('rent_count'), ('rent_info'), ('year_month_count'), ('year_month_count_detail');

INSERT INTO `hardcoding3`.`DDC_ratio` (`TAG`) VALUE ('4층인문'), ('3층인문'), ('3층사회'), ('5층문학');