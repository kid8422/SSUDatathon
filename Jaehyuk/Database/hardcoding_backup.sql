-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hardcoding
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `hardcoding` ;

-- -----------------------------------------------------
-- Schema hardcoding
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hardcoding` DEFAULT CHARACTER SET utf8mb4 ;
SHOW WARNINGS;
USE `hardcoding` ;

-- -----------------------------------------------------
-- Table `hardcoding`.`book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`book` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`book` (
  `ID` VARCHAR(10) NOT NULL,
  `registration_year` INT UNSIGNED NOT NULL,
  `registration_month` INT UNSIGNED NOT NULL,
  `get_course` VARCHAR(10) NOT NULL,
  `DDC` VARCHAR(20) NOT NULL,
  `ISBN` VARCHAR(20) NOT NULL,
  `title` VARCHAR(510) NOT NULL,
  `author` VARCHAR(160) NULL,
  `publisher` VARCHAR(220) NULL,
  `publication_year` VARCHAR(60) NULL,
  `location` VARCHAR(5) NOT NULL,
  `large_code` ENUM('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') NOT NULL,
  `middle_code` ENUM('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') NOT NULL,
  `jaum` VARCHAR(510) NULL,
  `bulli` VARCHAR(1530) NULL,
  `registration` DATE NOT NULL,
  `except` ENUM('0', '1') NULL DEFAULT '0',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`rent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`rent` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`rent` (
  `ID` VARCHAR(10) NOT NULL,
  `rent_date` DATETIME NOT NULL)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`rent_count`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`rent_count` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`rent_count` (
  `ID` VARCHAR(10) NOT NULL,
  `2004` INT UNSIGNED NULL DEFAULT 0,
  `2005` INT UNSIGNED NULL DEFAULT 0,
  `2006` INT UNSIGNED NULL DEFAULT 0,
  `2007` INT UNSIGNED NULL DEFAULT 0,
  `2008` INT UNSIGNED NULL DEFAULT 0,
  `2009` INT UNSIGNED NULL DEFAULT 0,
  `2010` INT UNSIGNED NULL DEFAULT 0,
  `2011` INT UNSIGNED NULL DEFAULT 0,
  `2012` INT UNSIGNED NULL DEFAULT 0,
  `2013` INT UNSIGNED NULL DEFAULT 0,
  `2014` INT UNSIGNED NULL DEFAULT 0,
  `2015` INT UNSIGNED NULL DEFAULT 0,
  `2016` INT UNSIGNED NULL DEFAULT 0,
  `2017` INT UNSIGNED NULL DEFAULT 0,
  `2018` INT UNSIGNED NULL DEFAULT 0,
  `2019` INT UNSIGNED NULL DEFAULT 0,
  `2020` INT UNSIGNED NULL DEFAULT 0,
  `2021` INT UNSIGNED NULL DEFAULT 0,
  `2022` INT UNSIGNED NULL DEFAULT 0,
  `2023` INT UNSIGNED NULL DEFAULT 0,
  `2024` INT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `도서ID_UNIQUE` (`ID` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`recent_rent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`recent_rent` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`recent_rent` (
  `ID` VARCHAR(10) NOT NULL,
  `duration` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `도서ID_UNIQUE` (`ID` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`ISBN_rent_count`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`ISBN_rent_count` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`ISBN_rent_count` (
  `ISBN` VARCHAR(20) NOT NULL,
  `ID_count` INT UNSIGNED NULL DEFAULT 0,
  `2004` INT UNSIGNED NULL DEFAULT 0,
  `2005` INT UNSIGNED NULL DEFAULT 0,
  `2006` INT UNSIGNED NULL DEFAULT 0,
  `2007` INT UNSIGNED NULL DEFAULT 0,
  `2008` INT UNSIGNED NULL DEFAULT 0,
  `2009` INT UNSIGNED NULL DEFAULT 0,
  `2010` INT UNSIGNED NULL DEFAULT 0,
  `2011` INT UNSIGNED NULL DEFAULT 0,
  `2012` INT UNSIGNED NULL DEFAULT 0,
  `2013` INT UNSIGNED NULL DEFAULT 0,
  `2014` INT UNSIGNED NULL DEFAULT 0,
  `2015` INT UNSIGNED NULL DEFAULT 0,
  `2016` INT UNSIGNED NULL DEFAULT 0,
  `2017` INT UNSIGNED NULL DEFAULT 0,
  `2018` INT UNSIGNED NULL DEFAULT 0,
  `2019` INT UNSIGNED NULL DEFAULT 0,
  `2020` INT UNSIGNED NULL DEFAULT 0,
  `2021` INT UNSIGNED NULL DEFAULT 0,
  `2022` INT UNSIGNED NULL DEFAULT 0,
  `2023` INT UNSIGNED NULL DEFAULT 0,
  `2024` INT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`ISBN`),
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`None_ISBN_rent_count`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`None_ISBN_rent_count` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`None_ISBN_rent_count` (
  `title` VARCHAR(510) NOT NULL,
  `author` VARCHAR(160) NULL,
  `publisher` VARCHAR(220) NULL,
  `ID_count` INT UNSIGNED NULL DEFAULT 0,
  `2004` INT UNSIGNED NULL DEFAULT 0,
  `2005` INT UNSIGNED NULL DEFAULT 0,
  `2006` INT UNSIGNED NULL DEFAULT 0,
  `2007` INT UNSIGNED NULL DEFAULT 0,
  `2008` INT UNSIGNED NULL DEFAULT 0,
  `2009` INT UNSIGNED NULL DEFAULT 0,
  `2010` INT UNSIGNED NULL DEFAULT 0,
  `2011` INT UNSIGNED NULL DEFAULT 0,
  `2012` INT UNSIGNED NULL DEFAULT 0,
  `2013` INT UNSIGNED NULL DEFAULT 0,
  `2014` INT UNSIGNED NULL DEFAULT 0,
  `2015` INT UNSIGNED NULL DEFAULT 0,
  `2016` INT UNSIGNED NULL DEFAULT 0,
  `2017` INT UNSIGNED NULL DEFAULT 0,
  `2018` INT UNSIGNED NULL DEFAULT 0,
  `2019` INT UNSIGNED NULL DEFAULT 0,
  `2020` INT UNSIGNED NULL DEFAULT 0,
  `2021` INT UNSIGNED NULL DEFAULT 0,
  `2022` INT UNSIGNED NULL DEFAULT 0,
  `2023` INT UNSIGNED NULL DEFAULT 0,
  `2024` INT UNSIGNED NULL DEFAULT 0,
  UNIQUE INDEX `None_ISBN_UNIQUE` (`title`(191) ASC, `author` ASC, `publisher`(191) ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`large_classification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`large_classification` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`large_classification` (
  `TAG` VARCHAR(20) NOT NULL,
  `000` INT UNSIGNED NULL DEFAULT 0,
  `100` INT UNSIGNED NULL DEFAULT 0,
  `200` INT UNSIGNED NULL DEFAULT 0,
  `300` INT UNSIGNED NULL DEFAULT 0,
  `400` INT UNSIGNED NULL DEFAULT 0,
  `500` INT UNSIGNED NULL DEFAULT 0,
  `600` INT UNSIGNED NULL DEFAULT 0,
  `700` INT UNSIGNED NULL DEFAULT 0,
  `800` INT UNSIGNED NULL DEFAULT 0,
  `900` INT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`TAG`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`middle_classification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`middle_classification` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`middle_classification` (
  `TAG` VARCHAR(20) NOT NULL,
  `000` INT UNSIGNED NULL DEFAULT 0,
  `010` INT UNSIGNED NULL DEFAULT 0,
  `020` INT UNSIGNED NULL DEFAULT 0,
  `030` INT UNSIGNED NULL DEFAULT 0,
  `040` INT UNSIGNED NULL DEFAULT 0,
  `050` INT UNSIGNED NULL DEFAULT 0,
  `060` INT UNSIGNED NULL DEFAULT 0,
  `070` INT UNSIGNED NULL DEFAULT 0,
  `080` INT UNSIGNED NULL DEFAULT 0,
  `090` INT UNSIGNED NULL DEFAULT 0,
  `100` INT UNSIGNED NULL DEFAULT 0,
  `110` INT UNSIGNED NULL DEFAULT 0,
  `120` INT UNSIGNED NULL DEFAULT 0,
  `130` INT UNSIGNED NULL DEFAULT 0,
  `140` INT UNSIGNED NULL DEFAULT 0,
  `150` INT UNSIGNED NULL DEFAULT 0,
  `160` INT UNSIGNED NULL DEFAULT 0,
  `170` INT UNSIGNED NULL DEFAULT 0,
  `180` INT UNSIGNED NULL DEFAULT 0,
  `190` INT UNSIGNED NULL DEFAULT 0,
  `200` INT UNSIGNED NULL DEFAULT 0,
  `210` INT UNSIGNED NULL DEFAULT 0,
  `220` INT UNSIGNED NULL DEFAULT 0,
  `230` INT UNSIGNED NULL DEFAULT 0,
  `240` INT UNSIGNED NULL DEFAULT 0,
  `250` INT UNSIGNED NULL DEFAULT 0,
  `260` INT UNSIGNED NULL DEFAULT 0,
  `270` INT UNSIGNED NULL DEFAULT 0,
  `280` INT UNSIGNED NULL DEFAULT 0,
  `290` INT UNSIGNED NULL DEFAULT 0,
  `300` INT UNSIGNED NULL DEFAULT 0,
  `310` INT UNSIGNED NULL DEFAULT 0,
  `320` INT UNSIGNED NULL DEFAULT 0,
  `330` INT UNSIGNED NULL DEFAULT 0,
  `340` INT UNSIGNED NULL DEFAULT 0,
  `350` INT UNSIGNED NULL DEFAULT 0,
  `360` INT UNSIGNED NULL DEFAULT 0,
  `370` INT UNSIGNED NULL DEFAULT 0,
  `380` INT UNSIGNED NULL DEFAULT 0,
  `390` INT UNSIGNED NULL DEFAULT 0,
  `400` INT UNSIGNED NULL DEFAULT 0,
  `410` INT UNSIGNED NULL DEFAULT 0,
  `420` INT UNSIGNED NULL DEFAULT 0,
  `430` INT UNSIGNED NULL DEFAULT 0,
  `440` INT UNSIGNED NULL DEFAULT 0,
  `450` INT UNSIGNED NULL DEFAULT 0,
  `460` INT UNSIGNED NULL DEFAULT 0,
  `470` INT UNSIGNED NULL DEFAULT 0,
  `480` INT UNSIGNED NULL DEFAULT 0,
  `490` INT UNSIGNED NULL DEFAULT 0,
  `500` INT UNSIGNED NULL DEFAULT 0,
  `510` INT UNSIGNED NULL DEFAULT 0,
  `520` INT UNSIGNED NULL DEFAULT 0,
  `530` INT UNSIGNED NULL DEFAULT 0,
  `540` INT UNSIGNED NULL DEFAULT 0,
  `550` INT UNSIGNED NULL DEFAULT 0,
  `560` INT UNSIGNED NULL DEFAULT 0,
  `570` INT UNSIGNED NULL DEFAULT 0,
  `580` INT UNSIGNED NULL DEFAULT 0,
  `590` INT UNSIGNED NULL DEFAULT 0,
  `600` INT UNSIGNED NULL DEFAULT 0,
  `610` INT UNSIGNED NULL DEFAULT 0,
  `620` INT UNSIGNED NULL DEFAULT 0,
  `630` INT UNSIGNED NULL DEFAULT 0,
  `640` INT UNSIGNED NULL DEFAULT 0,
  `650` INT UNSIGNED NULL DEFAULT 0,
  `660` INT UNSIGNED NULL DEFAULT 0,
  `670` INT UNSIGNED NULL DEFAULT 0,
  `680` INT UNSIGNED NULL DEFAULT 0,
  `690` INT UNSIGNED NULL DEFAULT 0,
  `700` INT UNSIGNED NULL DEFAULT 0,
  `710` INT UNSIGNED NULL DEFAULT 0,
  `720` INT UNSIGNED NULL DEFAULT 0,
  `730` INT UNSIGNED NULL DEFAULT 0,
  `740` INT UNSIGNED NULL DEFAULT 0,
  `750` INT UNSIGNED NULL DEFAULT 0,
  `760` INT UNSIGNED NULL DEFAULT 0,
  `770` INT UNSIGNED NULL DEFAULT 0,
  `780` INT UNSIGNED NULL DEFAULT 0,
  `790` INT UNSIGNED NULL DEFAULT 0,
  `800` INT UNSIGNED NULL DEFAULT 0,
  `810` INT UNSIGNED NULL DEFAULT 0,
  `820` INT UNSIGNED NULL DEFAULT 0,
  `830` INT UNSIGNED NULL DEFAULT 0,
  `840` INT UNSIGNED NULL DEFAULT 0,
  `850` INT UNSIGNED NULL DEFAULT 0,
  `860` INT UNSIGNED NULL DEFAULT 0,
  `870` INT UNSIGNED NULL DEFAULT 0,
  `880` INT UNSIGNED NULL DEFAULT 0,
  `890` INT UNSIGNED NULL DEFAULT 0,
  `900` INT UNSIGNED NULL DEFAULT 0,
  `910` INT UNSIGNED NULL DEFAULT 0,
  `920` INT UNSIGNED NULL DEFAULT 0,
  `930` INT UNSIGNED NULL DEFAULT 0,
  `940` INT UNSIGNED NULL DEFAULT 0,
  `950` INT UNSIGNED NULL DEFAULT 0,
  `960` INT UNSIGNED NULL DEFAULT 0,
  `970` INT UNSIGNED NULL DEFAULT 0,
  `980` INT UNSIGNED NULL DEFAULT 0,
  `990` INT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`TAG`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`year_month_count`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`year_month_count` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`year_month_count` (
  `year` INT UNSIGNED NOT NULL,
  `1` INT UNSIGNED NULL DEFAULT 0,
  `2` INT UNSIGNED NULL DEFAULT 0,
  `3` INT UNSIGNED NULL DEFAULT 0,
  `4` INT UNSIGNED NULL DEFAULT 0,
  `5` INT UNSIGNED NULL DEFAULT 0,
  `6` INT UNSIGNED NULL DEFAULT 0,
  `7` INT UNSIGNED NULL DEFAULT 0,
  `8` INT UNSIGNED NULL DEFAULT 0,
  `9` INT UNSIGNED NULL DEFAULT 0,
  `10` INT UNSIGNED NULL DEFAULT 0,
  `11` INT UNSIGNED NULL DEFAULT 0,
  `12` INT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`year`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`year_month_count_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`year_month_count_detail` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`year_month_count_detail` (
  `year` INT UNSIGNED NOT NULL,
  `month` INT UNSIGNED NOT NULL,
  `000` INT UNSIGNED NULL DEFAULT 0,
  `100` INT UNSIGNED NULL DEFAULT 0,
  `200` INT UNSIGNED NULL DEFAULT 0,
  `300` INT UNSIGNED NULL DEFAULT 0,
  `400` INT UNSIGNED NULL DEFAULT 0,
  `500` INT UNSIGNED NULL DEFAULT 0,
  `600` INT UNSIGNED NULL DEFAULT 0,
  `700` INT UNSIGNED NULL DEFAULT 0,
  `800` INT UNSIGNED NULL DEFAULT 0,
  `900` INT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`year`, `month`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`rent_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`rent_info` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`rent_info` (
  `rent_time` DATETIME NOT NULL,
  `ID` VARCHAR(10) NOT NULL,
  `title` VARCHAR(510) NOT NULL,
  `author` VARCHAR(160) NULL,
  `publisher` VARCHAR(220) NULL,
  `DDC` VARCHAR(20) NOT NULL,
  `location` VARCHAR(5) NOT NULL)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`DDC_ratio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`DDC_ratio` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`DDC_ratio` (
  `TAG` VARCHAR(5) NOT NULL,
  `000` DOUBLE NULL DEFAULT 0,
  `100` DOUBLE NULL DEFAULT 0,
  `200` DOUBLE NULL DEFAULT 0,
  `300` DOUBLE NULL DEFAULT 0,
  `400` DOUBLE NULL DEFAULT 0,
  `500` DOUBLE NULL DEFAULT 0,
  `600` DOUBLE NULL DEFAULT 0,
  `700` DOUBLE NULL DEFAULT 0,
  `800` DOUBLE NULL DEFAULT 0,
  `900` DOUBLE NULL DEFAULT 0,
  PRIMARY KEY (`TAG`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`timestamp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`timestamp` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`timestamp` (
  `table` VARCHAR(50) NOT NULL,
  `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`table`))
ENGINE = InnoDB;

SHOW WARNINGS;
USE `hardcoding`;

DELIMITER $$

CREATE PROCEDURE update_timestamp(table_name VARCHAR(50))
BEGIN
    UPDATE `hardcoding`.`timestamp`
    SET `timestamp` = NOW()
    WHERE `table` = table_name;
END$$

DELIMITER ;

SHOW WARNINGS;

DELIMITER $$

CREATE PROCEDURE process_book_data(
    IN location VARCHAR(20),
    IN large_code CHAR(1),
    IN middle_code CHAR(1)
)
BEGIN
    -- Update large_classification for the given location
    CASE location
        WHEN '보존서고' THEN
            CASE large_code
                WHEN '0' THEN UPDATE `hardcoding`.`large_classification` SET `000` = `000` + 1 WHERE `TAG` = '보존서고';
                WHEN '1' THEN UPDATE `hardcoding`.`large_classification` SET `100` = `100` + 1 WHERE `TAG` = '보존서고';
                WHEN '2' THEN UPDATE `hardcoding`.`large_classification` SET `200` = `200` + 1 WHERE `TAG` = '보존서고';
                WHEN '3' THEN UPDATE `hardcoding`.`large_classification` SET `300` = `300` + 1 WHERE `TAG` = '보존서고';
                WHEN '4' THEN UPDATE `hardcoding`.`large_classification` SET `400` = `400` + 1 WHERE `TAG` = '보존서고';
                WHEN '5' THEN UPDATE `hardcoding`.`large_classification` SET `500` = `500` + 1 WHERE `TAG` = '보존서고';
                WHEN '6' THEN UPDATE `hardcoding`.`large_classification` SET `600` = `600` + 1 WHERE `TAG` = '보존서고';
                WHEN '7' THEN UPDATE `hardcoding`.`large_classification` SET `700` = `700` + 1 WHERE `TAG` = '보존서고';
                WHEN '8' THEN UPDATE `hardcoding`.`large_classification` SET `800` = `800` + 1 WHERE `TAG` = '보존서고';
                WHEN '9' THEN UPDATE `hardcoding`.`large_classification` SET `900` = `900` + 1 WHERE `TAG` = '보존서고';
            END CASE;
            -- Update middle_classification for the given location and large_code
            CASE large_code
                WHEN '0' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `000` = `000` + 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `010` = `010` + 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `020` = `020` + 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `030` = `030` + 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `040` = `040` + 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `050` = `050` + 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `060` = `060` + 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `070` = `070` + 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `080` = `080` + 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `090` = `090` + 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '1' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `100` = `100` + 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `110` = `110` + 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `120` = `120` + 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `130` = `130` + 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `140` = `140` + 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `150` = `150` + 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `160` = `160` + 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `170` = `170` + 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `180` = `180` + 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `190` = `190` + 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '2' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `200` = `200` + 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `210` = `210` + 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `220` = `220` + 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `230` = `230` + 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `240` = `240` + 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `250` = `250` + 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `260` = `260` + 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `270` = `270` + 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `280` = `280` + 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `290` = `290` + 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '3' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `300` = `300` + 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `310` = `310` + 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `320` = `320` + 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `330` = `330` + 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `340` = `340` + 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `350` = `350` + 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `360` = `360` + 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `370` = `370` + 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `380` = `380` + 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `390` = `390` + 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '4' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `400` = `400` + 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `410` = `410` + 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `420` = `420` + 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `430` = `430` + 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `440` = `440` + 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `450` = `450` + 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `460` = `460` + 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `470` = `470` + 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `480` = `480` + 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `490` = `490` + 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '5' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `500` = `500` + 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `510` = `510` + 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `520` = `520` + 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `530` = `530` + 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `540` = `540` + 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `550` = `550` + 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `560` = `560` + 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `570` = `570` + 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `580` = `580` + 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `590` = `590` + 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '6' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `600` = `600` + 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `610` = `610` + 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `620` = `620` + 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `630` = `630` + 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `640` = `640` + 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `650` = `650` + 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `660` = `660` + 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `670` = `670` + 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `680` = `680` + 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `690` = `690` + 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '7' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `700` = `700` + 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `710` = `710` + 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `720` = `720` + 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `730` = `730` + 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `740` = `740` + 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `750` = `750` + 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `760` = `760` + 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `770` = `770` + 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `780` = `780` + 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `790` = `790` + 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '8' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `800` = `800` + 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `810` = `810` + 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `820` = `820` + 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `830` = `830` + 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `840` = `840` + 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `850` = `850` + 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `860` = `860` + 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `870` = `870` + 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `880` = `880` + 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `890` = `890` + 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '9' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `900` = `900` + 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `910` = `910` + 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `920` = `920` + 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `930` = `930` + 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `940` = `940` + 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `950` = `950` + 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `960` = `960` + 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `970` = `970` + 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `980` = `980` + 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `990` = `990` + 1 WHERE `TAG` = '보존서고';
                    END CASE;
            END CASE;
        WHEN '4층인문' THEN
            -- Similar logic for '4층인문'
            CASE large_code
                WHEN '0' THEN UPDATE `hardcoding`.`large_classification` SET `000` = `000` + 1 WHERE `TAG` = '4층인문';
                WHEN '1' THEN UPDATE `hardcoding`.`large_classification` SET `100` = `100` + 1 WHERE `TAG` = '4층인문';
                WHEN '2' THEN UPDATE `hardcoding`.`large_classification` SET `200` = `200` + 1 WHERE `TAG` = '4층인문';
                WHEN '3' THEN UPDATE `hardcoding`.`large_classification` SET `300` = `300` + 1 WHERE `TAG` = '4층인문';
                WHEN '4' THEN UPDATE `hardcoding`.`large_classification` SET `400` = `400` + 1 WHERE `TAG` = '4층인문';
                WHEN '5' THEN UPDATE `hardcoding`.`large_classification` SET `500` = `500` + 1 WHERE `TAG` = '4층인문';
                WHEN '6' THEN UPDATE `hardcoding`.`large_classification` SET `600` = `600` + 1 WHERE `TAG` = '4층인문';
                WHEN '7' THEN UPDATE `hardcoding`.`large_classification` SET `700` = `700` + 1 WHERE `TAG` = '4층인문';
                WHEN '8' THEN UPDATE `hardcoding`.`large_classification` SET `800` = `800` + 1 WHERE `TAG` = '4층인문';
                WHEN '9' THEN UPDATE `hardcoding`.`large_classification` SET `900` = `900` + 1 WHERE `TAG` = '4층인문';
            END CASE;
            -- Update middle_classification for '4층인문'
            CASE large_code
                WHEN '0' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `000` = `000` + 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `010` = `010` + 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `020` = `020` + 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `030` = `030` + 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `040` = `040` + 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `050` = `050` + 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `060` = `060` + 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `070` = `070` + 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `080` = `080` + 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `090` = `090` + 1 WHERE `TAG` = '4층인문';
                    END CASE;
				WHEN '1' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `100` = `100` + 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `110` = `110` + 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `120` = `120` + 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `130` = `130` + 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `140` = `140` + 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `150` = `150` + 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `160` = `160` + 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `170` = `170` + 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `180` = `180` + 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `190` = `190` + 1 WHERE `TAG` = '4층인문';
                    END CASE;
				WHEN '2' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `200` = `200` + 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `210` = `210` + 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `220` = `220` + 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `230` = `230` + 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `240` = `240` + 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `250` = `250` + 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `260` = `260` + 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `270` = `270` + 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `280` = `280` + 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `290` = `290` + 1 WHERE `TAG` = '4층인문';
                    END CASE;
                WHEN '3' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `300` = `300` + 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `310` = `310` + 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `320` = `320` + 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `330` = `330` + 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `340` = `340` + 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `350` = `350` + 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `360` = `360` + 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `370` = `370` + 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `380` = `380` + 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `390` = `390` + 1 WHERE `TAG` = '4층인문';
                    END CASE;
				WHEN '4' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `400` = `400` + 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `410` = `410` + 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `420` = `420` + 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `430` = `430` + 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `440` = `440` + 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `450` = `450` + 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `460` = `460` + 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `470` = `470` + 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `480` = `480` + 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `490` = `490` + 1 WHERE `TAG` = '4층인문';
                    END CASE;
                WHEN '5' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `500` = `500` + 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `510` = `510` + 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `520` = `520` + 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `530` = `530` + 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `540` = `540` + 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `550` = `550` + 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `560` = `560` + 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `570` = `570` + 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `580` = `580` + 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `590` = `590` + 1 WHERE `TAG` = '4층인문';
                    END CASE;
                WHEN '6' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `600` = `600` + 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `610` = `610` + 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `620` = `620` + 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `630` = `630` + 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `640` = `640` + 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `650` = `650` + 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `660` = `660` + 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `670` = `670` + 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `680` = `680` + 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `690` = `690` + 1 WHERE `TAG` = '4층인문';
                    END CASE;
                WHEN '7' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `700` = `700` + 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `710` = `710` + 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `720` = `720` + 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `730` = `730` + 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `740` = `740` + 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `750` = `750` + 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `760` = `760` + 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `770` = `770` + 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `780` = `780` + 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `790` = `790` + 1 WHERE `TAG` = '4층인문';
                    END CASE;
                WHEN '8' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `800` = `800` + 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `810` = `810` + 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `820` = `820` + 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `830` = `830` + 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `840` = `840` + 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `850` = `850` + 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `860` = `860` + 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `870` = `870` + 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `880` = `880` + 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `890` = `890` + 1 WHERE `TAG` = '4층인문';
                    END CASE;
                WHEN '9' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `900` = `900` + 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `910` = `910` + 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `920` = `920` + 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `930` = `930` + 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `940` = `940` + 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `950` = `950` + 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `960` = `960` + 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `970` = `970` + 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `980` = `980` + 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `990` = `990` + 1 WHERE `TAG` = '4층인문';
                    END CASE;
            END CASE;
    END CASE;

    -- Update large_classification and middle_classification for '전체'
    CASE large_code
        WHEN '0' THEN UPDATE `hardcoding`.`large_classification` SET `000` = `000` + 1 WHERE `TAG` = '전체';
        WHEN '1' THEN UPDATE `hardcoding`.`large_classification` SET `100` = `100` + 1 WHERE `TAG` = '전체';
        WHEN '2' THEN UPDATE `hardcoding`.`large_classification` SET `200` = `200` + 1 WHERE `TAG` = '전체';
        WHEN '3' THEN UPDATE `hardcoding`.`large_classification` SET `300` = `300` + 1 WHERE `TAG` = '전체';
        WHEN '4' THEN UPDATE `hardcoding`.`large_classification` SET `400` = `400` + 1 WHERE `TAG` = '전체';
        WHEN '5' THEN UPDATE `hardcoding`.`large_classification` SET `500` = `500` + 1 WHERE `TAG` = '전체';
        WHEN '6' THEN UPDATE `hardcoding`.`large_classification` SET `600` = `600` + 1 WHERE `TAG` = '전체';
        WHEN '7' THEN UPDATE `hardcoding`.`large_classification` SET `700` = `700` + 1 WHERE `TAG` = '전체';
        WHEN '8' THEN UPDATE `hardcoding`.`large_classification` SET `800` = `800` + 1 WHERE `TAG` = '전체';
        WHEN '9' THEN UPDATE `hardcoding`.`large_classification` SET `900` = `900` + 1 WHERE `TAG` = '전체';
    END CASE;
    
    CASE large_code
        WHEN '0' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `000` = `000` + 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `010` = `010` + 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `020` = `020` + 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `030` = `030` + 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `040` = `040` + 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `050` = `050` + 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `060` = `060` + 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `070` = `070` + 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `080` = `080` + 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `090` = `090` + 1 WHERE `TAG` = '전체';
            END CASE;
		WHEN '1' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `100` = `100` + 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `110` = `110` + 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `120` = `120` + 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `130` = `130` + 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `140` = `140` + 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `150` = `150` + 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `160` = `160` + 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `170` = `170` + 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `180` = `180` + 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `190` = `190` + 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '2' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `200` = `200` + 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `210` = `210` + 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `220` = `220` + 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `230` = `230` + 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `240` = `240` + 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `250` = `250` + 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `260` = `260` + 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `270` = `270` + 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `280` = `280` + 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `290` = `290` + 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '3' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `300` = `300` + 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `310` = `310` + 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `320` = `320` + 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `330` = `330` + 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `340` = `340` + 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `350` = `350` + 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `360` = `360` + 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `370` = `370` + 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `380` = `380` + 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `390` = `390` + 1 WHERE `TAG` = '전체';
            END CASE;
		WHEN '4' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `400` = `400` + 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `410` = `410` + 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `420` = `420` + 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `430` = `430` + 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `440` = `440` + 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `450` = `450` + 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `460` = `460` + 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `470` = `470` + 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `480` = `480` + 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `490` = `490` + 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '5' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `500` = `500` + 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `510` = `510` + 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `520` = `520` + 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `530` = `530` + 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `540` = `540` + 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `550` = `550` + 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `560` = `560` + 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `570` = `570` + 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `580` = `580` + 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `590` = `590` + 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '6' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `600` = `600` + 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `610` = `610` + 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `620` = `620` + 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `630` = `630` + 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `640` = `640` + 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `650` = `650` + 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `660` = `660` + 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `670` = `670` + 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `680` = `680` + 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `690` = `690` + 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '7' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `700` = `700` + 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `710` = `710` + 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `720` = `720` + 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `730` = `730` + 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `740` = `740` + 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `750` = `750` + 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `760` = `760` + 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `770` = `770` + 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `780` = `780` + 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `790` = `790` + 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '8' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `800` = `800` + 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `810` = `810` + 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `820` = `820` + 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `830` = `830` + 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `840` = `840` + 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `850` = `850` + 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `860` = `860` + 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `870` = `870` + 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `880` = `880` + 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `890` = `890` + 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '9' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `900` = `900` + 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `910` = `910` + 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `920` = `920` + 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `930` = `930` + 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `940` = `940` + 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `950` = `950` + 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `960` = `960` + 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `970` = `970` + 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `980` = `980` + 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `990` = `990` + 1 WHERE `TAG` = '전체';
            END CASE;
    END CASE;
END$$

SHOW WARNINGS;

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`book_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE TRIGGER `hardcoding`.`book_AFTER_INSERT`
AFTER INSERT ON `book`
FOR EACH ROW
BEGIN
    CALL process_book_data(NEW.location, NEW.large_code, NEW.middle_code);
    CALL update_timestamp('book');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE process_classification(
    IN location VARCHAR(20),
    IN large_code CHAR(1),
    IN middle_code CHAR(1)
)
BEGIN
    -- Update large_classification for the given location
    CASE location
        WHEN '보존서고' THEN
            CASE large_code
                WHEN '0' THEN UPDATE `hardcoding`.`large_classification` SET `000` = `000` - 1 WHERE `TAG` = '보존서고';
                WHEN '1' THEN UPDATE `hardcoding`.`large_classification` SET `100` = `100` - 1 WHERE `TAG` = '보존서고';
                WHEN '2' THEN UPDATE `hardcoding`.`large_classification` SET `200` = `200` - 1 WHERE `TAG` = '보존서고';
                WHEN '3' THEN UPDATE `hardcoding`.`large_classification` SET `300` = `300` - 1 WHERE `TAG` = '보존서고';
                WHEN '4' THEN UPDATE `hardcoding`.`large_classification` SET `400` = `400` - 1 WHERE `TAG` = '보존서고';
                WHEN '5' THEN UPDATE `hardcoding`.`large_classification` SET `500` = `500` - 1 WHERE `TAG` = '보존서고';
                WHEN '6' THEN UPDATE `hardcoding`.`large_classification` SET `600` = `600` - 1 WHERE `TAG` = '보존서고';
                WHEN '7' THEN UPDATE `hardcoding`.`large_classification` SET `700` = `700` - 1 WHERE `TAG` = '보존서고';
                WHEN '8' THEN UPDATE `hardcoding`.`large_classification` SET `800` = `800` - 1 WHERE `TAG` = '보존서고';
                WHEN '9' THEN UPDATE `hardcoding`.`large_classification` SET `900` = `900` - 1 WHERE `TAG` = '보존서고';
            END CASE;
            -- Update middle_classification for the given location and large_code
            CASE large_code
                WHEN '0' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `000` = `000` - 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `010` = `010` - 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `020` = `020` - 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `030` = `030` - 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `040` = `040` - 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `050` = `050` - 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `060` = `060` - 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `070` = `070` - 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `080` = `080` - 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `090` = `090` - 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '1' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `100` = `100` - 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `110` = `110` - 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `120` = `120` - 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `130` = `130` - 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `140` = `140` - 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `150` = `150` - 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `160` = `160` - 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `170` = `170` - 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `180` = `180` - 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `190` = `190` - 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '2' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `200` = `200` - 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `210` = `210` - 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `220` = `220` - 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `230` = `230` - 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `240` = `240` - 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `250` = `250` - 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `260` = `260` - 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `270` = `270` - 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `280` = `280` - 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `290` = `290` - 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '3' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `300` = `300` - 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `310` = `310` - 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `320` = `320` - 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `330` = `330` - 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `340` = `340` - 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `350` = `350` - 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `360` = `360` - 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `370` = `370` - 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `380` = `380` - 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `390` = `390` - 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '4' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `400` = `400` - 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `410` = `410` - 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `420` = `420` - 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `430` = `430` - 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `440` = `440` - 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `450` = `450` - 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `460` = `460` - 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `470` = `470` - 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `480` = `480` - 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `490` = `490` - 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '5' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `500` = `500` - 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `510` = `510` - 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `520` = `520` - 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `530` = `530` - 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `540` = `540` - 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `550` = `550` - 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `560` = `560` - 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `570` = `570` - 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `580` = `580` - 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `590` = `590` - 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '6' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `600` = `600` - 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `610` = `610` - 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `620` = `620` - 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `630` = `630` - 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `640` = `640` - 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `650` = `650` - 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `660` = `660` - 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `670` = `670` - 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `680` = `680` - 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `690` = `690` - 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '7' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `700` = `700` - 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `710` = `710` - 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `720` = `720` - 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `730` = `730` - 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `740` = `740` - 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `750` = `750` - 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `760` = `760` - 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `770` = `770` - 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `780` = `780` - 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `790` = `790` - 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '8' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `800` = `800` - 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `810` = `810` - 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `820` = `820` - 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `830` = `830` - 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `840` = `840` - 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `850` = `850` - 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `860` = `860` - 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `870` = `870` - 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `880` = `880` - 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `890` = `890` - 1 WHERE `TAG` = '보존서고';
                    END CASE;
                WHEN '9' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `900` = `900` - 1 WHERE `TAG` = '보존서고';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `910` = `910` - 1 WHERE `TAG` = '보존서고';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `920` = `920` - 1 WHERE `TAG` = '보존서고';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `930` = `930` - 1 WHERE `TAG` = '보존서고';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `940` = `940` - 1 WHERE `TAG` = '보존서고';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `950` = `950` - 1 WHERE `TAG` = '보존서고';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `960` = `960` - 1 WHERE `TAG` = '보존서고';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `970` = `970` - 1 WHERE `TAG` = '보존서고';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `980` = `980` - 1 WHERE `TAG` = '보존서고';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `990` = `990` - 1 WHERE `TAG` = '보존서고';
                    END CASE;
            END CASE;
        WHEN '4층인문' THEN
            -- Similar logic for '4층인문'
            CASE large_code
                WHEN '0' THEN UPDATE `hardcoding`.`large_classification` SET `000` = `000` - 1 WHERE `TAG` = '4층인문';
                WHEN '1' THEN UPDATE `hardcoding`.`large_classification` SET `100` = `100` - 1 WHERE `TAG` = '4층인문';
                WHEN '2' THEN UPDATE `hardcoding`.`large_classification` SET `200` = `200` - 1 WHERE `TAG` = '4층인문';
                WHEN '3' THEN UPDATE `hardcoding`.`large_classification` SET `300` = `300` - 1 WHERE `TAG` = '4층인문';
                WHEN '4' THEN UPDATE `hardcoding`.`large_classification` SET `400` = `400` - 1 WHERE `TAG` = '4층인문';
                WHEN '5' THEN UPDATE `hardcoding`.`large_classification` SET `500` = `500` - 1 WHERE `TAG` = '4층인문';
                WHEN '6' THEN UPDATE `hardcoding`.`large_classification` SET `600` = `600` - 1 WHERE `TAG` = '4층인문';
                WHEN '7' THEN UPDATE `hardcoding`.`large_classification` SET `700` = `700` - 1 WHERE `TAG` = '4층인문';
                WHEN '8' THEN UPDATE `hardcoding`.`large_classification` SET `800` = `800` - 1 WHERE `TAG` = '4층인문';
                WHEN '9' THEN UPDATE `hardcoding`.`large_classification` SET `900` = `900` - 1 WHERE `TAG` = '4층인문';
            END CASE;
            -- Update middle_classification for '4층인문'
            CASE large_code
                WHEN '0' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `000` = `000` - 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `010` = `010` - 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `020` = `020` - 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `030` = `030` - 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `040` = `040` - 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `050` = `050` - 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `060` = `060` - 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `070` = `070` - 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `080` = `080` - 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `090` = `090` - 1 WHERE `TAG` = '4층인문';
                    END CASE;
				WHEN '1' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `100` = `100` - 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `110` = `110` - 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `120` = `120` - 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `130` = `130` - 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `140` = `140` - 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `150` = `150` - 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `160` = `160` - 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `170` = `170` - 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `180` = `180` - 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `190` = `190` - 1 WHERE `TAG` = '4층인문';
                    END CASE;
				WHEN '2' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `200` = `200` - 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `210` = `210` - 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `220` = `220` - 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `230` = `230` - 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `240` = `240` - 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `250` = `250` - 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `260` = `260` - 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `270` = `270` - 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `280` = `280` - 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `290` = `290` - 1 WHERE `TAG` = '4층인문';
                    END CASE;
                WHEN '3' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `300` = `300` - 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `310` = `310` - 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `320` = `320` - 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `330` = `330` - 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `340` = `340` - 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `350` = `350` - 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `360` = `360` - 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `370` = `370` - 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `380` = `380` - 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `390` = `390` - 1 WHERE `TAG` = '4층인문';
                    END CASE;
				WHEN '4' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `400` = `400` - 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `410` = `410` - 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `420` = `420` - 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `430` = `430` - 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `440` = `440` - 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `450` = `450` - 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `460` = `460` - 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `470` = `470` - 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `480` = `480` - 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `490` = `490` - 1 WHERE `TAG` = '4층인문';
                    END CASE;
                WHEN '5' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `500` = `500` - 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `510` = `510` - 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `520` = `520` - 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `530` = `530` - 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `540` = `540` - 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `550` = `550` - 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `560` = `560` - 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `570` = `570` - 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `580` = `580` - 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `590` = `590` - 1 WHERE `TAG` = '4층인문';
                    END CASE;
                WHEN '6' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `600` = `600` - 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `610` = `610` - 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `620` = `620` - 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `630` = `630` - 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `640` = `640` - 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `650` = `650` - 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `660` = `660` - 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `670` = `670` - 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `680` = `680` - 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `690` = `690` - 1 WHERE `TAG` = '4층인문';
                    END CASE;
                WHEN '7' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `700` = `700` - 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `710` = `710` - 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `720` = `720` - 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `730` = `730` - 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `740` = `740` - 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `750` = `750` - 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `760` = `760` - 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `770` = `770` - 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `780` = `780` - 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `790` = `790` - 1 WHERE `TAG` = '4층인문';
                    END CASE;
                WHEN '8' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `800` = `800` - 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `810` = `810` - 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `820` = `820` - 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `830` = `830` - 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `840` = `840` - 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `850` = `850` - 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `860` = `860` - 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `870` = `870` - 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `880` = `880` - 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `890` = `890` - 1 WHERE `TAG` = '4층인문';
                    END CASE;
                WHEN '9' THEN
                    CASE middle_code
                        WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `900` = `900` - 1 WHERE `TAG` = '4층인문';
                        WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `910` = `910` - 1 WHERE `TAG` = '4층인문';
                        WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `920` = `920` - 1 WHERE `TAG` = '4층인문';
                        WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `930` = `930` - 1 WHERE `TAG` = '4층인문';
                        WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `940` = `940` - 1 WHERE `TAG` = '4층인문';
                        WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `950` = `950` - 1 WHERE `TAG` = '4층인문';
                        WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `960` = `960` - 1 WHERE `TAG` = '4층인문';
                        WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `970` = `970` - 1 WHERE `TAG` = '4층인문';
                        WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `980` = `980` - 1 WHERE `TAG` = '4층인문';
                        WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `990` = `990` - 1 WHERE `TAG` = '4층인문';
                    END CASE;
            END CASE;
    END CASE;

    -- Update large_classification and middle_classification for '전체'
    CASE large_code
        WHEN '0' THEN UPDATE `hardcoding`.`large_classification` SET `000` = `000` - 1 WHERE `TAG` = '전체';
        WHEN '1' THEN UPDATE `hardcoding`.`large_classification` SET `100` = `100` - 1 WHERE `TAG` = '전체';
        WHEN '2' THEN UPDATE `hardcoding`.`large_classification` SET `200` = `200` - 1 WHERE `TAG` = '전체';
        WHEN '3' THEN UPDATE `hardcoding`.`large_classification` SET `300` = `300` - 1 WHERE `TAG` = '전체';
        WHEN '4' THEN UPDATE `hardcoding`.`large_classification` SET `400` = `400` - 1 WHERE `TAG` = '전체';
        WHEN '5' THEN UPDATE `hardcoding`.`large_classification` SET `500` = `500` - 1 WHERE `TAG` = '전체';
        WHEN '6' THEN UPDATE `hardcoding`.`large_classification` SET `600` = `600` - 1 WHERE `TAG` = '전체';
        WHEN '7' THEN UPDATE `hardcoding`.`large_classification` SET `700` = `700` - 1 WHERE `TAG` = '전체';
        WHEN '8' THEN UPDATE `hardcoding`.`large_classification` SET `800` = `800` - 1 WHERE `TAG` = '전체';
        WHEN '9' THEN UPDATE `hardcoding`.`large_classification` SET `900` = `900` - 1 WHERE `TAG` = '전체';
    END CASE;
    
    CASE large_code
        WHEN '0' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `000` = `000` - 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `010` = `010` - 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `020` = `020` - 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `030` = `030` - 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `040` = `040` - 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `050` = `050` - 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `060` = `060` - 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `070` = `070` - 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `080` = `080` - 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `090` = `090` - 1 WHERE `TAG` = '전체';
            END CASE;
		WHEN '1' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `100` = `100` - 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `110` = `110` - 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `120` = `120` - 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `130` = `130` - 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `140` = `140` - 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `150` = `150` - 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `160` = `160` - 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `170` = `170` - 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `180` = `180` - 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `190` = `190` - 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '2' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `200` = `200` - 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `210` = `210` - 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `220` = `220` - 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `230` = `230` - 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `240` = `240` - 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `250` = `250` - 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `260` = `260` - 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `270` = `270` - 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `280` = `280` - 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `290` = `290` - 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '3' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `300` = `300` - 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `310` = `310` - 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `320` = `320` - 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `330` = `330` - 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `340` = `340` - 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `350` = `350` - 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `360` = `360` - 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `370` = `370` - 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `380` = `380` - 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `390` = `390` - 1 WHERE `TAG` = '전체';
            END CASE;
		WHEN '4' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `400` = `400` - 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `410` = `410` - 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `420` = `420` - 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `430` = `430` - 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `440` = `440` - 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `450` = `450` - 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `460` = `460` - 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `470` = `470` - 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `480` = `480` - 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `490` = `490` - 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '5' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `500` = `500` - 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `510` = `510` - 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `520` = `520` - 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `530` = `530` - 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `540` = `540` - 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `550` = `550` - 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `560` = `560` - 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `570` = `570` - 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `580` = `580` - 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `590` = `590` - 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '6' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `600` = `600` - 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `610` = `610` - 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `620` = `620` - 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `630` = `630` - 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `640` = `640` - 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `650` = `650` - 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `660` = `660` - 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `670` = `670` - 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `680` = `680` - 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `690` = `690` - 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '7' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `700` = `700` - 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `710` = `710` - 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `720` = `720` - 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `730` = `730` - 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `740` = `740` - 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `750` = `750` - 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `760` = `760` - 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `770` = `770` - 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `780` = `780` - 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `790` = `790` - 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '8' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `800` = `800` - 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `810` = `810` - 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `820` = `820` - 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `830` = `830` - 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `840` = `840` - 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `850` = `850` - 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `860` = `860` - 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `870` = `870` - 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `880` = `880` - 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `890` = `890` - 1 WHERE `TAG` = '전체';
            END CASE;
        WHEN '9' THEN
            CASE middle_code
                WHEN '0' THEN UPDATE `hardcoding`.`middle_classification` SET `900` = `900` - 1 WHERE `TAG` = '전체';
                WHEN '1' THEN UPDATE `hardcoding`.`middle_classification` SET `910` = `910` - 1 WHERE `TAG` = '전체';
                WHEN '2' THEN UPDATE `hardcoding`.`middle_classification` SET `920` = `920` - 1 WHERE `TAG` = '전체';
                WHEN '3' THEN UPDATE `hardcoding`.`middle_classification` SET `930` = `930` - 1 WHERE `TAG` = '전체';
                WHEN '4' THEN UPDATE `hardcoding`.`middle_classification` SET `940` = `940` - 1 WHERE `TAG` = '전체';
                WHEN '5' THEN UPDATE `hardcoding`.`middle_classification` SET `950` = `950` - 1 WHERE `TAG` = '전체';
                WHEN '6' THEN UPDATE `hardcoding`.`middle_classification` SET `960` = `960` - 1 WHERE `TAG` = '전체';
                WHEN '7' THEN UPDATE `hardcoding`.`middle_classification` SET `970` = `970` - 1 WHERE `TAG` = '전체';
                WHEN '8' THEN UPDATE `hardcoding`.`middle_classification` SET `980` = `980` - 1 WHERE `TAG` = '전체';
                WHEN '9' THEN UPDATE `hardcoding`.`middle_classification` SET `990` = `990` - 1 WHERE `TAG` = '전체';
            END CASE;
    END CASE;
END$$

DELIMITER ;

SHOW WARNINGS;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`book_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE TRIGGER `hardcoding`.`book_AFTER_UPDATE`
AFTER UPDATE ON `book`
FOR EACH ROW
BEGIN
	CALL process_book_data(NEW.location, NEW.large_code, NEW.middle_code);
    CALL process_classification(OLD.location, OLD.large_code, OLD.middle_code);
    CALL update_timestamp('book');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE process_rent_data(
    IN rent_id VARCHAR(10),
    IN rent_date DATETIME
)
BEGIN
    DECLARE rent_year INT;
    DECLARE large_code_value CHAR(1);
    DECLARE year_value INT;
    DECLARE month_value INT;

    -- Extract the year from rent_date
    SET rent_year = YEAR(rent_date);

    -- Insert the ID into rent_count if it doesn't already exist
    INSERT IGNORE INTO `hardcoding`.`rent_count` (`ID`)
    VALUES (rent_id);

    -- Increment the corresponding year's column in rent_count using IF
    IF rent_year = 2004 THEN
        UPDATE `hardcoding`.`rent_count`
        SET `2004` = `2004` + 1
        WHERE `ID` = rent_id;
    ELSEIF rent_year = 2005 THEN
        UPDATE `hardcoding`.`rent_count`
        SET `2005` = `2005` + 1
        WHERE `ID` = rent_id;
    ELSEIF rent_year = 2006 THEN
        UPDATE `hardcoding`.`rent_count`
        SET `2006` = `2006` + 1
        WHERE `ID` = rent_id;
	ELSEIF rent_year = 2007 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2007` = `2007` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2008 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2008` = `2008` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2009 THEN
		UPDATE `hardcoding`.`rent_count`
        SET `2009` = `2009` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2010 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2010` = `2010` + 1
		WHERE `ID` = rent_id;
	ELSEIF rent_year = 2011 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2011` = `2011` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2012 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2012` = `2012` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2013 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2013` = `2013` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2014 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2014` = `2014` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2015 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2015` = `2015` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2016 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2016` = `2016` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2017 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2017` = `2017` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2018 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2018` = `2018` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2019 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2019` = `2019` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2020 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2020` = `2020` + 1
		WHERE `ID` = rent_id;
	ELSEIF rent_year = 2021 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2021` = `2021` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2022 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2022` = `2022` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2023 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2023` = `2023` + 1
		WHERE `ID` = rent_id;
    ELSEIF rent_year = 2024 THEN
		UPDATE `hardcoding`.`rent_count`
		SET `2024` = `2024` + 1
		WHERE `ID` = rent_id;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Year out of range.';
    END IF;

    -- Fetch large_code from the book table
    SELECT large_code INTO large_code_value
    FROM `hardcoding`.`book`
    WHERE ID = rent_id;
    
    -- Check if large_code_value is NULL
    IF large_code_value IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid rent_id or missing large_code.';
    END IF;

    -- Extract year and month from rent_date
    SET year_value = YEAR(rent_date);
    SET month_value = MONTH(rent_date);

    -- Update year_month_count_detail based on large_code using CASE
    -- Update year_month_count_detail based on large_code using IF
    IF large_code_value = '0' THEN
        UPDATE `hardcoding`.`year_month_count_detail`
        SET `000` = `000` + 1
        WHERE `year` = year_value AND `month` = month_value;
    ELSEIF large_code_value = '1' THEN
        UPDATE `hardcoding`.`year_month_count_detail`
        SET `100` = `100` + 1
        WHERE `year` = year_value AND `month` = month_value;
    ELSEIF large_code_value = '2' THEN
        UPDATE `hardcoding`.`year_month_count_detail`
        SET `200` = `200` + 1
        WHERE `year` = year_value AND `month` = month_value;
	ELSEIF large_code_value = '3' THEN
		UPDATE `hardcoding`.`year_month_count_detail`
		SET `300` = `300` + 1
		WHERE `year` = year_value AND `month` = month_value;
	ELSEIF large_code_value = '4' THEN
		UPDATE `hardcoding`.`year_month_count_detail`
		SET `400` = `400` + 1
		WHERE `year` = year_value AND `month` = month_value;
	ELSEIF large_code_value = '5' THEN
		UPDATE `hardcoding`.`year_month_count_detail`
		SET `500` = `500` + 1
		WHERE `year` = year_value AND `month` = month_value;
	ELSEIF large_code_value = '6' THEN
		UPDATE `hardcoding`.`year_month_count_detail`
		SET `600` = `600` + 1
		WHERE `year` = year_value AND `month` = month_value;
	ELSEIF large_code_value = '7' THEN
		UPDATE `hardcoding`.`year_month_count_detail`
		SET `700` = `700` + 1
		WHERE `year` = year_value AND `month` = month_value;
	ELSEIF large_code_value = '8' THEN
		UPDATE `hardcoding`.`year_month_count_detail`
		SET `800` = `800` + 1
		WHERE `year` = year_value AND `month` = month_value;
	ELSEIF large_code_value = '9' THEN
		UPDATE `hardcoding`.`year_month_count_detail`
		SET `900` = `900` + 1
		WHERE `year` = year_value AND `month` = month_value;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Invalid large_code value.';
    END IF;
END$$

DELIMITER ;


DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`rent_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding`$$

CREATE TRIGGER `hardcoding`.`rent_AFTER_INSERT`
AFTER INSERT ON `rent`
FOR EACH ROW
BEGIN
    CALL process_rent_data(NEW.ID, NEW.rent_date);
    INSERT INTO rent_info (rent_time, ID, title, author, publisher, DDC, location)
    SELECT NEW.rent_date, b.ID, b.title, b.author, b.publisher, b.DDC, b.location
    FROM book b
    WHERE b.ID = NEW.ID;
    CALL update_timestamp('rent');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`rent_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding`$$

CREATE TRIGGER `hardcoding`.`rent_AFTER_UPDATE`
AFTER UPDATE ON `rent`
FOR EACH ROW
BEGIN
    CALL update_timestamp('rent');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`year_month_count_detail_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE TRIGGER `hardcoding`.`year_month_count_detail_AFTER_INSERT`
AFTER INSERT ON `year_month_count_detail`
FOR EACH ROW
BEGIN
    CALL update_timestamp('year_month_count_detail');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`year_month_count_detail_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`year_month_count_detail_AFTER_UPDATE` AFTER UPDATE ON `year_month_count_detail` FOR EACH ROW
BEGIN
    UPDATE year_month_count
    SET `1` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400` + `500` + `600` + `700` + `800` + `900`)
        FROM year_month_count_detail
        WHERE `year` = NEW.year AND `month` = 1
    ),
    `2` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400` + `500` + `600` + `700` + `800` + `900`)
        FROM year_month_count_detail
        WHERE `year` = NEW.year AND `month` = 2
    ),
    `3` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400` + `500` + `600` + `700` + `800` + `900`)
        FROM year_month_count_detail
        WHERE `year` = NEW.year AND `month` = 3
    ),
    `4` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400` + `500` + `600` + `700` + `800` + `900`)
        FROM year_month_count_detail
        WHERE `year` = NEW.year AND `month` = 4
    ),
    `5` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400` + `500` + `600` + `700` + `800` + `900`)
        FROM year_month_count_detail
        WHERE `year` = NEW.year AND `month` = 5
    ),
    `6` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400` + `500` + `600` + `700` + `800` + `900`)
        FROM year_month_count_detail
        WHERE `year` = NEW.year AND `month` = 6
    ),
    `7` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400` + `500` + `600` + `700` + `800` + `900`)
        FROM year_month_count_detail
        WHERE `year` = NEW.year AND `month` = 7
    ),
    `8` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400` + `500` + `600` + `700` + `800` + `900`)
        FROM year_month_count_detail
        WHERE `year` = NEW.year AND `month` = 8
    ),
    `9` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400` + `500` + `600` + `700` + `800` + `900`)
        FROM year_month_count_detail
        WHERE `year` = NEW.year AND `month` = 9
    ),
    `10` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400` + `500` + `600` + `700` + `800` + `900`)
        FROM year_month_count_detail
        WHERE `year` = NEW.year AND `month` = 10
    ),
    `11` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400` + `500` + `600` + `700` + `800` + `900`)
        FROM year_month_count_detail
        WHERE `year` = NEW.year AND `month` = 11
    ),
    `12` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400` + `500` + `600` + `700` + `800` + `900`)
        FROM year_month_count_detail
        WHERE `year` = NEW.year AND `month` = 12
    )
    WHERE `year` = NEW.year;
    CALL update_timestamp('year_month_count_detail');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`year_month_count_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE TRIGGER `hardcoding`.`year_month_count_AFTER_INSERT`
