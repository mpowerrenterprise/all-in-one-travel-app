-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 31, 2024 at 04:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `all_in_one_travel`
--

-- --------------------------------------------------------

--
-- Table structure for table `book_hotels`
--

CREATE TABLE `book_hotels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `hotel_name` varchar(255) NOT NULL,
  `place` varchar(255) NOT NULL,
  `price_single` decimal(8,2) NOT NULL,
  `price_double` decimal(8,2) NOT NULL,
  `price_family` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `book_hotels`
--

INSERT INTO `book_hotels` (`id`, `hotel_name`, `place`, `price_single`, `price_double`, `price_family`, `created_at`, `updated_at`) VALUES
(1, 'Ocean View Colombo', 'Colombo', 10000.00, 15000.00, 25000.00, NULL, NULL),
(2, 'City Lodge', 'Colombo', 9500.00, 14000.00, 22000.00, NULL, NULL),
(3, 'Grand Colombo Hotel', 'Colombo', 11000.00, 16000.00, 27000.00, NULL, NULL),
(4, 'Palm Court Inn', 'Gampaha', 8500.00, 13000.00, 21000.00, NULL, NULL),
(5, 'Green Leaf Resort', 'Gampaha', 9000.00, 13500.00, 22000.00, NULL, NULL),
(6, 'Hilltop Hotel', 'Gampaha', 8700.00, 12500.00, 20000.00, NULL, NULL),
(7, 'Kalutara Beachside', 'Kalutara', 10500.00, 15500.00, 26000.00, NULL, NULL),
(8, 'Riverfront Lodge', 'Kalutara', 9800.00, 14500.00, 24000.00, NULL, NULL),
(9, 'Golden Sands Resort', 'Kalutara', 10000.00, 15000.00, 25000.00, NULL, NULL),
(10, 'Mountain View Kandy', 'Kandy', 9200.00, 13800.00, 22500.00, NULL, NULL),
(11, 'Royal Retreat', 'Kandy', 9500.00, 14200.00, 23000.00, NULL, NULL),
(12, 'Lakewood Residence', 'Kandy', 9700.00, 14500.00, 23500.00, NULL, NULL),
(13, 'Forest Edge Resort', 'Matale', 8900.00, 13000.00, 21500.00, NULL, NULL),
(14, 'Matale Hillside Inn', 'Matale', 8500.00, 12500.00, 21000.00, NULL, NULL),
(15, 'Riverside Hotel', 'Matale', 8800.00, 12800.00, 21800.00, NULL, NULL),
(16, 'Alpine Lodge', 'Nuwara Eliya', 12000.00, 17500.00, 29000.00, NULL, NULL),
(17, 'Tea Garden Inn', 'Nuwara Eliya', 11500.00, 17000.00, 28000.00, NULL, NULL),
(18, 'Misty Peaks Hotel', 'Nuwara Eliya', 12500.00, 18000.00, 30000.00, NULL, NULL),
(19, 'Sea Breeze Resort', 'Galle', 10500.00, 15500.00, 26500.00, NULL, NULL),
(20, 'Fort Heritage Inn', 'Galle', 9800.00, 14500.00, 24000.00, NULL, NULL),
(21, 'Coral Bay Hotel', 'Galle', 10100.00, 14900.00, 24800.00, NULL, NULL),
(22, 'Sunset Lodge', 'Matara', 9200.00, 13800.00, 22500.00, NULL, NULL),
(23, 'Matara Paradise Inn', 'Matara', 9500.00, 14200.00, 23000.00, NULL, NULL),
(24, 'Bayfront Resort', 'Matara', 9700.00, 14500.00, 23500.00, NULL, NULL),
(25, 'Dune Resort', 'Hambantota', 8700.00, 12700.00, 21000.00, NULL, NULL),
(26, 'Safari Inn', 'Hambantota', 9000.00, 13000.00, 21500.00, NULL, NULL),
(27, 'Palm Breeze Hotel', 'Hambantota', 8500.00, 12500.00, 20500.00, NULL, NULL),
(28, 'Northern Star', 'Jaffna', 7800.00, 12000.00, 20000.00, NULL, NULL),
(29, 'Jaffna Heritage', 'Jaffna', 7500.00, 11500.00, 19500.00, NULL, NULL),
(30, 'Peninsula Lodge', 'Jaffna', 7700.00, 11800.00, 19800.00, NULL, NULL),
(31, 'Green Fields Resort', 'Kilinochchi', 7500.00, 11500.00, 19000.00, NULL, NULL),
(32, 'Kilinochchi Villa', 'Kilinochchi', 7200.00, 11000.00, 18500.00, NULL, NULL),
(33, 'Field View Inn', 'Kilinochchi', 7400.00, 11300.00, 18800.00, NULL, NULL),
(34, 'Island Breeze', 'Mannar', 8000.00, 12000.00, 21000.00, NULL, NULL),
(35, 'Bay View Hotel', 'Mannar', 7700.00, 11700.00, 20500.00, NULL, NULL),
(36, 'Mannar Pearl Inn', 'Mannar', 7900.00, 11800.00, 20800.00, NULL, NULL),
(37, 'Vavuniya Comfort Inn', 'Vavuniya', 8200.00, 12500.00, 21500.00, NULL, NULL),
(38, 'Northern Comfort', 'Vavuniya', 8500.00, 12800.00, 22000.00, NULL, NULL),
(39, 'City Stay', 'Vavuniya', 8000.00, 12200.00, 21000.00, NULL, NULL),
(40, 'Lagoon Lodge', 'Mullaitivu', 7800.00, 11800.00, 20000.00, NULL, NULL),
(41, 'Mullaitivu Bay Inn', 'Mullaitivu', 7500.00, 11500.00, 19500.00, NULL, NULL),
(42, 'Coral View', 'Mullaitivu', 7700.00, 11800.00, 19800.00, NULL, NULL),
(43, 'East Coast Inn', 'Batticaloa', 8700.00, 12800.00, 21500.00, NULL, NULL),
(44, 'Lagoon Breeze', 'Batticaloa', 9000.00, 13200.00, 22000.00, NULL, NULL),
(45, 'Batticaloa Resort', 'Batticaloa', 8500.00, 12500.00, 21000.00, NULL, NULL),
(46, 'Ampara Lodge', 'Ampara', 8200.00, 12500.00, 21500.00, NULL, NULL),
(47, 'Sunrise Inn', 'Ampara', 8500.00, 12800.00, 22000.00, NULL, NULL),
(48, 'Eastern Comfort', 'Ampara', 8000.00, 12200.00, 21000.00, NULL, NULL),
(49, 'Trinco Beachside', 'Trincomalee', 10000.00, 15000.00, 25000.00, NULL, NULL),
(50, 'Blue Bay Resort', 'Trincomalee', 10500.00, 15500.00, 26000.00, NULL, NULL),
(51, 'Coral Reef Inn', 'Trincomalee', 10200.00, 15200.00, 25500.00, NULL, NULL),
(52, 'Forest Retreat', 'Kurunegala', 8600.00, 12700.00, 21500.00, NULL, NULL),
(53, 'City Inn', 'Kurunegala', 8200.00, 12400.00, 21000.00, NULL, NULL),
(54, 'Kurunegala Comfort', 'Kurunegala', 8500.00, 12500.00, 21200.00, NULL, NULL),
(55, 'Palm Grove Resort', 'Puttalam', 9200.00, 13800.00, 22500.00, NULL, NULL),
(56, 'Seaside Lodge', 'Puttalam', 9500.00, 14200.00, 23000.00, NULL, NULL),
(57, 'Blue Lagoon Inn', 'Puttalam', 9700.00, 14500.00, 23500.00, NULL, NULL),
(58, 'Sacred City Hotel', 'Anuradhapura', 8500.00, 12800.00, 21500.00, NULL, NULL),
(59, 'Lake View Resort', 'Anuradhapura', 9000.00, 13200.00, 22000.00, NULL, NULL),
(60, 'Heritage Inn', 'Anuradhapura', 8700.00, 12500.00, 21000.00, NULL, NULL),
(61, 'Ancient City Inn', 'Polonnaruwa', 8800.00, 13000.00, 21500.00, NULL, NULL),
(62, 'Ruins View Hotel', 'Polonnaruwa', 8500.00, 12500.00, 21000.00, NULL, NULL),
(63, 'Polonnaruwa Comfort', 'Polonnaruwa', 8700.00, 12800.00, 21500.00, NULL, NULL),
(64, 'Mountain Breeze', 'Badulla', 9200.00, 13800.00, 22500.00, NULL, NULL),
(65, 'Tea Valley Resort', 'Badulla', 9500.00, 14200.00, 23000.00, NULL, NULL),
(66, 'Green Hills Inn', 'Badulla', 9300.00, 14000.00, 22800.00, NULL, NULL),
(67, 'Nature Inn', 'Monaragala', 8600.00, 12700.00, 21500.00, NULL, NULL),
(68, 'Hilltop Retreat', 'Monaragala', 8200.00, 12400.00, 21000.00, NULL, NULL),
(69, 'Monaragala Lodge', 'Monaragala', 8500.00, 12500.00, 21200.00, NULL, NULL),
(70, 'Gem City Hotel', 'Ratnapura', 10000.00, 15000.00, 25000.00, NULL, NULL),
(71, 'Mountain View Inn', 'Ratnapura', 9500.00, 14000.00, 23000.00, NULL, NULL),
(72, 'Rainforest Lodge', 'Ratnapura', 9700.00, 14500.00, 23500.00, NULL, NULL),
(73, 'Elephant Safari Inn', 'Kegalle', 10500.00, 15500.00, 26000.00, NULL, NULL),
(74, 'Kegalle Comfort', 'Kegalle', 9800.00, 14500.00, 24000.00, NULL, NULL),
(75, 'Forest View Lodge', 'Kegalle', 10100.00, 14900.00, 24800.00, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `book_hotels_data`
--

CREATE TABLE `book_hotels_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `hotel_id` bigint(20) UNSIGNED NOT NULL,
  `room_type` varchar(255) NOT NULL,
  `days` int(11) NOT NULL,
  `date` varchar(255) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `book_hotels_data`
