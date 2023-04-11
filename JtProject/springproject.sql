SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Create the `flowers` database if it doesn't exist
--
CREATE DATABASE IF NOT EXISTS `flowers`;
USE `flowers`;

-- --------------------------------------------------------

-- Removed categories table

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(64) NOT NULL,
  `role` varchar(45) NOT NULL,
  `enabled` tinyint(4) DEFAULT NULL,
  `email` varchar(110) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `keywords` varchar(255) NOT NULL,
  `image` text NOT NULL,
  `price` int(11) NOT NULL,
  `rating` float NOT NULL,
  `ratingNum` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `products` (`name`, `description`, `keywords`, `image`, `price`, `rating`, `ratingNum`, `quantity`)
VALUES ('Red Rose', 'Beautiful red rose for your loved ones', 'rose, red, flower', 'red_rose.jpg', 5, 4.7, 150, 100)
,('White Lily', 'Elegant and fragrant white lily for special occasions', 'lily, white, flower', 'white_lily.jpg', 10, 4.2, 90, 50)
,('Sunflower', 'Energetic and radiant sunflower to brighten your day', 'sunflower, yellow, flower', 'sunflower.jpg', 7, 4.8, 200, 120)
,('Yellow Tulip', 'Bright and cheerful yellow tulip bouquet', 'tulip, yellow, flower', 'yellow_tulip.jpg', 8, 4.4, 120, 80);

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `fk_user_id` (`user_id`),
  KEY `fk_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add constraints
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

COMMIT;