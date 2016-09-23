/*
MySQL Data Transfer
Source Host: localhost
Source Database: db_departamentos
Target Host: localhost
Target Database: db_departamentos
Date: 23-09-2016 18:23:35
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for ta_unidad
-- ----------------------------
CREATE TABLE `ta_unidad` (
  `id_unidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_unidad` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_unidad`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Table structure for ta_unidad_activa
-- ----------------------------
CREATE TABLE `ta_unidad_activa` (
  `id_unidad_activa` int(11) NOT NULL AUTO_INCREMENT,
  `id_unidad` int(11) DEFAULT NULL,
  `nombre_unidad_activa` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha_desde_unidad_activa` date DEFAULT NULL,
  `fecha_hasta_unidad_activa` date DEFAULT NULL,
  `estado_unidad_activa` int(1) DEFAULT NULL,
  PRIMARY KEY (`id_unidad_activa`),
  KEY `FK_ta_unidad_activa` (`id_unidad`),
  CONSTRAINT `FK_ta_unidad_activa` FOREIGN KEY (`id_unidad`) REFERENCES `ta_unidad` (`id_unidad`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Table structure for ta_unidad_padre
-- ----------------------------
CREATE TABLE `ta_unidad_padre` (
  `id_unidad_padre` int(11) NOT NULL AUTO_INCREMENT,
  `id_unidad` int(11) DEFAULT NULL,
  `id_unidad_depende` int(11) DEFAULT NULL,
  `fecha_desde_unidad_padre` date DEFAULT NULL,
  `fecha_hasta_unidad_padre` date DEFAULT NULL,
  `estado_unidad_padre` int(1) DEFAULT NULL,
  PRIMARY KEY (`id_unidad_padre`),
  KEY `FK_ta_unidad_depende` (`id_unidad_depende`),
  KEY `FK_ta_unidad_padre` (`id_unidad`),
  CONSTRAINT `FK_ta_unidad_padre` FOREIGN KEY (`id_unidad`) REFERENCES `ta_unidad` (`id_unidad`),
  CONSTRAINT `FK_ta_unidad_depende` FOREIGN KEY (`id_unidad_depende`) REFERENCES `ta_unidad` (`id_unidad`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `ta_unidad` VALUES ('23', 'z');
INSERT INTO `ta_unidad` VALUES ('24', 'A');
INSERT INTO `ta_unidad` VALUES ('25', 'y');
INSERT INTO `ta_unidad` VALUES ('26', 'x');
INSERT INTO `ta_unidad` VALUES ('27', 'B');
INSERT INTO `ta_unidad_activa` VALUES ('21', '23', 'z', '2016-09-01', null, '1');
INSERT INTO `ta_unidad_activa` VALUES ('22', '24', 'A', '2015-01-01', '2015-01-31', '0');
INSERT INTO `ta_unidad_activa` VALUES ('23', '24', 'A2', '2015-02-02', null, '1');
INSERT INTO `ta_unidad_activa` VALUES ('24', '25', 'y', '2016-09-01', null, '1');
INSERT INTO `ta_unidad_activa` VALUES ('25', '26', 'x', '2016-09-01', null, '1');
INSERT INTO `ta_unidad_activa` VALUES ('26', '27', 'B', '2015-01-01', null, '1');
INSERT INTO `ta_unidad_padre` VALUES ('1', '23', '24', '2016-09-01', null, '1');
INSERT INTO `ta_unidad_padre` VALUES ('2', '25', '24', '2016-09-01', null, '1');
INSERT INTO `ta_unidad_padre` VALUES ('3', '26', '24', '2016-09-01', null, '1');
