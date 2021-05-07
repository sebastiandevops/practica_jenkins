-- Server: 127.0.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `devopsdb`
--
CREATE DATABASE devopsdb;
USE devopsdb;

-- --------------------------------------------------------

--
-- Structure for the database: `participante`
--

CREATE TABLE `participante` (
  `Nombre` varchar(20) NOT NULL,
  `id` int(60) NOT NULL,
  `estado` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Some data for the data of table: `participante`
--

INSERT INTO `participante` (`Nombre`, `id`, `estado`) VALUES
('Santiago Garcia', 1111, 0),
('Marlon Gonzalez', 2222, 1),
('Joseph Rangel', 3333, 1),
('Juan Davila', 4444, 0);


--
-- Set ids for table: `participante`
--
ALTER TABLE `participante`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
