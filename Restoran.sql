-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 22, 2024 at 08:40 AM
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
-- Database: `restoran`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DaftarMenu` ()   BEGIN
    SELECT * FROM Menu;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTotalPesanan` (IN `tgl_mulai` DATE, IN `tgl_selesai` DATE)   BEGIN
    IF tgl_mulai IS NULL OR tgl_selesai IS NULL THEN
        SELECT 'Please provide both start and end dates' AS Catatan;
    ELSE
        SELECT SUM(Jumlah) AS Jumlah
        FROM Pemesanan
        WHERE Tgl_pesan BETWEEN tgl_mulai AND tgl_selesai;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GetTotalPelanggan` () RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE total_pelanggan INT;
    SELECT COUNT(*) INTO total_pelanggan FROM pelanggan;
    RETURN total_pelanggan;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `GetTotalPesanansByPelanggan` (`tgl_mulai` DATE, `tgl_selesai` DATE) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE total_pemesanan INT;
    SELECT COUNT(*) INTO total_pemesanan
    FROM Pemesanan
    WHERE Tgl_pesan BETWEEN tgl_mulai AND tgl_selesai;
    RETURN total_pemesanan;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detailkaryawan`
--

CREATE TABLE `detailkaryawan` (
  `KaryawanID` int(11) DEFAULT NULL,
  `Nama` varchar(100) DEFAULT NULL,
  `Alamat` text DEFAULT NULL,
  `Jenis_kelamin` char(1) DEFAULT NULL,
  `Agama` varchar(10) DEFAULT NULL,
  `No_hp` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detailkaryawan`
--

INSERT INTO `detailkaryawan` (`KaryawanID`, `Nama`, `Alamat`, `Jenis_kelamin`, `Agama`, `No_hp`) VALUES
(1, 'Siswanto', 'Sleman', 'L', 'Islam', '081222333111'),
(2, 'Bella Setyani', 'Sleman', 'P', 'Kristen', '081222333112'),
(3, 'Kiki Saputra', 'Catur Tunggal', 'L', 'Islam', '081222333113'),
(4, 'Abimanyu', 'Sleman', 'L', 'Islam', '081222333114'),
(5, 'Aditya', 'Bantul', 'L', 'Islam', '081222333115');

-- --------------------------------------------------------

--
-- Table structure for table `detailpemesanan`
--

CREATE TABLE `detailpemesanan` (
  `DetailPemesananID` int(11) NOT NULL,
  `PemesananID` int(11) DEFAULT NULL,
  `MenuID` int(11) DEFAULT NULL,
  `Jumlah` int(11) DEFAULT NULL,
  `Pembayaran` varchar(20) DEFAULT NULL,
  `KaryawanID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detailpemesanan`
--

INSERT INTO `detailpemesanan` (`DetailPemesananID`, `PemesananID`, `MenuID`, `Jumlah`, `Pembayaran`, `KaryawanID`) VALUES
(1, 1, 1, 6000, 'Cash', 2),
(2, 2, 2, 7000, 'Cash', 2),
(3, 3, 3, 2000, 'Cash', 2),
(4, 4, 3, 2000, 'Cash', 2),
(5, 5, 4, 3000, 'Cash', 2);

-- --------------------------------------------------------

--
-- Table structure for table `detailpemesananindex`
--

CREATE TABLE `detailpemesananindex` (
  `DetailPemesananID` int(11) NOT NULL,
  `PemesananID` int(11) DEFAULT NULL,
  `MenuID` int(11) DEFAULT NULL,
  `Jumlah` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `KaryawanID` int(11) NOT NULL,
  `Nama` varchar(100) DEFAULT NULL,
  `Jabatan` varchar(100) DEFAULT NULL,
  `Tgl_masuk` date DEFAULT NULL,
  `Gaji` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`KaryawanID`, `Nama`, `Jabatan`, `Tgl_masuk`, `Gaji`) VALUES
(1, 'Siswanto', 'Koki', '2023-07-01', 3000000.00),
(2, 'Bella Setyani', 'Kasir', '2024-01-21', 2600000.00),
(3, 'Kiki Saputra', 'Pramusaji', '2023-09-05', 3000000.00),
(4, 'Abimanyu', 'Pramusaji', '2023-09-05', 3000000.00),
(5, 'Aditya', 'Koki', '2024-01-11', 2800000.00);

-- --------------------------------------------------------

--
-- Stand-in structure for view `kontakpelangganview`
-- (See below for the actual view)
--
CREATE TABLE `kontakpelangganview` (
`Nama` varchar(100)
,`Email` varchar(100)
,`No_hp` varchar(15)
);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `MenuID` int(11) NOT NULL,
  `Nama` varchar(100) DEFAULT NULL,
  `Harga` decimal(10,2) DEFAULT NULL,
  `Deskripsi` varchar(255) DEFAULT NULL,
  `Tipe` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`MenuID`, `Nama`, `Harga`, `Deskripsi`, `Tipe`) VALUES
(1, 'Nasi Sayur', 6000.00, 'Nasi sayur ', 'Makanan'),
(2, 'Nasi Telur', 7000.00, 'Nasi Sayur + Telur', 'Makanan'),
(3, 'Teh Panas', 2000.00, 'Teh Panas/Anget', 'Minuman'),
(4, 'Es Teh', 3000.00, 'S Teh', 'Minuman'),
(5, 'Kerupuk', 1000.00, 'Kerupuk Putih', 'Lain-Lain');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `PelangganID` int(11) NOT NULL,
  `Nama` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `No_hp` varchar(15) DEFAULT NULL,
  `Alamat` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`PelangganID`, `Nama`, `Email`, `No_hp`, `Alamat`) VALUES
(1, 'Abdi', 'Abdi@gmail.com', '08123456789', 'Condongcatur'),
(2, 'Budi', 'Budi@gmail.com', '08123456788', 'Sleman'),
(3, 'Cintya', 'Cintya@gmail.com', '08123456787', 'Condongcatur'),
(4, 'Dika', 'Dika@gmail.com', '08123456786', 'Depok'),
(5, 'Ella', 'Ella@gmail.com', '08123456785', 'Depok'),
(6, 'Frank Moore', 'frank@example.com', '111-222-3333', '789 Birch St');

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan`
--

CREATE TABLE `pemesanan` (
  `PemesananID` int(11) NOT NULL,
  `PelangganID` int(11) DEFAULT NULL,
  `Tgl_pesan` date DEFAULT NULL,
  `Jumlah` decimal(10,2) DEFAULT NULL,
  `Catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemesanan`
--

INSERT INTO `pemesanan` (`PemesananID`, `PelangganID`, `Tgl_pesan`, `Jumlah`, `Catatan`) VALUES
(1, 1, '2024-07-19', 6000.00, NULL),
(2, 3, '2024-07-20', 7000.00, NULL),
(3, 2, '2024-07-21', 2000.00, NULL),
(4, 4, '2024-07-21', 2000.00, NULL),
(5, 5, '2024-07-21', 3000.00, NULL),
(6, 3, '2024-07-20', 2000.00, NULL),
(7, 1, '2024-07-06', 50.00, NULL);

--
-- Triggers `pemesanan`
--
DELIMITER $$
CREATE TRIGGER `after_pemesanan_delete` AFTER DELETE ON `pemesanan` FOR EACH ROW BEGIN
    INSERT INTO PemesananLog (PemesananID, Action) VALUES (OLD.PemesananID, 'AFTER DELETE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_pemesanan_insert` AFTER INSERT ON `pemesanan` FOR EACH ROW BEGIN
    INSERT INTO PemesananLog (PemesananID, Action) VALUES (NEW.PemesananID, 'AFTER INSERT');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_pemesanan_update` AFTER UPDATE ON `pemesanan` FOR EACH ROW BEGIN
    INSERT INTO PemesananLog (PemesananID, Action) VALUES (NEW.PemesananID, 'AFTER UPDATE');

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_pemesanan_delete` BEFORE DELETE ON `pemesanan` FOR EACH ROW BEGIN
    INSERT INTO PemesananLog (PemesananID, Action) VALUES (OLD.PemesananID, 'BEFORE DELETE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_pemesanan_insert` BEFORE INSERT ON `pemesanan` FOR EACH ROW BEGIN
    INSERT INTO PemesananLog (PemesananID, Action) VALUES (NEW.PemesananID, 'BEFORE INSERT');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_pemesanan_update` BEFORE UPDATE ON `pemesanan` FOR EACH ROW BEGIN
    INSERT INTO PemesananLog (PemesananID, Action) VALUES (NEW.PemesananID, 'BEFORE UPDATE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ifEXISTS_before_pemesanan_insert` BEFORE INSERT ON `pemesanan` FOR EACH ROW BEGIN
    INSERT INTO PemesananLog (PemesananID, Action) VALUES (NEW.PemesananID, 'BEFORE INSERT');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pemesananlog`
--

CREATE TABLE `pemesananlog` (
  `LogID` int(11) NOT NULL,
  `PemesananID` int(11) DEFAULT NULL,
  `Action` varchar(50) DEFAULT NULL,
  `ActionDate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemesananlog`
--

INSERT INTO `pemesananlog` (`LogID`, `PemesananID`, `Action`, `ActionDate`) VALUES
(1, 1, 'BEFORE INSERT', '2024-07-21 00:45:30'),
(2, 1, 'AFTER INSERT', '2024-07-21 00:45:30'),
(3, 2, 'BEFORE INSERT', '2024-07-21 00:46:36'),
(4, 2, 'AFTER INSERT', '2024-07-21 00:46:36'),
(5, 3, 'BEFORE INSERT', '2024-07-21 00:46:36'),
(6, 3, 'AFTER INSERT', '2024-07-21 00:46:36'),
(7, 4, 'BEFORE INSERT', '2024-07-21 00:46:36'),
(8, 4, 'AFTER INSERT', '2024-07-21 00:46:36'),
(9, 5, 'BEFORE INSERT', '2024-07-21 00:46:36'),
(10, 5, 'AFTER INSERT', '2024-07-21 00:46:36'),
(11, 1, 'BEFORE UPDATE', '2024-07-21 01:57:24'),
(12, 1, 'AFTER UPDATE', '2024-07-21 01:57:24'),
(13, 2, 'BEFORE UPDATE', '2024-07-21 01:58:41'),
(14, 2, 'AFTER UPDATE', '2024-07-21 01:58:41'),
(15, 3, 'BEFORE UPDATE', '2024-07-21 01:58:41'),
(16, 3, 'AFTER UPDATE', '2024-07-21 01:58:41'),
(17, 4, 'BEFORE UPDATE', '2024-07-21 01:58:41'),
(18, 4, 'AFTER UPDATE', '2024-07-21 01:58:41'),
(19, 5, 'BEFORE UPDATE', '2024-07-21 01:58:41'),
(20, 5, 'AFTER UPDATE', '2024-07-21 01:58:41'),
(21, 6, 'BEFORE INSERT', '2024-07-21 01:59:48'),
(22, 6, 'AFTER INSERT', '2024-07-21 01:59:48'),
(39, 7, 'BEFORE INSERT', '2024-07-22 03:40:18'),
(40, 7, 'BEFORE INSERT', '2024-07-22 03:40:18'),
(41, 7, 'AFTER INSERT', '2024-07-22 03:40:18'),
(42, 8, 'BEFORE INSERT', '2024-07-22 03:41:33'),
(43, 8, 'BEFORE INSERT', '2024-07-22 03:41:33'),
(44, 8, 'AFTER INSERT', '2024-07-22 03:41:33'),
(45, 8, 'BEFORE UPDATE', '2024-07-22 03:48:15'),
(46, 8, 'AFTER UPDATE', '2024-07-22 03:48:15'),
(47, 8, 'BEFORE DELETE', '2024-07-22 04:00:25'),
(48, 8, 'AFTER DELETE', '2024-07-22 04:00:25');

-- --------------------------------------------------------

--
-- Stand-in structure for view `pemesananpelangganview`
-- (See below for the actual view)
--
CREATE TABLE `pemesananpelangganview` (
`PelangganID` int(11)
,`Nama` varchar(100)
,`PemesananID` int(11)
,`Tgl_pesan` date
,`Jumlah` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pesananpelangganaktifview`
-- (See below for the actual view)
--
CREATE TABLE `pesananpelangganaktifview` (
`PelangganID` int(11)
,`Nama` varchar(100)
,`PemesananID` int(11)
,`Tgl_pesan` date
,`Jumlah` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Structure for view `kontakpelangganview`
--
DROP TABLE IF EXISTS `kontakpelangganview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `kontakpelangganview`  AS SELECT `pelanggan`.`Nama` AS `Nama`, `pelanggan`.`Email` AS `Email`, `pelanggan`.`No_hp` AS `No_hp` FROM `pelanggan` ;

-- --------------------------------------------------------

--
-- Structure for view `pemesananpelangganview`
--
DROP TABLE IF EXISTS `pemesananpelangganview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pemesananpelangganview`  AS SELECT `pl`.`PelangganID` AS `PelangganID`, `pl`.`Nama` AS `Nama`, `pm`.`PemesananID` AS `PemesananID`, `pm`.`Tgl_pesan` AS `Tgl_pesan`, `pm`.`Jumlah` AS `Jumlah` FROM (`pelanggan` `pl` join `pemesanan` `pm` on(`pm`.`PelangganID` = `pm`.`PelangganID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `pesananpelangganaktifview`
--
DROP TABLE IF EXISTS `pesananpelangganaktifview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pesananpelangganaktifview`  AS SELECT `pemesananpelangganview`.`PelangganID` AS `PelangganID`, `pemesananpelangganview`.`Nama` AS `Nama`, `pemesananpelangganview`.`PemesananID` AS `PemesananID`, `pemesananpelangganview`.`Tgl_pesan` AS `Tgl_pesan`, `pemesananpelangganview`.`Jumlah` AS `Jumlah` FROM `pemesananpelangganview` WHERE `pemesananpelangganview`.`Tgl_pesan` > '2024-01-01'WITH CASCADED CHECK OPTION  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detailkaryawan`
--
ALTER TABLE `detailkaryawan`
  ADD KEY `KaryawanID` (`KaryawanID`);

--
-- Indexes for table `detailpemesanan`
--
ALTER TABLE `detailpemesanan`
  ADD PRIMARY KEY (`DetailPemesananID`),
  ADD KEY `PemesananID` (`PemesananID`),
  ADD KEY `MenuID` (`MenuID`),
  ADD KEY `KaryawanID` (`KaryawanID`);

--
-- Indexes for table `detailpemesananindex`
--
ALTER TABLE `detailpemesananindex`
  ADD PRIMARY KEY (`DetailPemesananID`),
  ADD KEY `DetailPemesananIndex` (`PemesananID`,`MenuID`);

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`KaryawanID`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`MenuID`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`PelangganID`),
  ADD KEY `idx_pelanggan_email_nomor` (`Email`,`No_hp`);

--
-- Indexes for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`PemesananID`),
  ADD KEY `idx_pemesanan_pelanggan` (`PelangganID`,`Tgl_pesan`);

--
-- Indexes for table `pemesananlog`
--
ALTER TABLE `pemesananlog`
  ADD PRIMARY KEY (`LogID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pemesananlog`
--
ALTER TABLE `pemesananlog`
  MODIFY `LogID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detailkaryawan`
--
ALTER TABLE `detailkaryawan`
  ADD CONSTRAINT `detailkaryawan_ibfk_1` FOREIGN KEY (`KaryawanID`) REFERENCES `karyawan` (`KaryawanID`);

--
-- Constraints for table `detailpemesanan`
--
ALTER TABLE `detailpemesanan`
  ADD CONSTRAINT `detailpemesanan_ibfk_1` FOREIGN KEY (`PemesananID`) REFERENCES `pemesanan` (`PemesananID`),
  ADD CONSTRAINT `detailpemesanan_ibfk_2` FOREIGN KEY (`MenuID`) REFERENCES `menu` (`MenuID`),
  ADD CONSTRAINT `detailpemesanan_ibfk_3` FOREIGN KEY (`KaryawanID`) REFERENCES `karyawan` (`KaryawanID`);

--
-- Constraints for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD CONSTRAINT `pemesanan_ibfk_1` FOREIGN KEY (`PelangganID`) REFERENCES `pelanggan` (`PelangganID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