--

INSERT INTO `book_hotels_data` (`id`, `user_id`, `hotel_id`, `room_type`, `days`, `date`, `total_price`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 'family', 3, '2024-10-31', 63000.00, '2024-10-30 16:04:09', '2024-10-30 16:04:09'),
(2, 1, 17, 'double', 7, '2024-12-25', 119000.00, '2024-10-30 16:09:02', '2024-10-30 16:09:02'),
(3, 1, 30, 'family', 7, '2025-01-16', 138600.00, '2024-10-30 16:11:34', '2024-10-30 16:11:34'),
(4, 1, 14, 'double', 4, '2024-10-31', 50000.00, '2024-10-30 16:32:31', '2024-10-30 16:32:31'),
(5, 1, 15, 'double', 3, '2024-12-19', 38400.00, '2024-10-30 16:36:03', '2024-10-30 16:36:03'),
(6, 1, 17, 'double', 3, '2024-12-06', 51000.00, '2024-10-30 16:39:35', '2024-10-30 16:39:35'),
(7, 1, 11, 'double', 6, '2024-11-22', 85200.00, '2024-10-30 16:44:38', '2024-10-30 16:44:38'),
(8, 1, 14, 'double', 4, '2024-12-19', 50000.00, '2024-10-30 16:49:16', '2024-10-30 16:49:16'),
(9, 1, 17, 'family', 5, '2024-10-31', 140000.00, '2024-10-30 16:53:01', '2024-10-30 16:53:01'),
(10, 4, 18, 'double', 3, '2024-10-31', 54000.00, '2024-10-30 17:17:41', '2024-10-30 17:17:41'),
(11, 4, 17, 'double', 6, '2024-10-31', 102000.00, '2024-10-31 02:40:53', '2024-10-31 02:40:53'),
(12, 4, 21, 'family', 2, '2024-11-14', 49600.00, '2024-10-31 06:02:19', '2024-10-31 06:02:19'),
(13, 4, 17, 'double', 3, '2024-10-31', 51000.00, '2024-10-31 06:25:29', '2024-10-31 06:25:29'),
(14, 4, 12, 'double', 1, '2024-10-31', 14500.00, '2024-10-31 06:29:39', '2024-10-31 06:29:39'),
(15, 4, 29, 'family', 3, '2024-10-31', 58500.00, '2024-10-31 10:13:39', '2024-10-31 10:13:39');