AFTER INSERT ON `year_month_count`
FOR EACH ROW
BEGIN
    CALL update_timestamp('year_month_count');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`year_month_count_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE TRIGGER `hardcoding`.`year_month_count_AFTER_UPDATE`
AFTER UPDATE ON `year_month_count`
FOR EACH ROW
BEGIN
    CALL update_timestamp('year_month_count');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`rent_count_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`rent_count_AFTER_INSERT` AFTER INSERT ON `rent_count` FOR EACH ROW
BEGIN
	CALL update_timestamp('rent_count');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`rent_count_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`rent_count_AFTER_UPDATE` AFTER UPDATE ON `rent_count` FOR EACH ROW
BEGIN
	CALL update_timestamp('rent_count');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`recent_rent_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`recent_rent_AFTER_INSERT` AFTER INSERT ON `recent_rent` FOR EACH ROW
BEGIN
	CALL update_timestamp('recent_rent');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`recent_rent_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`recent_rent_AFTER_UPDATE` AFTER UPDATE ON `recent_rent` FOR EACH ROW
BEGIN
	CALL update_timestamp('recent_rent');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`ISBN_rent_count_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`ISBN_rent_count_AFTER_INSERT` AFTER INSERT ON `ISBN_rent_count` FOR EACH ROW
BEGIN
	CALL update_timestamp('ISBN_rent_count');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`ISBN_rent_count_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`ISBN_rent_count_AFTER_UPDATE` AFTER UPDATE ON `ISBN_rent_count` FOR EACH ROW
BEGIN
	CALL update_timestamp('ISBN_rent_count');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`None_ISBN_rent_count_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`None_ISBN_rent_count_AFTER_INSERT` AFTER INSERT ON `None_ISBN_rent_count` FOR EACH ROW
