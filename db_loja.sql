-- MySQL Script generated by MySQL Workbench
-- Tue Apr 12 18:52:32 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `db_loja` DEFAULT CHARACTER SET utf8 ;
USE `db_loja`;



CREATE TABLE `pessoa` (
  `id` int(11) NOT NULL,
  `nome` varchar(90) NOT NULL,
  `email` varchar(100) NOT NULL,
  `celular` varchar(20) NOT NULL,
  `cidade` varchar(85) NOT NULL,
  `data_nascimento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `tb_usuarios`;

INSERT INTO `pessoa` (`id`, `nome`, `email`, `celular`, `cidade`, `data_nascimento`) VALUES
(2, 'Ana Julia', 'ana@id.com.br', '99993333', 'Marialva', '2021-10-07'),
(3, 'Marilene Camargo', 'mari@pr.gov.br', '99991111', 'Maringá', '2021-10-05');

ALTER TABLE `pessoa`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `pessoa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;



CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `login` varchar(55) NOT NULL,
  `senha` varchar(55) NOT NULL,
  `tipo` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `usuario` (`id`, `login`, `senha`, `tipo`) VALUES
(1, 'teste', 'teste', 'Administrador');

ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;



DROP TABLE IF EXISTS `tb_endereco` ;

CREATE TABLE IF NOT EXISTS `tb_endereco` (
  `idendereco` INT NOT NULL AUTO_INCREMENT,
  `endereco` VARCHAR(45) NULL,
  `complemento` VARCHAR(45) NULL,
  `cidade` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `tb_pessoas_idpessoa` INT NOT NULL,
  PRIMARY KEY (`idendereco`),
  CONSTRAINT `fk_tb_endereco_tb_pessoas1`
    FOREIGN KEY (`tb_pessoas_idpessoa`)
    REFERENCES `tb_pessoas` (`idpessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



DROP TABLE IF EXISTS `tb_produtos` ;

CREATE TABLE IF NOT EXISTS `tb_produtos` (
  `idprodutos` INT NOT NULL AUTO_INCREMENT,
  `produto` VARCHAR(45) NULL,
  `valor` VARCHAR(45) NULL,
  PRIMARY KEY (`idprodutos`))
ENGINE = InnoDB;



DROP TABLE IF EXISTS `tb_categoria` ;

CREATE TABLE IF NOT EXISTS `tb_categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;



DROP TABLE IF EXISTS `tb_status` ;

CREATE TABLE IF NOT EXISTS `tb_status` (
  `idstatus` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`idstatus`))
ENGINE = InnoDB;



DROP TABLE IF EXISTS `tb_carrinho` ;

CREATE TABLE IF NOT EXISTS `tb_carrinho` (
  `idcarrinho` INT NOT NULL AUTO_INCREMENT,
  `sessao` VARCHAR(45) NULL,
  `idusuario` INT NULL,
  `idendereco` INT NULL,
  `vl_frete` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idcarrinho`))
ENGINE = InnoDB;



DROP TABLE IF EXISTS `tb_pagamentos` ;

CREATE TABLE IF NOT EXISTS `tb_pagamentos` (
  `idpagamentos` INT NOT NULL AUTO_INCREMENT,
  `vl_total` DECIMAL(10,2) NULL,
  `idstatus` INT NOT NULL,
  `idusuario` INT NOT NULL,
  `idcarrinho` INT NOT NULL,
  PRIMARY KEY (`idpagamentos`),
  CONSTRAINT `fk_tb_pagamentos_tb_status1`
    FOREIGN KEY (`idstatus`)
    REFERENCES `tb_status` (`idstatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_pagamentos_tb_usuarios1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `tb_usuarios` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_pagamentos_tb_carrinho1`
    FOREIGN KEY (`idcarrinho`)
    REFERENCES `tb_carrinho` (`idcarrinho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



DROP TABLE IF EXISTS `tb_carrinho_produtos` ;

CREATE TABLE IF NOT EXISTS `tb_carrinho_produtos` (
  `idcarrinho_produtos` INT NOT NULL AUTO_INCREMENT,
  `idcarrinho` INT NOT NULL,
  `idprodutos` INT NOT NULL,
  PRIMARY KEY (`idcarrinho_produtos`),
  CONSTRAINT `fk_tb_carrinho_produtos_tb_carrinho1`
    FOREIGN KEY (`idcarrinho`)
    REFERENCES `tb_carrinho` (`idcarrinho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_carrinho_produtos_tb_produtos1`
    FOREIGN KEY (`idprodutos`)
    REFERENCES `tb_produtos` (`idprodutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



DROP TABLE IF EXISTS `tb_produtos_has_tb_categoria` ;

CREATE TABLE IF NOT EXISTS `tb_produtos_has_tb_categoria` (
  `tb_produtos_idprodutos` INT NOT NULL,
  `tb_categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`tb_produtos_idprodutos`, `tb_categoria_idcategoria`),
  CONSTRAINT `fk_tb_produtos_has_tb_categoria_tb_produtos1`
    FOREIGN KEY (`tb_produtos_idprodutos`)
    REFERENCES `tb_produtos` (`idprodutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_produtos_has_tb_categoria_tb_categoria1`
    FOREIGN KEY (`tb_categoria_idcategoria`)
    REFERENCES `tb_categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;