-- --------------------------------------------------------

--
-- Table structure for table `book_tickets`
--

CREATE TABLE `book_tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `place` varchar(255) NOT NULL,
  `ticket_name` varchar(255) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `book_tickets`
--

INSERT INTO `book_tickets` (`id`, `place`, `ticket_name`, `price`, `created_at`, `updated_at`) VALUES
(1, 'Colombo', 'Colombo National Museum Entry', 1200.00, NULL, NULL),
(2, 'Colombo', 'Dehiwala Zoo Entry', 1000.00, NULL, NULL),
(3, 'Colombo', 'Viharamahadevi Park Tour', 500.00, NULL, NULL),
(4, 'Colombo', 'Galle Face Green Food Festival', 1500.00, NULL, NULL),
(5, 'Colombo', 'Colombo City Sightseeing', 2000.00, NULL, NULL),
(6, 'Gampaha', 'Kelaniya Temple Entry', 600.00, NULL, NULL),
(7, 'Gampaha', 'Leisure World Water Park', 2500.00, NULL, NULL),
(8, 'Gampaha', 'Henarathgoda Botanical Garden', 800.00, NULL, NULL),
(9, 'Gampaha', 'Negombo Beach Water Sports', 3000.00, NULL, NULL),
(10, 'Gampaha', 'Adventure Zipline - Negombo', 2000.00, NULL, NULL),
(11, 'Kalutara', 'Kalutara Bodhiya', 400.00, NULL, NULL),
(12, 'Kalutara', 'Richmond Castle Tour', 700.00, NULL, NULL),
(13, 'Kalutara', 'Beruwala Lighthouse Tour', 1000.00, NULL, NULL),
(14, 'Kalutara', 'Thudugala Waterfall Hike', 800.00, NULL, NULL),
(15, 'Kalutara', 'Adventure Boat Ride - Bentota', 2500.00, NULL, NULL),
(16, 'Kandy', 'Temple of the Tooth', 1500.00, NULL, NULL),
(17, 'Kandy', 'Kandy Lake Boat Ride', 500.00, NULL, NULL),
(18, 'Kandy', 'Peradeniya Botanical Gardens', 1200.00, NULL, NULL),
(19, 'Kandy', 'Knuckles Mountain Hike', 3000.00, NULL, NULL),
(20, 'Kandy', 'Kandy Cultural Show', 2000.00, NULL, NULL),
(21, 'Matale', 'Aluvihare Rock Temple', 600.00, NULL, NULL),
(22, 'Matale', 'Sigiriya Rock Fortress', 3000.00, NULL, NULL),
(23, 'Matale', 'Dambulla Cave Temple', 1200.00, NULL, NULL),
(24, 'Matale', 'Riverston Adventure Tour', 2500.00, NULL, NULL),
(25, 'Matale', 'Hunnasgiriya Tea Estate Tour', 900.00, NULL, NULL),
(26, 'Nuwara Eliya', 'Horton Plains National Park', 2000.00, NULL, NULL),
(27, 'Nuwara Eliya', 'Hakgala Botanical Gardens', 800.00, NULL, NULL),
(28, 'Nuwara Eliya', 'Gregory Lake Boat Ride', 1000.00, NULL, NULL),
(29, 'Nuwara Eliya', 'Ambewela Farm Tour', 600.00, NULL, NULL),
(30, 'Nuwara Eliya', 'World\'s End Hike', 3000.00, NULL, NULL),
(31, 'Galle', 'Galle Fort Tour', 1200.00, NULL, NULL),
(32, 'Galle', 'Unawatuna Beach Scuba Diving', 4000.00, NULL, NULL),
(33, 'Galle', 'Rumassala Jungle Beach Hike', 800.00, NULL, NULL),
(34, 'Galle', 'Galle Maritime Museum Entry', 500.00, NULL, NULL),
(35, 'Galle', 'Whale Watching Mirissa', 5000.00, NULL, NULL),
(36, 'Matara', 'Matara Fort Tour', 700.00, NULL, NULL),
(37, 'Matara', 'Polhena Beach Snorkeling', 1500.00, NULL, NULL),
(38, 'Matara', 'Dondra Head Lighthouse', 500.00, NULL, NULL),
(39, 'Matara', 'Snake Farm Tour - Matara', 800.00, NULL, NULL),
(40, 'Matara', 'Weligama Surfing', 3000.00, NULL, NULL),
(41, 'Hambantota', 'Yala National Park Safari', 5000.00, NULL, NULL),
(42, 'Hambantota', 'Bundala National Park', 2500.00, NULL, NULL),
(43, 'Hambantota', 'Bird Watching - Weerawila', 1500.00, NULL, NULL),
(44, 'Hambantota', 'Hambantota Beach Horse Riding', 2000.00, NULL, NULL),
(45, 'Hambantota', 'Hot Air Balloon Ride', 7000.00, NULL, NULL),
(46, 'Jaffna', 'Nallur Kovil', 500.00, NULL, NULL),
(47, 'Jaffna', 'Jaffna Fort Tour', 1000.00, NULL, NULL),
(48, 'Jaffna', 'Casuarina Beach', 400.00, NULL, NULL),
(49, 'Jaffna', 'Point Pedro Lighthouse', 800.00, NULL, NULL),
(50, 'Jaffna', 'Kayts Island Boat Tour', 1500.00, NULL, NULL),
(51, 'Kilinochchi', 'Iranamadu Tank Safari', 1200.00, NULL, NULL),
(52, 'Kilinochchi', 'Kilinochchi War Memorial', 500.00, NULL, NULL),
(53, 'Kilinochchi', 'Kandavalai Lake Tour', 600.00, NULL, NULL),
(54, 'Kilinochchi', 'Elephant Pass Tour', 800.00, NULL, NULL),
(55, 'Kilinochchi', 'Nature Trek - Kilinochchi', 1000.00, NULL, NULL),
(56, 'Mannar', 'Mannar Fort Tour', 700.00, NULL, NULL),
(57, 'Mannar', 'Adams Bridge Visit', 1000.00, NULL, NULL),
(58, 'Mannar', 'Madhu Church Pilgrimage', 600.00, NULL, NULL),
(59, 'Mannar', 'Vankalai Bird Sanctuary', 900.00, NULL, NULL),
(60, 'Mannar', 'Mannar Beach Sand Dunes', 800.00, NULL, NULL),
(61, 'Vavuniya', 'Vavuniya Historical Museum', 400.00, NULL, NULL),
(62, 'Vavuniya', 'Northern Province Cultural Center', 500.00, NULL, NULL),
(63, 'Vavuniya', 'Asikulam Lake Trek', 700.00, NULL, NULL),
(64, 'Vavuniya', 'Omanthai Railway Tour', 500.00, NULL, NULL),
(65, 'Vavuniya', 'Forest Reserve Camping', 2000.00, NULL, NULL),
(66, 'Mullaitivu', 'Mullaitivu War Memorial', 600.00, NULL, NULL),
(67, 'Mullaitivu', 'Chundikulam National Park', 2500.00, NULL, NULL),
(68, 'Mullaitivu', 'Nanthi Kadal Lagoon', 700.00, NULL, NULL),
(69, 'Mullaitivu', 'Kokkilai Lagoon Fishing', 1000.00, NULL, NULL),
(70, 'Mullaitivu', 'Coastal Bike Tour', 1200.00, NULL, NULL),
(71, 'Batticaloa', 'Batticaloa Fort', 800.00, NULL, NULL),
(72, 'Batticaloa', 'Pasikudah Beach', 500.00, NULL, NULL),
(73, 'Batticaloa', 'Batticaloa Lighthouse', 300.00, NULL, NULL),
(74, 'Batticaloa', 'Kallady Bridge Tour', 400.00, NULL, NULL),
(75, 'Batticaloa', 'Lagoon Boat Tour', 1500.00, NULL, NULL),
(76, 'Ampara', 'Gal Oya National Park Safari', 3000.00, NULL, NULL),
(77, 'Ampara', 'Arugam Bay Surfing', 4000.00, NULL, NULL),
(78, 'Ampara', 'Okanda Temple', 500.00, NULL, NULL),
(79, 'Ampara', 'Kumana National Park', 2500.00, NULL, NULL),
(80, 'Ampara', 'Pottuvil Lagoon Safari', 1200.00, NULL, NULL),
(81, 'Trincomalee', 'Koneswaram Temple', 700.00, NULL, NULL),
(82, 'Trincomalee', 'Pigeon Island Snorkeling', 3500.00, NULL, NULL),
(83, 'Trincomalee', 'Nilaveli Beach', 400.00, NULL, NULL),
(84, 'Trincomalee', 'Marble Beach Entry', 300.00, NULL, NULL),
(85, 'Trincomalee', 'Fort Frederick', 600.00, NULL, NULL),
(86, 'Kurunegala', 'Athugala Rock Temple', 500.00, NULL, NULL),
(87, 'Kurunegala', 'Ridiyagama Safari Park', 1500.00, NULL, NULL),
(88, 'Kurunegala', 'Ibbagamuwa Spice Gardens', 400.00, NULL, NULL),
(89, 'Kurunegala', 'Kurunegala Lake', 200.00, NULL, NULL),
(90, 'Kurunegala', 'Ethagala Mountain Hike', 700.00, NULL, NULL),
(91, 'Puttalam', 'Kalpitiya Dolphin Watching', 4000.00, NULL, NULL),
(92, 'Puttalam', 'Wilpattu National Park', 3000.00, NULL, NULL),
(93, 'Puttalam', 'Munneswaram Temple', 600.00, NULL, NULL),
(94, 'Puttalam', 'Anawilundawa Bird Sanctuary', 1000.00, NULL, NULL),
(95, 'Puttalam', 'Kalpitiya Beach Adventure', 2500.00, NULL, NULL),
(96, 'Anuradhapura', 'Ruwanwelisaya Stupa', 1000.00, NULL, NULL),
(97, 'Anuradhapura', 'Jaya Sri Maha Bodhi', 700.00, NULL, NULL),
(98, 'Anuradhapura', 'Mihintale Rock', 800.00, NULL, NULL),
(99, 'Anuradhapura', 'Abhayagiri Monastery', 500.00, NULL, NULL),
(100, 'Anuradhapura', 'Isurumuniya Temple', 600.00, NULL, NULL),
(101, 'Polonnaruwa', 'Polonnaruwa Ancient City', 1500.00, NULL, NULL),
(102, 'Polonnaruwa', 'Gal Vihara Temple', 1200.00, NULL, NULL),
(103, 'Polonnaruwa', 'Parakrama Samudra Boat Ride', 600.00, NULL, NULL),
(104, 'Polonnaruwa', 'Minneriya National Park Safari', 3500.00, NULL, NULL),
(105, 'Polonnaruwa', 'Medirigiriya Temple', 800.00, NULL, NULL),
(106, 'Badulla', 'Dunhinda Falls Tour', 700.00, NULL, NULL),
(107, 'Badulla', 'Namunukula Mountain Hike', 1000.00, NULL, NULL),
(108, 'Badulla', 'Ella Rock', 1200.00, NULL, NULL),
(109, 'Badulla', 'Nine Arches Bridge Tour', 500.00, NULL, NULL),
(110, 'Badulla', 'Ravana Falls Tour', 400.00, NULL, NULL),
(111, 'Monaragala', 'Lahugala National Park', 1200.00, NULL, NULL),
(112, 'Monaragala', 'Yala East Safari', 3000.00, NULL, NULL),
(113, 'Monaragala', 'Biso Pokuna', 800.00, NULL, NULL),
(114, 'Monaragala', 'Buttala Ruins', 700.00, NULL, NULL),
(115, 'Monaragala', 'Maduru Oya Boat Safari', 2000.00, NULL, NULL),
(116, 'Ratnapura', 'Sinharaja Forest Trek', 2000.00, NULL, NULL),
(117, 'Ratnapura', 'Adam\'s Peak Pilgrimage', 2500.00, NULL, NULL),
(118, 'Ratnapura', 'Gem Museum Entry', 500.00, NULL, NULL),
(119, 'Ratnapura', 'Bopath Ella Falls', 400.00, NULL, NULL),
(120, 'Ratnapura', 'Pinnawala Elephant Safari', 1500.00, NULL, NULL),
(121, 'Kegalle', 'Pinnawala Elephant Orphanage', 2500.00, NULL, NULL),
(122, 'Kegalle', 'Kitulgala White Water Rafting', 3000.00, NULL, NULL),
(123, 'Kegalle', 'Belilena Cave Tour', 700.00, NULL, NULL),
(124, 'Kegalle', 'Saradiel Village', 600.00, NULL, NULL),
(125, 'Kegalle', 'Kegalle Rubber Plantation Tour', 500.00, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `book_tickets_data`
--

CREATE TABLE `book_tickets_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `ticket_name` varchar(255) NOT NULL,
  `number_of_tickets` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `date` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `book_tickets_data`
