-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lautaro-notes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lautaro-notes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lautaro-notes` DEFAULT CHARACTER SET utf8 ;
USE `lautaro-notes` ;

-- -----------------------------------------------------
-- Table `lautaro-notes`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lautaro-notes`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lautaro-notes`.`notas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lautaro-notes`.`notas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `fecha-de-creacion` DATE NOT NULL,
  `fecha-de-modificacion` DATE NULL,
  `descripcion` TEXT NOT NULL,
  `borrable` TINYINT NOT NULL DEFAULT 0,
  `usuario-id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_notas_usuarios`
    FOREIGN KEY (`usuario-id`)
    REFERENCES `lautaro-notes`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lautaro-notes`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lautaro-notes`.`categorias` (
  `id` INT NOT NULL,
  `notas-id` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lautaro-notes`.`subcategorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lautaro-notes`.`subcategorias` (
  `id` INT NOT NULL,
  `cagtegoria-id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `sk:subCategorias_categorias_idx` (`cagtegoria-id` ASC) VISIBLE,
  CONSTRAINT `sk:subCategorias_categorias`
    FOREIGN KEY (`cagtegoria-id`)
    REFERENCES `lautaro-notes`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lautaro-notes`.`notas_categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lautaro-notes`.`notas_categorias` (
  `id` INT NOT NULL,
  `nota_id` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_notasCategorias_notas_idx` (`nota_id` ASC) VISIBLE,
  INDEX `fk:notasCategorias_categorias_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_notasCategorias_notas`
    FOREIGN KEY (`nota_id`)
    REFERENCES `lautaro-notes`.`notas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk:notasCategorias_categorias`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `lautaro-notes`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
