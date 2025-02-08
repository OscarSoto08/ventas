-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 07, 2025 at 06:45 PM
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
-- Database: `db_ventas`
--

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `IdCliente` int(11) UNSIGNED NOT NULL,
  `Dni` varchar(8) DEFAULT NULL,
  `Nombres` varchar(244) DEFAULT NULL,
  `Direccion` varchar(244) DEFAULT NULL,
  `Estado` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `cliente`
--

INSERT INTO `cliente` (`IdCliente`, `Dni`, `Nombres`, `Direccion`, `Estado`) VALUES
(18, '1', 'Maria Rosas Villanuevaa', 'Los Laureles 2345', '1'),
(19, '3', 'Andres de Santa Cruz', 'Av. La Frontera 347', '1'),
(24, '2', 'Andres Casanare', 'Los Laureles 234', '1'),
(26, '5', 'Maria Pedraza', 'Los Laureles 234', '1'),
(27, '4', 'Juanito alima', 'california 23-2', '0');

-- --------------------------------------------------------

--
-- Table structure for table `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `IdDetalleVentas` int(11) UNSIGNED NOT NULL,
  `IdVentas` int(11) UNSIGNED NOT NULL,
  `IdProducto` int(11) UNSIGNED NOT NULL,
  `Cantidad` int(11) UNSIGNED DEFAULT NULL,
  `PrecioVenta` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`IdDetalleVentas`, `IdVentas`, `IdProducto`, `Cantidad`, `PrecioVenta`) VALUES
(1, 1, 3, 1, 800),
(2, 2, 12, 10, 685),
(3, 2, 12, 2, 685),
(4, 3, 3, 7, 800),
(5, 3, 4, 2, 500),
(6, 4, 2, 5, 200),
(7, 5, 3, 7, 800),
(8, 6, 9, 1, 200),
(9, 6, 9, 1, 200),
(10, 6, 9, 1, 200),
(11, 7, 2, 1, 200),
(12, 7, 2, 1, 200),
(13, 7, 2, 1, 200),
(14, 7, 2, 1, 200),
(15, 7, 2, 1, 200);

-- --------------------------------------------------------

--
-- Table structure for table `empleado`
--

CREATE TABLE `empleado` (
  `IdEmpleado` int(10) UNSIGNED NOT NULL,
  `Dni` varchar(8) NOT NULL,
  `Nombres` varchar(255) DEFAULT NULL,
  `correo` varchar(255) NOT NULL,
  `Telefono` varchar(9) DEFAULT NULL,
  `Estado` varchar(1) DEFAULT NULL,
  `User` varchar(45) DEFAULT NULL,
  `clave` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `empleado`
--

INSERT INTO `empleado` (`IdEmpleado`, `Dni`, `Nombres`, `correo`, `Telefono`, `Estado`, `User`, `clave`) VALUES
(1, '123', 'Oscar Gonzalez', 'og@sv.com', '988252459', '0', 'oscaralejo4', 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM='),
(2, '123', 'Roman Riquelme', 'jo46@v.com', '988252459', '1', 'Jo46', 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM='),
(3, '123', 'Palermo Suarez', 'jo47@v.com', '453536458', '1', 'Em21', 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM='),
(10, '123', 'Palermo Suarez', 'jo48@v.com', '453536458', '1', 'Em22', 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM='),
(12, '123', 'Palermo Suarez', 'jo49@v.com', '453536458', '1', 'Em23', 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM='),
(15, '123', 'Roman Riquelme', 'jo50@v.com', '988252459', '1', 'Em01', 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM=');

-- --------------------------------------------------------

--
-- Table structure for table `producto`
--

CREATE TABLE `producto` (
  `IdProducto` int(11) UNSIGNED NOT NULL,
  `Nombres` varchar(244) DEFAULT NULL,
  `Precio` double DEFAULT NULL,
  `Stock` int(11) UNSIGNED DEFAULT NULL,
  `Estado` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `producto`
--

INSERT INTO `producto` (`IdProducto`, `Nombres`, `Precio`, `Stock`, `Estado`) VALUES
(2, 'Mouse Logitech 568', 200, 60, '1'),
(3, 'Laptop Lenovo Ideapad 520', 800, 81, '1'),
(4, 'HeadPhones Sony M333', 500, 98, '1'),
(7, 'Producto Nuevo w', 200, 59, '1'),
(9, 'Teclado 2', 200, 92, '1'),
(12, 'Celular Xiaomi 14t', 605, 120, '1');

-- --------------------------------------------------------

--
-- Table structure for table `ventas`
--

CREATE TABLE `ventas` (
  `IdVentas` int(11) UNSIGNED NOT NULL,
  `IdCliente` int(11) UNSIGNED NOT NULL,
  `IdEmpleado` int(10) UNSIGNED NOT NULL,
  `NumeroSerie` varchar(244) DEFAULT NULL,
  `FechaVentas` date DEFAULT NULL,
  `Monto` double DEFAULT NULL,
  `Estado` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ventas`
--

INSERT INTO `ventas` (`IdVentas`, `IdCliente`, `IdEmpleado`, `NumeroSerie`, `FechaVentas`, `Monto`, `Estado`) VALUES
(1, 18, 1, '00000001', '2025-02-03', 800, '1'),
(2, 19, 1, '00000002', '2025-02-03', 8220, '1'),
(3, 19, 1, '00000003', '2025-02-03', 6600, '1'),
(4, 18, 1, '00000004', '2025-02-03', 1000, '1'),
(5, 26, 1, '00000005', '2025-02-05', 5600, '1'),
(6, 24, 1, '00000006', '2025-02-06', 600, '1'),
(7, 18, 1, '00000007', '2025-02-06', 1000, '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`IdCliente`);

--
-- Indexes for table `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`IdDetalleVentas`,`IdVentas`,`IdProducto`),
  ADD KEY `Ventas_has_Producto_FKIndex1` (`IdVentas`),
  ADD KEY `Ventas_has_Producto_FKIndex2` (`IdProducto`);

--
-- Indexes for table `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`IdEmpleado`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indexes for table `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`IdProducto`);

--
-- Indexes for table `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`IdVentas`),
  ADD KEY `Ventas_FKIndex1` (`IdEmpleado`),
  ADD KEY `Ventas_FKIndex2` (`IdCliente`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cliente`
--
ALTER TABLE `cliente`
  MODIFY `IdCliente` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `IdDetalleVentas` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `empleado`
--
ALTER TABLE `empleado`
  MODIFY `IdEmpleado` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `producto`
--
ALTER TABLE `producto`
  MODIFY `IdProducto` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `ventas`
--
ALTER TABLE `ventas`
  MODIFY `IdVentas` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD CONSTRAINT `detalle_ventas_ibfk_1` FOREIGN KEY (`IdVentas`) REFERENCES `ventas` (`IdVentas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `detalle_ventas_ibfk_2` FOREIGN KEY (`IdProducto`) REFERENCES `producto` (`IdProducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`IdEmpleado`) REFERENCES `empleado` (`IdEmpleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`IdCliente`) REFERENCES `cliente` (`IdCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
