-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- 1. 스키마 생성
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BBB` ;
CREATE SCHEMA IF NOT EXISTS `BBB` DEFAULT CHARACTER SET utf8mb4 ;
SHOW WARNINGS;
USE `BBB` ;

-- -----------------------------------------------------
-- 2. 테이블 생성 (book, rent, rent_count, ... )
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BBB`.`book` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`book` (
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
  `large_code` ENUM('0','1','2','3','4','5','6','7','8','9') NOT NULL,
  `middle_code` ENUM('0','1','2','3','4','5','6','7','8','9') NOT NULL,
  `jaum` VARCHAR(510) NULL,
  `bulli` VARCHAR(1530) NULL,
  `registration` DATE NOT NULL,
  `except` ENUM('0','1') NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

DROP TABLE IF EXISTS `BBB`.`rent` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`rent` (
  `ID` VARCHAR(10) NOT NULL,
  `rent_date` DATETIME NOT NULL
)
ENGINE = InnoDB;
SHOW WARNINGS;

DROP TABLE IF EXISTS `BBB`.`rent_count` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`rent_count` (
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
  UNIQUE INDEX `도서ID_UNIQUE` (`ID` ASC) VISIBLE
)
ENGINE = InnoDB;
SHOW WARNINGS;

DROP TABLE IF EXISTS `BBB`.`recent_rent` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`recent_rent` (
  `ID` VARCHAR(10) NOT NULL,
  `duration` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `도서ID_UNIQUE` (`ID` ASC) VISIBLE
)
ENGINE = InnoDB;
SHOW WARNINGS;

DROP TABLE IF EXISTS `BBB`.`ISBN_rent_count` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`ISBN_rent_count` (
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
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) VISIBLE
)
ENGINE = InnoDB;
SHOW WARNINGS;

DROP TABLE IF EXISTS `BBB`.`None_ISBN_rent_count` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`None_ISBN_rent_count` (
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
  UNIQUE INDEX `None_ISBN_UNIQUE` (`title`(191) ASC, `author` ASC, `publisher`(191) ASC) VISIBLE
)
ENGINE = InnoDB;
SHOW WARNINGS;

