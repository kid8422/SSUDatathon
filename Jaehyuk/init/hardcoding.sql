-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hardcoding
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hardcoding
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `hardcoding`;
CREATE SCHEMA IF NOT EXISTS `hardcoding` DEFAULT CHARACTER SET euckr ;
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
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `book_id_UNIQUE` (`ID` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`rent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`rent` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`rent` (
  `ID` VARCHAR(10) NOT NULL,
  `rent_date` DATE NOT NULL,
  `TAG` VARCHAR(5) NULL DEFAULT NULL)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`rent_count`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`rent_count` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`rent_count` (
  `ID` VARCHAR(10) NOT NULL,
  `2004` INT ZEROFILL UNSIGNED NULL,
  `2005` INT UNSIGNED ZEROFILL NULL,
  `2006` INT UNSIGNED ZEROFILL NULL,
  `2007` INT UNSIGNED ZEROFILL NULL,
  `2008` INT UNSIGNED ZEROFILL NULL,
  `2009` INT UNSIGNED ZEROFILL NULL,
  `2010` INT UNSIGNED ZEROFILL NULL,
  `2011` INT UNSIGNED ZEROFILL NULL,
  `2012` INT UNSIGNED ZEROFILL NULL,
  `2013` INT UNSIGNED ZEROFILL NULL,
  `2014` INT UNSIGNED ZEROFILL NULL,
  `2015` INT UNSIGNED ZEROFILL NULL,
  `2016` INT UNSIGNED ZEROFILL NULL,
  `2017` INT UNSIGNED ZEROFILL NULL,
  `2018` INT UNSIGNED ZEROFILL NULL,
  `2019` INT UNSIGNED ZEROFILL NULL,
  `2020` INT UNSIGNED ZEROFILL NULL,
  `2021` INT UNSIGNED ZEROFILL NULL,
  `2022` INT ZEROFILL UNSIGNED NULL,
  `2023` INT UNSIGNED ZEROFILL NULL,
  `2024` INT UNSIGNED ZEROFILL NULL,
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
  `rent_count` INT UNSIGNED ZEROFILL NULL,
  `book_count` INT UNSIGNED ZEROFILL NULL,
  PRIMARY KEY (`ISBN`),
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) VISIBLE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `hardcoding`.`DDC_count`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hardcoding`.`DDC_count` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `hardcoding`.`DDC_count` (
  `0` INT UNSIGNED ZEROFILL NOT NULL,
  `100` INT UNSIGNED ZEROFILL NOT NULL,
  `200` INT UNSIGNED ZEROFILL NOT NULL,
  `300` INT UNSIGNED ZEROFILL NOT NULL,
  `400` INT UNSIGNED ZEROFILL NOT NULL,
  `500` INT ZEROFILL UNSIGNED NOT NULL,
  `600` INT UNSIGNED ZEROFILL NOT NULL,
  `700` INT ZEROFILL UNSIGNED NOT NULL,
  `800` INT UNSIGNED ZEROFILL NOT NULL,
  `900` INT ZEROFILL UNSIGNED NOT NULL)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
