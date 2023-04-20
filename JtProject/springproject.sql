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
DROP DATABASE if exists flowers;
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
  `address` text NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
INSERT INTO `users` (`user_id`, `username`, `password`, `role`, `enabled`, `email`) VALUES
(0, 'admin', '123', 'ROLE_ADMIN', 1, 'test@a.com');
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


INSERT INTO `products` (`name`, `description`, `keywords`, `image`, `price`, `rating`, `ratingNum`, `quantity`) VALUES ('Red Rose', 'Most of us are familiar with what the red rose means, having been used across cultures to represent love and romance for centuries.  The meaning of red roses is universally understood to be love and passion.', 'Red, rose, roses, love, anniversary, wedding, girlfriend', 'red_rose.jpg', 15, 5, 1, 10), ('White Rose', 'White roses symbolize purity, youthfulness, and innocence. Young love, eternal loyalty, and new beginnings are also commonly  tied to the meaning of white roses, making them a popular choice for weddings and romantic occasions.', 'White, rose, roses, love, anniversary, wedding, girlfriend, communion, baptism', 'white_rose.jpg', 16, 5, 1, 10), ('Allium', 'Allium symbolizes unity, good fortune, prosperity, humility, and patience—these blooms make the perfect gift to wish someone good luck on a new endeavor.', 'Allium, graduation, new, job, retirement, birth, baby', 'allium.jpg', 14, 5, 1, 10), ('Sunflower', 'Sunflowers symbolize loyalty and adoration thanks to the myth of Clytie and Apollo. And, because of their association with the sun, sunflowers are well-known for being a happy flower and the perfect bloom for a summer flower delivery to brighten someones mood!', 'Sunflower, Happy, get, well, graduation, anniversary, wedding', 'sunflower.jpg', 17, 5, 1, 10), ('Tulip', 'The most known meaning of tulips is perfect and deep love. As tulips are a classic flower that has been loved by many for centuries they have been attached with the meaning of love. Theyre ideal to give to someone who you have a deep, unconditional love for, whether its your partner, children, parents or siblings.', 'Tulip, Wedding, love, family, girlfriend, birth, parent, child, sibling', 'tulip.jpg', 15, 5, 1, 10), ('Peony', 'Generally symbolic of love, honor, happiness wealth, romance, and beauty, the peony is traditionally  given on special occasions as an expression of goodwill, best wishes, and joy.', 'Peony, Wedding, love, new, job,  anniversary, retirement', 'peony.jpg', 14, 5 ,1, 10 );
INSERT INTO `products` (`name`, `description`, `keywords`, `image`, `price`, `rating`, `ratingNum`, `quantity`) VALUES ('Lilac', 'Lilac, the color for which this flower is named, is a light purple that symbolizes a first love. Lilacs have one of the shortest  bloom times and only flower for three weeks at the beginning of spring.', 'Lilac, Wedding, love, girlfriend, anniversary', 'lilac.jpg', 14, 5, 1, 10), ('Hydrangea', 'The hydrangea represents gratitude, grace and beauty. It also radiates abundance because of the lavish number of  flowers and the generous round shape. Its colors symbolize love, harmony and peace.', 'Hydrangea, Wedding, love, girlfriend, anniversary, birth', 'hydrangea.jpg', 13, 5, 1, 10), ('Lily', 'The name lily comes from the Latin word for this type of flower, “lilium." The flowers represent purity, innocence and rebirth: in religious iconography,  they often represent the Virgin Mary, and are also often depicted at the Resurrection of Christ.', 'Lily, christianity, wedding, communion, confirmation',  'lily.jpg', 15, 5, 1, 10),  ('Dahlia', 'In the Victorian Era, when floriography (the language of flowers) was all the rage, dahlias were given as symbols of devotion, love, beauty and dignity.   These meanings still hold true in modern times.', 'Dahlia, Wedding, love, girlfriend, anniversary', 'dahlia.jpg', 17, 5, 1, 10),  ('Carnation', 'The carnation flower symbolizes Love, Captivation and Distinction… its no wonder that its so widely used and is the best alternative to rose bouquets.   It also makes a lovely addition to any bunch because of its long-lasting freshness and fragrance', 'Carnation, Wedding, love, girlfriend, anniversary, remembrance, funeral',  'carnation.jpg', 16, 5, 1,10),  ('Orchid', 'The flower symbolism associated with the orchid is love, beauty, refinement, many children, thoughtfulness and mature charm. Orchids have become a major market   throughout the world.','Orchid, Family, love, children, birth, baby, shower, mother', 'orchid.jpg', 14, 5, 1 , 10);
INSERT INTO `products` (`name`, `description`, `keywords`, `image`, `price`, `rating`, `ratingNum`, `quantity`) VALUES ('Daisy', 'The meaning of a daisy flower can be purity, innocence, new beginnings, joy and cheerfulness.  In the Victorian Era, daisies symbolised innocence, loyalty and an ability to keep things secret.', 'Daisy, purity, birth,  baby, shower, mother', 'daisy.jpg', 12,5,1,10), ('Babys Breath', 'Babys Breath has long been used as a symbol of purity, innocence, hope, and new beginnings.  For these reasons, it has been traditionally used in wedding bouquets and baby showers. In many cultures,  Babys Breath is given to new mothers for good luck, which is how this flower got its name.', 
 'Baby, baby’s, breath, wedding, shower, mother', 'babys_breath.jpg', 9, 5 , 1, 10), 
 ('Chrysanthemum', 'In the United States, chrysanthemums symbolize friendship, happiness,
 and well-being.  They are often tied to the arrival of autumn since they are one of the most popular fall flowers.', 
 'Chrysanthemum, friendship, autumn', 'chrysanthemum.jpg', 13, 5 , 1, 10), ('Poppy', 'In classical times, poppy
 flowers symbolized sleep, peace, and death.  Poppies can therefore be a way of paying respect to someone 
 you love who has passed.',  'Poppy, poppies, funeral, death, remembrance', 'poppy.jpg', 14, 5, 1, 10), 
 ('Marigold', 'Early Christians had a tradition of placing flowers on Mary’s altar as an offering. 
 In fact, the use of marigolds as a symbol occurred in many cultures like Hindu, Buddhist, and Aztec. 
 Marigolds were often linked to the sun and represent power, strength, and light.', 'Marigold, christianity,
 offering,  sun, strength, yellow, orange', 'marigold.jpg', 15, 5, 1, 10),  ('Daffodil', 'The daffodil symbolises
 rebirth and new beginnings.   Its one of the first flowers to bloom at the end of winter, announcing the beginning of spring and signifying  the end of the cold, dark days.', 
 'Daffodil, daffodils, birth, mother, baby, shower, spring',  'daffodil.jpg', 10, 5, 1 , 10), 
 ('Snapdragon', 'The Snapdragon symbolizes grace and strength after its upright growing habitat 
 and harsh native habitat. They are also associated with deception.  Throughout history, these
 flowers were used to ward off evil and bad luck.', 'Snapdragon, snapdragons, luck, graduation, new, job', 
 'snapdragon.jpg', 11, 5, 1, 10),  ('Gladiolus', 'Generally, gladioli represent strength of character, faithfulness, 
 moral integrity, and remembrance.  Gladioli are actually the traditional 40th-anniversary flower and the birth flower
 for the month of August!',  'Gladioli, gladiolus, remembrance, death, funeral, August, anniversary', 'gladiolus.jpg',
 16, 5, 1, 10),  ('Iris', 'The most common meanings include hope, wisdom, trust and valor.   The iris has also been known
 to mean nobility as its been long associated with royalty all throughout history.',  'Iris, graduation, new, job, noble,
 wealth, wisdom', 'iris.jpg', 18, 5, 1, 10),  ('Gardenia', 'The gardenia is a flower that symbolizes 
 purity and gentleness.   Gardenia flowers symbolize everything related to pure attraction and the spiritual world.',
 'Gardenia, spiritual, wedding, baptism, confirmation, christianity', 'gardenia.jpg', 14, 5, 1, 10), 
 ('Delphinium', 'Delphiniums symbolize cheerfulness and goodwill, as well as a protective plant. 
 Delphiniums are used to communicate encouragement and joy, as well as remembering loved ones who have passed.', 
 'Delphinium, funeral, death, remembrance', 'delphinium.jpg', 16, 5, 1, 10), 
 ('Camellia', 'Camellia flowers are often seen as a symbol of love, adoration, and longing. Dont hesitate to give them to people you love,  no matter if your affection is romantic or platonic.', 'Camellia, love, wedding, birthday, friend, family, anniversary',  'camellia.jpg', 16, 5, 1, 10),  ('Begonia', 'The begonia stands for caution and consideration, as well as good communication between different parties.  It is commonly given as a gift when paying back a favour.', 'Begonia, thank, you, thanks, gratitude, friend',  'begonia.jpg', 15, 5, 1, 10), 
 ('Azalea', 'The lovely Azaleas represent beauty and femininity. This connotation makes the flowers an ideal gift for someone close to you, such as a mother or wife. Many cultures associate the azalea flower with a womans gentleness and femininity.'
 , 'Azalea, feminine, femininity, wedding, wife, mother, girlfriend', 'azalea.jpg',  17, 5,1, 10),
 ('Aster', 'Named after the Greek word for "Star" due to its blooms resembling a star, Asters symbolize love, wisdom, faith, and color. This flower became a symbol of love when in Greek mythology it was placed on the altars for the gods.',
 'Aster, offering, love, graduation, new, job', 'aster.jpg', 15, 5, 1, 10),
 ('Freesia', 'Botanist Christian P. Ecklon decided to name the bloom after his friend, Dr. Freese as a symbol of their friendship. 
 This is also why the flowers main meaning is now trust and friendship.', 'Freesia, friendship, love, trust', 'freesia.jpg', 16,5, 1, 10),
 ('Hyacinth', 'Purple hyacinths are generally used to symbolize royalty and spirituality. Because hyacinths can also symbolize sorrow and occasionally forgiveness, a purple hyacinth is a good flower to give someone who not only 
 deserves your respect but your gratitude, too.', 'Hyacinth, gratitude, thank, you, love, sorry, apology', 'hyacinth.jpg', 16, 5, 1, 10);

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
  
-- Add table `order_history`
CREATE TABLE `order_history` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `rating` int(11) NOT NULL DEFAULT 5,
  `rated` boolean NOT NULL DEFAULT false,
 
  
  
  PRIMARY KEY (`order_id`),
  KEY `fk_order_user_id` (`user_id`),
  KEY `fk_order_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add constraints
ALTER TABLE `order_history`
  ADD CONSTRAINT `fk_order_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_order_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

COMMIT;