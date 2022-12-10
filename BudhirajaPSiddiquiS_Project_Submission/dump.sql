CREATE DATABASE  IF NOT EXISTS `ecommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecommerce`;
-- MySQL dump 10.13  Distrib 8.0.30, for macos12 (x86_64)
--
-- Host: 127.0.0.1    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `street_address_1` varchar(64) NOT NULL,
  `street_address_2` varchar(55) DEFAULT NULL,
  `city` varchar(55) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zip` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`address_id`),
  KEY `address_fk_user` (`user_id`),
  CONSTRAINT `address_fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'75 land','huntington','boston','ma',2115,1),(2,'huntingon 350','','boston','ma',2115,2),(3,'clari street','','San Diego','CA',90011,3),(4,'Luxy aptmt','strong st.','San Diego','CA',95011,4),(5,'sea st.','500','Buffalo','NY',30004,2);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(64) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'electronics'),(2,'apparel'),(3,'home'),(4,'shoes'),(5,'accessories');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `consolidated_view`
--

DROP TABLE IF EXISTS `consolidated_view`;
/*!50001 DROP VIEW IF EXISTS `consolidated_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `consolidated_view` AS SELECT 
 1 AS `order_id`,
 1 AS `order_date`,
 1 AS `user_id`,
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `product_quantity`,
 1 AS `price`,
 1 AS `item_total`,
 1 AS `short_desc`,
 1 AS `category_id`,
 1 AS `category_name`,
 1 AS `supplier_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `order_product_details`
--

DROP TABLE IF EXISTS `order_product_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_product_details` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  KEY `order_fk_details` (`order_id`),
  KEY `product_fk_details` (`product_id`),
  CONSTRAINT `order_fk_details` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product_fk_details` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_product_details`
--

LOCK TABLES `order_product_details` WRITE;
/*!40000 ALTER TABLE `order_product_details` DISABLE KEYS */;
INSERT INTO `order_product_details` VALUES (1,7,2),(2,4,1),(2,5,1),(3,1,1),(3,2,1),(4,7,1),(4,2,1),(4,3,4);
/*!40000 ALTER TABLE `order_product_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `order_date` date NOT NULL,
  `total_price` float NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_fk_user` (`user_id`),
  CONSTRAINT `orders_fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2021-12-15',30,1),(2,'2022-10-24',120,2),(3,'2022-11-01',545,1),(4,'2022-10-24',120,4);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone`
--

DROP TABLE IF EXISTS `phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phone` (
  `phone_number` varchar(55) NOT NULL,
  `is_primary` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`phone_number`),
  KEY `phone_fk_user` (`user_id`),
  CONSTRAINT `phone_fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone`
--

LOCK TABLES `phone` WRITE;
/*!40000 ALTER TABLE `phone` DISABLE KEYS */;
INSERT INTO `phone` VALUES ('(269)542000',0,2),('(269)5450900',1,1),('5695009400',0,3),('6584247300',1,2),('737-813-0400',1,4);
/*!40000 ALTER TABLE `phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `category_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `price` float NOT NULL,
  `weight` float DEFAULT NULL,
  `short_desc` varchar(255) NOT NULL,
  `long_desc` varchar(10000) DEFAULT NULL,
  `image_url` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `product_fk_category` (`category_id`),
  KEY `product_fk_supplier` (`supplier_id`),
  CONSTRAINT `product_fk_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product_fk_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Galaxy 31 pro',1,2,500,5.5,'phone from galaxy','',''),(2,'cotton sweater',2,2,45,NULL,'cable knit pattern','','z.com/jpg'),(3,'usb adapter',1,1,20,NULL,'type c adapter','','electric.com/jpg'),(4,'sports shoes',4,2,60,NULL,'running shoes','perfectly stitched with flexible insole',''),(5,'Nike sports shoes',4,3,60,NULL,'running shoes','weather resistant and perfect for jogging in any weather',NULL),(6,'Formal shoes',4,3,90,NULL,'formal shoes',NULL,NULL),(7,'ear rings gold',5,3,15,2.3,'jewellary for ears',NULL,'');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(45) NOT NULL,
  `contact_first_name` varchar(64) NOT NULL,
  `contact_last_name` varchar(64) DEFAULT NULL,
  `contact_title` varchar(55) NOT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Z-electronics','Alex','Scott','CEO'),(2,'Genpa','Jeff','Gates','Manager'),(3,'xtra shoes and apparel','Sid','Chakra','COO');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(256) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Alex Sid','s@gmail.com','amber'),(2,'John','j@gmail.com','1234'),(3,'Bruce Wayne','bw@gmail.com','batman'),(4,'Clark Kent','ck@gmail.com','superman');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ecommerce'
--

--
-- Dumping routines for database 'ecommerce'
--
/*!50003 DROP PROCEDURE IF EXISTS `priceRangeFilter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `priceRangeFilter`(IN start_r INT, IN end_r INT)
BEGIN
DECLARE row_not_found INT;
DECLARE product_id INT; 
DECLARE product_price, product_weight FLOAT;
DECLARE product_name VARCHAR(50);
DECLARE product_category INT;


DECLARE product_cursor CURSOR FOR 
    select p.product_id, p.name, p.price, p.weight, p.category_id
    from ecommerce.product p
    where p.price >= start_r and p.price <= end_r;
DECLARE CONTINUE HANDLER FOR NOT FOUND
    set row_not_found = TRUE;
set row_not_found = FALSE;
OPEN product_cursor;
WHILE row_not_found = false DO
    FETCH product_cursor into product_id, product_name, product_price, product_weight, product_category;
    select product_id, product_name, product_price, product_weight, product_category;
END WHILE;
CLOSE product_cursor;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `consolidated_view`
--

/*!50001 DROP VIEW IF EXISTS `consolidated_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `consolidated_view` AS select `o`.`order_id` AS `order_id`,`o`.`order_date` AS `order_date`,`o`.`user_id` AS `user_id`,`a`.`product_id` AS `product_id`,`p`.`name` AS `product_name`,`a`.`quantity` AS `product_quantity`,`p`.`price` AS `price`,(`p`.`price` * `a`.`quantity`) AS `item_total`,`p`.`short_desc` AS `short_desc`,`p`.`category_id` AS `category_id`,`c`.`category_name` AS `category_name`,`s`.`company_name` AS `supplier_name` from ((((`orders` `o` join `order_product_details` `a` on((`o`.`order_id` = `a`.`order_id`))) join `product` `p` on((`a`.`product_id` = `p`.`product_id`))) join `category` `c` on((`p`.`category_id` = `c`.`category_id`))) join `supplier` `s` on((`p`.`supplier_id` = `s`.`supplier_id`))) order by `o`.`order_id`,`o`.`user_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-09 22:52:13
