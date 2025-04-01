-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 01, 2025 at 08:18 PM
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
(1, 'King Bed', 'king-bed', 1, '2025-03-30 03:23:26', '2025-03-30 03:23:26'),
(2, 'Queen Bed', 'queen-bed', 1, '2025-03-30 03:23:34', '2025-03-30 03:23:34'),
(3, 'Twins Bed', 'twins-bed', 1, '2025-03-30 03:23:42', '2025-03-30 03:23:42'),
(4, 'dsfsdfsdf sdfasdf sdf sd fsd fsdf', 'dsfsdfsdf-sdfasdf-sdf-sd-fsd-fsdf', 1, '2025-03-30 03:23:47', '2025-04-01 21:29:42'),
(5, 'Futon Bed', 'futon-bed', 1, '2025-03-30 03:23:59', '2025-03-30 03:23:59'),
(6, 'Mattress Bed', 'mattress-bed', 1, '2025-03-30 03:24:07', '2025-03-30 03:24:07'),
(7, 'Air Bed', 'air-bed', 1, '2025-03-30 03:24:14', '2025-03-31 05:46:57'),
(8, 'Standard Double', 'standard-double', 1, '2025-03-31 06:02:52', '2025-03-31 20:48:24'),
(9, 'Standard Queen', 'standard-queen', 1, '2025-03-31 20:50:57', '2025-03-31 20:50:57'),
(10, 'Luxury King', 'luxury-king', 1, '2025-03-31 20:52:09', '2025-03-31 20:52:09'),
(11, 'Standard Twin', 'standard-twin', 1, '2025-03-31 20:55:22', '2025-03-31 20:55:22'),
(12, 'Luxury Queen', 'luxury-queen', 1, '2025-03-31 20:56:52', '2025-03-31 20:56:52'),
(13, 'Standard King', 'standard-king', 1, '2025-03-31 20:58:53', '2025-03-31 20:58:53'),
(14, 'Normal Bed', 'normal-bed', 1, '2025-03-31 21:02:54', '2025-03-31 21:02:54');

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

--
-- Dumping data for table `bulk_address`
--