BEGIN
	CALL update_timestamp('None_ISBN_rent_count');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`None_ISBN_rent_count_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`None_ISBN_rent_count_AFTER_UPDATE` AFTER UPDATE ON `None_ISBN_rent_count` FOR EACH ROW
BEGIN
	CALL update_timestamp('None_ISBN_rent_count');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`large_classification_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`large_classification_AFTER_INSERT` AFTER INSERT ON `large_classification` FOR EACH ROW
BEGIN
	CALL update_timestamp('large_classification');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`large_classification_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`large_classification_AFTER_UPDATE` AFTER UPDATE ON `large_classification` FOR EACH ROW
BEGIN
	CALL update_timestamp('large_classification');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`middle_classification_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`middle_classification_AFTER_INSERT` AFTER INSERT ON `middle_classification` FOR EACH ROW
BEGIN
	CALL update_timestamp('middle_classification');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`middle_classification_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`middle_classification_AFTER_UPDATE` AFTER UPDATE ON `middle_classification` FOR EACH ROW
BEGIN
	CALL update_timestamp('middle_classification');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`rent_info_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`rent_info_AFTER_INSERT` AFTER INSERT ON `rent_info` FOR EACH ROW
BEGIN
	CALL update_timestamp('rent_info');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`rent_info_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`rent_info_AFTER_UPDATE` AFTER UPDATE ON `rent_info` FOR EACH ROW
BEGIN
	CALL update_timestamp('rent_info');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`DDC_ratio_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`DDC_ratio_AFTER_INSERT` AFTER INSERT ON `DDC_ratio` FOR EACH ROW
BEGIN
	CALL update_timestamp('DDC_ratio');
END$$

SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

USE `hardcoding`$$
DROP TRIGGER IF EXISTS `hardcoding`.`DDC_ratio_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `hardcoding`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hardcoding`.`DDC_ratio_AFTER_UPDATE` AFTER UPDATE ON `DDC_ratio` FOR EACH ROW
BEGIN
	CALL update_timestamp('book');
END$$

SHOW WARNINGS$$

DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