--

INSERT INTO `book_tickets_data` (`id`, `user_id`, `ticket_name`, `number_of_tickets`, `total_price`, `date`, `created_at`, `updated_at`) VALUES
(1, 1, '2', 1, 500.00, '2024-10-31', '2024-10-31 05:56:54', '2024-10-31 05:56:54'),
(2, 1, '2', 1, 500.00, '2024-10-31', '2024-10-31 05:57:45', '2024-10-31 05:57:45'),
(3, 1, '2', 2, 2400.00, '2024-10-31', '2024-10-31 05:59:58', '2024-10-31 05:59:58'),
(4, 1, '2', 2, 8000.00, '2024-10-31', '2024-10-31 06:01:06', '2024-10-31 06:01:06'),
(5, 1, '2', 2, 5000.00, '2024-10-31', '2024-10-31 06:01:16', '2024-10-31 06:01:16'),
(6, 4, 'Unawatuna Beach Scuba Diving', 3, 12000.00, '2024-10-31', '2024-10-31 06:24:46', '2024-10-31 06:24:46'),
(7, 4, 'Galle Maritime Museum Entry', 1, 500.00, '2024-10-31', '2024-10-31 06:29:47', '2024-10-31 06:29:47'),
(8, 4, 'Kelaniya Temple Entry', 2, 1200.00, '2024-10-31', '2024-10-31 10:14:05', '2024-10-31 10:14:05');

