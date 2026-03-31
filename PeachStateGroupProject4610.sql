-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mb_B6
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mb_B6
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mb_B6` DEFAULT CHARACTER SET utf8 ;
USE `mb_B6` ;

-- -----------------------------------------------------
-- Table `mb_B6`.`Primary Director`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Primary Director` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Primary Director` (
  `p_direct.id` INT NOT NULL,
  `p_direct.fname` VARCHAR(45) NULL,
  `p_direct.lname` VARCHAR(45) NULL,
  `p_direct.phone` VARCHAR(10) NULL,
  PRIMARY KEY (`p_direct.id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Submission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Submission` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Submission` (
  `sub.id` INT NOT NULL,
  `sub.name` VARCHAR(45) NULL,
  `sub.phone` VARCHAR(10) NULL,
  `sub.email` VARCHAR(45) NULL,
  PRIMARY KEY (`sub.id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Category` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Category` (
  `cat.code` INT NOT NULL,
  `cat.max_runtime` TIMESTAMP(6) NULL,
  `cat.subfee` DECIMAL(5,2) NULL,
  `cat.name` VARCHAR(45) NULL,
  PRIMARY KEY (`cat.code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Film`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Film` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Film` (
  `f.id` INT NOT NULL,
  `f.title` VARCHAR(45) NULL,
  `f.language` VARCHAR(45) NULL,
  `f.country` VARCHAR(20) NULL,
  `f.rating` INT NULL,
  `f.runtime` TIMESTAMP(6) NULL,
  `P_director.id` INT NOT NULL,
  `A_director.id` INT NOT NULL,
  `f.sub.id` INT NOT NULL,
  `f.cat.code` INT NOT NULL,
  `paired.film.id` INT NOT NULL,
  PRIMARY KEY (`f.id`, `P_director.id`, `A_director.id`, `f.sub.id`, `f.cat.code`),
  INDEX `fk_Film_Primary Director_idx` (`P_director.id` ASC) VISIBLE,
  INDEX `fk_Film_Primary Director1_idx` (`A_director.id` ASC) VISIBLE,
  INDEX `fk_Film_Submission1_idx` (`f.sub.id` ASC) VISIBLE,
  INDEX `fk_Film_Category1_idx` (`f.cat.code` ASC) VISIBLE,
  INDEX `fk_Film_Film1_idx` (`paired.film.id` ASC) VISIBLE,
  UNIQUE INDEX `f.id_UNIQUE` (`f.id` ASC) VISIBLE,
  CONSTRAINT `fk_Film_Primary Director`
    FOREIGN KEY (`P_director.id`)
    REFERENCES `mb_B6`.`Primary Director` (`p_direct.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Primary Director1`
    FOREIGN KEY (`A_director.id`)
    REFERENCES `mb_B6`.`Primary Director` (`p_direct.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Submission1`
    FOREIGN KEY (`f.sub.id`)
    REFERENCES `mb_B6`.`Submission` (`sub.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Category1`
    FOREIGN KEY (`f.cat.code`)
    REFERENCES `mb_B6`.`Category` (`cat.code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Film_Film1`
    FOREIGN KEY (`paired.film.id`)
    REFERENCES `mb_B6`.`Film` (`f.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Venue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Venue` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Venue` (
  `ven.id` INT NOT NULL,
  `ven.name` VARCHAR(45) NULL,
  `ven.address` VARCHAR(45) NULL,
  `ven.phone` VARCHAR(10) NULL,
  PRIMARY KEY (`ven.id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Screening`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Screening` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Screening` (
  `screen.id` INT NOT NULL,
  `screen.date` DATE NULL,
  `screen.starttime` TIME NULL,
  `Film_f.id` INT NOT NULL,
  `Film_P_director.id` INT NOT NULL,
  `Film_A_director.id` INT NOT NULL,
  `Film_f.sub.id` INT NOT NULL,
  `Film_f.cat.code` INT NOT NULL,
  `Film_f.id1` INT NOT NULL,
  `Film_P_director.id1` INT NOT NULL,
  `Film_A_director.id1` INT NOT NULL,
  `Film_f.sub.id1` INT NOT NULL,
  `Film_f.cat.code1` INT NOT NULL,
  PRIMARY KEY (`screen.id`, `Film_f.id`, `Film_P_director.id`, `Film_A_director.id`, `Film_f.sub.id`, `Film_f.cat.code`),
  INDEX `fk_Screening_Film1_idx` (`Film_f.id1` ASC, `Film_P_director.id1` ASC, `Film_A_director.id1` ASC, `Film_f.sub.id1` ASC, `Film_f.cat.code1` ASC) VISIBLE,
  CONSTRAINT `fk_Screening_Film1`
    FOREIGN KEY (`Film_f.id1` , `Film_P_director.id1` , `Film_A_director.id1` , `Film_f.sub.id1` , `Film_f.cat.code1`)
    REFERENCES `mb_B6`.`Film` (`f.id` , `P_director.id` , `A_director.id` , `f.sub.id` , `f.cat.code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Customer` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Customer` (
  `cust.id` INT NOT NULL,
  `cust.name` VARCHAR(45) NULL,
  `cust.phone` VARCHAR(10) NULL,
  `cust.email` VARCHAR(45) NULL,
  PRIMARY KEY (`cust.id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Reservation/Tickets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Reservation/Tickets` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Reservation/Tickets` (
  `ticket.id` INT NOT NULL,
  `ticket.seats` INT NULL,
  `ticket.checkin` VARCHAR(45) NULL,
  `Customer_cust.id` INT NOT NULL,
  `Screening_screen.id` INT NOT NULL,
  `Screening_Film_f.id` INT NOT NULL,
  `Screening_Film_P_director.id` INT NOT NULL,
  `Screening_Film_A_director.id` INT NOT NULL,
  `Screening_Film_f.sub.id` INT NOT NULL,
  `Screening_Film_f.cat.code` INT NOT NULL,
  PRIMARY KEY (`ticket.id`, `Customer_cust.id`),
  INDEX `fk_Reservation/Tickets_Customer1_idx` (`Customer_cust.id` ASC) VISIBLE,
  INDEX `fk_Reservation/Tickets_Screening1_idx` (`Screening_screen.id` ASC, `Screening_Film_f.id` ASC, `Screening_Film_P_director.id` ASC, `Screening_Film_A_director.id` ASC, `Screening_Film_f.sub.id` ASC, `Screening_Film_f.cat.code` ASC) VISIBLE,
  CONSTRAINT `fk_Reservation/Tickets_Customer1`
    FOREIGN KEY (`Customer_cust.id`)
    REFERENCES `mb_B6`.`Customer` (`cust.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservation/Tickets_Screening1`
    FOREIGN KEY (`Screening_screen.id` , `Screening_Film_f.id` , `Screening_Film_P_director.id` , `Screening_Film_A_director.id` , `Screening_Film_f.sub.id` , `Screening_Film_f.cat.code`)
    REFERENCES `mb_B6`.`Screening` (`screen.id` , `Film_f.id` , `Film_P_director.id` , `Film_A_director.id` , `Film_f.sub.id` , `Film_f.cat.code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Staff/Voulenteer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Staff/Voulenteer` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Staff/Voulenteer` (
  `staff.id` INT NOT NULL,
  `staff.fname` VARCHAR(45) NULL,
  `staff.lname` VARCHAR(45) NULL,
  `staff.trained` VARCHAR(3) NULL,
  `staff.role` VARCHAR(45) NULL,
  PRIMARY KEY (`staff.id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Shift`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Shift` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Shift` (
  `shift.id` INT NOT NULL,
  `shift.date` DATE NULL,
  `shift.stime` TIME NULL,
  `shift.etime` TIME NULL,
  `Venue_ven.id` INT NOT NULL,
  PRIMARY KEY (`shift.id`, `Venue_ven.id`),
  INDEX `fk_Shift_Venue1_idx` (`Venue_ven.id` ASC) VISIBLE,
  CONSTRAINT `fk_Shift_Venue1`
    FOREIGN KEY (`Venue_ven.id`)
    REFERENCES `mb_B6`.`Venue` (`ven.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Screening Room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Screening Room` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Screening Room` (
  `Screening_screen.id` INT NOT NULL,
  `Screening_Film_f.id` INT NOT NULL,
  `Screening_Film_P_director.id` INT NOT NULL,
  `Screening_Film_A_director.id` INT NOT NULL,
  `Screening_Film_f.sub.id` INT NOT NULL,
  `Screening_Film_f.cat.code` INT NOT NULL,
  `Venue_ven.id` INT NOT NULL,
  `SR.max_runtime` TIME NULL,
  `SR.closedcaption` VARCHAR(3) NULL,
  `SR.adaaccess` VARCHAR(3) NULL,
  `SR.maxcap` VARCHAR(45) NULL,
  PRIMARY KEY (`Screening_screen.id`, `Venue_ven.id`),
  INDEX `fk_Screening_has_Venue_Venue1_idx` (`Venue_ven.id` ASC) VISIBLE,
  INDEX `fk_Screening_has_Venue_Screening1_idx` (`Screening_screen.id` ASC, `Screening_Film_f.id` ASC, `Screening_Film_P_director.id` ASC, `Screening_Film_A_director.id` ASC, `Screening_Film_f.sub.id` ASC, `Screening_Film_f.cat.code` ASC) VISIBLE,
  CONSTRAINT `fk_Screening_has_Venue_Screening1`
    FOREIGN KEY (`Screening_screen.id` , `Screening_Film_f.id` , `Screening_Film_P_director.id` , `Screening_Film_A_director.id` , `Screening_Film_f.sub.id` , `Screening_Film_f.cat.code`)
    REFERENCES `mb_B6`.`Screening` (`screen.id` , `Film_f.id` , `Film_P_director.id` , `Film_A_director.id` , `Film_f.sub.id` , `Film_f.cat.code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Screening_has_Venue_Venue1`
    FOREIGN KEY (`Venue_ven.id`)
    REFERENCES `mb_B6`.`Venue` (`ven.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Assignment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Assignment` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Assignment` (
  `assignment.shift.id` INT NOT NULL,
  `assignment.ven.id` INT NOT NULL,
  `assignment.staff.id` INT NOT NULL,
  `Assignment.checkin` VARCHAR(45) NULL,
  PRIMARY KEY (`assignment.shift.id`, `assignment.staff.id`, `assignment.ven.id`),
  INDEX `fk_Shift_has_Staff/Voulenteer_Staff/Voulenteer1_idx` (`assignment.staff.id` ASC) VISIBLE,
  INDEX `fk_Shift_has_Staff/Voulenteer_Shift1_idx` (`assignment.shift.id` ASC, `assignment.ven.id` ASC) VISIBLE,
  CONSTRAINT `fk_Shift_has_Staff/Voulenteer_Shift1`
    FOREIGN KEY (`assignment.shift.id` , `assignment.ven.id`)
    REFERENCES `mb_B6`.`Shift` (`shift.id` , `Venue_ven.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Shift_has_Staff/Voulenteer_Staff/Voulenteer1`
    FOREIGN KEY (`assignment.staff.id`)
    REFERENCES `mb_B6`.`Staff/Voulenteer` (`staff.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Vendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Vendor` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Vendor` (
  `ven.id` INT NOT NULL,
  `ven.name` VARCHAR(45) NULL,
  `ven.type` VARCHAR(45) NULL,
  `ven.phone` VARCHAR(10) NULL,
  PRIMARY KEY (`ven.id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Consession Transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Consession Transaction` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Consession Transaction` (
  `trans.id` INT NOT NULL,
  `trans.datetime` DATETIME NULL,
  `trans.total` DECIMAL(5) NULL,
  `Venue_ven.id` INT NOT NULL,
  PRIMARY KEY (`trans.id`),
  INDEX `fk_Consession Transaction_Venue1_idx` (`Venue_ven.id` ASC) VISIBLE,
  CONSTRAINT `fk_Consession Transaction_Venue1`
    FOREIGN KEY (`Venue_ven.id`)
    REFERENCES `mb_B6`.`Venue` (`ven.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Menu Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Menu Item` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Menu Item` (
  `menu.id` INT NOT NULL,
  `menu.name` VARCHAR(45) NULL,
  `menu.cost` DECIMAL(2) NULL,
  `menu.calorie` INT NULL,
  `Vendor_ven.id` INT NOT NULL,
  PRIMARY KEY (`menu.id`),
  INDEX `fk_Menu Item_Vendor1_idx` (`Vendor_ven.id` ASC) VISIBLE,
  CONSTRAINT `fk_Menu Item_Vendor1`
    FOREIGN KEY (`Vendor_ven.id`)
    REFERENCES `mb_B6`.`Vendor` (`ven.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Transaction Line Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Transaction Line Item` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Transaction Line Item` (
  `Consession Transaction_trans.id` INT NOT NULL,
  `Menu Item_menu.id` INT NOT NULL,
  `lineitem.quantity` INT NULL,
  `lineitem.custom` VARCHAR(45) NULL,
  PRIMARY KEY (`Consession Transaction_trans.id`, `Menu Item_menu.id`),
  INDEX `fk_Consession Transaction_has_Menu Item_Menu Item1_idx` (`Menu Item_menu.id` ASC) VISIBLE,
  INDEX `fk_Consession Transaction_has_Menu Item_Consession Transact_idx` (`Consession Transaction_trans.id` ASC) VISIBLE,
  CONSTRAINT `fk_Consession Transaction_has_Menu Item_Consession Transaction1`
    FOREIGN KEY (`Consession Transaction_trans.id`)
    REFERENCES `mb_B6`.`Consession Transaction` (`trans.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consession Transaction_has_Menu Item_Menu Item1`
    FOREIGN KEY (`Menu Item_menu.id`)
    REFERENCES `mb_B6`.`Menu Item` (`menu.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mb_B6`.`Award`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mb_B6`.`Award` ;

CREATE TABLE IF NOT EXISTS `mb_B6`.`Award` (
  `Award.id` INT NOT NULL,
  `award.name` VARCHAR(45) NULL,
  `award.prize` DECIMAL(2) NULL,
  `Film_f.id` INT NOT NULL,
  PRIMARY KEY (`Award.id`),
  INDEX `fk_Award_Film1_idx` (`Film_f.id` ASC) VISIBLE,
  CONSTRAINT `fk_Award_Film1`
    FOREIGN KEY (`Film_f.id`)
    REFERENCES `mb_B6`.`Film` (`f.id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