INSERT INTO `bulk_address` (`id`, `merchant_id`, `walletAddress`, `status`, `block_status`, `created_at`, `updated_at`, `entry_by`) VALUES
(2, 3, 'TPAgKfYzRdK83Qocc4gXvEVu4jPKfeuer5', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:38:30', 1),
(3, 3, 'JkP2d0VjGl98rF3Xz73s5Ye6ZTx4aBcqVJ', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(4, 3, '7pKm1NhbYoVqjW2tFJg8hV5Lp1sXyXtM2Z', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(5, 3, 'L3Pc9VrAK6f0WGb7hy2h7X0jt8Q7JwFcNe', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(6, 3, '0NzQ5R9kmTk04c2J7hZ2pHmQyFxpmW8cuv', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(7, 3, 'Bm5rTY7g1jw0AZ0eqP4k9h11vf4sQJklo1', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(8, 3, '8Wm2j1y1r7l3fXaPzR4Vgt8Q3KL64Db3Fw', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(9, 3, '4Ghp2KxA93NFzVy94P6tkGv7Qf1JxkL2X3', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(10, 3, 'kGfX6bY2aq4d80m3zV3jmGpLmPbF8hR2yX', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(11, 3, 'LdT6s3TqGh7Ykn9mAP0jZ3f5Qs1KwN08po', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(12, 3, '1n9Xf2tmLjv4b7cH5Y1KQwBz7e6s1kpN3E', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(13, 3, 'YR8Kv5PQFgXr2WoQFzXcz77n8bPLk09Z2A', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(14, 3, 'oZ4fTmYbHz88rI6WqP2g3xvL6h81Akh09X', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(15, 3, '3bWxTY4P6L0oC7Z8p9fE5DxNzS0yGVZ1Za', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(16, 3, '4AzM9PnS3t7pXg5u0vKcZ8GJXq2Wtf1lS', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(17, 3, 'P6v0n9p6Lh2XbE2mRyq5m0XsZ8K3V5Wk5H', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(18, 3, '8T7tV13oJbC92H4nS0Y0y7XZ7gKp29fB0h', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(19, 3, '2BxKa3p5JhR16vFzH1k4n9d8rLlm0w9VvD', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(20, 3, 'K2hWm4oFqR3ZkL2N1hN8yZ9Yb1tGvM7f7u', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(21, 3, 'oZt85c7m9W4zH9p6QaV0RZm8kXwP2uQ5Hh', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(22, 3, '0Tj8nN4Lkz5pX63X7g9vQ0sDb61CrZTj1D', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(23, 3, 'fC7t9k6bW0z9Yc8mVR2pLm3qF11XlO2n2y', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(24, 3, '2Gb0uH5jJf8t3m9kR1e2n9v7Z5l0G5Xj6', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(25, 3, 'yA0P8c3oZlK6r1DqR9v3d1W9x5Qh8V1mjY', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(26, 3, '3vGnC0d7R8X8y2jSh5m7fQcW9K7a2rjOhC', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(27, 3, 'YV3P6yJ2l9F0k1R6z9V2t9bPq7n2W0Lj1m', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(28, 3, '7gMr8zP2XkS4tD5nJ1p5V1Hq9bR4G9x0o', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(29, 3, 'fP1L6Vt0h2wR8d7nK2cJg5LmX0t9F9m1z7', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(30, 3, '3Tk8qF6oVbL1m3r1Z5Xy9fN1dJ6V7p9XH6', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(31, 3, 'B8gYf7P0Wm0X7F2T9hQ0J3y1b8g0d6m9oG', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(32, 3, 'V7z5K1v9cP6J4Z2r8qLmT0Wf7vH9Y8P5oD', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(33, 3, 'wU2V8c7mJ4gQ5r1o3p9L6yN9n0B8tG2h1J', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(34, 3, 'd9p8t9F4V3v2H8XK8L1Z9Q3W7t0y9C0r6A', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(35, 3, '5gY7kL9t6m9wH4y2Xr7pD9Z1n9t5V2Xb9L', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(36, 3, 'd8M9XyP6K7g0t8Jz1N3r7v9Wb0p6j9g1K', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(37, 3, 'o0R5d2N5tVb9X4y5qQ0M7P2h1F6C8j7Xy', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(38, 3, 'h2n8c5pV7Y1g3B8F7r0X9v9g6T5q9K1o9', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(39, 3, '3B0qF1R9p3dL7M9J6Y8z5Vb0o5X6H9p1z', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(40, 3, '5R3Z8V6p2F1m1W2tL0pV1K8n3B5x8v2L0', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(41, 3, 'Y7k2Q9z7P1t3F5J6gW0p9b8hV2m0X9R0D', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(42, 3, 'Z6wJ0v9dP1F2r1n8tM6L3t9Q9g5X3d5Xy', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(43, 3, 'f4P9X1Z0gK7v2J3p4mR6L8n5t9X6o7W7G', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(44, 3, 'H3Q9W2b5dR0zK7y9mX3P9t0F6w3o7d5Y6', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(45, 3, '0Q3J7p9L1X8g5Y2V9tW3R2zF9J1p4m7bY', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(46, 3, 'X9F0t2b7m0Q3Z8d9gY6L2J1V5n3H6p0W2', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(47, 3, 'j0L9t5P1fR8y2X5m7b3Q7v1Z5g9V0T7Xx', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(48, 3, '0X5Yt9h1pK7q6d8n2F1g3W9J5V8L9c6m2', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(49, 3, '4b0m6H5K2V3y8N0X7p1t9J1r8g7f3W0m3', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(50, 3, 'J2Q4y9W6g1tR7d3Z8p5F3V2mK8v9L1X0N', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(51, 3, '1P9J2yF5X6vR7L8m9n0b3Q7X9Y0t9K7oP', 1, 0, '2025-01-12 22:07:49', '2025-01-12 22:07:49', 4),
(53, 3, '0Q3J7p9L1X8g5Y2V9tW3R2zF9J1p4m7bY3', 1, 0, '2025-01-13 19:31:38', '2025-01-13 19:31:38', NULL);

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
(7, 'Additional Services', 'additional-services', 1, '2025-04-01 15:46:16', '2025-04-01 15:46:16');

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

--
-- Dumping data for table `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(1, '5d64097e-af0c-492d-931d-2ec78ed2263f', 'database', 'default', '{\"uuid\":\"5d64097e-af0c-492d-931d-2ec78ed2263f\",\"displayName\":\"App\\\\Jobs\\\\LargeExcelJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\LargeExcelJob\",\"command\":\"O:22:\\\"App\\\\Jobs\\\\LargeExcelJob\\\":1:{s:11:\\\"\\u0000*\\u0000filePath\\\";s:53:\\\"huploads\\/yNlsQVYw7dLxM3zU17nsxt6uJUpS0yNnKLANMVXD.csv\\\";}\"}}', 'PDOException: SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'title\' cannot be null in D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php:45\nStack trace:\n#0 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(45): PDOStatement->execute()\n#1 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(816): Illuminate\\Database\\MySqlConnection->Illuminate\\Database\\{closure}(\'insert into `vi...\', Array)\n#2 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(783): Illuminate\\Database\\Connection->runQueryCallback(\'insert into `vi...\', Array, Object(Closure))\n#3 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(50): Illuminate\\Database\\Connection->run(\'insert into `vi...\', Array, Object(Closure))\n#4 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Processors\\MySqlProcessor.php(35): Illuminate\\Database\\MySqlConnection->insert(\'insert into `vi...\', Array, \'id\')\n#5 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Builder.php(3549): Illuminate\\Database\\Query\\Processors\\MySqlProcessor->processInsertGetId(Object(Illuminate\\Database\\Query\\Builder), \'insert into `vi...\', Array, \'id\')\n#6 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Builder.php(1982): Illuminate\\Database\\Query\\Builder->insertGetId(Array, \'id\')\n#7 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1334): Illuminate\\Database\\Eloquent\\Builder->__call(\'insertGetId\', Array)\n#8 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1299): Illuminate\\Database\\Eloquent\\Model->insertAndSetId(Object(Illuminate\\Database\\Eloquent\\Builder), Array)\n#9 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1138): Illuminate\\Database\\Eloquent\\Model->performInsert(Object(Illuminate\\Database\\Eloquent\\Builder))\n#10 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1166): Illuminate\\Database\\Eloquent\\Model->save(Array)\n#11 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Concerns\\ManagesTransactions.php(30): Illuminate\\Database\\Eloquent\\Model->Illuminate\\Database\\Eloquent\\{closure}(Object(Illuminate\\Database\\MySqlConnection))\n#12 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1166): Illuminate\\Database\\Connection->transaction(Object(Closure))\n#13 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(167): Illuminate\\Database\\Eloquent\\Model->saveOrFail()\n#14 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(240): Maatwebsite\\Excel\\Imports\\ModelManager->Maatwebsite\\Excel\\Imports\\{closure}(Object(App\\Models\\Video), 0)\n#15 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(172): Illuminate\\Support\\Collection->each(Object(Closure))\n#16 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(240): Maatwebsite\\Excel\\Imports\\ModelManager->Maatwebsite\\Excel\\Imports\\{closure}(Array, 18102)\n#17 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(173): Illuminate\\Support\\Collection->each(Object(Closure))\n#18 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(82): Maatwebsite\\Excel\\Imports\\ModelManager->singleFlush(Object(App\\Imports\\LargeHostersmport))\n#19 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelImporter.php(114): Maatwebsite\\Excel\\Imports\\ModelManager->flush(Object(App\\Imports\\LargeHostersmport), false)\n#20 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelImporter.php(95): Maatwebsite\\Excel\\Imports\\ModelImporter->flush(Object(App\\Imports\\LargeHostersmport), 1, 18102)\n#21 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Sheet.php(258): Maatwebsite\\Excel\\Imports\\ModelImporter->import(Object(PhpOffice\\PhpSpreadsheet\\Worksheet\\Worksheet), Object(App\\Imports\\LargeHostersmport), 1)\n#22 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Reader.php(116): Maatwebsite\\Excel\\Sheet->import(Object(App\\Imports\\LargeHostersmport), 1)\n#23 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Concerns\\ManagesTransactions.php(30): Maatwebsite\\Excel\\Reader->Maatwebsite\\Excel\\{closure}(Object(Illuminate\\Database\\MySqlConnection))\n#24 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Transactions\\DbTransactionHandler.php(30): Illuminate\\Database\\Connection->transaction(Object(Closure))\n#25 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Reader.php(130): Maatwebsite\\Excel\\Transactions\\DbTransactionHandler->__invoke(Object(Closure))\n#26 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Excel.php(155): Maatwebsite\\Excel\\Reader->read(Object(App\\Imports\\LargeHostersmport), \'huploads/yNlsQV...\', \'Csv\', NULL)\n#27 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Facades\\Facade.php(355): Maatwebsite\\Excel\\Excel->import(Object(App\\Imports\\LargeHostersmport), \'huploads/yNlsQV...\')\n#28 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\app\\Jobs\\largeExcelJob.php(26): Illuminate\\Support\\Facades\\Facade::__callStatic(\'import\', Array)\n#29 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\LargeExcelJob->handle()\n#30 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#31 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#32 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#33 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(662): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#34 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#35 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(144): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#36 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(119): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#37 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#38 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(124): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\LargeExcelJob), false)\n#39 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(144): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#40 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(119): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#41 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#42 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\LargeExcelJob))\n#43 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#44 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(439): Illuminate\\Queue\\Jobs\\Job->fire()\n#45 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(389): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#46 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(176): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#47 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(138): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#48 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(121): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#49 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#50 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#51 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#52 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#53 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(662): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#54 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#55 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Command\\Command.php(326): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#56 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(181): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#57 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Application.php(1096): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#58 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#59 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Application.php(175): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#60 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(201): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#61 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#62 {main}\n\nNext Illuminate\\Database\\QueryException: SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'title\' cannot be null (Connection: mysql, SQL: insert into `videos_1` (`video_id`, `category`, `title`, `url`, `thumb_src`, `keywords`, `thumb_size`, `length_sec`, `length_min`, `embed`, `status`, `updated_at`, `created_at`) values (18188, Asian, ?, https://www.eporner.com/video-WsDBaYjd63i//, https://static-ca-cdn.eporner.com/thumbs/static4/1/11/115/11502288/8_240.jpg, medium, 48, amateur, , , brunette, asian, pov, 1677, 27, https://www.eporner.com/embed/WsDBaYjd63i/, 2024-10-20 16:09:02, 2024-10-20 16:09:02)) in D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php:829\nStack trace:\n#0 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Connection.php(783): Illuminate\\Database\\Connection->runQueryCallback(\'insert into `vi...\', Array, Object(Closure))\n#1 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\MySqlConnection.php(50): Illuminate\\Database\\Connection->run(\'insert into `vi...\', Array, Object(Closure))\n#2 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Processors\\MySqlProcessor.php(35): Illuminate\\Database\\MySqlConnection->insert(\'insert into `vi...\', Array, \'id\')\n#3 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Query\\Builder.php(3549): Illuminate\\Database\\Query\\Processors\\MySqlProcessor->processInsertGetId(Object(Illuminate\\Database\\Query\\Builder), \'insert into `vi...\', Array, \'id\')\n#4 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Builder.php(1982): Illuminate\\Database\\Query\\Builder->insertGetId(Array, \'id\')\n#5 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1334): Illuminate\\Database\\Eloquent\\Builder->__call(\'insertGetId\', Array)\n#6 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1299): Illuminate\\Database\\Eloquent\\Model->insertAndSetId(Object(Illuminate\\Database\\Eloquent\\Builder), Array)\n#7 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1138): Illuminate\\Database\\Eloquent\\Model->performInsert(Object(Illuminate\\Database\\Eloquent\\Builder))\n#8 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1166): Illuminate\\Database\\Eloquent\\Model->save(Array)\n#9 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Concerns\\ManagesTransactions.php(30): Illuminate\\Database\\Eloquent\\Model->Illuminate\\Database\\Eloquent\\{closure}(Object(Illuminate\\Database\\MySqlConnection))\n#10 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Model.php(1166): Illuminate\\Database\\Connection->transaction(Object(Closure))\n#11 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(167): Illuminate\\Database\\Eloquent\\Model->saveOrFail()\n#12 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(240): Maatwebsite\\Excel\\Imports\\ModelManager->Maatwebsite\\Excel\\Imports\\{closure}(Object(App\\Models\\Video), 0)\n#13 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(172): Illuminate\\Support\\Collection->each(Object(Closure))\n#14 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(240): Maatwebsite\\Excel\\Imports\\ModelManager->Maatwebsite\\Excel\\Imports\\{closure}(Array, 18102)\n#15 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(173): Illuminate\\Support\\Collection->each(Object(Closure))\n#16 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(82): Maatwebsite\\Excel\\Imports\\ModelManager->singleFlush(Object(App\\Imports\\LargeHostersmport))\n#17 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelImporter.php(114): Maatwebsite\\Excel\\Imports\\ModelManager->flush(Object(App\\Imports\\LargeHostersmport), false)\n#18 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelImporter.php(95): Maatwebsite\\Excel\\Imports\\ModelImporter->flush(Object(App\\Imports\\LargeHostersmport), 1, 18102)\n#19 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Sheet.php(258): Maatwebsite\\Excel\\Imports\\ModelImporter->import(Object(PhpOffice\\PhpSpreadsheet\\Worksheet\\Worksheet), Object(App\\Imports\\LargeHostersmport), 1)\n#20 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Reader.php(116): Maatwebsite\\Excel\\Sheet->import(Object(App\\Imports\\LargeHostersmport), 1)\n#21 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Concerns\\ManagesTransactions.php(30): Maatwebsite\\Excel\\Reader->Maatwebsite\\Excel\\{closure}(Object(Illuminate\\Database\\MySqlConnection))\n#22 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Transactions\\DbTransactionHandler.php(30): Illuminate\\Database\\Connection->transaction(Object(Closure))\n#23 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Reader.php(130): Maatwebsite\\Excel\\Transactions\\DbTransactionHandler->__invoke(Object(Closure))\n#24 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\maatwebsite\\excel\\src\\Excel.php(155): Maatwebsite\\Excel\\Reader->read(Object(App\\Imports\\LargeHostersmport), \'huploads/yNlsQV...\', \'Csv\', NULL)\n#25 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Facades\\Facade.php(355): Maatwebsite\\Excel\\Excel->import(Object(App\\Imports\\LargeHostersmport), \'huploads/yNlsQV...\')\n#26 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\app\\Jobs\\largeExcelJob.php(26): Illuminate\\Support\\Facades\\Facade::__callStatic(\'import\', Array)\n#27 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Jobs\\LargeExcelJob->handle()\n#28 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(662): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#33 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(144): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#34 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(119): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#35 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#36 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(124): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Jobs\\LargeExcelJob), false)\n#37 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(144): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#38 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(119): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Jobs\\LargeExcelJob))\n#39 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#40 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Jobs\\LargeExcelJob))\n#41 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#42 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(439): Illuminate\\Queue\\Jobs\\Job->fire()\n#43 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(389): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#44 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(176): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#45 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(138): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#46 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(121): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#47 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#48 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(41): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#49 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#50 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#51 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(662): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#52 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#53 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Command\\Command.php(326): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#54 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(181): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#55 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Application.php(1096): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#56 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Application.php(324): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#57 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\symfony\\console\\Application.php(175): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#58 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(201): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#59 D:\\xampp\\htdocs\\apps\\fgames_v2\\api\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#60 {main}', '2024-10-20 10:09:02');

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

--
-- Dumping data for table `global_wallet_address`
--

INSERT INTO `global_wallet_address` (`id`, `name`, `slug`, `status`, `lock_unlock`, `created_at`, `updated_at`) VALUES
(1, 'TYspxFx6hpoPMY7bQD9sMAr8MXHXRGpZcV', NULL, 1, 0, '2024-07-12 18:37:40', '2024-07-15 22:18:01'),
(2, 'TYqqYjuu7Wu9rntHKkttg4bTRVQBJSKTVx', NULL, 1, 0, '2024-07-12 18:37:49', '2024-07-16 17:44:30'),
(3, 'TN2rjjCvFNHJn5GDEeYdtSoiUhS5pb5UBo', NULL, 1, 0, '2024-07-12 18:37:49', '2024-07-13 03:40:19'),
(4, 'TFfy3cXnTDTsbjrDmaxhtDUtegBQMTTsGB', NULL, 1, 0, '2024-07-12 18:37:49', '2024-07-13 03:46:32'),
(5, 'TW7MHZQktuHF3P8hjQtpALhFR3x7xcAarK', NULL, 1, 0, '2024-07-12 18:37:49', '2024-07-13 03:49:20'),
(6, 'TL2gcHbUskPiVBPrf8zFLMfswVp6B2yjK9', NULL, 1, 0, '2024-07-12 18:37:49', '2024-07-13 03:51:50'),
(7, 'TKpEvzgncwWUx252YUdmrJU2RLmoHzm43A', NULL, 1, 0, '2024-07-12 18:37:49', '2024-07-13 05:38:18'),
(8, 'TKvQL9ykYyDCEkNSoktjzDhQppX3Gz5oWE', NULL, 1, 0, '2024-07-12 18:37:49', '2024-07-13 06:16:18'),
(9, 'TAosrFLVXqRk1eEPisoKLAZ6KRu5yBSgVK', NULL, 1, 0, '2024-07-12 18:37:49', '2024-07-12 18:37:49'),
(10, 'TJ31ZrjgFBsdySaLqUaM2FQaGmNjqQBVb6', NULL, 1, 0, '2024-07-12 18:37:49', '2024-07-12 18:37:49'),
(11, 'TXbbicZTeHY3nv3g9v5GWjwpu6f9hGSNVN', NULL, 1, 0, '2024-07-12 18:37:49', '2024-07-12 18:37:49'),
(12, 'TFpS6PeSvGSRK6xv1GNftPb4dvfTHoeUfh', NULL, 1, 0, '2024-07-12 18:37:49', '2024-07-12 18:37:49'),
(13, 'TQUiTZzqypMpwSNTaKS1kye2p1MGd4tNvK', 'tquitzzqypmpwsntaks1kye2p1mgd4tnvk', 1, 0, '2024-07-12 18:37:49', '2024-12-09 18:47:54');

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
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`id`, `name`, `slug`, `roomType`, `capacity`, `extraCapacity`, `roomPrice`, `bedCharge`, `room_size_id`, `bedNumber`, `bed_type_id`, `roomDescription`, `reserveCondition`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Vip Guest', 'vip-guest', 'Vip Guest', 3, 'YES', 4000.00, 100, 6, '2', 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 20:48:04', '2025-03-31 20:48:38'),
(2, 'Vip', 'vip', 'Vip', 20, 'YES', 10000.00, 400, 6, '1', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 20:49:42', '2025-03-31 20:49:42'),
(3, 'Family Room', 'family-room', 'Family Room', 4, 'YES', 4500.00, 150, 5, '2', 9, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 20:50:46', '2025-03-31 20:51:06'),
(4, 'Deluxe Suite', 'deluxe-suite', 'Deluxe Suite', 3, 'YES', 5500.00, 130, 6, '1', 10, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 20:51:54', '2025-03-31 20:52:21'),
(5, 'Standard Room', 'standard-room', 'Standard Room', 3, 'YES', 3000.00, 80, 5, '1', 9, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 20:53:04', '2025-03-31 20:53:04'),
(6, 'Single Room', 'single-room', 'Single Room', 1, 'YES', 2500.00, 70, 13, '1', 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 20:53:58', '2025-03-31 20:55:32'),
(7, 'Executive Room', 'executive-room', 'Executive Room', 2, 'YES', 4500.00, 110, 5, '2', 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 20:56:46', '2025-03-31 20:57:02'),
(8, 'Presidential Suite', 'presidential-suite', 'Presidential Suite', 6, 'YES', 8000.00, 200, 6, '3', 10, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 20:57:43', '2025-03-31 20:57:43'),
(9, 'Double Room', 'double-room', 'Double Room', 2, 'YES', 3500.00, 90, 6, '1', 13, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 20:58:42', '2025-03-31 20:59:00'),
(10, 'Family Suite', 'family-suite', 'Family Suite', 5, 'YES', 6000.00, 160, 6, '2', 10, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 20:59:37', '2025-03-31 20:59:37'),
(11, 'Junior Suite', 'junior-suite', 'Junior Suite', 3, 'YES', 4800.00, 140, 5, '1', 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 21:00:24', '2025-03-31 21:00:24'),
(12, 'King Suite', 'king-suite', 'King Suite', 4, 'YES', 7000.00, 180, 6, '2', 10, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 21:01:03', '2025-03-31 21:01:03'),
(13, 'Twin Room', 'twin-room', 'Twin Room', 2, 'YES', 3200.00, 85, 13, '2', 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 21:01:42', '2025-03-31 21:01:42'),
(14, 'Signal Room', 'signal-room', 'Signal Room', 1, 'YES', 1600.00, 300, 14, '1', 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', '', 1, '2025-03-31 21:02:34', '2025-03-31 21:12:37'),
(16, 'Triple Room', 'triple-room', 'Triple Room', 5, 'YES', 500.00, 50, 3, '5', 10, 'Triple Room Triple Room', '', 1, '2025-04-01 12:12:37', '2025-04-01 14:39:10');

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
(24, 2, 'Mosquito net', 'mosquito-net', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03'),
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
(63, 7, 'Airport transfer service', 'airport-transfer-service', 1, '2025-04-01 18:02:03', '2025-04-01 18:02:03');

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
(8, 1, '/backend/files/t3US2GOQs00sWMIxl13I.jpg', 'VIP-Guest', 1, '2025-04-01 11:58:56', '2025-04-01 11:58:56'),
(12, 2, '/backend/files/YyOfAYVFO9x8Px0EpK6t.jpg', 'VIP', 1, '2025-04-01 12:03:56', '2025-04-01 12:03:56'),
(15, 6, '/backend/files/SchwxHa0fnywAk6g2zv9.jpg', 'Single room', 1, '2025-04-01 12:09:40', '2025-04-01 12:09:40'),
(16, 13, '/backend/files/uqg4GTb01gOoRw97yA6I.jpg', 'Twin Room', 1, '2025-04-01 12:09:57', '2025-04-01 12:09:57'),
(17, 16, '/backend/files/P2qWAYCEDqUJXPi4NAto.jpg', 'Triple Room', 1, '2025-04-01 12:12:56', '2025-04-01 12:12:56');

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
(2, 'Users', 1, '2024-04-16 10:56:15', '2024-04-16 10:56:15'),
(3, 'Admin', 1, '2024-04-16 10:56:27', '2024-12-06 12:43:05');

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `deposit_service_charge` int(11) DEFAULT NULL COMMENT '%',
  `convert_php_amt` float DEFAULT NULL,
  `withdraw_service_charge` int(11) DEFAULT NULL COMMENT '%',
  `withdraw_minimum_amount` int(11) DEFAULT NULL,
  `withdraw_maximum_amount` int(11) DEFAULT NULL,
  `minimum_trade_amount` int(11) DEFAULT NULL,
  `minimum_purchages_amt` int(11) DEFAULT NULL,
  `minimum_deposit_amount` int(11) DEFAULT NULL,
  `trade_fee` int(11) DEFAULT NULL COMMENT '%',
  `tel` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` mediumtext NOT NULL,
  `whatsApp` varchar(255) NOT NULL,
  `emergency` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `description` mediumtext NOT NULL,
  `copyright` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `admin_photo` varchar(244) NOT NULL,
  `admin_name` varchar(255) NOT NULL,
  `admin_email` varchar(255) NOT NULL,
  `admin_phone` varchar(255) NOT NULL,
  `meta_keywords` mediumtext DEFAULT NULL,
  `meta_description` mediumtext DEFAULT NULL,
  `pphoto` varchar(255) NOT NULL,
  `bg_color` varchar(255) DEFAULT NULL,
  `currency` varchar(150) DEFAULT NULL,
  `openinig_balance_date` date DEFAULT NULL,
  `reffer_bonus` int(11) DEFAULT NULL,
  `maximum_supply` double(10,2) DEFAULT NULL,
  `total_supply` varchar(255) DEFAULT NULL,
  `openinig_balance_comments` mediumtext DEFAULT NULL,
  `fblink` varchar(255) DEFAULT NULL,
  `twitterlink` varchar(255) DEFAULT NULL,
  `linkdinlink` varchar(255) DEFAULT NULL,
  `instragramlink` varchar(255) DEFAULT NULL,
  `store_policy` longtext DEFAULT NULL,
  `crypto_wallet_address` varchar(255) DEFAULT NULL,
  `master_pass_acc_no` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `telegram` varchar(255) DEFAULT NULL,
  `register_bonus` int(11) DEFAULT NULL,
  `mininmum_deposit_amount` double(10,2) DEFAULT NULL,
  `maximum_deposit_amount` double(10,2) DEFAULT NULL,
  `minimum_withdrawal` double(10,2) DEFAULT NULL,
  `maximum_withdrawal` double(10,2) DEFAULT NULL,
  `level_1_bonus` int(11) DEFAULT NULL,
  `level_2_bonus` int(11) DEFAULT NULL,
  `level_3_bonus` int(11) DEFAULT NULL,
  `ocn_purchage` double(10,2) DEFAULT NULL,
  `daily_max_withdraw_request` double(10,2) DEFAULT NULL,
  `withdrawal_free_amount` double(10,2) DEFAULT NULL,
  `withdrawal_free_on_percentage` double(10,2) DEFAULT NULL,
  `maximum_supply_level` varchar(255) DEFAULT NULL,
  `mimumun_transfer_amount_to_other_user` double(10,2) DEFAULT NULL,
  `maximum_transfer_amount_to_other_user` double(10,2) DEFAULT NULL,
  `transfer_fee_fixed_amount` double(10,2) DEFAULT NULL,
  `traansfer_fee_on_percentage` double(10,2) DEFAULT NULL,
  `total_supply_level` varchar(255) DEFAULT NULL,
  `liquidity_total_supply` varchar(255) DEFAULT NULL,
  `beganing_price` varchar(255) DEFAULT NULL,
  `circlation` varchar(255) DEFAULT NULL,
  `update_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id`, `name`, `deposit_service_charge`, `convert_php_amt`, `withdraw_service_charge`, `withdraw_minimum_amount`, `withdraw_maximum_amount`, `minimum_trade_amount`, `minimum_purchages_amt`, `minimum_deposit_amount`, `trade_fee`, `tel`, `email`, `address`, `whatsApp`, `emergency`, `photo`, `description`, `copyright`, `status`, `admin_photo`, `admin_name`, `admin_email`, `admin_phone`, `meta_keywords`, `meta_description`, `pphoto`, `bg_color`, `currency`, `openinig_balance_date`, `reffer_bonus`, `maximum_supply`, `total_supply`, `openinig_balance_comments`, `fblink`, `twitterlink`, `linkdinlink`, `instragramlink`, `store_policy`, `crypto_wallet_address`, `master_pass_acc_no`, `website`, `telegram`, `register_bonus`, `mininmum_deposit_amount`, `maximum_deposit_amount`, `minimum_withdrawal`, `maximum_withdrawal`, `level_1_bonus`, `level_2_bonus`, `level_3_bonus`, `ocn_purchage`, `daily_max_withdraw_request`, `withdrawal_free_amount`, `withdrawal_free_on_percentage`, `maximum_supply_level`, `mimumun_transfer_amount_to_other_user`, `maximum_transfer_amount_to_other_user`, `transfer_fee_fixed_amount`, `traansfer_fee_on_percentage`, `total_supply_level`, `liquidity_total_supply`, `beganing_price`, `circlation`, `update_by`, `created_at`, `updated_at`) VALUES
(1, 'OCN TRADE AI', 5, 64, 5, 20, 4000, 5, 20, 20, 6, '+44245454545', 'ocn@abcd.com', 'Addres', '00000055555', '+000000', 'pic/2tAjiUpJ0X8GziIrKJJJ.png', 'Business Description', 'Copyright Â© 2024 uic . All Rights Reserved', 1, 'pic/ZOdc8nsWAMY1YELkp9zH.jpg', 'admin', 'info@admin.com', '+44245454545', NULL, NULL, '', '#ffffff', '$', '2020-05-13', 5, 30000000.00, '4500000', NULL, 'https://www.fiverr.com', 'https://www.facebook.com', 'https://web.whatsapp.com/', '#', '', 'TPpMvdKfhENfJqYZsDJQLgEopMRBy15jeU', '225588996633', 'http://winup360.com', '116898999999', 5, 55.00, 5.00, 20.00, 3690.00, 3, 2, 1, NULL, 5.00, 5.00, 5.00, '30 MILLION', 5.00, 5.00, 5.00, 50.00, '4.5 MILLION', '5000', '0.0011244444', 'null', 2993, '2024-05-12 05:32:50', '2024-05-12 03:42:05');

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
  `role_id` int(11) DEFAULT NULL,
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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `logged_out` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fg_id`, `fg_wallet_address`, `inviteCode`, `ref_id`, `employee_id`, `company_name`, `role_id`, `name`, `email`, `username`, `phone`, `available_balance`, `show_password`, `password`, `real_name`, `phone_number`, `image`, `doc_file`, `address`, `address_1`, `address_2`, `website`, `github`, `gender`, `date_of_birth`, `twitter`, `instagram`, `nationality_id`, `state_id`, `otp`, `facebook`, `wallet_balance`, `email_verified_at`, `telegram`, `whtsapp`, `remember_token`, `entry_by`, `register_ip`, `lastlogin_ip`, `lastlogin_country`, `lastlogin_datetime`, `created_at`, `updated_at`, `status`, `logged_out`) VALUES
(1, NULL, '6f21357fs863ce24ce21c1a82f49a7d5d13', '0000123', 0, 4, 'FG IT', 1, 'Black Jons', 'dev1@mail.com', 'dev', '01915728982', NULL, 'dev', '$2y$10$egNt4iHOZ4sWab8IcaHE9..QCyQc3z4oFRYUwesyeTH52KDFzM5.y', NULL, '01915728982', '/backend/files/hZkagctUSINKsFU64UJr.png', NULL, 'Dhaka', '', '', 'http://localhost:3000/profile', 'http://localhost:3000/profile', '', '1982-01-30', 'http://localhost:3000/profile', 'http://localhost:3000/profile', 0, 0, NULL, 'http://localhost:3000/profile', NULL, NULL, NULL, NULL, NULL, 1, NULL, '127.0.0.1', NULL, '2024-11-22 09:50:10', '2023-06-22 03:20:43', '2024-12-07 10:42:29', 1, NULL),
(2, 'FG000000002', 'be036e59dd06bfa6d13d36110d3d96a3', '9234087', 0, NULL, 'Dream CareFangs', 3, 'Mamun', 'mrmamun@gmail.com', 'mamun', '01915728983', NULL, 'Password', '$2y$10$VQOKQNqr6/WAhN004ea0Nu.N/j4Tgy2TQL8rzAeEGhm.LBeoUzW5a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2024-10-17 07:13:54', '2024-10-17 07:13:54', 1, NULL),
(3, 'FG000000003', '52f02f16c2f22a233e76a84fe87f73f4', '2843662', 0, NULL, 'FansGame Online', 2, 'Mamun Ahmed', 'mrmamunahmed@gmail.com', 'mamunahmed', '01915728984', NULL, 'dev', '$2y$10$o/S3ILyrSzVNu06bypfKDODM4ZD4wXYbdiX53wiCh7ThvomWrQNJG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '127.0.0.1', NULL, NULL, NULL, '2024-10-17 07:14:44', '2025-01-08 22:24:22', 1, NULL),
(4, 'FG000000004', '0294d090cc9b186adac2d2f0bd8ced42', '4941998', 0, NULL, 'Facebook', 2, 'Kabir', 'kabirahmed@gmail.com', 'kabirahmed', '01915728985', NULL, 'kabirahmed', '$2y$10$lmzA0KbNyMantkLl55QsWO1VzooI7rpLZXTozHrOatTLhSn3wSZ/i', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2024-10-17 07:18:14', '2024-10-17 07:18:14', 1, NULL),
(5, 'FG000000005', '08247c76f2cf3eed3bff4456509cc593', '9598693', 0, NULL, 'Google', 2, 'Ibraheem', 'ibraheem@gmail.com', 'Ibraheem', '01915728986', NULL, 'Ibraheem', '$2y$10$6a9KsR/hyDkbiBhu8Qa74.G88m6JzIZ3RgXNFNtAuBqpyMUko2FtC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2024-10-17 09:05:59', '2024-10-17 09:05:59', 1, NULL),
(6, 'FG000000006', 'fc375fb7c06ab05b400f730b53754aeb', '0369589', 0, NULL, 'Twitter', 2, 'Ayesha', 'ayesha@gmail.com', 'ayesha', '01915728987', NULL, 'ayesha', '$2y$10$YXGs5Rf7tFbBWeW91LFyW.AXjTLIeX7xRrvMAZaqAtlZ764VJo4Hy', NULL, '', NULL, NULL, '', NULL, NULL, 'http://localhost:5173/my-profile', '', NULL, NULL, 'http://localhost:5173/my-profileTwitter', '', NULL, NULL, NULL, 'http://localhost:5173/my-profileFacebook', NULL, NULL, 'Teelegram', '01954784555', NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2024-10-17 09:07:16', '2024-10-17 09:07:16', 1, NULL),
(21, 'FG000000021', '6537aff00a10a37930603165a2da53f4', '2009591', 0, NULL, 'Linkdin', 2, 'Postman', 'postman@gmail.com', 'postman@gmail.com', '01915728988', NULL, 'postman@gmail.com', '$2y$10$0uPrvPrY83vXfd2KJCA9AOkRRC7sdNVAsmB4larhW8FG3g5KL9ZNu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, '2024-11-27 07:40:00', '2024-11-27 07:40:00', 1, NULL),
(22, 'FG000000022', '8e3c461a604cc05851d6461b764ff56d', '7234009', 0, NULL, 'Dropbox', 2, 'Alamin', 'pc@gmail.com', 'pc', '01915728989', NULL, 'bijonpassword', '$2y$10$20dlwRdo55XEHA90nIiNQ.RA6aXq.c12LJ36/N5JVyQyEcxx/uKnG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, '127.0.0.1', NULL, NULL, NULL, '2024-11-27 09:28:43', '2024-12-07 08:44:05', 1, NULL);

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
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `setting`
--
ALTER TABLE `setting`
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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `booking_type`
--
ALTER TABLE `booking_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `bulk_address`
--
ALTER TABLE `bulk_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `global_wallet_address`
--
ALTER TABLE `global_wallet_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `room_facility`
--
ALTER TABLE `room_facility`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `room_images`
--
ALTER TABLE `room_images`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `room_size`
--
ALTER TABLE `room_size`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `rule`
--
ALTER TABLE `rule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `setting`
--
ALTER TABLE `setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