-- --------------------------------------------------------

--
-- Table structure for table `book_travels_data`
--

CREATE TABLE `book_travels_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `booking_id` bigint(20) UNSIGNED NOT NULL,
  `date` varchar(255) NOT NULL,
  `time` varchar(255) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `book_travels_data`
--

INSERT INTO `book_travels_data` (`id`, `user_id`, `booking_id`, `date`, `time`, `total_price`, `created_at`, `updated_at`) VALUES
(1, 1, 35, '2024-10-31', '02:17:00', 75000.00, '2024-10-30 13:19:13', '2024-10-30 13:19:13'),
(2, 1, 63, '2024-10-31', '05:45:00', 60000.00, '2024-10-30 13:19:23', '2024-10-30 13:19:23'),
(3, 1, 68, '2024-10-31', '05:00:00', 24000.00, '2024-10-30 13:20:55', '2024-10-30 13:20:55'),
(4, 1, 63, '2024-10-31', '02:23:00', 60000.00, '2024-10-30 13:23:40', '2024-10-30 13:23:40'),
(5, 1, 36, '2024-10-31', '18:24:00', 69000.00, '2024-10-30 13:24:44', '2024-10-30 13:24:44'),
(6, 1, 36, '2024-10-31', '06:20:00', 69000.00, '2024-10-30 13:25:54', '2024-10-30 13:25:54'),
(7, 1, 35, '2024-10-31', '01:14:00', 75000.00, '2024-10-30 14:14:31', '2024-10-30 14:14:31'),
(8, 1, 11, '2024-10-31', '02:27:00', 42000.00, '2024-10-30 15:27:40', '2024-10-30 15:27:40'),
(9, 1, 9, '2024-11-08', '03:44:00', 21000.00, '2024-10-30 16:44:13', '2024-10-30 16:44:13'),
(10, 1, 9, '2024-10-31', '04:48:00', 21000.00, '2024-10-30 16:49:02', '2024-10-30 16:49:02'),
(11, 1, 35, '2024-12-13', '05:00:00', 75000.00, '2024-10-30 16:53:16', '2024-10-30 16:53:16'),
(12, 1, 8, '2025-01-10', '04:09:00', 15000.00, '2024-10-30 17:09:43', '2024-10-30 17:09:43'),
(13, 1, 35, '2024-10-31', '04:09:00', 75000.00, '2024-10-30 17:09:51', '2024-10-30 17:09:51'),
(14, 4, 10, '2024-10-31', '04:17:00', 45000.00, '2024-10-30 17:17:30', '2024-10-30 17:17:30'),
(15, 4, 10, '2024-10-31', '17:25:00', 45000.00, '2024-10-31 02:40:43', '2024-10-31 02:40:43'),
(16, 4, 35, '2024-10-31', '17:25:00', 75000.00, '2024-10-31 06:25:38', '2024-10-31 06:25:38'),
(17, 4, 9, '2024-10-31', '17:29:00', 21000.00, '2024-10-31 06:29:30', '2024-10-31 06:29:30'),
(18, 4, 60, '2024-10-31', '21:13:00', 81000.00, '2024-10-31 10:13:54', '2024-10-31 10:13:54');

-- --------------------------------------------------------

--
-- Table structure for table `book_travels_vehicle`
--

CREATE TABLE `book_travels_vehicle` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vehicle_name` varchar(255) NOT NULL,
  `place` varchar(255) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `book_travels_vehicle`
