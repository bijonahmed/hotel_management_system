-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 03, 2025 at 11:50 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_hotel_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `api_configs`
--

CREATE TABLE `api_configs` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `app_id` varchar(255) NOT NULL,
  `api_url` varchar(255) NOT NULL,
  `api_key` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `api_configs`
--

INSERT INTO `api_configs` (`id`, `name`, `app_id`, `api_url`, `api_key`, `created_at`, `updated_at`) VALUES
(1, 'Game List', '771', 'https://api-gametest.omgapi.cc/api/game/loadlist', 'dc7df6a77d8e82fcf26062d773b8d385', '2024-10-17 04:52:28', '2024-10-17 04:52:31');

-- --------------------------------------------------------

--
-- Table structure for table `api_key`
--

CREATE TABLE `api_key` (
  `id` int(11) NOT NULL,
  `merchant_id` int(11) NOT NULL,
  `key` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `api_key`
--

INSERT INTO `api_key` (`id`, `merchant_id`, `key`, `password`, `status`, `created_at`, `updated_at`) VALUES
(1, 6, 'hkttruzpxboovmme7s7ua6cppa6m0xp8', 'xRSLnG38I9uH', 1, '2024-12-08 13:33:06', '2024-12-08 15:26:39'),
(4, 3, 'TQUiTZzqypMpwSNTaKS1kye2p1MGd4tNvK', 'LRWwU5D6womf', 1, '2024-12-08 15:26:59', '2025-01-12 23:21:37'),
(5, 5, '5yjjrs1dqc064ikm9zf1opiyblj4xn4n', 'cTQt96aJIQZg', 1, '2024-12-08 15:30:33', '2024-12-08 15:30:33'),
(7, 22, 'a1z796m6004vd9t6euj6aheey7pieprg', 'BuUWvdAEE6pw', 1, '2025-01-10 14:39:03', '2025-01-10 14:39:03');

-- --------------------------------------------------------

--
-- Table structure for table `bed_type`
--

CREATE TABLE `bed_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bed_type`
--

INSERT INTO `bed_type` (`id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, '1 large double bed', '1-large-double-bed', 1, '2025-04-03 12:03:28', '2025-04-03 12:03:28'),
(2, '2 large double bed', '2-large-double-bed', 1, '2025-04-03 12:03:57', '2025-04-03 12:03:57'),
(3, '1 extra-large double bed', '1-extra-large-double-bed', 1, '2025-04-03 12:07:29', '2025-04-03 12:07:29'),
(4, '2 extra-large double bed', '2-extra-large-double-bed', 1, '2025-04-03 12:17:16', '2025-04-03 12:17:16');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int(10) UNSIGNED NOT NULL,
  `booking_id` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `country_code` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `checkin` date NOT NULL,
  `checkout` date NOT NULL,
  `room_id` int(10) UNSIGNED NOT NULL,
  `room_no` varchar(255) DEFAULT NULL,
  `adult` int(11) DEFAULT 0,
  `child` int(11) DEFAULT 0,
  `booking_type` varchar(255) DEFAULT NULL,
  `room_price` double(10,2) DEFAULT NULL COMMENT 'Per day room price',
  `total_amount` decimal(10,2) DEFAULT NULL,
  `advance_amount` decimal(10,2) DEFAULT NULL,
  `total_bill` decimal(10,2) DEFAULT NULL,
  `due_amount` decimal(10,2) DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT NULL,
  `final_total_amount` decimal(10,2) DEFAULT NULL,
  `tax_amount` decimal(10,2) DEFAULT NULL,
  `item_total` decimal(10,2) DEFAULT NULL,
  `grand_total` decimal(10,2) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `customer_title` varchar(255) DEFAULT NULL,
  `customer_first_name` varchar(255) DEFAULT NULL,
  `customer_last_name` varchar(255) DEFAULT NULL,
  `customer_father_name` varchar(255) DEFAULT NULL,
  `customer_gender` varchar(255) DEFAULT NULL,
  `customer_occupation` varchar(255) DEFAULT NULL,
  `customer_dob` date DEFAULT NULL,
  `customer_nationality` varchar(255) DEFAULT NULL,
  `customer_contact_type` varchar(255) DEFAULT NULL,
  `customer_contact_address` text DEFAULT NULL,
  `customer_contact_email` varchar(255) DEFAULT NULL,
  `id_no` varchar(255) DEFAULT NULL,
  `front_side_document` varchar(255) DEFAULT NULL,
  `back_side_document` varchar(255) DEFAULT NULL,
  `arival_from` text DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `paymenttype` int(11) DEFAULT NULL COMMENT '1=online,2=offline',
  `booking_status` int(11) DEFAULT NULL COMMENT '1=Booked\r\n2=Release\r\n3=Cancel\r\n4=Others like advance payment update etc.',
  `update_by` int(11) DEFAULT NULL,
  `booking_by` int(11) DEFAULT NULL COMMENT 'this admin entry track which user entry',
  `booking_reference_no` varchar(255) DEFAULT NULL,
  `pupose_of_visit` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `check_in_by` int(11) DEFAULT NULL,
  `check_out_reason` text DEFAULT NULL,
  `invoice_create_by` int(11) DEFAULT NULL,
  `invoice_create` int(11) NOT NULL DEFAULT 2 COMMENT '1=Yes,2=NO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `booking_id`, `name`, `email`, `country_code`, `phone`, `checkin`, `checkout`, `room_id`, `room_no`, `adult`, `child`, `booking_type`, `room_price`, `total_amount`, `advance_amount`, `total_bill`, `due_amount`, `discount_amount`, `final_total_amount`, `tax_amount`, `item_total`, `grand_total`, `message`, `customer_title`, `customer_first_name`, `customer_last_name`, `customer_father_name`, `customer_gender`, `customer_occupation`, `customer_dob`, `customer_nationality`, `customer_contact_type`, `customer_contact_address`, `customer_contact_email`, `id_no`, `front_side_document`, `back_side_document`, `arival_from`, `customer_id`, `paymenttype`, `booking_status`, `update_by`, `booking_by`, `booking_reference_no`, `pupose_of_visit`, `remarks`, `check_in_by`, `check_out_reason`, `invoice_create_by`, `invoice_create`, `created_at`, `updated_at`) VALUES
(1, '82179', 'jons', '11jons@gmail.com', NULL, '01915728982', '2025-05-31', '2025-05-31', 7, '102', NULL, NULL, NULL, 9720.00, 9720.00, 720.00, 9720.00, 9000.00, 0.00, 9000.00, 180.00, 1388.92, 10568.92, NULL, NULL, 'Bijons', NULL, NULL, 'Male', 'Programmer', NULL, NULL, NULL, NULL, NULL, '654998999', '/backend/files/XNLffmKNpg6VbZApnuDv.png', '/backend/files/1cxC66IPaTkNRIxZ0sNT.png', 'Dhaka', 29, 2, 2, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, 1, '2025-05-31 14:02:08', '2025-06-01 04:45:18'),
(2, '12505', 'Gazi', 'mdbijon@gmail.com', NULL, '01915728982', '2025-06-01', '2025-06-03', 7, NULL, 4, 6, NULL, 9720.00, 19440.00, 440.00, 19440.00, 19000.00, 0.00, 19000.00, 380.00, 915.00, 20295.00, 'This second booking request.', NULL, 'Gazi', 'Ahmed', 'Mr. Harunur Rashid', 'Male', 'Programmer', NULL, NULL, NULL, NULL, NULL, '56898879999', '/backend/files/AdUtRe8damCiS8ZxuihZ.png', '/backend/files/5kPSXX8dan3cNVdx0N6f.png', 'Dhaka', 29, 2, 2, NULL, NULL, '54545', 'For visit', NULL, 1, NULL, 1, 1, '2025-05-31 14:03:16', '2025-06-01 18:34:57'),
(5, '29741', 'Bijon', 'sajibahmed@gmail.com', NULL, '01915728982', '2025-06-03', '2025-06-03', 7, NULL, 3, 5, NULL, 9720.00, 9720.00, 720.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ccc', 'Mr.', 'Bijon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '548578855555', '/backend/files/R1S6JO33JDazHgdVqa3l.png', '/backend/files/seRIH6y3qPOdRGzKPo8V.png', 'Dhaka', 0, 2, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 1, '2025-06-01 13:35:01', '2025-06-03 02:00:22'),
(6, '61949', 'kahem ali', 'kashem@gmail.com', NULL, '0187878888', '2025-06-05', '2025-06-06', 7, NULL, 0, 0, NULL, 9720.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'xssss', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '2025-06-01 13:37:28', '2025-06-01 13:37:28'),
(7, '15769', 'kawsar', 'kawsar@gmail.com', NULL, NULL, '2025-06-01', '2025-06-04', 1, NULL, 1, 3, NULL, 7290.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ddd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '2025-06-01 14:08:18', '2025-06-01 14:08:18'),
(8, '75498', 'dsf', 'sdf@gmail.com', NULL, NULL, '2025-06-15', '2025-06-18', 3, NULL, 0, 0, NULL, 12190.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '2025-06-03 02:17:35', '2025-06-03 02:17:35'),
(9, '34306', 'Mouthwatering Caprese Skewers', 'ran1223ay123@gmail.com', NULL, NULL, '2025-06-21', '2025-06-23', 3, NULL, 0, 0, NULL, 12190.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, '2025-06-03 02:21:05', '2025-06-03 02:21:05');

-- --------------------------------------------------------

--
-- Table structure for table `booking_type`
--

CREATE TABLE `booking_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `booking_type`
--

INSERT INTO `booking_type` (`id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'SSSSS', 'sssss', 1, '2025-03-31 06:21:21', '2025-03-31 06:37:09'),
(2, 'Instant', 'instant', 1, '2025-03-31 06:21:31', '2025-03-31 06:21:31'),
(3, 'Groups', 'groups', 1, '2025-03-31 06:21:40', '2025-03-31 06:21:40'),
(4, 'Allocation', 'allocation', 1, '2025-03-31 06:21:46', '2025-03-31 06:21:46'),
(5, 'Business Seminar', 'business-seminar', 1, '2025-03-31 06:21:51', '2025-03-31 06:21:51'),
(6, 'Wedding', 'wedding', 1, '2025-03-31 06:21:56', '2025-03-31 06:21:56'),
(7, 'Birthday', 'birthday', 1, '2025-03-31 06:22:01', '2025-03-31 06:22:01'),
(8, 'Photoshoot', 'photoshoot', 1, '2025-03-31 06:22:06', '2025-03-31 06:22:06');

-- --------------------------------------------------------

--
-- Table structure for table `bulk_address`
--

CREATE TABLE `bulk_address` (
  `id` int(11) NOT NULL,
  `merchant_id` int(11) DEFAULT NULL,
  `walletAddress` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `block_status` int(11) NOT NULL DEFAULT 0 COMMENT '0=unblock,1=block',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `entry_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categorys`
--

CREATE TABLE `categorys` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categorys`
--

INSERT INTO `categorys` (`id`, `name`, `slug`, `file`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Global category', 'global-category', NULL, 1, NULL, NULL),
(2, 'Artificial Intelligence', 'artificial-intelligence', NULL, 1, NULL, NULL),
(3, 'Machine Learning', 'machine-learning', NULL, 1, NULL, NULL),
(4, 'Blockchain', 'blockchain', NULL, 1, NULL, NULL),
(5, 'Cloud Computing', 'cloud-computing', NULL, 1, NULL, NULL),
(6, 'Cybersecurity', 'cybersecurity', NULL, 1, NULL, NULL),
(7, 'Data Science', 'data-science', NULL, 1, NULL, NULL),
(8, 'Big Data', 'big-data', NULL, 1, NULL, NULL),
(9, 'Internet of Things', 'internet-of-things', NULL, 1, NULL, NULL),
(10, 'Augmented Reality', 'augmented-reality', NULL, 1, NULL, NULL),
(11, 'Virtual Reality', 'virtual-reality', NULL, 1, NULL, NULL),
(12, 'Web Development', 'web-development', NULL, 1, NULL, NULL),
(13, 'Mobile Development', 'mobile-development', NULL, 1, NULL, NULL),
(14, 'DevOps', 'devops', NULL, 1, NULL, NULL),
(15, 'Game Development', 'game-development', NULL, 1, NULL, NULL),
(16, 'Robotics', 'robotics', NULL, 1, NULL, NULL),
(17, 'Artificial Neural Networks', 'artificial-neural-networks', NULL, 1, NULL, NULL),
(18, 'Digital Marketing', 'digital-marketing', NULL, 1, NULL, NULL),
(19, 'E-commerce', 'e-commerce', NULL, 1, NULL, NULL),
(20, 'SEO Optimization', 'seo-optimization', NULL, 1, NULL, NULL),
(21, 'Software Development', 'software-development', NULL, 1, NULL, NULL),
(22, 'UI/UX Design', 'ui-ux-design', NULL, 1, NULL, NULL),
(23, 'Programming Languages', 'programming-languages', NULL, 1, NULL, NULL),
(24, 'Ethical Hacking', 'ethical-hacking', NULL, 1, NULL, NULL),
(25, 'Networking', 'networking', NULL, 1, NULL, NULL),
(26, 'System Administration', 'system-administration', NULL, 1, NULL, NULL),
(27, 'Database Management', 'database-management', NULL, 1, NULL, NULL),
(28, 'Cryptography', 'cryptography', NULL, 1, NULL, NULL),
(29, 'Automation', 'automation', NULL, 1, NULL, NULL),
(30, 'Computer Vision', 'computer-vision', NULL, 1, NULL, NULL),
(31, 'Natural Language Processing', 'natural-language-processing', NULL, 1, NULL, NULL),
(32, 'Edge Computing', 'edge-computing', NULL, 1, NULL, NULL),
(33, 'Quantum Computing', 'quantum-computing', NULL, 1, NULL, NULL),
(34, 'Digital Twins', 'digital-twins', NULL, 1, NULL, NULL),
(35, '5G Technology', '5g-technology', NULL, 1, NULL, NULL),
(36, 'Smart Cities', 'smart-cities', NULL, 1, NULL, NULL),
(37, 'Biometrics', 'biometrics', NULL, 1, NULL, NULL),
(38, 'Wearable Technology', 'wearable-technology', NULL, 1, NULL, NULL),
(39, '3D Printing', '3d-printing', NULL, 1, NULL, NULL),
(40, 'Open Source', 'open-source', NULL, 1, NULL, NULL),
(41, 'Augmented Analytics', 'augmented-analytics', NULL, 1, NULL, NULL),
(42, 'Edge AI', 'edge-ai', NULL, 1, NULL, NULL),
(43, 'Computer Graphics', 'computer-graphics', NULL, 1, NULL, NULL),
(44, 'Digital Transformation', 'digital-transformation', NULL, 1, NULL, NULL),
(45, 'Chatbots', 'chatbots', NULL, 1, NULL, NULL),
(46, 'API Development', 'api-development', NULL, 1, NULL, NULL),
(47, 'Backend Development', 'backend-development', NULL, 1, NULL, NULL),
(48, 'Frontend Development', 'frontend-development', NULL, 1, NULL, NULL),
(49, 'Augmented Workspaces', 'augmented-workspaces', NULL, 1, NULL, NULL),
(50, 'Full-stack Development', 'full-stack-development', NULL, 1, NULL, NULL),
(51, 'Digital Payments', 'digital-payments', NULL, 1, NULL, NULL),
(52, 'Smart Contracts', 'smart-contracts', NULL, 1, NULL, NULL),
(53, 'Drones', 'drones', NULL, 1, NULL, NULL),
(54, 'Virtual Assistants', 'virtual-assistants', NULL, 1, NULL, NULL),
(55, 'Mixed Reality', 'mixed-reality', NULL, 1, NULL, NULL),
(56, 'E-Learning', 'e-learning', NULL, 1, NULL, NULL),
(57, 'EdTech', 'edtech', NULL, 1, NULL, NULL),
(58, 'FinTech', 'fintech', NULL, 1, NULL, NULL),
(59, 'PropTech', 'proptech', NULL, 1, NULL, NULL),
(60, 'AgriTech', 'agritech', NULL, 1, NULL, NULL),
(61, 'HealthTech', 'healthtech', NULL, 1, NULL, NULL),
(62, 'MarTech', 'martech', NULL, 1, NULL, NULL),
(63, 'InsurTech', 'insurtech', NULL, 1, NULL, NULL),
(64, 'LegalTech', 'legaltech', NULL, 1, NULL, NULL),
(65, 'RegTech', 'regtech', NULL, 1, NULL, NULL),
(66, 'FoodTech', 'foodtech', NULL, 1, NULL, NULL),
(67, 'MedTech', 'medtech', NULL, 1, NULL, NULL),
(68, 'ClimateTech', 'climatetech', NULL, 1, NULL, NULL),
(69, 'GreenTech', 'greentech', NULL, 1, NULL, NULL),
(70, 'HRTech', 'hrtech', NULL, 1, NULL, NULL),
(71, 'RetailTech', 'retailtech', NULL, 1, NULL, NULL),
(72, 'EnergyTech', 'energytech', NULL, 1, NULL, NULL),
(73, 'SpaceTech', 'spacetech', NULL, 1, NULL, NULL),
(74, 'MobilityTech', 'mobilitytech', NULL, 1, NULL, NULL),
(75, 'Gaming', 'gaming', NULL, 1, NULL, NULL),
(76, 'Digital Advertising', 'digital-advertising', NULL, 1, NULL, NULL),
(77, 'Search Engines', 'search-engines', NULL, 1, NULL, NULL),
(78, 'Video Streaming', 'video-streaming', NULL, 1, NULL, NULL),
(79, 'Smart Home', 'smart-home', NULL, 1, NULL, NULL),
(80, 'Space Exploration', 'space-exploration', NULL, 1, NULL, NULL),
(81, 'Autonomous Vehicles', 'autonomous-vehicles', NULL, 1, NULL, NULL),
(82, 'AI Ethics', 'ai-ethics', NULL, 1, NULL, NULL),
(83, 'Digital Art', 'digital-art', NULL, 1, NULL, NULL),
(84, 'Design Thinking', 'design-thinking', NULL, 1, NULL, NULL),
(85, 'Predictive Analytics', 'predictive-analytics', NULL, 1, NULL, NULL),
(86, 'Customer Experience', 'customer-experience', NULL, 1, NULL, NULL),
(87, 'Content Management', 'content-management', NULL, 1, NULL, NULL),
(88, 'IT Governance', 'it-governance', NULL, 1, NULL, NULL),
(89, 'Social Media', 'social-media', NULL, 1, NULL, NULL),
(90, 'Innovation', 'innovation', NULL, 1, NULL, NULL),
(91, 'Digital Identity', 'digital-identity', NULL, 1, NULL, NULL),
(92, 'Crowdsourcing', 'crowdsourcing', NULL, 1, NULL, NULL),
(93, 'Disruptive Technology', 'disruptive-technology', NULL, 1, NULL, NULL),
(94, 'Technology Trends', 'technology-trends', NULL, 1, NULL, NULL),
(95, 'Tech Startups', 'tech-startups', NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `id` int(11) NOT NULL,
  `shortname` varchar(3) NOT NULL,
  `name` varchar(150) NOT NULL,
  `phonecode` int(11) NOT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `shortname`, `name`, `phonecode`, `status`) VALUES
(1, 'AF', 'Afghanistan', 93, 1),
(2, 'AL', 'Albania', 355, 1),
(3, 'DZ', 'Algeria', 213, 1),
(4, 'AS', 'American Samoa', 1684, 1),
(5, 'AD', 'Andorra', 376, 1),
(6, 'AO', 'Angola', 244, 1),
(7, 'AI', 'Anguilla', 1264, 1),
(8, 'AQ', 'Antarctica', 0, 1),
(9, 'AG', 'Antigua And Barbuda', 1268, 1),
(10, 'AR', 'Argentina', 54, 1),
(11, 'AM', 'Armenia', 374, 1),
(12, 'AW', 'Aruba', 297, 1),
(13, 'AU', 'Australia', 61, 1),
(14, 'AT', 'Austria', 43, 1),
(15, 'AZ', 'Azerbaijan', 994, 1),
(16, 'BS', 'Bahamas The', 1242, 1),
(17, 'BH', 'Bahrain', 973, 1),
(18, 'BD', 'Bangladesh', 880, 1),
(19, 'BB', 'Barbados', 1246, 1),
(20, 'BY', 'Belarus', 375, 1),
(21, 'BE', 'Belgium', 32, 1),
(22, 'BZ', 'Belize', 501, 1),
(23, 'BJ', 'Benin', 229, 1),
(24, 'BM', 'Bermuda', 1441, 1),
(25, 'BT', 'Bhutan', 975, 1),
(26, 'BO', 'Bolivia', 591, 1),
(27, 'BA', 'Bosnia and Herzegovina', 387, 1),
(28, 'BW', 'Botswana', 267, 1),
(29, 'BV', 'Bouvet Island', 0, 1),
(30, 'BR', 'Brazil', 55, 1),
(31, 'IO', 'British Indian Ocean Territory', 246, 1),
(32, 'BN', 'Brunei', 673, 1),
(33, 'BG', 'Bulgaria', 359, 1),
(34, 'BF', 'Burkina Faso', 226, 1),
(35, 'BI', 'Burundi', 257, 1),
(36, 'KH', 'Cambodia', 855, 1),
(37, 'CM', 'Cameroon', 237, 1),
(38, 'CA', 'Canada', 1, 1),
(39, 'CV', 'Cape Verde', 238, 1),
(40, 'KY', 'Cayman Islands', 1345, 1),
(41, 'CF', 'Central African Republic', 236, 1),
(42, 'TD', 'Chad', 235, 1),
(43, 'CL', 'Chile', 56, 1),
(44, 'CN', 'China', 86, 1),
(45, 'CX', 'Christmas Island', 61, 1),
(46, 'CC', 'Cocos (Keeling) Islands', 672, 1),
(47, 'CO', 'Colombia', 57, 1),
(48, 'KM', 'Comoros', 269, 1),
(49, 'CG', 'Republic Of The Congo', 242, 1),
(50, 'CD', 'Democratic Republic Of The Congo', 242, 1),
(51, 'CK', 'Cook Islands', 682, 1),
(52, 'CR', 'Costa Rica', 506, 1),
(53, 'CI', 'Cote D\'Ivoire (Ivory Coast)', 225, 1),
(54, 'HR', 'Croatia (Hrvatska)', 385, 1),
(55, 'CU', 'Cuba', 53, 1),
(56, 'CY', 'Cyprus', 357, 1),
(57, 'CZ', 'Czech Republic', 420, 1),
(58, 'DK', 'Denmark', 45, 1),
(59, 'DJ', 'Djibouti', 253, 1),
(60, 'DM', 'Dominica', 1767, 1),
(61, 'DO', 'Dominican Republic', 1809, 1),
(62, 'TP', 'East Timor', 670, 1),
(63, 'EC', 'Ecuador', 593, 1),
(64, 'EG', 'Egypt', 20, 1),
(65, 'SV', 'El Salvador', 503, 1),
(66, 'GQ', 'Equatorial Guinea', 240, 1),
(67, 'ER', 'Eritrea', 291, 1),
(68, 'EE', 'Estonia', 372, 1),
(69, 'ET', 'Ethiopia', 251, 1),
(70, 'XA', 'External Territories of Australia', 61, 1),
(71, 'FK', 'Falkland Islands', 500, 1),
(72, 'FO', 'Faroe Islands', 298, 1),
(73, 'FJ', 'Fiji Islands', 679, 1),
(74, 'FI', 'Finland', 358, 1),
(75, 'FR', 'France', 33, 1),
(76, 'GF', 'French Guiana', 594, 1),
(77, 'PF', 'French Polynesia', 689, 1),
(78, 'TF', 'French Southern Territories', 0, 1),
(79, 'GA', 'Gabon', 241, 1),
(80, 'GM', 'Gambia The', 220, 1),
(81, 'GE', 'Georgia', 995, 1),
(82, 'DE', 'Germany', 49, 1),
(83, 'GH', 'Ghana', 233, 1),
(84, 'GI', 'Gibraltar', 350, 1),
(85, 'GR', 'Greece', 30, 1),
(86, 'GL', 'Greenland', 299, 1),
(87, 'GD', 'Grenada', 1473, 1),
(88, 'GP', 'Guadeloupe', 590, 1),
(89, 'GU', 'Guam', 1671, 1),
(90, 'GT', 'Guatemala', 502, 1),
(91, 'XU', 'Guernsey and Alderney', 44, 1),
(92, 'GN', 'Guinea', 224, 1),
(93, 'GW', 'Guinea-Bissau', 245, 1),
(94, 'GY', 'Guyana', 592, 1),
(95, 'HT', 'Haiti', 509, 1),
(96, 'HM', 'Heard and McDonald Islands', 0, 1),
(97, 'HN', 'Honduras', 504, 1),
(98, 'HK', 'Hong Kong S.A.R.', 852, 1),
(99, 'HU', 'Hungary', 36, 1),
(100, 'IS', 'Iceland', 354, 1),
(101, 'IN', 'India', 91, 1),
(102, 'ID', 'Indonesia', 62, 1),
(103, 'IR', 'Iran', 98, 1),
(104, 'IQ', 'Iraq', 964, 1),
(105, 'IE', 'Ireland', 353, 1),
(106, 'IL', 'Israel', 972, 1),
(107, 'IT', 'Italy', 39, 1),
(108, 'JM', 'Jamaica', 1876, 1),
(109, 'JP', 'Japan', 81, 1),
(110, 'XJ', 'Jersey', 44, 1),
(111, 'JO', 'Jordan', 962, 1),
(112, 'KZ', 'Kazakhstan', 7, 1),
(113, 'KE', 'Kenya', 254, 1),
(114, 'KI', 'Kiribati', 686, 1),
(115, 'KP', 'Korea North', 850, 1),
(116, 'KR', 'Korea South', 82, 1),
(117, 'KW', 'Kuwait', 965, 1),
(118, 'KG', 'Kyrgyzstan', 996, 1),
(119, 'LA', 'Laos', 856, 1),
(120, 'LV', 'Latvia', 371, 1),
(121, 'LB', 'Lebanon', 961, 1),
(122, 'LS', 'Lesotho', 266, 1),
(123, 'LR', 'Liberia', 231, 1),
(124, 'LY', 'Libya', 218, 1),
(125, 'LI', 'Liechtenstein', 423, 1),
(126, 'LT', 'Lithuania', 370, 1),
(127, 'LU', 'Luxembourg', 352, 1),
(128, 'MO', 'Macau S.A.R.', 853, 1),
(129, 'MK', 'Macedonia', 389, 1),
(130, 'MG', 'Madagascar', 261, 1),
(131, 'MW', 'Malawi', 265, 1),
(132, 'MY', 'Malaysia', 60, 1),
(133, 'MV', 'Maldives', 960, 1),
(134, 'ML', 'Mali', 223, 1),
(135, 'MT', 'Malta', 356, 1),
(136, 'XM', 'Man (Isle of)', 44, 1),
(137, 'MH', 'Marshall Islands', 692, 1),
(138, 'MQ', 'Martinique', 596, 1),
(139, 'MR', 'Mauritania', 222, 1),
(140, 'MU', 'Mauritius', 230, 1),
(141, 'YT', 'Mayotte', 269, 1),
(142, 'MX', 'Mexico', 52, 1),
(143, 'FM', 'Micronesia', 691, 1),
(144, 'MD', 'Moldova', 373, 1),
(145, 'MC', 'Monaco', 377, 1),
(146, 'MN', 'Mongolia', 976, 1),
(147, 'MS', 'Montserrat', 1664, 1),
(148, 'MA', 'Morocco', 212, 1),
(149, 'MZ', 'Mozambique', 258, 1),
(150, 'MM', 'Myanmar', 95, 1),
(151, 'NA', 'Namibia', 264, 1),
(152, 'NR', 'Nauru', 674, 1),
(153, 'NP', 'Nepal', 977, 1),
(154, 'AN', 'Netherlands Antilles', 599, 1),
(155, 'NL', 'Netherlands The', 31, 1),
(156, 'NC', 'New Caledonia', 687, 1),
(157, 'NZ', 'New Zealand', 64, 1),
(158, 'NI', 'Nicaragua', 505, 1),
(159, 'NE', 'Niger', 227, 1),
(160, 'NG', 'Nigeria', 234, 1),
(161, 'NU', 'Niue', 683, 1),
(162, 'NF', 'Norfolk Island', 672, 1),
(163, 'MP', 'Northern Mariana Islands', 1670, 1),
(164, 'NO', 'Norway', 47, 1),
(165, 'OM', 'Oman', 968, 1),
(166, 'PK', 'Pakistan', 92, 1),
(167, 'PW', 'Palau', 680, 1),
(168, 'PS', 'Palestinian Territory Occupied', 970, 1),
(169, 'PA', 'Panama', 507, 1),
(170, 'PG', 'Papua new Guinea', 675, 1),
(171, 'PY', 'Paraguay', 595, 1),
(172, 'PE', 'Peru', 51, 1),
(173, 'PH', 'Philippines', 63, 1),
(174, 'PN', 'Pitcairn Island', 0, 1),
(175, 'PL', 'Poland', 48, 1),
(176, 'PT', 'Portugal', 351, 1),
(177, 'PR', 'Puerto Rico', 1787, 1),
(178, 'QA', 'Qatar', 974, 1),
(179, 'RE', 'Reunion', 262, 1),
(180, 'RO', 'Romania', 40, 1),
(181, 'RU', 'Russia', 70, 1),
(182, 'RW', 'Rwanda', 250, 1),
(183, 'SH', 'Saint Helena', 290, 1),
(184, 'KN', 'Saint Kitts And Nevis', 1869, 1),
(185, 'LC', 'Saint Lucia', 1758, 1),
(186, 'PM', 'Saint Pierre and Miquelon', 508, 1),
(187, 'VC', 'Saint Vincent And The Grenadines', 1784, 1),
(188, 'WS', 'Samoa', 684, 1),
(189, 'SM', 'San Marino', 378, 1),
(190, 'ST', 'Sao Tome and Principe', 239, 1),
(191, 'SA', 'Saudi Arabia', 966, 1),
(192, 'SN', 'Senegal', 221, 1),
(193, 'RS', 'Serbia', 381, 1),
(194, 'SC', 'Seychelles', 248, 1),
(195, 'SL', 'Sierra Leone', 232, 1),
(196, 'SG', 'Singapore', 65, 1),
(197, 'SK', 'Slovakia', 421, 1),
(198, 'SI', 'Slovenia', 386, 1),
(199, 'XG', 'Smaller Territories of the UK', 44, 1),
(200, 'SB', 'Solomon Islands', 677, 1),
(201, 'SO', 'Somalia', 252, 1),
(202, 'ZA', 'South Africa', 27, 1),
(203, 'GS', 'South Georgia', 0, 1),
(204, 'SS', 'South Sudan', 211, 1),
(205, 'ES', 'Spain', 34, 1),
(206, 'LK', 'Sri Lanka', 94, 1),
(207, 'SD', 'Sudan', 249, 1),
(208, 'SR', 'Suriname', 597, 1),
(209, 'SJ', 'Svalbard And Jan Mayen Islands', 47, 1),
(210, 'SZ', 'Swaziland', 268, 1),
(211, 'SE', 'Sweden', 46, 1),
(212, 'CH', 'Switzerland', 41, 1),
(213, 'SY', 'Syria', 963, 1),
(214, 'TW', 'Taiwan', 886, 1),
(215, 'TJ', 'Tajikistan', 992, 1),
(216, 'TZ', 'Tanzania', 255, 1),
(217, 'TH', 'Thailand', 66, 1),
(218, 'TG', 'Togo', 228, 1),
(219, 'TK', 'Tokelau', 690, 1),
(220, 'TO', 'Tonga', 676, 1),
(221, 'TT', 'Trinidad And Tobago', 1868, 1),
(222, 'TN', 'Tunisia', 216, 1),
(223, 'TR', 'Turkey', 90, 1),
(224, 'TM', 'Turkmenistan', 7370, 1),
(225, 'TC', 'Turks And Caicos Islands', 1649, 1),
(226, 'TV', 'Tuvalu', 688, 1),
(227, 'UG', 'Uganda', 256, 1),
(228, 'UA', 'Ukraine', 380, 1),
(229, 'AE', 'United Arab Emirates', 971, 1),
(230, 'GB', 'United Kingdom', 44, 1),
(231, 'US', 'United States', 1, 1),
(232, 'UM', 'United States Minor Outlying Islands', 1, 1),
(233, 'UY', 'Uruguay', 598, 1),
(234, 'UZ', 'Uzbekistan', 998, 1),
(235, 'VU', 'Vanuatu', 678, 1),
(236, 'VA', 'Vatican City State (Holy See)', 39, 1),
(237, 'VE', 'Venezuela', 58, 1),
(238, 'VN', 'Vietnam', 84, 1),
(239, 'VG', 'Virgin Islands (British)', 1284, 1),
(240, 'VI', 'Virgin Islands (US)', 1340, 1),
(241, 'WF', 'Wallis And Futuna Islands', 681, 1),
(242, 'EH', 'Western Sahara', 212, 1),
(243, 'YE', 'Yemen', 967, 1),
(244, 'YU', 'Yugoslavia', 38, 1),
(245, 'ZM', 'Zambia', 260, 1),
(246, 'ZW', 'Zimbabwe', 263, 1);

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `country` varchar(100) DEFAULT NULL,
  `currency` varchar(100) DEFAULT NULL,
  `code` varchar(4) DEFAULT NULL,
  `minor_unit` smallint(6) DEFAULT NULL,
  `symbol` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`country`, `currency`, `code`, `minor_unit`, `symbol`) VALUES
('Afghanistan', 'Afghani', 'AFN', 2, '؋'),
('Åland Islands', 'Euro', 'EUR', 2, '€'),
('Albania', 'Lek', 'ALL', 2, 'Lek'),
('Algeria', 'Algerian Dinar', 'DZD', 2, NULL),
('American Samoa', 'US Dollar', 'USD', 2, '$'),
('Andorra', 'Euro', 'EUR', 2, '€'),
('Angola', 'Kwanza', 'AOA', 2, NULL),
('Anguilla', 'East Caribbean Dollar', 'XCD', 2, NULL),
('Antigua And Barbuda', 'East Caribbean Dollar', 'XCD', 2, NULL),
('Argentina', 'Argentine Peso', 'ARS', 2, '$'),
('Armenia', 'Armenian Dram', 'AMD', 2, NULL),
('Aruba', 'Aruban Florin', 'AWG', 2, NULL),
('Australia', 'Australian Dollar', 'AUD', 2, '$'),
('Austria', 'Euro', 'EUR', 2, '€'),
('Azerbaijan', 'Azerbaijan Manat', 'AZN', 2, NULL),
('Bahamas', 'Bahamian Dollar', 'BSD', 2, '$'),
('Bahrain', 'Bahraini Dinar', 'BHD', 3, NULL),
('Bangladesh', 'Taka', 'BDT', 2, '৳'),
('Barbados', 'Barbados Dollar', 'BBD', 2, '$'),
('Belarus', 'Belarusian Ruble', 'BYN', 2, NULL),
('Belgium', 'Euro', 'EUR', 2, '€'),
('Belize', 'Belize Dollar', 'BZD', 2, 'BZ$'),
('Benin', 'CFA Franc BCEAO', 'XOF', 0, NULL),
('Bermuda', 'Bermudian Dollar', 'BMD', 2, NULL),
('Bhutan', 'Indian Rupee', 'INR', 2, '₹'),
('Bhutan', 'Ngultrum', 'BTN', 2, NULL),
('Bolivia', 'Boliviano', 'BOB', 2, NULL),
('Bolivia', 'Mvdol', 'BOV', 2, NULL),
('Bonaire, Sint Eustatius And Saba', 'US Dollar', 'USD', 2, '$'),
('Bosnia And Herzegovina', 'Convertible Mark', 'BAM', 2, NULL),
('Botswana', 'Pula', 'BWP', 2, NULL),
('Bouvet Island', 'Norwegian Krone', 'NOK', 2, NULL),
('Brazil', 'Brazilian Real', 'BRL', 2, 'R$'),
('British Indian Ocean Territory', 'US Dollar', 'USD', 2, '$'),
('Brunei Darussalam', 'Brunei Dollar', 'BND', 2, NULL),
('Bulgaria', 'Bulgarian Lev', 'BGN', 2, 'лв'),
('Burkina Faso', 'CFA Franc BCEAO', 'XOF', 0, NULL),
('Burundi', 'Burundi Franc', 'BIF', 0, NULL),
('Cabo Verde', 'Cabo Verde Escudo', 'CVE', 2, NULL),
('Cambodia', 'Riel', 'KHR', 2, '៛'),
('Cameroon', 'CFA Franc BEAC', 'XAF', 0, NULL),
('Canada', 'Canadian Dollar', 'CAD', 2, '$'),
('Cayman Islands', 'Cayman Islands Dollar', 'KYD', 2, NULL),
('Central African Republic', 'CFA Franc BEAC', 'XAF', 0, NULL),
('Chad', 'CFA Franc BEAC', 'XAF', 0, NULL),
('Chile', 'Chilean Peso', 'CLP', 0, '$'),
('Chile', 'Unidad de Fomento', 'CLF', 4, NULL),
('China', 'Yuan Renminbi', 'CNY', 2, '¥'),
('Christmas Island', 'Australian Dollar', 'AUD', 2, NULL),
('Cocos (keeling) Islands', 'Australian Dollar', 'AUD', 2, NULL),
('Colombia', 'Colombian Peso', 'COP', 2, '$'),
('Colombia', 'Unidad de Valor Real', 'COU', 2, NULL),
('Comoros', 'Comorian Franc ', 'KMF', 0, NULL),
('Congo (the Democratic Republic Of The)', 'Congolese Franc', 'CDF', 2, NULL),
('Congo', 'CFA Franc BEAC', 'XAF', 0, NULL),
('Cook Islands', 'New Zealand Dollar', 'NZD', 2, '$'),
('Costa Rica', 'Costa Rican Colon', 'CRC', 2, NULL),
('Côte D\'ivoire', 'CFA Franc BCEAO', 'XOF', 0, NULL),
('Croatia', 'Kuna', 'HRK', 2, 'kn'),
('Cuba', 'Cuban Peso', 'CUP', 2, NULL),
('Cuba', 'Peso Convertible', 'CUC', 2, NULL),
('Curaçao', 'Netherlands Antillean Guilder', 'ANG', 2, NULL),
('Cyprus', 'Euro', 'EUR', 2, '€'),
('Czechia', 'Czech Koruna', 'CZK', 2, 'Kč'),
('Denmark', 'Danish Krone', 'DKK', 2, 'kr'),
('Djibouti', 'Djibouti Franc', 'DJF', 0, NULL),
('Dominica', 'East Caribbean Dollar', 'XCD', 2, NULL),
('Dominican Republic', 'Dominican Peso', 'DOP', 2, NULL),
('Ecuador', 'US Dollar', 'USD', 2, '$'),
('Egypt', 'Egyptian Pound', 'EGP', 2, NULL),
('El Salvador', 'El Salvador Colon', 'SVC', 2, NULL),
('El Salvador', 'US Dollar', 'USD', 2, '$'),
('Equatorial Guinea', 'CFA Franc BEAC', 'XAF', 0, NULL),
('Eritrea', 'Nakfa', 'ERN', 2, NULL),
('Estonia', 'Euro', 'EUR', 2, '€'),
('Eswatini', 'Lilangeni', 'SZL', 2, NULL),
('Ethiopia', 'Ethiopian Birr', 'ETB', 2, NULL),
('European Union', 'Euro', 'EUR', 2, '€'),
('Falkland Islands [Malvinas]', 'Falkland Islands Pound', 'FKP', 2, NULL),
('Faroe Islands', 'Danish Krone', 'DKK', 2, NULL),
('Fiji', 'Fiji Dollar', 'FJD', 2, NULL),
('Finland', 'Euro', 'EUR', 2, '€'),
('France', 'Euro', 'EUR', 2, '€'),
('French Guiana', 'Euro', 'EUR', 2, '€'),
('French Polynesia', 'CFP Franc', 'XPF', 0, NULL),
('French Southern Territories', 'Euro', 'EUR', 2, '€'),
('Gabon', 'CFA Franc BEAC', 'XAF', 0, NULL),
('Gambia', 'Dalasi', 'GMD', 2, NULL),
('Georgia', 'Lari', 'GEL', 2, '₾'),
('Germany', 'Euro', 'EUR', 2, '€'),
('Ghana', 'Ghana Cedi', 'GHS', 2, NULL),
('Gibraltar', 'Gibraltar Pound', 'GIP', 2, NULL),
('Greece', 'Euro', 'EUR', 2, '€'),
('Greenland', 'Danish Krone', 'DKK', 2, NULL),
('Grenada', 'East Caribbean Dollar', 'XCD', 2, NULL),
('Guadeloupe', 'Euro', 'EUR', 2, '€'),
('Guam', 'US Dollar', 'USD', 2, '$'),
('Guatemala', 'Quetzal', 'GTQ', 2, NULL),
('Guernsey', 'Pound Sterling', 'GBP', 2, '£'),
('Guinea', 'Guinean Franc', 'GNF', 0, NULL),
('Guinea-bissau', 'CFA Franc BCEAO', 'XOF', 0, NULL),
('Guyana', 'Guyana Dollar', 'GYD', 2, NULL),
('Haiti', 'Gourde', 'HTG', 2, NULL),
('Haiti', 'US Dollar', 'USD', 2, '$'),
('Heard Island And Mcdonald Islands', 'Australian Dollar', 'AUD', 2, NULL),
('Holy See (Vatican)', 'Euro', 'EUR', 2, '€'),
('Honduras', 'Lempira', 'HNL', 2, NULL),
('Hong Kong', 'Hong Kong Dollar', 'HKD', 2, '$'),
('Hungary', 'Forint', 'HUF', 2, 'ft'),
('Iceland', 'Iceland Krona', 'ISK', 0, NULL),
('India', 'Indian Rupee', 'INR', 2, '₹'),
('Indonesia', 'Rupiah', 'IDR', 2, 'Rp'),
('International Monetary Fund (IMF)', 'SDR (Special Drawing Right)', 'XDR', 0, NULL),
('Iran', 'Iranian Rial', 'IRR', 2, NULL),
('Iraq', 'Iraqi Dinar', 'IQD', 3, NULL),
('Ireland', 'Euro', 'EUR', 2, '€'),
('Isle Of Man', 'Pound Sterling', 'GBP', 2, '£'),
('Israel', 'New Israeli Sheqel', 'ILS', 2, '₪'),
('Italy', 'Euro', 'EUR', 2, '€'),
('Jamaica', 'Jamaican Dollar', 'JMD', 2, NULL),
('Japan', 'Yen', 'JPY', 0, '¥'),
('Jersey', 'Pound Sterling', 'GBP', 2, '£'),
('Jordan', 'Jordanian Dinar', 'JOD', 3, NULL),
('Kazakhstan', 'Tenge', 'KZT', 2, NULL),
('Kenya', 'Kenyan Shilling', 'KES', 2, 'Ksh'),
('Kiribati', 'Australian Dollar', 'AUD', 2, NULL),
('Korea (the Democratic People’s Republic Of)', 'North Korean Won', 'KPW', 2, NULL),
('Korea (the Republic Of)', 'Won', 'KRW', 0, '₩'),
('Kuwait', 'Kuwaiti Dinar', 'KWD', 3, NULL),
('Kyrgyzstan', 'Som', 'KGS', 2, NULL),
('Lao People’s Democratic Republic', 'Lao Kip', 'LAK', 2, NULL),
('Latvia', 'Euro', 'EUR', 2, '€'),
('Lebanon', 'Lebanese Pound', 'LBP', 2, NULL),
('Lesotho', 'Loti', 'LSL', 2, NULL),
('Lesotho', 'Rand', 'ZAR', 2, NULL),
('Liberia', 'Liberian Dollar', 'LRD', 2, NULL),
('Libya', 'Libyan Dinar', 'LYD', 3, NULL),
('Liechtenstein', 'Swiss Franc', 'CHF', 2, NULL),
('Lithuania', 'Euro', 'EUR', 2, '€'),
('Luxembourg', 'Euro', 'EUR', 2, '€'),
('Macao', 'Pataca', 'MOP', 2, NULL),
('North Macedonia', 'Denar', 'MKD', 2, NULL),
('Madagascar', 'Malagasy Ariary', 'MGA', 2, NULL),
('Malawi', 'Malawi Kwacha', 'MWK', 2, NULL),
('Malaysia', 'Malaysian Ringgit', 'MYR', 2, 'RM'),
('Maldives', 'Rufiyaa', 'MVR', 2, NULL),
('Mali', 'CFA Franc BCEAO', 'XOF', 0, NULL),
('Malta', 'Euro', 'EUR', 2, '€'),
('Marshall Islands', 'US Dollar', 'USD', 2, '$'),
('Martinique', 'Euro', 'EUR', 2, '€'),
('Mauritania', 'Ouguiya', 'MRU', 2, NULL),
('Mauritius', 'Mauritius Rupee', 'MUR', 2, NULL),
('Mayotte', 'Euro', 'EUR', 2, '€'),
('Member Countries Of The African Development Bank Group', 'ADB Unit of Account', 'XUA', 0, NULL),
('Mexico', 'Mexican Peso', 'MXN', 2, '$'),
('Mexico', 'Mexican Unidad de Inversion (UDI)', 'MXV', 2, NULL),
('Micronesia', 'US Dollar', 'USD', 2, '$'),
('Moldova', 'Moldovan Leu', 'MDL', 2, NULL),
('Monaco', 'Euro', 'EUR', 2, '€'),
('Mongolia', 'Tugrik', 'MNT', 2, NULL),
('Montenegro', 'Euro', 'EUR', 2, '€'),
('Montserrat', 'East Caribbean Dollar', 'XCD', 2, NULL),
('Morocco', 'Moroccan Dirham', 'MAD', 2, ' .د.م '),
('Mozambique', 'Mozambique Metical', 'MZN', 2, NULL),
('Myanmar', 'Kyat', 'MMK', 2, NULL),
('Namibia', 'Namibia Dollar', 'NAD', 2, NULL),
('Namibia', 'Rand', 'ZAR', 2, NULL),
('Nauru', 'Australian Dollar', 'AUD', 2, NULL),
('Nepal', 'Nepalese Rupee', 'NPR', 2, NULL),
('Netherlands', 'Euro', 'EUR', 2, '€'),
('New Caledonia', 'CFP Franc', 'XPF', 0, NULL),
('New Zealand', 'New Zealand Dollar', 'NZD', 2, '$'),
('Nicaragua', 'Cordoba Oro', 'NIO', 2, NULL),
('Niger', 'CFA Franc BCEAO', 'XOF', 0, NULL),
('Nigeria', 'Naira', 'NGN', 2, '₦'),
('Niue', 'New Zealand Dollar', 'NZD', 2, '$'),
('Norfolk Island', 'Australian Dollar', 'AUD', 2, NULL),
('Northern Mariana Islands', 'US Dollar', 'USD', 2, '$'),
('Norway', 'Norwegian Krone', 'NOK', 2, 'kr'),
('Oman', 'Rial Omani', 'OMR', 3, NULL),
('Pakistan', 'Pakistan Rupee', 'PKR', 2, 'Rs'),
('Palau', 'US Dollar', 'USD', 2, '$'),
('Panama', 'Balboa', 'PAB', 2, NULL),
('Panama', 'US Dollar', 'USD', 2, '$'),
('Papua New Guinea', 'Kina', 'PGK', 2, NULL),
('Paraguay', 'Guarani', 'PYG', 0, NULL),
('Peru', 'Sol', 'PEN', 2, 'S'),
('Philippines', 'Philippine Peso', 'PHP', 2, '₱'),
('Pitcairn', 'New Zealand Dollar', 'NZD', 2, '$'),
('Poland', 'Zloty', 'PLN', 2, 'zł'),
('Portugal', 'Euro', 'EUR', 2, '€'),
('Puerto Rico', 'US Dollar', 'USD', 2, '$'),
('Qatar', 'Qatari Rial', 'QAR', 2, NULL),
('Réunion', 'Euro', 'EUR', 2, '€'),
('Romania', 'Romanian Leu', 'RON', 2, 'lei'),
('Russian Federation', 'Russian Ruble', 'RUB', 2, '₽'),
('Rwanda', 'Rwanda Franc', 'RWF', 0, NULL),
('Saint Barthélemy', 'Euro', 'EUR', 2, '€'),
('Saint Helena, Ascension And Tristan Da Cunha', 'Saint Helena Pound', 'SHP', 2, NULL),
('Saint Kitts And Nevis', 'East Caribbean Dollar', 'XCD', 2, NULL),
('Saint Lucia', 'East Caribbean Dollar', 'XCD', 2, NULL),
('Saint Martin (French Part)', 'Euro', 'EUR', 2, '€'),
('Saint Pierre And Miquelon', 'Euro', 'EUR', 2, '€'),
('Saint Vincent And The Grenadines', 'East Caribbean Dollar', 'XCD', 2, NULL),
('Samoa', 'Tala', 'WST', 2, NULL),
('San Marino', 'Euro', 'EUR', 2, '€'),
('Sao Tome And Principe', 'Dobra', 'STN', 2, NULL),
('Saudi Arabia', 'Saudi Riyal', 'SAR', 2, NULL),
('Senegal', 'CFA Franc BCEAO', 'XOF', 0, NULL),
('Serbia', 'Serbian Dinar', 'RSD', 2, NULL),
('Seychelles', 'Seychelles Rupee', 'SCR', 2, NULL),
('Sierra Leone', 'Leone', 'SLL', 2, NULL),
('Singapore', 'Singapore Dollar', 'SGD', 2, '$'),
('Sint Maarten (Dutch Part)', 'Netherlands Antillean Guilder', 'ANG', 2, NULL),
('Sistema Unitario De Compensacion Regional De Pagos \"sucre\"\"\"', 'Sucre', 'XSU', 0, NULL),
('Slovakia', 'Euro', 'EUR', 2, '€'),
('Slovenia', 'Euro', 'EUR', 2, '€'),
('Solomon Islands', 'Solomon Islands Dollar', 'SBD', 2, NULL),
('Somalia', 'Somali Shilling', 'SOS', 2, NULL),
('South Africa', 'Rand', 'ZAR', 2, 'R'),
('South Sudan', 'South Sudanese Pound', 'SSP', 2, NULL),
('Spain', 'Euro', 'EUR', 2, '€'),
('Sri Lanka', 'Sri Lanka Rupee', 'LKR', 2, 'Rs'),
('Sudan (the)', 'Sudanese Pound', 'SDG', 2, NULL),
('Suriname', 'Surinam Dollar', 'SRD', 2, NULL),
('Svalbard And Jan Mayen', 'Norwegian Krone', 'NOK', 2, NULL),
('Sweden', 'Swedish Krona', 'SEK', 2, 'kr'),
('Switzerland', 'Swiss Franc', 'CHF', 2, NULL),
('Switzerland', 'WIR Euro', 'CHE', 2, NULL),
('Switzerland', 'WIR Franc', 'CHW', 2, NULL),
('Syrian Arab Republic', 'Syrian Pound', 'SYP', 2, NULL),
('Taiwan', 'New Taiwan Dollar', 'TWD', 2, NULL),
('Tajikistan', 'Somoni', 'TJS', 2, NULL),
('Tanzania, United Republic Of', 'Tanzanian Shilling', 'TZS', 2, NULL),
('Thailand', 'Baht', 'THB', 2, '฿'),
('Timor-leste', 'US Dollar', 'USD', 2, '$'),
('Togo', 'CFA Franc BCEAO', 'XOF', 0, NULL),
('Tokelau', 'New Zealand Dollar', 'NZD', 2, '$'),
('Tonga', 'Pa’anga', 'TOP', 2, NULL),
('Trinidad And Tobago', 'Trinidad and Tobago Dollar', 'TTD', 2, NULL),
('Tunisia', 'Tunisian Dinar', 'TND', 3, NULL),
('Turkey', 'Turkish Lira', 'TRY', 2, '₺'),
('Turkmenistan', 'Turkmenistan New Manat', 'TMT', 2, NULL),
('Turks And Caicos Islands', 'US Dollar', 'USD', 2, '$'),
('Tuvalu', 'Australian Dollar', 'AUD', 2, NULL),
('Uganda', 'Uganda Shilling', 'UGX', 0, NULL),
('Ukraine', 'Hryvnia', 'UAH', 2, '₴'),
('United Arab Emirates', 'UAE Dirham', 'AED', 2, 'د.إ'),
('United Kingdom Of Great Britain And Northern Ireland', 'Pound Sterling', 'GBP', 2, '£'),
('United States Minor Outlying Islands', 'US Dollar', 'USD', 2, '$'),
('United States Of America', 'US Dollar', 'USD', 2, '$'),
('United States Of America', 'US Dollar (Next day)', 'USN', 2, NULL),
('Uruguay', 'Peso Uruguayo', 'UYU', 2, NULL),
('Uruguay', 'Uruguay Peso en Unidades Indexadas (UI)', 'UYI', 0, NULL),
('Uruguay', 'Unidad Previsional', 'UYW', 4, NULL),
('Uzbekistan', 'Uzbekistan Sum', 'UZS', 2, NULL),
('Vanuatu', 'Vatu', 'VUV', 0, NULL),
('Venezuela', 'Bolívar Soberano', 'VES', 2, NULL),
('Vietnam', 'Dong', 'VND', 0, '₫'),
('Virgin Islands (British)', 'US Dollar', 'USD', 2, '$'),
('Virgin Islands (U.S.)', 'US Dollar', 'USD', 2, '$'),
('Wallis And Futuna', 'CFP Franc', 'XPF', 0, NULL),
('Western Sahara', 'Moroccan Dirham', 'MAD', 2, NULL),
('Yemen', 'Yemeni Rial', 'YER', 2, NULL),
('Zambia', 'Zambian Kwacha', 'ZMW', 2, NULL),
('Zimbabwe', 'Zimbabwe Dollar', 'ZWL', 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `currency_type`
--

CREATE TABLE `currency_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currency_type`
--

INSERT INTO `currency_type` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'USDT-TRC20-TRX', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(2, 'USDT-ERC20', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(3, 'USDT-OMNI', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(4, 'BTC', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(5, 'LTC', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(6, 'ETH', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(7, 'TRX', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11'),
(8, 'ADA', 1, '2024-03-21 19:13:11', '2024-03-21 19:13:11');

-- --------------------------------------------------------

--
-- Table structure for table `deposit_request`
--

CREATE TABLE `deposit_request` (
  `id` int(11) NOT NULL,
  `depositID` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `merchant_id` int(11) DEFAULT NULL,
  `deposit_amount` double(10,2) DEFAULT NULL,
  `receivable_amount` double(10,2) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `to_crypto_wallet_address` varchar(255) DEFAULT NULL,
  `trxId` varchar(255) DEFAULT NULL,
  `depscription` text DEFAULT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '0=Review,2=Reject,1=Approved',
  `approved_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deposit_request`
--

INSERT INTO `deposit_request` (`id`, `depositID`, `user_id`, `merchant_id`, `deposit_amount`, `receivable_amount`, `payment_method`, `to_crypto_wallet_address`, `trxId`, `depscription`, `wallet_address`, `status`, `approved_by`, `created_at`, `updated_at`) VALUES
(1, 'DEPOSIT.0127b06252935c330e9f23651b398ce4', 6, 3, 600.00, NULL, NULL, 'B8gYf7P0Wm0X7F2T9hQ0J3y1b8g0d6m9oG', NULL, NULL, NULL, 0, NULL, '2025-01-16 02:41:56', '2025-01-16 02:41:56'),
(2, 'DEPOSIT.7e8750d4a701596732953c160d2ae096', 6, 3, 1050.00, NULL, NULL, 'X9F0t2b7m0Q3Z8d9gY6L2J1V5n3H6p0W2', NULL, NULL, NULL, 0, NULL, '2025-01-16 02:50:33', '2025-01-16 02:50:33'),
(3, 'DEPOSIT.c4de8ced6214345614d33fb0b16a8acd', 6, 3, 650.00, NULL, NULL, '7gMr8zP2XkS4tD5nJ1p5V1Hq9bR4G9x0o', NULL, NULL, NULL, 0, NULL, '2025-01-16 04:29:27', '2025-01-16 04:29:27');

-- --------------------------------------------------------

--
-- Table structure for table `facility_group`
--

CREATE TABLE `facility_group` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `facility_group`
--

INSERT INTO `facility_group` (`id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'General Amenities', 'general-amenities', 1, '2025-04-01 15:45:39', '2025-04-01 15:45:39'),
(2, 'Bed & Comfort', 'bed-comfort', 1, '2025-04-01 15:45:45', '2025-04-01 15:45:45'),
(3, 'Bathroom Facilities', 'bathroom-facilities', 1, '2025-04-01 15:45:51', '2025-04-01 15:45:51'),
(4, 'Kitchen & Dining', 'kitchen-dining', 1, '2025-04-01 15:45:57', '2025-04-01 15:45:57'),
(5, 'Technology & Security', 'technology-security', 1, '2025-04-01 15:46:04', '2025-04-01 15:46:04'),
(6, 'Leisure & Extras', 'leisure-extras', 1, '2025-04-01 15:46:11', '2025-04-01 15:46:11'),
(7, 'Additional Services', 'additional-services', 1, '2025-04-01 15:46:16', '2025-04-01 15:46:16'),
(8, 'In your private bathroom', 'in-your-private-bathroom', 1, '2025-04-03 06:17:45', '2025-04-03 06:17:45'),
(9, 'View', 'view', 1, '2025-04-03 06:19:20', '2025-04-03 06:19:20'),
(10, 'Bungalow facilities', 'bungalow-facilities', 1, '2025-04-03 06:20:15', '2025-04-03 06:20:15'),
(11, 'Smoking', 'smoking', 1, '2025-04-03 06:41:03', '2025-04-03 06:41:03'),
(12, 'Bungalow with Sea View', 'bungalow-with-sea-view', 1, '2025-04-03 06:44:46', '2025-04-03 06:44:46'),
(13, 'Executive Suite', 'executive-suite', 1, '2025-04-03 08:56:39', '2025-04-03 08:56:39');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `global_wallet_address`
--

CREATE TABLE `global_wallet_address` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  `lock_unlock` int(11) NOT NULL COMMENT '1=lock,0=unlock',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `invoice_create_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice_items`
--

INSERT INTO `invoice_items` (`id`, `booking_id`, `item_id`, `name`, `qty`, `price`, `total`, `invoice_create_by`, `created_at`, `updated_at`) VALUES
(1, 82179, 65, 'Almond Pack', 25, 17.00, 425.00, 1, '2025-05-31 15:35:49', '2025-05-31 15:35:49'),
(2, 82179, 422, 'Apple Juice Bottle', 40, 18.00, 720.00, 1, '2025-05-31 15:36:11', '2025-05-31 15:36:11'),
(3, 82179, 81, 'Boiled Egg', 30, 6.00, 180.00, 1, '2025-05-31 15:36:15', '2025-05-31 15:36:15'),
(4, 82179, 5, 'Body Lotion 205', 34, 1.88, 63.92, 1, '2025-05-31 15:40:09', '2025-05-31 15:40:09'),
(6, 12505, 119, 'Apple', 45, 7.00, 315.00, 1, '2025-06-01 08:39:18', '2025-06-01 08:39:18'),
(7, 12505, 118, 'Banana', 50, 6.00, 300.00, 1, '2025-06-01 08:39:20', '2025-06-01 08:39:20'),
(8, 12505, 108, 'Apple Pie', 15, 20.00, 300.00, 1, '2025-06-01 08:50:56', '2025-06-01 08:50:56'),
(9, 29741, 425, 'Vegetable Soup', 25, 15.75, 393.75, 1, '2025-06-02 06:13:32', '2025-06-02 06:13:32'),
(10, 29741, 119, 'Apple', 45, 7.00, 315.00, 1, '2025-06-02 06:13:36', '2025-06-02 06:13:36'),
(11, 29741, 32, 'Biscuits 232', 72, 20.59, 1482.48, 1, '2025-06-02 06:13:43', '2025-06-02 06:13:43'),
(12, 29741, 31, 'Mineral Water 231', 9, 45.48, 409.32, 1, '2025-06-02 06:14:14', '2025-06-02 06:14:14'),
(13, 29741, 442, 'Apple Pie Slice', 15, 16.00, 240.00, 1, '2025-06-02 06:14:30', '2025-06-02 06:14:30'),
(14, 0, 117, 'Apple Juice', 35, 12.50, 437.50, 1, '2025-06-03 20:20:47', '2025-06-03 20:20:47'),
(15, 0, 108, 'Apple Pie', 15, 20.00, 300.00, 1, '2025-06-03 20:20:47', '2025-06-03 20:20:47'),
(16, 0, 75, 'Beef Sandwich', 15, 22.00, 330.00, 1, '2025-06-03 20:20:47', '2025-06-03 20:20:47');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `quantity` int(11) DEFAULT 0,
  `unit_price` decimal(10,2) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `quantity`, `unit_price`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'Comb 201', 85, 29.91, 1, 'Comb 201 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(2, 'Shaving Kit 202', 61, 4.39, 1, 'Shaving Kit 202 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(3, 'Shower Cap 203', 4, 17.43, 1, 'Shower Cap 203 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(4, 'Cotton Buds 204', 93, 43.12, 1, 'Cotton Buds 204 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:30'),
(5, 'Body Lotion 205', 34, 1.88, 1, 'Body Lotion 205 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(6, 'Hair Dryer 206', 96, 49.73, 1, 'Hair Dryer 206 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(7, 'Iron 207', 57, 4.63, 1, 'Iron 207 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(8, 'Iron Board 208', 10, 34.86, 1, 'Iron Board 208 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(9, 'Hangers 209', 26, 43.93, 1, 'Hangers 209 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(10, 'Laundry Bag 210', 55, 14.98, 1, 'Laundry Bag 210 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(11, 'Room Freshener 211', 71, 23.24, 1, 'Room Freshener 211 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(12, 'Notepad 212', 14, 33.93, 1, 'Notepad 212 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(13, 'Pen 213', 22, 10.96, 1, 'Pen 213 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(14, 'TV Remote 214', 44, 10.04, 1, 'TV Remote 214 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(15, 'AC Remote 215', 30, 30.39, 1, 'AC Remote 215 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(16, 'Menu Card 216', 98, 49.03, 1, 'Menu Card 216 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(17, 'Do Not Disturb Sign 217', 16, 7.76, 1, 'Do Not Disturb Sign 217 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(18, 'Laundry Price List 218', 66, 40.12, 1, 'Laundry Price List 218 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(19, 'Sewing Kit 219', 87, 17.84, 1, 'Sewing Kit 219 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(20, 'Tea Bags 220', 33, 20.12, 1, 'Tea Bags 220 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(21, 'Coffee Sachets 221', 74, 15.87, 1, 'Coffee Sachets 221 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(22, 'Sugar Sachets 222', 38, 45.48, 1, 'Sugar Sachets 222 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(23, 'Creamer 223', 7, 17.65, 1, 'Creamer 223 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(24, 'Electric Kettle 224', 59, 4.49, 1, 'Electric Kettle 224 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(25, 'Coffee Mug 225', 25, 26.38, 1, 'Coffee Mug 225 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(26, 'Glass 226', 27, 20.48, 1, 'Glass 226 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(27, 'Ashtray 227', 52, 43.99, 1, 'Ashtray 227 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(28, 'Pillow 228', 11, 4.38, 1, 'Pillow 228 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(29, 'Bedsheet 229', 43, 33.25, 1, 'Bedsheet 229 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(30, 'Blanket 230', 5, 14.94, 1, 'Blanket 230 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(31, 'Mineral Water 231', 9, 45.48, 1, 'Mineral Water 231 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(32, 'Biscuits 232', 72, 20.59, 1, 'Biscuits 232 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(33, 'Tissue Box 233', 67, 32.12, 1, 'Tissue Box 233 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(34, 'Shampoo 234', 18, 19.44, 1, 'Shampoo 234 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(35, 'Toothbrush 235', 84, 13.83, 1, 'Toothbrush 235 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(36, 'Toothpaste 236', 60, 41.23, 1, 'Toothpaste 236 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(37, 'Bath Towel 237', 93, 38.64, 1, 'Bath Towel 237 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(38, 'Hand Towel 238', 90, 3.51, 1, 'Hand Towel 238 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(39, 'Soap 239', 42, 9.87, 1, 'Soap 239 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(40, 'Slippers 240', 36, 11.73, 1, 'Slippers 240 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(41, 'Comb 241', 87, 6.66, 1, 'Comb 241 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(42, 'Shaving Kit 242', 73, 37.42, 1, 'Shaving Kit 242 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(43, 'Shower Cap 243', 15, 30.01, 1, 'Shower Cap 243 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(44, 'Cotton Buds 244', 76, 33.79, 1, 'Cotton Buds 244 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(45, 'Body Lotion 245', 8, 28.16, 1, 'Body Lotion 245 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(46, 'Hair Dryer 246', 64, 9.46, 1, 'Hair Dryer 246 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(47, 'Iron 247', 3, 36.93, 1, 'Iron 247 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(48, 'Iron Board 248', 70, 19.58, 1, 'Iron Board 248 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(49, 'Hangers 249', 99, 38.15, 1, 'Hangers 249 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:12:37'),
(50, 'Laundry Bag 250', 45, 14.27, 1, 'Laundry Bag 250 standard supply', '2025-05-22 19:07:06', '2025-05-22 19:07:06'),
(51, 'Chips Pack', 50, 10.50, 1, 'Chips Pack standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(52, 'Chocolate Bar', 40, 12.00, 1, 'Chocolate Bar standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(53, 'Salted Peanuts', 30, 8.75, 1, 'Salted Peanuts standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(54, 'Mixed Dry Fruits', 25, 15.20, 1, 'Mixed Dry Fruits standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(55, 'Instant Noodles', 60, 7.50, 1, 'Instant Noodles standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(56, 'Cup Noodles', 45, 6.90, 1, 'Cup Noodles standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(57, 'Fruit Cake', 20, 18.00, 1, 'Fruit Cake standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(58, 'Plain Biscuits', 80, 5.50, 1, 'Plain Biscuits standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(59, 'Cream Biscuits', 70, 6.20, 1, 'Cream Biscuits standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(60, 'Butter Cookies', 55, 9.30, 1, 'Butter Cookies standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(61, 'Cheese Crackers', 40, 11.00, 1, 'Cheese Crackers standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(62, 'Granola Bar', 35, 8.90, 1, 'Granola Bar standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(63, 'Protein Bar', 30, 14.25, 1, 'Protein Bar standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(64, 'Cashew Nuts', 20, 16.75, 1, 'Cashew Nuts standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(65, 'Almond Pack', 25, 17.00, 1, 'Almond Pack standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(66, 'Raisin Mix', 30, 12.80, 1, 'Raisin Mix standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(67, 'Trail Mix', 35, 13.45, 1, 'Trail Mix standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(68, 'Jelly Cup', 40, 4.90, 1, 'Jelly Cup standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(69, 'Cupcake', 25, 9.90, 1, 'Cupcake standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(70, 'Muffin', 30, 10.50, 1, 'Muffin standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(71, 'Croissant', 15, 12.00, 1, 'Croissant standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(72, 'Bread Roll', 20, 7.00, 1, 'Bread Roll standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(73, 'Chicken Sandwich', 18, 20.50, 1, 'Chicken Sandwich standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(74, 'Veg Sandwich', 22, 17.50, 1, 'Veg Sandwich standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(75, 'Beef Sandwich', 15, 22.00, 1, 'Beef Sandwich standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(76, 'Club Sandwich', 12, 24.00, 1, 'Club Sandwich standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(77, 'Tuna Sandwich', 10, 21.00, 1, 'Tuna Sandwich standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(78, 'Fruit Bowl', 10, 19.00, 1, 'Fruit Bowl standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(79, 'Mixed Salad', 8, 18.50, 1, 'Mixed Salad standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(80, 'Yogurt Cup', 20, 9.50, 1, 'Yogurt Cup standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(81, 'Boiled Egg', 30, 6.00, 1, 'Boiled Egg standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(82, 'Scrambled Egg', 25, 8.50, 1, 'Scrambled Egg standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(83, 'Cheese Omelette', 18, 10.75, 1, 'Cheese Omelette standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(84, 'Chicken Nuggets', 15, 16.00, 1, 'Chicken Nuggets standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(85, 'French Fries', 20, 14.00, 1, 'French Fries standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(86, 'Mini Pizza', 10, 25.00, 1, 'Mini Pizza standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(87, 'Samosa', 30, 5.50, 1, 'Samosa standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(88, 'Spring Rolls', 25, 8.00, 1, 'Spring Rolls standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(89, 'Chicken Wings', 15, 22.50, 1, 'Chicken Wings standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(90, 'Grilled Sandwich', 12, 19.00, 1, 'Grilled Sandwich standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(91, 'Fish Fingers', 14, 20.00, 1, 'Fish Fingers standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(92, 'Veg Pulao', 10, 24.00, 1, 'Veg Pulao standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(93, 'Chicken Biryani', 8, 30.00, 1, 'Chicken Biryani standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(94, 'Fried Rice', 15, 22.00, 1, 'Fried Rice standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(95, 'Naan Bread', 25, 6.00, 1, 'Naan Bread standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(96, 'Chapati', 30, 5.00, 1, 'Chapati standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(97, 'Butter Naan', 20, 6.50, 1, 'Butter Naan standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(98, 'Paratha', 18, 7.00, 1, 'Paratha standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(99, 'Chicken Curry', 10, 28.00, 1, 'Chicken Curry standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(100, 'Paneer Curry', 12, 25.00, 1, 'Paneer Curry standard supply', '2025-05-22 19:09:28', '2025-05-22 19:09:28'),
(101, 'Veg Burger', 20, 18.50, 1, 'Veg Burger standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(102, 'Chicken Burger', 15, 22.00, 1, 'Chicken Burger standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(103, 'Cheese Burger', 10, 24.00, 1, 'Cheese Burger standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(104, 'Hot Dog', 25, 15.50, 1, 'Hot Dog standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(105, 'French Baguette', 12, 8.00, 1, 'French Baguette standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(106, 'Croissant Chocolate', 10, 13.50, 1, 'Croissant Chocolate standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(107, 'Blueberry Muffin', 20, 11.00, 1, 'Blueberry Muffin standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(108, 'Apple Pie', 15, 20.00, 1, 'Apple Pie standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(109, 'Chocolate Cake Slice', 18, 25.00, 1, 'Chocolate Cake Slice standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(110, 'Vanilla Ice Cream Cup', 22, 14.00, 1, 'Vanilla Ice Cream Cup standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(111, 'Strawberry Ice Cream Cup', 20, 14.00, 1, 'Strawberry Ice Cream Cup standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(112, 'Mango Ice Cream Cup', 18, 14.50, 1, 'Mango Ice Cream Cup standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(113, 'Fruit Yogurt', 25, 9.00, 1, 'Fruit Yogurt standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(114, 'Energy Drink', 30, 18.50, 1, 'Energy Drink standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(115, 'Soft Drink Can', 40, 10.00, 1, 'Soft Drink Can standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(116, 'Orange Juice', 35, 12.00, 1, 'Orange Juice standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(117, 'Apple Juice', 35, 12.50, 1, 'Apple Juice standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(118, 'Banana', 50, 6.00, 1, 'Banana standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(119, 'Apple', 45, 7.00, 1, 'Apple standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(120, 'Orange', 40, 6.50, 1, 'Orange standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(121, 'Pineapple Slice', 20, 8.00, 1, 'Pineapple Slice standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(122, 'Grapes Pack', 30, 9.00, 1, 'Grapes Pack standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(123, 'Watermelon Slice', 15, 7.50, 1, 'Watermelon Slice standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(124, 'Papaya Slice', 20, 7.00, 1, 'Papaya Slice standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(125, 'Mango Slice', 18, 8.50, 1, 'Mango Slice standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(126, 'Peach', 25, 8.00, 1, 'Peach standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(127, 'Plum', 20, 7.50, 1, 'Plum standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(128, 'Cherry Pack', 15, 10.00, 1, 'Cherry Pack standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(129, 'Mixed Fruit Pack', 30, 15.00, 1, 'Mixed Fruit Pack standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(130, 'Cereal Box', 40, 18.00, 1, 'Cereal Box standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(131, 'Oatmeal Pack', 35, 20.00, 1, 'Oatmeal Pack standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(132, 'Honey Jar', 15, 25.00, 1, 'Honey Jar standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(133, 'Peanut Butter Jar', 20, 22.00, 1, 'Peanut Butter Jar standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(134, 'Jam Jar', 25, 18.50, 1, 'Jam Jar standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(135, 'Cheddar Cheese', 15, 28.00, 1, 'Cheddar Cheese standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(136, 'Mozzarella Cheese', 15, 30.00, 1, 'Mozzarella Cheese standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(137, 'Cream Cheese', 20, 24.00, 1, 'Cream Cheese standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(138, 'Yogurt Drink', 25, 10.00, 1, 'Yogurt Drink standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(139, 'Buttermilk', 20, 8.00, 1, 'Buttermilk standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(140, 'Butter Pack', 15, 20.00, 1, 'Butter Pack standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(141, 'Salt Pack', 50, 5.00, 1, 'Salt Pack standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(142, 'Black Pepper Pack', 40, 7.00, 1, 'Black Pepper Pack standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(143, 'Sugar Pack', 45, 6.50, 1, 'Sugar Pack standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(144, 'Tea Bags Box', 30, 15.00, 1, 'Tea Bags Box standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(145, 'Coffee Sachets Box', 30, 20.00, 1, 'Coffee Sachets Box standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(146, 'Instant Coffee', 25, 18.50, 1, 'Instant Coffee standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(147, 'Milk Pack', 40, 12.00, 1, 'Milk Pack standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(148, 'Soy Milk Pack', 20, 14.00, 1, 'Soy Milk Pack standard supply', '2025-05-22 19:10:34', '2025-05-22 19:10:34'),
(422, 'Apple Juice Bottle', 40, 18.00, 1, 'Apple Juice Bottle standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(423, 'Orange Juice Bottle', 35, 17.50, 1, 'Orange Juice Bottle standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(424, 'Mango Juice Pack', 30, 19.00, 1, 'Mango Juice Pack standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(425, 'Vegetable Soup', 25, 15.75, 1, 'Vegetable Soup standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(426, 'Chicken Soup', 20, 18.50, 1, 'Chicken Soup standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(427, 'Beef Jerky Pack', 15, 22.00, 1, 'Beef Jerky Pack standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(428, 'Mixed Berry Jam', 30, 14.00, 1, 'Mixed Berry Jam standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(429, 'Maple Syrup Bottle', 15, 20.00, 1, 'Maple Syrup Bottle standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(430, 'Butter Stick', 40, 10.50, 1, 'Butter Stick standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(431, 'Cream Cheese Tub', 35, 12.00, 1, 'Cream Cheese Tub standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(432, 'Whipped Cream Can', 30, 14.75, 1, 'Whipped Cream Can standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(433, 'Salami Slices', 25, 22.50, 1, 'Salami Slices standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(434, 'Turkey Slices', 20, 21.00, 1, 'Turkey Slices standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(435, 'Ham Slices', 25, 20.00, 1, 'Ham Slices standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(436, 'Sausage Roll', 30, 15.50, 1, 'Sausage Roll standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(437, 'Chocolate Muffin', 40, 12.75, 1, 'Chocolate Muffin standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(438, 'Vanilla Cake Slice', 20, 18.00, 1, 'Vanilla Cake Slice standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(439, 'Carrot Cake Slice', 18, 19.50, 1, 'Carrot Cake Slice standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(440, 'Cheesecake Slice', 15, 20.00, 1, 'Cheesecake Slice standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(441, 'Blueberry Tart', 20, 17.50, 1, 'Blueberry Tart standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(442, 'Apple Pie Slice', 15, 16.00, 1, 'Apple Pie Slice standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(443, 'Brownie Square', 35, 13.00, 1, 'Brownie Square standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(444, 'Lemon Tart', 25, 14.25, 1, 'Lemon Tart standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(445, 'Pistachio Nuts Pack', 30, 21.00, 1, 'Pistachio Nuts Pack standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(446, 'Walnut Pack', 20, 19.50, 1, 'Walnut Pack standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(447, 'Macadamia Nuts Pack', 15, 23.00, 1, 'Macadamia Nuts Pack standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(448, 'Popcorn Bag', 50, 9.00, 1, 'Popcorn Bag standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(449, 'Pretzel Pack', 40, 8.50, 1, 'Pretzel Pack standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(450, 'Greek Yogurt', 30, 11.50, 1, 'Greek Yogurt standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(451, 'Cheese Stick', 45, 13.00, 1, 'Cheese Stick standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(452, 'Salted Butter Pretzels', 35, 9.50, 1, 'Salted Butter Pretzels standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(453, 'Chocolate Covered Almonds', 25, 19.00, 1, 'Chocolate Covered Almonds standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(454, 'Chocolate Ice Cream Cup', 20, 14.00, 1, 'Chocolate Ice Cream Cup standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(455, 'Mango Pudding', 20, 16.00, 1, 'Mango Pudding standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(456, 'Chia Seed Pudding', 15, 17.00, 1, 'Chia Seed Pudding standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(457, 'Rice Krispies Treat', 30, 9.00, 1, 'Rice Krispies Treat standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(458, 'Peach Slices Can', 20, 11.00, 1, 'Peach Slices Can standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(459, 'Pineapple Slices Can', 20, 11.50, 1, 'Pineapple Slices Can standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(460, 'Canned Tuna', 25, 15.00, 1, 'Canned Tuna standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(461, 'Canned Corn', 30, 10.50, 1, 'Canned Corn standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(462, 'Pickle Jar', 20, 12.00, 1, 'Pickle Jar standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04'),
(463, 'Olives Jar', 25, 14.50, 1, 'Olives Jar standard supply', '2025-05-22 19:19:04', '2025-05-22 19:19:04');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` text NOT NULL,
  `attempts` int(10) UNSIGNED DEFAULT 0,
  `reserved_at` timestamp NULL DEFAULT NULL,
  `available_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(1, 'default', '{\"uuid\":\"6e08bc6a-fb56-41e5-8b8a-bf44b880f1ca\",\"displayName\":\"App\\\\Mail\\\\Guestsendingmail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":15:{s:8:\\\"mailable\\\";O:25:\\\"App\\\\Mail\\\\Guestsendingmail\\\":3:{s:10:\\\"customData\\\";s:47:\\\"email=mdbijon%40gmail.com&password=%23123456%23\\\";s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:17:\\\"mdbijon@gmail.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:3:\\\"job\\\";N;}\"}}', 0, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'default', '{\"uuid\":\"aef278e5-a753-498b-b1b0-acfb138ef995\",\"displayName\":\"App\\\\Mail\\\\Guestsendingmail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":15:{s:8:\\\"mailable\\\";O:25:\\\"App\\\\Mail\\\\Guestsendingmail\\\":3:{s:7:\\\"details\\\";s:48:\\\"email=1mdbijon%40gmail.com&password=%23123456%23\\\";s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:18:\\\"1mdbijon@gmail.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:3:\\\"job\\\";N;}\"}}', 0, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(10) NOT NULL,
  `status` int(11) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `status`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', 1, '2024-10-26 11:34:03', '2024-10-26 11:34:03'),
(2, 'Bengali', 'bn', 1, '2024-10-26 11:34:03', '2024-10-27 06:00:00'),
(3, 'Hindi', 'hi', 0, '2024-10-26 11:34:03', '2024-10-26 11:34:03'),
(4, 'Tamil', 'ta', 0, '2024-10-26 11:34:03', '2024-10-27 10:16:45'),
(5, 'Chinese', 'zh', 0, '2024-10-26 11:34:03', '2024-10-27 11:10:21'),
(6, 'Spanish', 'es', 0, '2024-10-26 11:34:03', '2024-10-26 11:34:03');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `method` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `merchant_request`
--

CREATE TABLE `merchant_request` (
  `id` int(10) UNSIGNED NOT NULL,
  `api_key_id` int(10) UNSIGNED NOT NULL,
  `merchant_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `api_key` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` int(11) DEFAULT 0 COMMENT '1=approved\r\n0=not approved',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 2),
(3, '2019_08_19_000000_create_failed_jobs_table', 3),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token`, `created_at`) VALUES
(1, 'gazigiashuddin@gmail.com', 'cBk8LmFh6xfydQ2ao78Qznbj4XtNcPMSJRlNxSUePN07sEr9Vg2yCl3Ou9Y9', '2024-07-11 17:39:05'),
(2, 'gazigiashuddin@gmail.com', 'mhEUCcET2u0JHkrS9srpcahx1Uz9g7D4AcohXUW4VutHE5qiNw73Ozjifyi4', '2024-07-11 17:44:39');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `post_category_id` int(11) DEFAULT NULL,
  `entry_by` int(11) DEFAULT NULL,
  `thumnail_img` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `name`, `slug`, `description`, `post_category_id`, `entry_by`, `thumnail_img`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Hellow Bangladesh', 'hellow-bangladesh', '<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Access to every feature TinyMCE offers</h4>\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">Optimize the content creation and editing experience in your app with some of our most popular features - from out-of-the-box tools your users expect to endless customization possibilities.</p>\n</div>\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Unlimited editor loads</h4>\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">We know it can be hard to estimate your editor loads at first, so spend a stress-free 14 days on us evaluating your usage without incurring overage fees.</p>\n</div>', 7, 1, NULL, 1, '2024-12-07 15:23:32', '2024-12-07 15:23:32'),
(2, 'For Testing Post', 'for-testing-post', '<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Access to every feature TinyMCE offers</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">Optimize the content creation and editing experience in your app with some of our most popular features - from out-of-the-box tools your users expect to endless customization possibilities.</p>\r\n</div>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Unlimited editor loads</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">We know it can be hard to estimate your editor loads at first, so spend a stress-free 14 days on us evaluating your usage without incurring overage fees.</p>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Access to every feature TinyMCE offers</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">Optimize the content creation and editing experience in your app with some of our most popular features - from out-of-the-box tools your users expect to endless customization possibilities.</p>\r\n</div>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Unlimited editor loads</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">We know it can be hard to estimate your editor loads at first, so spend a stress-free 14 days on us evaluating your usage without incurring overage fees.</p>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Access to every feature TinyMCE offers</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">Optimize the content creation and editing experience in your app with some of our most popular features - from out-of-the-box tools your users expect to endless customization possibilities.</p>\r\n</div>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Unlimited editor loads</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">We know it can be hard to estimate your editor loads at first, so spend a stress-free 14 days on us evaluating your usage without incurring overage fees.</p>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Access to every feature TinyMCE offers</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">Optimize the content creation and editing experience in your app with some of our most popular features - from out-of-the-box tools your users expect to endless customization possibilities.</p>\r\n</div>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Unlimited editor loads</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">We know it can be hard to estimate your editor loads at first, so spend a stress-free 14 days on us evaluating your usage without incurring overage fees.</p>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Access to every feature TinyMCE offers</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">Optimize the content creation and editing experience in your app with some of our most popular features - from out-of-the-box tools your users expect to endless customization possibilities.</p>\r\n</div>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Unlimited editor loads</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">We know it can be hard to estimate your editor loads at first, so spend a stress-free 14 days on us evaluating your usage without incurring overage fees.</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 46, 1, NULL, 1, '2024-12-07 15:24:25', '2024-12-07 15:24:25'),
(3, 'For Testing Post--123456', 'for-testing-post--123456', '<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Access to every feature TinyMCE offers-123456</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">Optimize the content creation and editing experience in your app with some of our most popular features - from out-of-the-box tools your users expect to endless customization possibilities.</p>\r\n</div>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Unlimited editor loads</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">We know it can be hard to estimate your editor loads at first, so spend a stress-free 14 days on us evaluating your usage without incurring overage fees.</p>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Access to every feature TinyMCE offers</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">Optimize the content creation and editing experience in your app with some of our most popular features - from out-of-the-box tools your users expect to endless customization possibilities.</p>\r\n</div>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Unlimited editor loads</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">We know it can be hard to estimate your editor loads at first, so spend a stress-free 14 days on us evaluating your usage without incurring overage fees.</p>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Access to every feature TinyMCE offers</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">Optimize the content creation and editing experience in your app with some of our most popular features - from out-of-the-box tools your users expect to endless customization possibilities.</p>\r\n</div>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Unlimited editor loads</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">We know it can be hard to estimate your editor loads at first, so spend a stress-free 14 days on us evaluating your usage without incurring overage fees.</p>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Access to every feature TinyMCE offers</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">Optimize the content creation and editing experience in your app with some of our most popular features - from out-of-the-box tools your users expect to endless customization possibilities.</p>\r\n</div>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Unlimited editor loads</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">We know it can be hard to estimate your editor loads at first, so spend a stress-free 14 days on us evaluating your usage without incurring overage fees.</p>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Access to every feature TinyMCE offers</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">Optimize the content creation and editing experience in your app with some of our most popular features - from out-of-the-box tools your users expect to endless customization possibilities.</p>\r\n</div>\r\n<div style=\"margin: 0px; padding: 0px; border: 0px; font-size: 16px; vertical-align: baseline; color: #000000; font-family: Inter, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">\r\n<h4 class=\"css-rtej3a\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-style: normal; font-stretch: normal; font-weight: 600; font-family: \'Inter VF\', Inter, sans-serif; letter-spacing: 0.09px; color: #070b1a;\">Unlimited editor loads</h4>\r\n<p class=\"css-g41btx\" style=\"margin: 0px; padding: 0px; border: 0px; font-size: 1rem; vertical-align: baseline; line-height: 1.5; font-weight: normal; font-style: normal; font-stretch: normal; letter-spacing: normal; font-family: \'Inter VF\', Inter, sans-serif; color: #070b1a;\">We know it can be hard to estimate your editor loads at first, so spend a stress-free 14 days on us evaluating your usage without incurring overage fees.</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 46, 1, NULL, 1, '2024-12-08 05:02:24', '2024-12-08 05:31:35');

-- --------------------------------------------------------

--
-- Table structure for table `post_category`
--

CREATE TABLE `post_category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_category`
--

INSERT INTO `post_category` (`id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'FAQs', 'faqs', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(2, 'Technology', 'technology', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(3, 'Health', 'health', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(4, 'Education', 'education', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(5, 'Finance', 'finance', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(6, 'Lifestyle', 'lifestyle', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(7, 'Air Bed', 'air-bed', 1, '2024-12-07 12:27:29', '2025-03-30 23:45:24'),
(8, 'Food', 'food', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(9, 'Entertainment', 'entertainment', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(10, 'Sports', 'sports', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(11, 'Science', 'science', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(12, 'Politics', 'politics', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(13, 'Business', 'business', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(14, 'Art', 'art', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(15, 'Music', 'music', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(16, 'Books', 'books', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(17, 'Movies', 'movies', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(18, 'DIY', 'diy', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(19, 'Parenting', 'parenting', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(20, 'Fitness', 'fitness', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(21, 'Photography', 'photography', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(22, 'Gaming', 'gaming', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(23, 'Programming', 'programming', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(24, 'AI', 'ai', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(25, 'Machine Learning', 'machine-learning', 1, '2024-12-07 12:27:29', '2024-12-07 12:27:29'),
(26, 'Startups', 'startups', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(27, 'Marketing', 'marketing', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(28, 'SEO', 'seo', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(29, 'E-commerce', 'e-commerce', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(30, 'Fashion', 'fashion', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(31, 'Beauty', 'beauty', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(32, 'Design', 'design', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(33, 'Environment', 'environment', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(34, 'Sustainability', 'sustainability', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(35, 'Culture', 'culture', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(36, 'History', 'history', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(37, 'Psychology', 'psychology', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(38, 'Self-Improvement', 'self-improvement', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(39, 'Relationships', 'relationships', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(40, 'Career', 'career', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(41, 'Productivity', 'productivity', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(42, 'Real Estate', 'real-estate', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(43, 'Investment', 'investment', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(44, 'Cryptocurrency', 'cryptocurrency', 1, '2024-12-07 12:27:30', '2024-12-07 12:27:30'),
(45, 'Cooking', 'cooking', 1, '2024-12-07 12:27:31', '2024-12-07 12:27:31'),
(46, 'Recipes', 'recipes', 1, '2024-12-07 12:27:31', '2024-12-07 12:27:31'),
(47, 'Automobiles', 'automobiles', 1, '2024-12-07 12:27:31', '2024-12-07 12:27:31'),
(48, 'Technology News', 'technology-news', 1, '2024-12-07 12:27:31', '2024-12-07 12:27:31'),
(49, 'Mobile Devices', 'mobile-devices', 1, '2024-12-07 12:27:31', '2024-12-07 12:27:31');

-- --------------------------------------------------------

--
-- Table structure for table `promocode`
--

CREATE TABLE `promocode` (
  `id` bigint(20) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `form_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `promoCode` text DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `promocode`
--

INSERT INTO `promocode` (`id`, `room_id`, `form_date`, `to_date`, `discount`, `promoCode`, `status`, `created_at`, `updated_at`) VALUES
(1, 7, '2025-03-12', '2025-03-15', 500.00, 'BEFO-488', 1, '2025-04-01 13:20:55', '2025-04-01 13:20:55'),
(2, 5, '2025-04-07', '2025-04-17', 5366.00, 'BEFO-4882', 1, '2025-04-01 13:26:03', '2025-04-01 14:33:07'),
(3, 1, '2025-04-01', '2025-04-15', 33.00, 'BEFO-488233', 1, '2025-04-01 13:27:03', '2025-04-01 13:27:03');

-- --------------------------------------------------------

--
-- Table structure for table `restaruent_invoice`
--

CREATE TABLE `restaruent_invoice` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `item_total` decimal(12,2) DEFAULT 0.00,
  `advance_amount` decimal(12,2) DEFAULT 0.00,
  `due_amount` decimal(12,2) DEFAULT 0.00,
  `discount_amount` decimal(12,2) DEFAULT 0.00,
  `after_discount` decimal(12,2) DEFAULT 0.00,
  `tax_percentage` decimal(5,2) DEFAULT 0.00,
  `tax_amount` decimal(12,2) DEFAULT 0.00,
  `grand_total` decimal(12,2) DEFAULT 0.00,
  `invoice_create_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `restaruent_invoice`
--

INSERT INTO `restaruent_invoice` (`id`, `invoice_no`, `name`, `email`, `phone`, `address`, `item_total`, `advance_amount`, `due_amount`, `discount_amount`, `after_discount`, `tax_percentage`, `tax_amount`, `grand_total`, `invoice_create_by`, `created_at`, `updated_at`) VALUES
(1, '0000001', 'Jons', 'mdbijon@gmail.com', '01567897888', 'dhakak', 1067.50, 0.00, 1067.50, 0.00, 1067.50, 2.00, 21.35, 1088.85, 1, '2025-06-03 20:42:10', '2025-06-03 20:52:23'),
(2, '0000002', 'Mrs. Ayesha', 'ayesha@gmail.com', '01988846927', 'Dhaka', 7966.40, 0.00, 7966.40, 0.00, 7966.40, 2.00, 159.33, 8125.73, 1, '2025-06-03 20:43:30', '2025-06-03 20:52:19'),
(3, '0000003', 'Gazi', 'gazi@gmail.com', '01915728982', 'Dhaka', 645.00, 0.00, 645.00, 0.00, 645.00, 2.00, 12.90, 657.90, 1, '2025-06-03 20:48:44', '2025-06-03 20:52:48'),
(4, '0000004', 'Gazi', 'gazi@gmail.com', '01915728982', 'Dhaka', 645.00, 0.00, 645.00, 0.00, 645.00, 2.00, 12.90, 657.90, 1, '2025-06-03 20:51:20', '2025-06-03 20:52:52'),
(5, '0000005', 'Robi', 'robi@gmail.com', '01915728982', 'Dhaka', 645.00, 0.00, 645.00, 0.00, 645.00, 2.00, 12.90, 657.90, 1, '2025-06-03 20:52:02', '2025-06-03 20:52:43');

-- --------------------------------------------------------

--
-- Table structure for table `restaruent_invoice_history`
--

CREATE TABLE `restaruent_invoice_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rest_invoice_id` bigint(20) UNSIGNED NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `qty` int(10) UNSIGNED DEFAULT 1,
  `price` decimal(12,2) DEFAULT 0.00,
  `total` decimal(12,2) DEFAULT 0.00,
  `invoice_create_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `restaruent_invoice_history`
--

INSERT INTO `restaruent_invoice_history` (`id`, `rest_invoice_id`, `item_id`, `name`, `qty`, `price`, `total`, `invoice_create_by`, `created_at`, `updated_at`) VALUES
(1, 1, 117, 'Apple Juice', 35, 12.50, 437.50, 1, '2025-06-03 20:42:10', '2025-06-03 20:42:10'),
(2, 1, 108, 'Apple Pie', 15, 20.00, 300.00, 1, '2025-06-03 20:42:10', '2025-06-03 20:42:10'),
(3, 1, 75, 'Beef Sandwich', 15, 22.00, 330.00, 1, '2025-06-03 20:42:10', '2025-06-03 20:42:10'),
(4, 2, 119, 'Apple', 45, 7.00, 315.00, 1, '2025-06-03 20:43:30', '2025-06-03 20:43:30'),
(5, 2, 37, 'Bath Towel 237', 93, 38.64, 3593.52, 1, '2025-06-03 20:43:30', '2025-06-03 20:43:30'),
(6, 2, 32, 'Biscuits 232', 144, 20.59, 2964.96, 1, '2025-06-03 20:43:30', '2025-06-03 20:43:30'),
(7, 2, 142, 'Black Pepper Pack', 40, 7.00, 280.00, 1, '2025-06-03 20:43:30', '2025-06-03 20:43:30'),
(8, 2, 5, 'Body Lotion 205', 34, 1.88, 63.92, 1, '2025-06-03 20:43:30', '2025-06-03 20:43:30'),
(9, 2, 461, 'Canned Corn', 30, 10.50, 315.00, 1, '2025-06-03 20:43:30', '2025-06-03 20:43:30'),
(10, 2, 59, 'Cream Biscuits', 70, 6.20, 434.00, 1, '2025-06-03 20:43:30', '2025-06-03 20:43:30'),
(11, 3, 119, 'Apple', 45, 7.00, 315.00, 1, '2025-06-03 20:48:44', '2025-06-03 20:48:44'),
(12, 3, 75, 'Beef Sandwich', 15, 22.00, 330.00, 1, '2025-06-03 20:48:44', '2025-06-03 20:48:44'),
(13, 4, 119, 'Apple', 45, 7.00, 315.00, 1, '2025-06-03 20:51:20', '2025-06-03 20:51:20'),
(14, 4, 75, 'Beef Sandwich', 15, 22.00, 330.00, 1, '2025-06-03 20:51:20', '2025-06-03 20:51:20'),
(15, 5, 119, 'Apple', 45, 7.00, 315.00, 1, '2025-06-03 20:52:02', '2025-06-03 20:52:02'),
(16, 5, 75, 'Beef Sandwich', 15, 22.00, 330.00, 1, '2025-06-03 20:52:02', '2025-06-03 20:52:02');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `roomType` varchar(255) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `extraCapacity` varchar(255) DEFAULT NULL COMMENT 'extraCapability',
  `roomPrice` decimal(10,2) DEFAULT NULL,
  `bedCharge` int(11) DEFAULT NULL,
  `room_size_id` int(11) DEFAULT NULL,
  `bedNumber` varchar(255) DEFAULT NULL,
  `bed_type_id` int(11) DEFAULT NULL,
  `roomDescription` text DEFAULT NULL,
  `reserveCondition` text DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `booking_status` int(11) DEFAULT NULL COMMENT '1=Booked 2=Release 3=Cancel',
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`id`, `name`, `slug`, `roomType`, `capacity`, `extraCapacity`, `roomPrice`, `bedCharge`, `room_size_id`, `bedNumber`, `bed_type_id`, `roomDescription`, `reserveCondition`, `status`, `booking_status`, `created_at`, `updated_at`) VALUES
(1, 'Bungalow with Sea View', 'bungalow-with-sea-view', 'Bungalow with Sea View', 2, '', 7290.00, 0, 0, '', 1, 'Comfy beds, 10 – Based on 1 review\r\nThis bungalow includes 1 living room, 1 separate bedroom and 1 bathroom with a shower and free toiletries. The unit has \r\nair conditioning, \r\nsea views, \r\na balcony and fruit is offered for guests. The unit has 1 bed. Bungalow size: 29 m²', '', 1, 1, '2025-04-03 14:43:03', '2025-06-01 18:39:37'),
(2, 'Executive Suite', 'executive-suite', 'Executive Suite', 1, '', 19528.00, 0, 0, '', 3, 'Living room: 1 sofa bed\r\nPrivate suite\r\n\r\nComfy beds, 10 – Based on 1 review\r\nThe unit has 2 beds.\r\n\r\nSmoking: ​ No smoking', '', 0, NULL, '2025-04-03 14:56:26', '2025-05-15 23:10:28'),
(3, 'Superior Bungalow', 'superior-bungalow', 'Superior Bungalow', 1, '', 12190.00, 0, 0, '', 3, '1 extra-large double bed \r\nComfy beds, 10 – Based on 1 review\r\nFeaturing a private entrance, this air-conditioned bungalow consists of 1 bedroom and 1 bathroom with a bath and a shower. This bungalow features a seating area, flat-screen TV, mountain views, as well as fruit for guests. The unit offers 1 bed.\r\n\r\nIn your private bathroom:\r\nBath\r\nFree toiletries\r\nShower\r\nBidet\r\nToilet\r\nToilet paper\r\nView:\r\nBalcony\r\nMountain view\r\nBungalow facilities:\r\nFlat-screen TV\r\nPrivate entrance\r\nFan\r\nTowels\r\nSeating Area\r\nMosquito net\r\nAir conditioning', '', 1, 1, '2025-04-03 14:56:26', '2025-06-03 08:21:05'),
(6, 'Bungalow with Sea View', 'bungalow-with-sea-view-', 'Bungalow with Sea View', 2, '', 7000.00, 0, 0, '', 1, '1 large double bed \r\nEntire bungalow29 m²BalconySea viewMountain viewEnsuite bathroom\r\nFree toiletries  Shower  Bidet Toilet  Sofa  Towels  Desk Seating Area  Mosquito net Fan  Toilet paper', '', 1, NULL, '2025-05-15 22:48:50', '2025-05-15 22:50:45'),
(7, 'Bungalow', 'bungalow', 'Bungalow', 1, '', 9720.00, 0, 0, '', 1, '<p><strong>Bedroom 1: </strong>1 large double bed Living room: 1 sofa bed Comfy beds, 10 &ndash; Based on 1 review The unit has 2 beds. Smoking: ​ No smoking</p>', '', 1, 2, '2025-05-15 22:52:10', '2025-06-02 00:34:57');

-- --------------------------------------------------------

--
-- Table structure for table `room_facility`
--

CREATE TABLE `room_facility` (
  `id` bigint(20) NOT NULL,
  `room_facility_group_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_facility`
--

INSERT INTO `room_facility` (`id`, `room_facility_group_id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Air conditioning', 'air-conditioning', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(2, 1, 'Free Wi-Fi', 'free-wifi', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(3, 1, 'Smart TV / Cable TV', 'smart-tv', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(4, 1, 'Work desk & chair', 'work-desk-chair', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(5, 1, 'Sofa or seating area', 'sofa-seating-area', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(6, 1, 'Wardrobe/Closet', 'wardrobe-closet', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(7, 1, 'Safe deposit box', 'safe-deposit-box', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(8, 1, 'Telephone', 'telephone', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(9, 1, 'Alarm clock', 'alarm-clock', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(10, 1, 'Full-length mirror', 'full-length-mirror', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(11, 1, 'Private entrance', 'private-entrance', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(12, 1, 'Coat rack', 'coat-rack', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(13, 1, 'Soundproof walls', 'soundproof-walls', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(14, 1, 'Blackout curtains', 'blackout-curtains', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(15, 1, 'Carpeting / Wooden flooring', 'carpeting-wooden-flooring', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(16, 2, 'King/Queen/Twin beds', 'king-queen-twin-beds', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(17, 2, 'High-quality mattress', 'high-quality-mattress', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(18, 2, 'Soft pillows & cushions', 'soft-pillows-cushions', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(19, 2, 'Extra blanket', 'extra-blanket', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(20, 2, 'Bedside table', 'bedside-table', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(21, 2, 'Adjustable bed lighting', 'adjustable-bed-lighting', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(22, 2, 'Reading lamp', 'reading-lamp', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(23, 2, 'Electric blanket (for winter)', 'electric-blanket', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(24, 10, 'Mosquito net', 'mosquito-net', 1, '2025-04-01 18:02:03', '2025-04-03 06:27:26'),
(25, 2, 'Hypoallergenic bedding', 'hypoallergenic-bedding', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(26, 3, 'Private bathroom', 'private-bathroom', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(27, 3, 'Rain shower', 'rain-shower', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(28, 3, 'Bathtub', 'bathtub', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(29, 3, 'Hot & cold water', 'hot-cold-water', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(30, 3, 'Fresh towels', 'fresh-towels', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(31, 3, 'Hairdryer', 'hairdryer', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(32, 3, 'Bathrobe & slippers', 'bathrobe-slippers', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(33, 3, 'Complimentary toiletries', 'complimentary-toiletries', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(34, 3, 'Magnifying makeup mirror', 'magnifying-makeup-mirror', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(35, 3, 'Bidet / Toilet hose', 'bidet-toilet-hose', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(36, 3, 'Heated towel rack', 'heated-towel-rack', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(37, 4, 'Mini refrigerator', 'mini-refrigerator', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(38, 4, 'Electric kettle', 'electric-kettle', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(39, 4, 'Coffee maker', 'coffee-maker', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(40, 4, 'Microwave oven', 'microwave-oven', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(41, 4, 'Dining table & chairs', 'dining-table-chairs', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(42, 4, 'Cutlery & crockery set', 'cutlery-crockery-set', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(43, 4, 'Bottled drinking water', 'bottled-drinking-water', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(44, 5, 'Electronic key card access', 'electronic-key-card', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(45, 5, 'Fire alarm & smoke detector', 'fire-alarm-smoke-detector', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(46, 5, 'Emergency evacuation plan', 'emergency-evacuation-plan', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(47, 5, 'CCTV security', 'cctv-security', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(48, 5, 'Power backup / Generator', 'power-backup-generator', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(49, 6, 'Balcony / Terrace', 'balcony-terrace', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(50, 6, 'In-room jacuzzi', 'in-room-jacuzzi', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(51, 6, 'Private swimming pool', 'private-swimming-pool', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(52, 6, 'City/Mountain/Sea view rooms', 'city-mountain-sea-view', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(53, 7, 'Room service (24/7)', 'room-service', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(54, 7, 'Newspaper delivery', 'newspaper-delivery', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(55, 7, 'Concierge service', 'concierge-service', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(56, 7, 'Laundry & dry-cleaning service', 'laundry-dry-cleaning', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(57, 7, 'Shoe polishing kit', 'shoe-polishing-kit', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(58, 7, 'Luggage storage', 'luggage-storage', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(59, 7, 'Turndown service', 'turndown-service', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(60, 7, 'Express check-in/check-out', 'express-check-in-out', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(61, 7, 'Babysitting service', 'babysitting-service', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(62, 7, 'Car rental assistance', 'car-rental-assistance', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(63, 7, 'Airport transfer service', 'airport-transfer-service', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
(65, 8, 'Free toiletries', 'free-toiletries', 1, '2025-04-03 06:18:02', '2025-04-03 06:18:02'),
(66, 8, 'Toilet', 'toilet', 1, '2025-04-03 06:18:19', '2025-04-03 06:18:19'),
(67, 8, 'Shower', 'shower', 1, '2025-04-03 06:18:28', '2025-04-03 06:18:28'),
(68, 8, 'Toilet paper', 'toilet-paper', 1, '2025-04-03 06:18:37', '2025-04-03 06:18:37'),
(69, 8, 'Bidet', 'bidet', 1, '2025-04-03 06:18:54', '2025-04-03 06:18:54'),
(70, 9, 'Balcony', 'balcony', 1, '2025-04-03 06:19:46', '2025-04-03 06:46:39'),
(71, 9, 'Mountain view', 'mountain-view', 1, '2025-04-03 06:19:53', '2025-04-03 06:19:53'),
(72, 9, 'Sea view', 'sea-view', 1, '2025-04-03 06:20:00', '2025-04-03 06:20:00'),
(73, 10, 'Desk', 'desk', 1, '2025-04-03 06:26:27', '2025-04-03 06:26:27'),
(74, 10, 'Sofa', 'sofa', 1, '2025-04-03 06:26:35', '2025-04-03 06:26:35'),
(75, 10, 'Fan', 'fan', 1, '2025-04-03 06:26:41', '2025-04-03 06:26:41'),
(76, 10, 'Towels', 'towels', 1, '2025-04-03 06:26:48', '2025-04-03 06:26:48'),
(77, 10, 'Seating Area', 'seating-area', 1, '2025-04-03 06:26:53', '2025-04-03 06:26:53'),
(78, 11, 'Smoking permitted', 'smoking-permitted', 1, '2025-04-03 06:41:16', '2025-04-03 06:41:16'),
(79, 12, 'Entire bungalow', 'entire-bungalow', 1, '2025-04-03 06:44:59', '2025-04-03 06:44:59'),
(80, 12, '29 m²', '29-m-', 1, '2025-04-03 06:45:06', '2025-04-03 06:45:06'),
(81, 12, 'Balcony', 'balcony', 1, '2025-04-03 06:46:16', '2025-04-03 06:46:16'),
(82, 12, 'Sea view', 'sea-view', 1, '2025-04-03 06:47:04', '2025-04-03 06:47:12'),
(83, 12, 'Mountain view', 'mountain-view', 1, '2025-04-03 06:47:29', '2025-04-03 06:47:36'),
(84, 12, 'Private bathroom', 'private-bathroom', 1, '2025-04-03 06:47:52', '2025-04-03 06:47:59'),
(85, 13, 'Private suite', 'private-suite', 1, '2025-04-03 08:56:49', '2025-04-03 08:56:49');

-- --------------------------------------------------------

--
-- Table structure for table `room_images`
--

CREATE TABLE `room_images` (
  `id` bigint(20) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `roomImage` varchar(255) DEFAULT NULL,
  `roomImgDescription` text DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_images`
--

INSERT INTO `room_images` (`id`, `room_id`, `roomImage`, `roomImgDescription`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, '/backend/files/s1SN4qUmrWizPxuKJarC.jpg', '', 1, '2025-04-03 14:48:09', '2025-04-03 14:48:09'),
(2, 1, '/backend/files/Ba0w970urOW4I2T6Mvms.jpg', '', 1, '2025-04-03 14:48:19', '2025-04-03 14:48:19'),
(3, 1, '/backend/files/cwUw8bJYAmoLODFqn88a.jpg', '', 1, '2025-04-03 14:48:27', '2025-04-03 14:48:27'),
(4, 1, '/backend/files/Dubpa6yUt4rm913yYmGk.jpg', '', 1, '2025-04-03 14:48:35', '2025-04-03 14:48:35'),
(5, 2, '/backend/files/mx7KULphkqXmCQNgdSGh.jpg', '', 1, '2025-04-03 14:59:21', '2025-04-03 14:59:21'),
(6, 2, '/backend/files/OQLjTlhmOZU98U93CeMP.jpg', '', 1, '2025-04-03 14:59:30', '2025-04-03 14:59:30'),
(7, 2, '/backend/files/XeEbspMBRrItpIratdBH.jpg', '', 1, '2025-04-03 14:59:36', '2025-04-03 14:59:36'),
(8, 2, '/backend/files/uQqq6pQo4KonWwCjs2a9.jpg', '', 1, '2025-04-03 14:59:44', '2025-04-03 14:59:44'),
(9, 2, '/backend/files/TMC44McTxlWjLA95VPP5.jpg', '', 1, '2025-04-03 14:59:53', '2025-04-03 14:59:53'),
(10, 2, '/backend/files/LRsLChikzBJ1PHQ3h7Uw.jpg', '', 1, '2025-04-03 15:00:01', '2025-04-03 15:00:01'),
(18, 4, '/backend/files/LRsLChikzBJ1PHQ3h7Uw.jpg', '', 1, '2025-04-03 15:00:01', '2025-04-03 15:00:01'),
(19, 4, '/backend/files/Dubpa6yUt4rm913yYmGk.jpg', '', 1, '2025-04-03 15:00:01', '2025-04-03 15:00:01'),
(20, 3, '/backend/files/fuEd8DSMvMW3hNl5Om2r.jpg', '', 1, '2025-05-08 23:25:12', '2025-05-08 23:25:12'),
(25, 7, '/backend/files/VTCgz0nj3TUqqJFQzAQu.jpg', NULL, 1, '2025-05-31 22:04:54', '2025-05-31 22:04:54'),
(26, 7, '/backend/files/ppVzn7GURyxntV8ushBr.jpg', NULL, 1, '2025-05-31 22:04:54', '2025-05-31 22:04:54'),
(27, 7, '/backend/files/7wDutafG2Quknaa7xbeI.jpg', NULL, 1, '2025-06-01 10:50:51', '2025-06-01 10:50:51'),
(28, 7, '/backend/files/29XwOmoBrOac3FUGXbI7.jpeg', NULL, 1, '2025-06-01 10:51:01', '2025-06-01 10:51:01'),
(29, 7, '/backend/files/kTUR8sryGzpm40y6J6CV.jpg', NULL, 1, '2025-06-01 10:51:23', '2025-06-01 10:51:23');

-- --------------------------------------------------------

--
-- Table structure for table `room_size`
--

CREATE TABLE `room_size` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_size`
--

INSERT INTO `room_size` (`id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Singal', 'singal', 1, '2025-03-31 06:40:50', '2025-03-31 06:40:50'),
(2, 'Double', 'double', 1, '2025-03-31 06:40:54', '2025-03-31 06:40:54'),
(3, 'Tripal', 'tripal', 1, '2025-03-31 06:40:58', '2025-03-31 06:40:58'),
(4, 'Quad', 'quad', 1, '2025-03-31 06:41:01', '2025-03-31 06:41:01'),
(5, 'Queen', 'queen', 1, '2025-03-31 06:41:05', '2025-03-31 06:41:05'),
(6, 'King', 'king', 1, '2025-03-31 06:41:09', '2025-03-31 06:41:09'),
(7, 'Studio', 'studio', 1, '2025-03-31 06:41:15', '2025-03-31 06:41:15'),
(8, 'Suite', 'suite', 1, '2025-03-31 06:41:21', '2025-03-31 06:41:21'),
(9, 'Penthouse', 'penthouse', 1, '2025-03-31 06:41:28', '2025-03-31 06:41:28'),
(10, 'Presidential Suite', 'presidential-suite', 1, '2025-03-31 06:41:34', '2025-03-31 06:41:34'),
(11, 'Duplex', 'duplex', 1, '2025-03-31 06:41:39', '2025-03-31 06:41:39'),
(12, 'Others', 'others', 1, '2025-03-31 06:41:46', '2025-03-31 06:41:46'),
(13, 'Twin', 'twin', 1, '2025-03-31 19:57:48', '2025-03-31 20:54:12'),
(14, 'Small', 'small', 1, '2025-03-31 21:02:43', '2025-03-31 21:02:43'),
(15, 'Vip', 'vip', 1, '2025-03-31 23:10:03', '2025-03-31 23:10:03'),
(16, 'Vip Guest', 'vip-guest', 1, '2025-03-31 23:10:18', '2025-03-31 23:10:18');

-- --------------------------------------------------------

--
-- Table structure for table `rule`
--

CREATE TABLE `rule` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rule`
--

INSERT INTO `rule` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 1, '2024-04-16 10:33:46', '2024-04-16 10:33:46'),
(2, 'Customer', 1, '2024-04-16 10:56:15', '2024-04-16 10:56:15'),
(3, 'Admin', 1, '2024-04-16 10:56:27', '2024-12-06 12:43:05'),
(4, 'User', 1, '2024-04-16 10:56:27', '2024-12-06 12:43:05');

-- --------------------------------------------------------

--
-- Table structure for table `select_room_facilities`
--

CREATE TABLE `select_room_facilities` (
  `id` bigint(20) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `room_facility_group_id` int(11) DEFAULT NULL,
  `facilities_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `select_room_facilities`
--

INSERT INTO `select_room_facilities` (`id`, `room_id`, `room_facility_group_id`, `facilities_id`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 5, 1, 1, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(2, 5, 1, 2, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(3, 5, 1, 3, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(4, 5, 1, 4, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(5, 5, 1, 5, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(6, 5, 1, 6, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(7, 5, 1, 7, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(8, 5, 1, 8, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(9, 5, 1, 9, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(10, 5, 1, 10, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(11, 5, 1, 11, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(12, 5, 1, 12, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(13, 5, 1, 13, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(14, 5, 1, 14, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(15, 5, 1, 15, 1, 1, '2025-05-05 03:02:58', '2025-05-05 03:02:58'),
(16, 5, 2, 16, 1, 1, '2025-05-05 03:03:05', '2025-05-05 03:03:05'),
(17, 5, 2, 17, 1, 1, '2025-05-05 03:03:05', '2025-05-05 03:03:05'),
(18, 5, 2, 18, 1, 1, '2025-05-05 03:03:05', '2025-05-05 03:03:05'),
(19, 5, 2, 19, 1, 1, '2025-05-05 03:03:05', '2025-05-05 03:03:05'),
(20, 5, 2, 20, 1, 1, '2025-05-05 03:03:05', '2025-05-05 03:03:05'),
(21, 5, 2, 21, 1, 1, '2025-05-05 03:03:05', '2025-05-05 03:03:05'),
(24, 5, 2, 25, 1, 1, '2025-05-05 03:03:05', '2025-05-05 03:03:05'),
(25, 7, 1, 1, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(26, 7, 1, 2, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(27, 7, 1, 3, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(28, 7, 1, 4, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(29, 7, 1, 5, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(30, 7, 1, 6, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(31, 7, 1, 7, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(32, 7, 1, 8, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(33, 7, 1, 9, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(34, 7, 1, 10, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(35, 7, 1, 11, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(36, 7, 1, 12, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(37, 7, 1, 13, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(38, 7, 1, 14, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(39, 7, 1, 15, 1, 1, '2025-06-01 04:52:07', '2025-06-01 04:52:07'),
(40, 7, 4, 37, 1, 1, '2025-06-01 04:54:35', '2025-06-01 04:54:35'),
(41, 7, 4, 38, 1, 1, '2025-06-01 04:54:35', '2025-06-01 04:54:35'),
(42, 7, 4, 39, 1, 1, '2025-06-01 04:54:35', '2025-06-01 04:54:35'),
(43, 7, 4, 40, 1, 1, '2025-06-01 04:54:35', '2025-06-01 04:54:35'),
(44, 7, 4, 41, 1, 1, '2025-06-01 04:54:35', '2025-06-01 04:54:35'),
(45, 7, 4, 42, 1, 1, '2025-06-01 04:54:35', '2025-06-01 04:54:35'),
(46, 7, 4, 43, 1, 1, '2025-06-01 04:54:35', '2025-06-01 04:54:35'),
(47, 3, 1, 1, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(48, 3, 1, 2, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(49, 3, 1, 3, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(50, 3, 1, 4, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(51, 3, 1, 5, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(52, 3, 1, 6, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(53, 3, 1, 7, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(54, 3, 1, 8, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(55, 3, 1, 9, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(56, 3, 1, 10, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(57, 3, 1, 11, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(58, 3, 1, 12, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(59, 3, 1, 13, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(60, 3, 1, 14, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50'),
(61, 3, 1, 15, 1, 1, '2025-06-01 04:55:50', '2025-06-01 04:55:50');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(7, 'Coffee Bar', NULL, 1, '2025-05-07 19:05:26', '2025-05-07 19:05:26'),
(8, 'Restaurant', NULL, 1, '2025-05-07 19:08:34', '2025-05-07 19:08:34'),
(9, 'Room Service', NULL, 1, '2025-05-07 19:08:41', '2025-05-07 19:08:41'),
(10, '24x7 Reception', NULL, 1, '2025-05-07 19:08:47', '2025-05-07 19:08:47'),
(11, 'Car Rental', NULL, 1, '2025-05-07 19:08:52', '2025-05-07 19:08:52'),
(12, 'Secure Wi-Fi', NULL, 1, '2025-05-07 19:08:59', '2025-05-07 19:08:59');

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` mediumtext NOT NULL,
  `whatsApp` varchar(255) NOT NULL,
  `about_us` mediumtext NOT NULL,
  `copyright` varchar(255) NOT NULL,
  `fblink` varchar(255) DEFAULT NULL,
  `twitterlink` varchar(255) DEFAULT NULL,
  `linkdinlink` varchar(255) DEFAULT NULL,
  `instragramlink` varchar(255) DEFAULT NULL,
  `slugan` varchar(255) DEFAULT NULL,
  `tax_percentag` int(11) DEFAULT NULL,
  `currency_symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `banner_image` varchar(255) DEFAULT NULL,
  `youtubelink` varchar(255) DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id`, `name`, `email`, `address`, `whatsApp`, `about_us`, `copyright`, `fblink`, `twitterlink`, `linkdinlink`, `instragramlink`, `slugan`, `tax_percentag`, `currency_symbol`, `logo`, `banner_image`, `youtubelink`, `update_by`, `created_at`, `updated_at`) VALUES
(1, 'Moon Nest', 'shahin@moon-nest.com', 'Pechardwip, Cox\'s Bazar, Bangladesh', '+8801830330055', 'Moon Nest is a very soothing resort. All are wooden bungalow with both sea and hill view sides. There is a bathroom, a couple bed room & a veranda in one bungalow. You will get complementary breakfast for 2 person with one bungalow. Also we have a open restaurant, where you can order fresh drinks, food, sea food and so on. The beautiful beach is 6 to 7 mins walking away from our resort.', 'All Right Reserved.Designed By Moon Nest', 'https://www.facebook.com/moon.nest.coxsbazar', NULL, NULL, '#', 'Moon Nest is a very soothing resort', 2, 'TK', '/backend/files/AukuMMjw6OAo2RZr5XX8.jpg', '/backend/files/3ETgRBbgeceBCnwXRein.jpg', 'https://www.youtube.com/embed/aoJEbllaj2c?si=kIVLuI-hWyoV19NH', NULL, '2024-05-12 05:32:50', '2025-06-01 16:27:53');

-- --------------------------------------------------------

--
-- Table structure for table `slider_images`
--

CREATE TABLE `slider_images` (
  `id` bigint(20) NOT NULL,
  `title_name` varchar(255) DEFAULT NULL,
  `sliderImage` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `slider_images`
--

INSERT INTO `slider_images` (`id`, `title_name`, `sliderImage`, `status`, `created_at`, `updated_at`) VALUES
(3, 'Moon Nest is a very soothing resort', '/backend/files/Pg00kvVwFnp0Vpd0tqi4.jpg', 1, '2025-05-08 02:09:38', '2025-05-08 02:09:38'),
(4, 'Moon Nest is a very soothing resort', '/backend/files/qbT71EKU3jJtxJrsEVh3.jpg', 1, '2025-05-08 02:09:55', '2025-05-08 02:09:55');

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `country_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fg_id` varchar(255) DEFAULT NULL,
  `fg_wallet_address` varchar(255) DEFAULT NULL,
  `inviteCode` varchar(255) DEFAULT NULL,
  `ref_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL COMMENT '1=Supper admin, 2=Customer, 3=Admin, 4=User',
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `available_balance` double(10,8) DEFAULT NULL,
  `show_password` varchar(225) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `real_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(225) DEFAULT NULL,
  `image` varchar(225) DEFAULT NULL,
  `doc_file` varchar(255) DEFAULT NULL,
  `address` varchar(225) DEFAULT NULL,
  `address_1` varchar(255) DEFAULT NULL,
  `address_2` varchar(255) DEFAULT NULL,
  `website` varchar(225) DEFAULT NULL,
  `github` varchar(225) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `twitter` varchar(225) DEFAULT NULL,
  `instagram` varchar(225) DEFAULT NULL,
  `nationality_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `otp` int(11) DEFAULT NULL,
  `facebook` varchar(225) DEFAULT NULL,
  `wallet_balance` decimal(10,2) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `telegram` varchar(255) DEFAULT NULL,
  `whtsapp` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `entry_by` int(11) DEFAULT NULL,
  `register_ip` varchar(255) DEFAULT NULL,
  `lastlogin_ip` varchar(255) DEFAULT NULL,
  `lastlogin_country` varchar(255) DEFAULT NULL,
  `lastlogin_datetime` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `status` int(11) DEFAULT 0,
  `logged_out` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fg_id`, `fg_wallet_address`, `inviteCode`, `ref_id`, `employee_id`, `company_name`, `role_id`, `name`, `email`, `username`, `phone`, `available_balance`, `show_password`, `password`, `real_name`, `phone_number`, `image`, `doc_file`, `address`, `address_1`, `address_2`, `website`, `github`, `gender`, `date_of_birth`, `twitter`, `instagram`, `nationality_id`, `state_id`, `otp`, `facebook`, `wallet_balance`, `email_verified_at`, `telegram`, `whtsapp`, `remember_token`, `entry_by`, `register_ip`, `lastlogin_ip`, `lastlogin_country`, `lastlogin_datetime`, `created_at`, `updated_at`, `status`, `logged_out`) VALUES
(1, NULL, '6f21357fs863ce24ce21c1a82f49a7d5d13', '0000123', 0, 4, 'FG IT', 1, 'Black jons', 'dev1@mail.com', 'dev', '019155555', NULL, 'dev', '$2y$10$egNt4iHOZ4sWab8IcaHE9..QCyQc3z4oFRYUwesyeTH52KDFzM5.y', NULL, '01915728982', '/backend/files/hZkagctUSINKsFU64UJr.png', NULL, 'Dhaka', '', '', 'http://localhost:3000/profile', 'http://localhost:3000/profile', '', '1982-01-30', 'http://localhost:3000/profile', 'http://localhost:3000/profile', 0, 0, NULL, 'http://localhost:3000/profile', NULL, NULL, NULL, NULL, NULL, 1, NULL, '127.0.0.1', NULL, '2024-11-22 09:50:10', '2023-06-22 03:20:43', '2025-04-15 02:56:37', 1, NULL),
(2, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'Ibraheem', '12ibraheem@gmail.com', '4888', '045878787888', NULL, 'Ibraheem', '$2y$10$xD8SNrVUclcpYXMtzfx9OeMz98V4bTDYQG/0OwYS.xFv1rwMnufWC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2025-04-12 04:01:49', '2025-04-12 04:01:56', 1, NULL),
(3, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'jannat', 'jannat4874878@gmail.com', 'jannat', '458787888', NULL, 'jannat', '$2y$10$bfBvKWL5zKjjpz0IZIdSPeIPRt148zd6FVVDAL.2xRNzgUgiJ5qEK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2025-04-12 04:01:53', '2025-04-12 04:01:59', 1, NULL),
(4, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'Rana', 'rana@gmail.com', 'rana', '59898989898', NULL, '124156', '$2y$10$PG63dsfnzkqO4t3OK/mTW.RvcnrD0i8bSeiGvkIgGi7F9bVJ2k1rG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2025-04-12 04:02:35', '2025-04-12 04:02:35', 1, NULL),
(5, NULL, NULL, NULL, NULL, NULL, NULL, 3, 'Rabeya', 'rabeya@gmail.com', 'rabeya', '01989898999', NULL, 'rabeya', '$2y$10$O0VXjUpE0VYsFME.BP.R5ehmXaKPGE9gu.gXlsLHjqXdDKAs3BiZC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2025-04-12 04:12:44', '2025-04-12 04:12:44', 1, NULL),
(6, NULL, NULL, NULL, NULL, NULL, NULL, 3, 'Ayesha', 'ayesha@gmail.com', 'ayesha123', '00157878788', NULL, 'ayesha123', '$2y$10$4FbfI7bUybzfYjzzRRwddeoUlucC4DgRG3JTMOFO8ED8lPHpmxtGG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2025-04-12 04:41:06', '2025-04-12 04:41:06', 1, NULL),
(7, NULL, '6f21357fs863ce4424ce21c1a82f49a7d5d13', '0000123', 0, 4, 'FG IT', 1, 'Admin ', 'admin@mail.com', 'admin112233', '019155555', NULL, 'dev', '$2a$12$udapmAoPpAi2i6OCFQoVb.akdQkNF45V4OgKwWZO1WYPuE1Bp6F.C', NULL, '019157289845', '/backend/files/hZkagctUSINKsFU64UJr.png', NULL, 'Dhaka', '', '', 'http://localhost:3000/profile', 'http://localhost:3000/profile', '', '1982-01-30', 'http://localhost:3000/profile', 'http://localhost:3000/profile', 0, 0, NULL, 'http://localhost:3000/profile', NULL, NULL, NULL, NULL, NULL, 1, NULL, '127.0.0.1', NULL, '2024-11-22 09:50:10', '2023-06-22 03:20:43', '2025-04-15 02:56:37', 1, NULL),
(8, NULL, NULL, '5267056', NULL, NULL, NULL, 2, 'Jh', 'coxspegasus@gmail.com', '5267051', '01830330055', NULL, '#123456#', '$2y$10$8bd0N8/r35CybiJ9fPzzY.cZHirJbVWSObtX754W/1SKf7fbczu0W', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '37.111.200.10', NULL, NULL, NULL, '2025-05-06 10:32:06', '2025-05-06 10:32:06', 1, NULL),
(9, 'FG000000024', '6bef7562c1493b48753b47113ea97cd9', '2536442', NULL, NULL, NULL, 2, 'Bijon', 'mdbijon@yahoo.com', '2530289', '00114568982', NULL, '#123456#', '$2y$10$0Bou/SBDtjDMRdGRPc/jlO2UDSVhHihkExPZigVrHv5Uhp7NPD0YW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '45.250.22.140', NULL, NULL, NULL, '2025-05-07 04:30:53', '2025-05-07 04:30:53', 1, NULL),
(25, 'FG000000025', '7f284e9d9213df577c302320575f3ebc', '1203881', NULL, NULL, NULL, 2, 'mohammad yousuf', 'yousufharrier@gmail.com', '1198372', '01711936050', NULL, '#123456#', '$2y$10$wKWp7DYN35B/r8JEl74kdO6Z4QbgepL5Etu13RXAyGmYeJflM22re', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '103.150.27.238', NULL, NULL, NULL, '2025-05-08 17:58:39', '2025-05-08 18:01:19', 1, NULL),
(26, 'FG000000026', 'eedc68afba0a1a3183e2c631e1cea6b9', '7622966', NULL, NULL, NULL, 2, 'Mridul', 'mujib1k@yahoo.com', '7617374', '01911367912', NULL, '#123456#', '$2y$10$YmlCm.7oTeNb4KaIHZHaAON.YuDUfJ6KvKQHjgKg8b9tlybIRS5jm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '43.255.21.233', NULL, NULL, NULL, '2025-05-10 11:32:41', '2025-05-10 11:32:42', 1, NULL),
(27, 'FG000000027', '4d72b53ed1ca22f2ea59523681cd993c', '7364654', NULL, NULL, NULL, 2, 'Test', 'aljawadurrahman1234@gmail.com', '1735861', '01684253300', NULL, '#123456#', '$2y$10$uWUW8qHR2VnpF8qjIYFP2OVYjzQD7fMJlVGrU4g1fnf9KmVIQTvDW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '119.148.32.98', NULL, NULL, NULL, '2025-05-13 07:35:35', '2025-05-13 07:35:36', 1, NULL),
(28, 'FG000000028', '81d3f6e24daca2a87d8f1fbc5bb48f1d', '8608109', NULL, NULL, NULL, 2, 'test', 'test@gmail.com', '8598088', '0000000887', NULL, '#123456#', '$2y$10$XzL.U3zfBIPegM1k9fDJj.qNUkelDfpvNlzGbrzMHUbnU/AgWgHKa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '103.150.26.149', NULL, NULL, NULL, '2025-05-15 17:07:39', '2025-05-15 17:07:40', 1, NULL),
(29, NULL, NULL, '6388409', NULL, NULL, NULL, 2, 'Bijon', 'mdbijon@yahoo123.com', '6388398', '01915728982', NULL, '#123456#', '$2y$10$VLFOg9qCGiEOPLOAdmseMehcHqI70HHRfar0KhnHqTNe.4nbldAm2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2025-05-30 20:07:19', '2025-05-30 20:07:19', 1, NULL),
(30, NULL, NULL, '7670022', NULL, NULL, NULL, 2, 'Bijon', 'gazijons@gmail.com', '7670019', '655987888', NULL, '#123456#', '$2y$10$88CKnMNqmMnIL3rGJLqnDehfgBV4GAjnx5.bnczyTjRHzB3XvlRzm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2025-05-30 20:09:27', '2025-05-30 20:09:27', 1, NULL),
(31, NULL, NULL, '8081975', NULL, NULL, NULL, 2, 'Bijon', '1234gazijons@gmail.com', '5808197', '655987888', NULL, '#123456#', '$2y$10$HuZFwLjco6c2YhNNW2H16Od98Jj0R6vMVEd9mUqzCqeGzu5Dc7pGa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2025-05-30 20:10:08', '2025-05-30 20:10:08', 1, NULL),
(32, 'FG000000032', '729a84d0116f5e62632633990c9b1dad', '0774124', NULL, NULL, NULL, 2, 'Bijon', '4447ons@gmail.com', '0773488', '655987888', NULL, '#123456#', '$2y$10$Mzx8troDefyZGwefBxF3wefOmnQLm883OVZKhdtPhOMSUMkm7.dSO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2025-05-30 20:14:37', '2025-05-30 20:14:37', 1, NULL),
(33, NULL, NULL, '5772638', NULL, NULL, NULL, 2, 'Ibraheem ahmed', 'ibrhmahmed@gmail.com', '5772632', '58978788888', NULL, '#123456#', '$2y$10$JGOLRhlVs487hAG61L.v6eJZQFUMZjZT4dCV3Gx3s4lz9AERoo7jG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2025-06-01 12:39:37', '2025-06-01 12:39:37', 1, NULL),
(34, NULL, NULL, '7888672', NULL, NULL, NULL, 2, 'ff', 'sdfsf@gmail.com', '7888666', '00589789788', NULL, '#123456#', '$2y$10$PhZxQHU89/EQ7bQAqLaX/uzZPutklUj5WlKjyu8rf5hSpY3SyCWnC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2025-06-01 12:43:08', '2025-06-01 12:43:08', 1, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `api_configs`
--
ALTER TABLE `api_configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `api_code_unique` (`app_id`);

--
-- Indexes for table `api_key`
--
ALTER TABLE `api_key`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bed_type`
--
ALTER TABLE `bed_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `booking_id` (`booking_id`),
  ADD KEY `idx_room_id` (`room_id`),
  ADD KEY `idx_customer_id` (`customer_id`);

--
-- Indexes for table `booking_type`
--
ALTER TABLE `booking_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bulk_address`
--
ALTER TABLE `bulk_address`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `walletAddress` (`walletAddress`);

--
-- Indexes for table `categorys`
--
ALTER TABLE `categorys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currency_type`
--
ALTER TABLE `currency_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposit_request`
--
ALTER TABLE `deposit_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `facility_group`
--
ALTER TABLE `facility_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `global_wallet_address`
--
ALTER TABLE `global_wallet_address`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `merchant_request`
--
ALTER TABLE `merchant_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post_category`
--
ALTER TABLE `post_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promocode`
--
ALTER TABLE `promocode`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `restaruent_invoice`
--
ALTER TABLE `restaruent_invoice`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoice_no` (`invoice_no`);

--
-- Indexes for table `restaruent_invoice_history`
--
ALTER TABLE `restaruent_invoice_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `room_facility`
--
ALTER TABLE `room_facility`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_images`
--
ALTER TABLE `room_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_size`
--
ALTER TABLE `room_size`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rule`
--
ALTER TABLE `rule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `select_room_facilities`
--
ALTER TABLE `select_room_facilities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `slider_images`
--
ALTER TABLE `slider_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `fg_wallet_address` (`fg_wallet_address`),
  ADD UNIQUE KEY `fg_id` (`fg_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `api_configs`
--
ALTER TABLE `api_configs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `api_key`
--
ALTER TABLE `api_key`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `bed_type`
--
ALTER TABLE `bed_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `booking_type`
--
ALTER TABLE `booking_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `bulk_address`
--
ALTER TABLE `bulk_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categorys`
--
ALTER TABLE `categorys`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT for table `currency_type`
--
ALTER TABLE `currency_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `deposit_request`
--
ALTER TABLE `deposit_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `facility_group`
--
ALTER TABLE `facility_group`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `global_wallet_address`
--
ALTER TABLE `global_wallet_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=464;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `merchant_request`
--
ALTER TABLE `merchant_request`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `post_category`
--
ALTER TABLE `post_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `promocode`
--
ALTER TABLE `promocode`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `restaruent_invoice`
--
ALTER TABLE `restaruent_invoice`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `restaruent_invoice_history`
--
ALTER TABLE `restaruent_invoice_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `room_facility`
--
ALTER TABLE `room_facility`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `room_images`
--
ALTER TABLE `room_images`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `room_size`
--
ALTER TABLE `room_size`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `rule`
--
ALTER TABLE `rule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `select_room_facilities`
--
ALTER TABLE `select_room_facilities`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `setting`
--
ALTER TABLE `setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `slider_images`
--
ALTER TABLE `slider_images`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