DROP TABLE IF EXISTS `BBB`.`large_classification` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`large_classification` (
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
  PRIMARY KEY (`TAG`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

DROP TABLE IF EXISTS `BBB`.`middle_classification` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`middle_classification` (
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
  PRIMARY KEY (`TAG`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

DROP TABLE IF EXISTS `BBB`.`year_month_count` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`year_month_count` (
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
  PRIMARY KEY (`year`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

DROP TABLE IF EXISTS `BBB`.`year_month_count_detail` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`year_month_count_detail` (
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
  PRIMARY KEY (`year`, `month`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

DROP TABLE IF EXISTS `BBB`.`rent_info` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`rent_info` (
  `rent_time` DATETIME NOT NULL,
  `ID` VARCHAR(10) NOT NULL,
  `title` VARCHAR(510) NOT NULL,
  `author` VARCHAR(160) NULL,
  `publisher` VARCHAR(220) NULL,
  `DDC` VARCHAR(20) NOT NULL,
  `location` VARCHAR(5) NOT NULL
)
ENGINE = InnoDB;
SHOW WARNINGS;

DROP TABLE IF EXISTS `BBB`.`DDC_ratio` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`DDC_ratio` (
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
  PRIMARY KEY (`TAG`)
)
ENGINE = InnoDB;
SHOW WARNINGS;

DROP TABLE IF EXISTS `BBB`.`timestamp` ;
SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `BBB`.`timestamp` (
  `table` VARCHAR(50) NOT NULL,
  `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`table`)
)
ENGINE = InnoDB;
SHOW WARNINGS;


USE `BBB`;

-- -----------------------------------------------------
-- 3. 기본 프로시저 / 함수들 (update_timestamp 등)
-- -----------------------------------------------------
DELIMITER $$

CREATE PROCEDURE update_timestamp(table_name VARCHAR(50))
BEGIN
    UPDATE `BBB`.`timestamp`
    SET `timestamp` = NOW()
    WHERE `table` = table_name;
END$$

DELIMITER ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- 4. 분류 정보 처리 프로시저 (process_book_data, process_classification)
-- -----------------------------------------------------
DELIMITER $$

CREATE PROCEDURE process_book_data(
    IN location VARCHAR(20),
    IN large_code CHAR(1),
    IN middle_code CHAR(1)
)
BEGIN
    DECLARE large_col VARCHAR(10);
    DECLARE middle_col VARCHAR(10);

    -- 1. 대분류/중분류 컬럼명 동적 생성
    SET large_col = CONCAT(large_code, '00');       -- 예) '3' -> '300'
    SET middle_col = CONCAT(large_code, middle_code, '0'); -- 예) '3','7' -> '370'

    -- 2. INSERT IGNORE로 TAG 미존재 시 자동 추가
    INSERT IGNORE INTO `BBB`.`large_classification` (TAG) VALUES (location);
    INSERT IGNORE INTO `BBB`.`middle_classification` (TAG) VALUES (location);
    INSERT IGNORE INTO `BBB`.`large_classification` (TAG) VALUES ('전체');
    INSERT IGNORE INTO `BBB`.`middle_classification` (TAG) VALUES ('전체');

    -- 3. large_classification 업데이트 (+1)
    SET @query_large = CONCAT(
        'UPDATE `BBB`.`large_classification` SET `',
         large_col, '` = `', large_col, '` + 1 WHERE `TAG` = "', location, '";'
    );
    PREPARE stmt FROM @query_large;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- 4. middle_classification 업데이트 (+1)
    SET @query_middle = CONCAT(
        'UPDATE `BBB`.`middle_classification` SET `',
        middle_col, '` = `', middle_col, '` + 1 WHERE `TAG` = "', location, '";'
    );
    PREPARE stmt2 FROM @query_middle;
    EXECUTE stmt2;
    DEALLOCATE PREPARE stmt2;

    -- 5. 전체(전체 TAG)도 함께 +1
    SET @query_large_total = CONCAT(
        'UPDATE `BBB`.`large_classification` SET `',
        large_col, '` = `', large_col, '` + 1 WHERE `TAG` = "전체";'
    );
    PREPARE stmt3 FROM @query_large_total;
    EXECUTE stmt3;
    DEALLOCATE PREPARE stmt3;

    SET @query_middle_total = CONCAT(
        'UPDATE `BBB`.`middle_classification` SET `',
        middle_col, '` = `', middle_col, '` + 1 WHERE `TAG` = "전체";'
    );
    PREPARE stmt4 FROM @query_middle_total;
    EXECUTE stmt4;
    DEALLOCATE PREPARE stmt4;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE process_classification(
    IN location VARCHAR(20),
    IN large_code CHAR(1),
    IN middle_code CHAR(1)
)
BEGIN
    DECLARE large_col VARCHAR(10);
    DECLARE middle_col VARCHAR(10);

    SET large_col = CONCAT(large_code, '00'); 
    SET middle_col = CONCAT(large_code, middle_code, '0');

    -- 각 테이블에서 -1 처리 (기존 값 제거)
    SET @query_large = CONCAT(
        'UPDATE `BBB`.`large_classification` SET `',
        large_col, '` = `', large_col, '` - 1 WHERE `TAG` = "', location, '";'
    );
    PREPARE stmt FROM @query_large;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET @query_middle = CONCAT(
        'UPDATE `BBB`.`middle_classification` SET `',
        middle_col, '` = `', middle_col, '` - 1 WHERE `TAG` = "', location, '";'
    );
    PREPARE stmt2 FROM @query_middle;
    EXECUTE stmt2;
    DEALLOCATE PREPARE stmt2;

    -- 전체(전체 TAG)도 -1
    SET @query_large_total = CONCAT(
        'UPDATE `BBB`.`large_classification` SET `',
        large_col, '` = `', large_col, '` - 1 WHERE `TAG` = "전체";'
    );
    PREPARE stmt3 FROM @query_large_total;
    EXECUTE stmt3;
    DEALLOCATE PREPARE stmt3;

    SET @query_middle_total = CONCAT(
        'UPDATE `BBB`.`middle_classification` SET `',
        middle_col, '` = `', middle_col, '` - 1 WHERE `TAG` = "전체";'
    );
    PREPARE stmt4 FROM @query_middle_total;
    EXECUTE stmt4;
    DEALLOCATE PREPARE stmt4;

END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- 5. book 테이블 처리 프로시저 (insert_book, update_book)
-- -----------------------------------------------------
DELIMITER $$

CREATE PROCEDURE insert_book(
    IN book_ID VARCHAR(10),
    IN registration_year INT UNSIGNED,
    IN registration_month INT UNSIGNED,
    IN get_course VARCHAR(10),
    IN DDC VARCHAR(20),
    IN ISBN VARCHAR(20),
    IN title VARCHAR(510),
    IN author VARCHAR(160),
    IN publisher VARCHAR(220),
    IN publication_year VARCHAR(60),
    IN location VARCHAR(5),
    IN large_code ENUM('0','1','2','3','4','5','6','7','8','9'),
    IN middle_code ENUM('0','1','2','3','4','5','6','7','8','9'),
    IN jaum VARCHAR(510),
    IN bulli VARCHAR(1530),
    IN registration DATE,
    IN `except` ENUM('0','1')
)
BEGIN
    -- 새 도서 INSERT
    INSERT INTO `BBB`.`book` 
    (`ID`, `registration_year`, `registration_month`, `get_course`, `DDC`, `ISBN`,
     `title`, `author`, `publisher`, `publication_year`, `location`,
     `large_code`, `middle_code`, `jaum`, `bulli`, `registration`, `except`)
    VALUES (
      book_ID, registration_year, registration_month, get_course, DDC, ISBN,
      title, author, publisher, publication_year, location,
      large_code, middle_code, jaum, bulli, registration, `except`
    );

    -- 분류 정보 갱신 및 timestamp
    CALL process_book_data(location, large_code, middle_code);
    CALL update_timestamp('book');
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE update_book(
    IN book_ID VARCHAR(10),
    IN new_registration_year INT UNSIGNED,
    IN new_registration_month INT UNSIGNED,
    IN new_get_course VARCHAR(10),
    IN new_DDC VARCHAR(20),
    IN new_ISBN VARCHAR(20),
    IN new_title VARCHAR(510),
    IN new_author VARCHAR(160),
    IN new_publisher VARCHAR(220),
    IN new_publication_year VARCHAR(60),
    IN new_location VARCHAR(5),
    IN new_large_code ENUM('0','1','2','3','4','5','6','7','8','9'),
    IN new_middle_code ENUM('0','1','2','3','4','5','6','7','8','9'),
    IN new_jaum VARCHAR(510),
    IN new_bulli VARCHAR(1530),
    IN new_registration DATE,
    IN `new_except` ENUM('0','1')
)
BEGIN
    DECLARE old_location VARCHAR(5);
    DECLARE old_large_code ENUM('0','1','2','3','4','5','6','7','8','9');
    DECLARE old_middle_code ENUM('0','1','2','3','4','5','6','7','8','9');

    -- 기존 데이터 조회
    SELECT location, large_code, middle_code
      INTO old_location, old_large_code, old_middle_code
      FROM `BBB`.`book`
   WHERE ID = book_ID;
     
    UPDATE `BBB`.`book`
        SET registration_year = new_registration_year, registration_month = new_registration_month, get_course = new_get_course, 
         DDC = new_DDC, ISBN = new_ISBN, title = new_title, author = new_author, publisher = new_publisher, 
         publication_year = new_publication_year, location = new_location, large_code = new_large_code, middle_code = new_middle_code, 
         jaum = new_jaum, bulli = new_bulli, registration = new_registration, `except` = `new_except`
        WHERE ID = book_ID; 
   

    -- (3) 기존 값과 다를 때만 UPDATE 실행
    IF (old_location != new_location
        OR old_large_code != new_large_code
        OR old_middle_code != new_middle_code) THEN
        
        -- 새 값 반영
        CALL process_book_data(new_location, new_large_code, new_middle_code);

        -- 이전 값 제거
        CALL process_classification(old_location, old_large_code, old_middle_code);
    END IF;
    
    CALL update_rent_full(book_ID, new_DDC, new_title, new_author, new_publisher, new_location);

    -- timestamp 갱신
    CALL update_timestamp('book');
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- 6. rent 테이블 처리 프로시저 (process_rent_data, insert_rent)
-- -----------------------------------------------------
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

    -- 연도 추출
    SET rent_year = YEAR(rent_date);

    -- rent_count에 ID가 없으면 생성
    INSERT IGNORE INTO `BBB`.`rent_count` (`ID`) VALUES (rent_id);

    -- rent_count에서 해당 연도 컬럼 +1
    SET @col = CAST(rent_year AS CHAR);
    SET @query = CONCAT(
      'UPDATE `BBB`.`rent_count` SET `',
      @col, '` = `', @col, '` + 1 WHERE `ID` = "', rent_id, '"'
    );
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- book 테이블에서 large_code 가져오기
    SELECT large_code INTO large_code_value
      FROM `BBB`.`book`
     WHERE ID = rent_id;

    -- large_code가 없는 경우 에러 발생
    IF large_code_value IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid rent_id or missing large_code.';
    END IF;

    -- year_month_count_detail에 반영
    SET year_value = YEAR(rent_date);
    SET month_value = MONTH(rent_date);
    
    -- year_month_count_detail에 (year_value, month_value)가 없으면 자동 삽입
   INSERT IGNORE INTO `BBB`.`year_month_count_detail` (year, month)
    SELECT rent_year, months.m
    FROM (
        SELECT 1 AS m
        UNION ALL SELECT 2
        UNION ALL SELECT 3
        UNION ALL SELECT 4
        UNION ALL SELECT 5
        UNION ALL SELECT 6
        UNION ALL SELECT 7
        UNION ALL SELECT 8
        UNION ALL SELECT 9
        UNION ALL SELECT 10
        UNION ALL SELECT 11
        UNION ALL SELECT 12
    ) AS months;

    SET @code_col = CONCAT(large_code_value, '00');  -- 예: '1' -> '100'
    SET @query2 = CONCAT(
      'UPDATE `BBB`.`year_month_count_detail` ',
      'SET `', @code_col, '` = `', @code_col, '` + 1 ',
      'WHERE `year` = ', year_value, ' AND `month` = ', month_value
    );
    PREPARE stmt2 FROM @query2;
    EXECUTE stmt2;
    DEALLOCATE PREPARE stmt2;

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE insert_rent(
    IN rent_ID VARCHAR(10),
    IN rent_date DATETIME
)
BEGIN
    -- 1) rent 테이블에 INSERT
    INSERT INTO `BBB`.`rent` (`ID`, `rent_date`)
    VALUES (rent_ID, rent_date);

    -- 2) 대여 정보 처리 (rent_count, year_month_count_detail)
    CALL process_rent_data(rent_ID, rent_date);

    -- 3) 연도별 통계( year_month_count ) 갱신
    CALL update_year_month_count(YEAR(rent_date));

    -- 4) rent_info 테이블에 정보 삽입 (insert_rent_full 호출)
    CALL insert_rent_full(rent_ID, rent_date);

    -- 5) rent 테이블 타임스탬프 갱신
    CALL update_timestamp('rent');
END$$

DELIMITER ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- 7. 기타: year_month_count_detail, rent_info, ... 업데이트용 트리거/프로시저
-- -----------------------------------------------------
DELIMITER $$

USE `BBB`$$
DROP TRIGGER IF EXISTS `BBB`.`rent_AFTER_UPDATE` $$
SHOW WARNINGS$$
USE `BBB`$$
CREATE TRIGGER `BBB`.`rent_AFTER_UPDATE`
AFTER UPDATE ON `rent`
FOR EACH ROW
BEGIN
    -- 단순히 rent 테이블에 UPDATE 시 timestamp만 갱신
    CALL update_timestamp('rent');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$
USE `BBB`$$
DROP TRIGGER IF EXISTS `BBB`.`year_month_count_detail_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `BBB`$$
CREATE TRIGGER `BBB`.`year_month_count_detail_AFTER_INSERT`
AFTER INSERT ON `year_month_count_detail`
FOR EACH ROW
BEGIN
    CALL update_timestamp('year_month_count_detail');
END$$
SHOW WARNINGS$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE update_year_month_count(IN year_value INT)
BEGIN
   -- 1️⃣ (year_value) 행이 없으면 자동 생성
    INSERT IGNORE INTO year_month_count (`year`)
    VALUES (year_value);
    
    UPDATE year_month_count
    SET `1` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400`
                  + `500` + `600` + `700` + `800` + `900`)
          FROM year_month_count_detail
         WHERE `year` = year_value AND `month` = 1
    ),
    `2` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400`
                  + `500` + `600` + `700` + `800` + `900`)
          FROM year_month_count_detail
         WHERE `year` = year_value AND `month` = 2
    ),
    `3` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400`
                  + `500` + `600` + `700` + `800` + `900`)
          FROM year_month_count_detail
         WHERE `year` = year_value AND `month` = 3
    ),
    `4` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400`
                  + `500` + `600` + `700` + `800` + `900`)
          FROM year_month_count_detail
         WHERE `year` = year_value AND `month` = 4
    ),
    `5` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400`
                  + `500` + `600` + `700` + `800` + `900`)
          FROM year_month_count_detail
         WHERE `year` = year_value AND `month` = 5
    ),
    `6` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400`
                  + `500` + `600` + `700` + `800` + `900`)
          FROM year_month_count_detail
         WHERE `year` = year_value AND `month` = 6
    ),
    `7` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400`
                  + `500` + `600` + `700` + `800` + `900`)
          FROM year_month_count_detail
         WHERE `year` = year_value AND `month` = 7
    ),
    `8` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400`
                  + `500` + `600` + `700` + `800` + `900`)
          FROM year_month_count_detail
         WHERE `year` = year_value AND `month` = 8
    ),
    `9` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400`
                  + `500` + `600` + `700` + `800` + `900`)
          FROM year_month_count_detail
         WHERE `year` = year_value AND `month` = 9
    ),
    `10` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400`
                  + `500` + `600` + `700` + `800` + `900`)
          FROM year_month_count_detail
         WHERE `year` = year_value AND `month` = 10
    ),
    `11` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400`
                  + `500` + `600` + `700` + `800` + `900`)
          FROM year_month_count_detail
         WHERE `year` = year_value AND `month` = 11
    ),
    `12` = (
        SELECT SUM(`000` + `100` + `200` + `300` + `400`
                  + `500` + `600` + `700` + `800` + `900`)
          FROM year_month_count_detail
         WHERE `year` = year_value AND `month` = 12
    )
    WHERE `year` = year_value;

    CALL update_timestamp('year_month_count_detail');
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE insert_rent_full(
    IN rent_ID VARCHAR(10),
    IN rent_date DATETIME
)
BEGIN
    -- rent_info 테이블에 정보 삽입
    INSERT INTO rent_info (rent_time, ID, title, author, publisher, DDC, location)
    SELECT rent_date, b.ID, b.title, b.author, b.publisher, b.DDC, b.location
    FROM book b
    WHERE b.ID = rent_ID;

    -- rent_info 테이블 타임스탬프 갱신
    CALL update_timestamp('rent_info');
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE update_rent_full(
    IN rent_ID VARCHAR(10),
    IN new_DDC VARCHAR(20),
    IN new_title VARCHAR(510),
    IN new_author VARCHAR(160),
    IN new_publisher VARCHAR(220),
    IN new_location VARCHAR(5)
)
BEGIN
   UPDATE rent_info SET DDC = new_DDC, title = new_title, author = new_author, publisher = new_publisher, location = new_location
    WHERE ID = rent_ID;

    -- rent_info 테이블 타임스탬프 갱신
    CALL update_timestamp('rent_info');
END$$

DELIMITER ;