--

INSERT INTO `book_travels_vehicle` (`id`, `vehicle_name`, `place`, `price`, `created_at`, `updated_at`) VALUES
(1, '3_wheeler', 'Colombo', 4500.00, NULL, NULL),
(2, '3_wheeler', 'Gampaha', 7500.00, NULL, NULL),
(3, '3_wheeler', 'Kalutara', 9000.00, NULL, NULL),
(4, '3_wheeler', 'Kandy', 15000.00, NULL, NULL),
(5, '3_wheeler', 'Matale', 16500.00, NULL, NULL),
(6, '3_wheeler', 'Nuwara Eliya', 18000.00, NULL, NULL),
(7, '3_wheeler', 'Galle', 13500.00, NULL, NULL),
(8, '3_wheeler', 'Matara', 15000.00, NULL, NULL),
(9, '3_wheeler', 'Hambantota', 21000.00, NULL, NULL),
(10, '3_wheeler', 'Jaffna', 45000.00, NULL, NULL),
(11, '3_wheeler', 'Kilinochchi', 42000.00, NULL, NULL),
(12, '3_wheeler', 'Mannar', 36000.00, NULL, NULL),
(13, '3_wheeler', 'Vavuniya', 33000.00, NULL, NULL),
(14, '3_wheeler', 'Mullaitivu', 39000.00, NULL, NULL),
(15, '3_wheeler', 'Batticaloa', 24000.00, NULL, NULL),
(16, '3_wheeler', 'Ampara', 22500.00, NULL, NULL),
(17, '3_wheeler', 'Trincomalee', 27000.00, NULL, NULL),
(18, '3_wheeler', 'Kurunegala', 13500.00, NULL, NULL),
(19, '3_wheeler', 'Puttalam', 15000.00, NULL, NULL),
(20, '3_wheeler', 'Anuradhapura', 19500.00, NULL, NULL),
(21, '3_wheeler', 'Polonnaruwa', 21000.00, NULL, NULL),
(22, '3_wheeler', 'Badulla', 25500.00, NULL, NULL),
(23, '3_wheeler', 'Monaragala', 27000.00, NULL, NULL),
(24, '3_wheeler', 'Ratnapura', 12000.00, NULL, NULL),
(25, '3_wheeler', 'Kegalle', 10500.00, NULL, NULL),
(26, 'car', 'Colombo', 7500.00, NULL, NULL),
(27, 'car', 'Gampaha', 12000.00, NULL, NULL),
(28, 'car', 'Kalutara', 15000.00, NULL, NULL),
(29, 'car', 'Kandy', 24000.00, NULL, NULL),
(30, 'car', 'Matale', 25500.00, NULL, NULL),
(31, 'car', 'Nuwara Eliya', 27000.00, NULL, NULL),
(32, 'car', 'Galle', 21000.00, NULL, NULL),
(33, 'car', 'Matara', 24000.00, NULL, NULL),
(34, 'car', 'Hambantota', 36000.00, NULL, NULL),
(35, 'car', 'Jaffna', 75000.00, NULL, NULL),
(36, 'car', 'Kilinochchi', 69000.00, NULL, NULL),
(37, 'car', 'Mannar', 60000.00, NULL, NULL),
(38, 'car', 'Vavuniya', 54000.00, NULL, NULL),
(39, 'car', 'Mullaitivu', 66000.00, NULL, NULL),
(40, 'car', 'Batticaloa', 39000.00, NULL, NULL),
(41, 'car', 'Ampara', 37500.00, NULL, NULL),
(42, 'car', 'Trincomalee', 45000.00, NULL, NULL),
(43, 'car', 'Kurunegala', 21000.00, NULL, NULL),
(44, 'car', 'Puttalam', 24000.00, NULL, NULL),
(45, 'car', 'Anuradhapura', 30000.00, NULL, NULL),
(46, 'car', 'Polonnaruwa', 33000.00, NULL, NULL),
(47, 'car', 'Badulla', 40500.00, NULL, NULL),
(48, 'car', 'Monaragala', 42000.00, NULL, NULL),
(49, 'car', 'Ratnapura', 18000.00, NULL, NULL),
(50, 'car', 'Kegalle', 15000.00, NULL, NULL),
(51, 'van', 'Colombo', 9000.00, NULL, NULL),
(52, 'van', 'Gampaha', 15000.00, NULL, NULL),
(53, 'van', 'Kalutara', 18000.00, NULL, NULL),
(54, 'van', 'Kandy', 27000.00, NULL, NULL),
(55, 'van', 'Matale', 30000.00, NULL, NULL),
(56, 'van', 'Nuwara Eliya', 31500.00, NULL, NULL),
(57, 'van', 'Galle', 25500.00, NULL, NULL),
(58, 'van', 'Matara', 28500.00, NULL, NULL),
(59, 'van', 'Hambantota', 42000.00, NULL, NULL),
(60, 'van', 'Jaffna', 81000.00, NULL, NULL),
(61, 'van', 'Kilinochchi', 75000.00, NULL, NULL),
(62, 'van', 'Mannar', 66000.00, NULL, NULL),
(63, 'van', 'Vavuniya', 60000.00, NULL, NULL),
(64, 'van', 'Mullaitivu', 72000.00, NULL, NULL),
(65, 'van', 'Batticaloa', 48000.00, NULL, NULL),
(66, 'van', 'Ampara', 46500.00, NULL, NULL),
(67, 'van', 'Trincomalee', 52500.00, NULL, NULL),
(68, 'van', 'Kurunegala', 24000.00, NULL, NULL),
(69, 'van', 'Puttalam', 25500.00, NULL, NULL),
(70, 'van', 'Anuradhapura', 36000.00, NULL, NULL),
(71, 'van', 'Polonnaruwa', 39000.00, NULL, NULL),
(72, 'van', 'Badulla', 45000.00, NULL, NULL),
(73, 'van', 'Monaragala', 46500.00, NULL, NULL),
(74, 'van', 'Ratnapura', 22500.00, NULL, NULL),
(75, 'van', 'Kegalle', 19500.00, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(2, '2024_10_30_075949_create_mobile_users_table', 1),
(3, '2024_10_30_131502_create_book_travels_vehicle_table', 2),
(5, '2024_10_30_132851_create_book_travels_data_table', 3),
(8, '2024_10_30_185923_create_book_hotels_table', 4),
(9, '2024_10_30_211704_create_book_hotels_data_table', 5),
(10, '2024_10_30_214929_create_book_tickets_table', 6),
(13, '2024_10_30_215747_create_book_tickets_data_table', 7);

-- --------------------------------------------------------

--
-- Table structure for table `mobile_users`
--

CREATE TABLE `mobile_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mobile_users`
--

INSERT INTO `mobile_users` (`id`, `email`, `full_name`, `password`, `phone_number`, `gender`, `dob`, `country`, `address`, `created_at`, `updated_at`) VALUES
(1, 'guna@gmail.com', 'gunarakulangunarak', '$2y$12$IuGf8eH26cNBZFnXZSQaCOIhyoFWMvyfnioo/LfjzFdZiib9eadPC', '123456789', 'male', '1997-11-10', 'Austria', 'cfddsfds', '2024-10-30 05:51:45', '2024-10-30 05:51:45'),
(2, 'guna@gmail.comm', 'gunarakula', '$2y$12$nVdI26C3t7hZxK0VOEaYBeflldZR6xsPtkAFgKfM/TtLwMhIAhbIS', '23456', 'male', '1997-11-11', 'Bahamas', 'cxcz', '2024-10-30 05:54:05', '2024-10-30 05:54:05'),
(3, 'gunaa@gmail.com', 'guna', '12345678', '32457689', 'male', '1997-11-11', 'Brunei', 'sdasdsa', '2024-10-30 05:57:44', '2024-10-30 17:07:41'),
(4, 'java@gmail.com', 'Java', 'java.com123', '324576', 'male', '1997-11-11', 'Bhutan', 'nonono', '2024-10-30 17:09:16', '2024-10-30 17:09:16'),
(5, 'dsadsadsa@gmail.com', 'maaaaa', 'fdsfdsfdsfdsfdsf', '23456432', 'male', '2007-11-11', 'Bahamas', 'dsfds', '2024-10-31 10:15:03', '2024-10-31 10:15:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book_hotels`
--
ALTER TABLE `book_hotels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `book_hotels_data`
--
ALTER TABLE `book_hotels_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `book_tickets`
--
ALTER TABLE `book_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `book_tickets_data`
--
ALTER TABLE `book_tickets_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `book_travels_data`
--
ALTER TABLE `book_travels_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_travels_data_booking_id_foreign` (`booking_id`);

--
-- Indexes for table `book_travels_vehicle`
--
ALTER TABLE `book_travels_vehicle`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mobile_users`
--
ALTER TABLE `mobile_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mobile_users_email_unique` (`email`),
  ADD UNIQUE KEY `mobile_users_phone_number_unique` (`phone_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `book_hotels`
--
ALTER TABLE `book_hotels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `book_hotels_data`
--
ALTER TABLE `book_hotels_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `book_tickets`
--
ALTER TABLE `book_tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `book_tickets_data`
--
ALTER TABLE `book_tickets_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `book_travels_data`
--
ALTER TABLE `book_travels_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `book_travels_vehicle`
--
ALTER TABLE `book_travels_vehicle`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `mobile_users`
--
ALTER TABLE `mobile_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book_travels_data`
--
ALTER TABLE `book_travels_data`
  ADD CONSTRAINT `book_travels_data_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `book_travels_vehicle` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
