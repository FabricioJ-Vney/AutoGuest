-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-02-2026 a las 21:04:38
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestion_taller`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `idUsuario` varchar(50) NOT NULL,
  `idTaller` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`idUsuario`, `idTaller`) VALUES
('ADM01', 'T01'),
('ADM02', 'T02'),
('UA4hmUO', 'T02WDr'),
('ADM03', 'T03'),
('ADM04', 'T04'),
('ADM05', 'T05'),
('ADM06', 'T06'),
('ADM07', 'T07'),
('ADM08', 'T08'),
('ADM09', 'T09'),
('ADM10', 'T10'),
('ADM11', 'T11'),
('ADM12', 'T12'),
('ADM13', 'T13'),
('ADM14', 'T14'),
('ADM15', 'T15'),
('ADM16', 'T16'),
('ADM17', 'T17'),
('ADM18', 'T18'),
('ADM19', 'T19'),
('ADM20', 'T20'),
('ADM21', 'T21'),
('ADM22', 'T22'),
('ADM23', 'T23'),
('ADM24', 'T24'),
('ADM25', 'T25'),
('ADM26', 'T26'),
('ADM27', 'T27'),
('ADM28', 'T28'),
('ADM29', 'T29'),
('UAFUg5i', 'T2XTqg'),
('ADM30', 'T30'),
('ADM31', 'T31'),
('ADM32', 'T32'),
('ADM33', 'T33'),
('ADM34', 'T34'),
('ADM35', 'T35'),
('ADM36', 'T36'),
('ADM37', 'T37'),
('ADM38', 'T38'),
('ADM39', 'T39'),
('ADM40', 'T40'),
('ADM41', 'T41'),
('ADM42', 'T42'),
('ADM43', 'T43'),
('ADM44', 'T44'),
('ADM45', 'T45'),
('ADM46', 'T46'),
('ADM47', 'T47'),
('ADM48', 'T48'),
('ADM49', 'T49'),
('ADM50', 'T50'),
('UA7joPp', 'T5ueot');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chat_mensaje`
--

CREATE TABLE `chat_mensaje` (
  `idMensaje` varchar(20) NOT NULL,
  `idCita` varchar(20) NOT NULL,
  `remitenteId` varchar(20) NOT NULL,
  `remitenteTipo` enum('cliente','mecanico') NOT NULL,
  `tipoContenido` enum('texto','imagen') NOT NULL DEFAULT 'texto',
  `contenido` longtext NOT NULL,
  `nombreArchivo` varchar(255) DEFAULT NULL,
  `leido` tinyint(1) NOT NULL DEFAULT 0,
  `fechaEnvio` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `chat_mensaje`
--

INSERT INTO `chat_mensaje` (`idMensaje`, `idCita`, `remitenteId`, `remitenteTipo`, `tipoContenido`, `contenido`, `nombreArchivo`, `leido`, `fechaEnvio`) VALUES
('MSG8LLWcxF', 'CITw63jy', 'MECUPEAuuv', 'mecanico', 'texto', 'holaaa buenos dias', NULL, 1, '2026-02-19 10:14:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `idCita` varchar(50) NOT NULL,
  `fechaHora` datetime NOT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `idCliente` varchar(50) NOT NULL,
  `idVehiculo` varchar(50) NOT NULL,
  `idMecanico` varchar(50) DEFAULT NULL,
  `idTaller` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`idCita`, `fechaHora`, `estado`, `idCliente`, `idVehiculo`, `idMecanico`, `idTaller`) VALUES
('C01', '2025-11-01 09:00:00', 'Cancelado', 'CLI01', 'V01', 'MEC01', 'T01'),
('C02', '2025-11-02 10:00:00', 'En Reparación', 'CLI02', 'V02', 'MEC02', 'T02'),
('C03', '2025-11-03 11:00:00', 'Finalizada', 'CLI03', 'V03', 'MEC03', 'T03'),
('C04', '2025-11-04 12:00:00', 'Pendiente de Cotización', 'CLI04', 'V04', 'MEC04', 'T04'),
('C05', '2025-11-05 13:00:00', 'En Reparación', 'CLI05', 'V05', 'MEC05', 'T05'),
('C06', '2025-11-06 09:00:00', 'Finalizada', 'CLI06', 'V06', 'MEC06', 'T06'),
('C07', '2025-11-07 10:00:00', 'Pendiente de Cotización', 'CLI07', 'V07', 'MEC07', 'T07'),
('C08', '2025-11-08 11:00:00', 'En Reparación', 'CLI08', 'V08', 'MEC08', 'T08'),
('C09', '2025-11-09 12:00:00', 'Finalizada', 'CLI09', 'V09', 'MEC09', 'T09'),
('C10', '2025-11-10 13:00:00', 'Pendiente de Cotización', 'CLI10', 'V10', 'MEC10', 'T10'),
('C11', '2025-11-11 09:00:00', 'En Reparación', 'CLI11', 'V11', 'MEC11', 'T11'),
('C12', '2025-11-12 10:00:00', 'Finalizada', 'CLI12', 'V12', 'MEC12', 'T12'),
('C13', '2025-11-13 11:00:00', 'Pendiente de Cotización', 'CLI13', 'V13', 'MEC13', 'T13'),
('C14', '2025-11-14 12:00:00', 'En Reparación', 'CLI14', 'V14', 'MEC14', 'T14'),
('C15', '2025-11-15 13:00:00', 'Finalizada', 'CLI15', 'V15', 'MEC15', 'T15'),
('C16', '2025-11-16 09:00:00', 'Pendiente de Cotización', 'CLI16', 'V16', 'MEC16', 'T16'),
('C17', '2025-11-17 10:00:00', 'En Reparación', 'CLI17', 'V17', 'MEC17', 'T17'),
('C18', '2025-11-18 11:00:00', 'Finalizada', 'CLI18', 'V18', 'MEC18', 'T18'),
('C19', '2025-11-19 12:00:00', 'Pendiente de Cotización', 'CLI19', 'V19', 'MEC19', 'T19'),
('C20', '2025-11-20 13:00:00', 'En Reparación', 'CLI20', 'V20', 'MEC20', 'T20'),
('C21', '2025-11-21 09:00:00', 'Finalizada', 'CLI21', 'V21', 'MEC21', 'T21'),
('C22', '2025-11-22 10:00:00', 'Pendiente de Cotización', 'CLI22', 'V22', 'MEC22', 'T22'),
('C23', '2025-11-23 11:00:00', 'En Reparación', 'CLI23', 'V23', 'MEC23', 'T23'),
('C24', '2025-11-24 12:00:00', 'Finalizada', 'CLI24', 'V24', 'MEC24', 'T24'),
('C25', '2025-11-25 13:00:00', 'Pendiente de Cotización', 'CLI25', 'V25', 'MEC25', 'T25'),
('C26', '2025-11-26 09:00:00', 'En Reparación', 'CLI26', 'V26', 'MEC26', 'T26'),
('C27', '2025-11-27 10:00:00', 'Finalizada', 'CLI27', 'V27', 'MEC27', 'T27'),
('C28', '2025-11-28 11:00:00', 'Pendiente de Cotización', 'CLI28', 'V28', 'MEC28', 'T28'),
('C29', '2025-11-29 12:00:00', 'En Reparación', 'CLI29', 'V29', 'MEC29', 'T29'),
('C30', '2025-11-30 13:00:00', 'Finalizada', 'CLI30', 'V30', 'MEC30', 'T30'),
('C31', '2025-12-01 09:00:00', 'Pendiente de Cotización', 'CLI31', 'V31', 'MEC31', 'T31'),
('C32', '2025-12-02 10:00:00', 'En Reparación', 'CLI32', 'V32', 'MEC32', 'T32'),
('C33', '2025-12-03 11:00:00', 'Finalizada', 'CLI33', 'V33', 'MEC33', 'T33'),
('C34', '2025-12-04 12:00:00', 'Pendiente de Cotización', 'CLI34', 'V34', 'MEC34', 'T34'),
('C35', '2025-12-05 13:00:00', 'En Reparación', 'CLI35', 'V35', 'MEC35', 'T35'),
('C36', '2025-12-06 09:00:00', 'Finalizada', 'CLI36', 'V36', 'MEC36', 'T36'),
('C37', '2025-12-07 10:00:00', 'Pendiente de Cotización', 'CLI37', 'V37', 'MEC37', 'T37'),
('C38', '2025-12-08 11:00:00', 'En Reparación', 'CLI38', 'V38', 'MEC38', 'T38'),
('C39', '2025-12-09 12:00:00', 'Finalizada', 'CLI39', 'V39', 'MEC39', 'T39'),
('C40', '2025-12-10 13:00:00', 'Pendiente de Cotización', 'CLI40', 'V40', 'MEC40', 'T40'),
('C41', '2025-12-11 09:00:00', 'En Reparación', 'CLI41', 'V41', 'MEC41', 'T41'),
('C42', '2025-12-12 10:00:00', 'Finalizada', 'CLI42', 'V42', 'MEC42', 'T42'),
('C43', '2025-12-13 11:00:00', 'Pendiente de Cotización', 'CLI43', 'V43', 'MEC43', 'T43'),
('C44', '2025-12-14 12:00:00', 'En Reparación', 'CLI44', 'V44', 'MEC44', 'T44'),
('C45', '2025-12-15 13:00:00', 'Finalizada', 'CLI45', 'V45', 'MEC45', 'T45'),
('C46', '2025-12-16 09:00:00', 'Pendiente de Cotización', 'CLI46', 'V46', 'MEC46', 'T46'),
('C47', '2025-12-17 10:00:00', 'En Reparación', 'CLI47', 'V47', 'MEC47', 'T47'),
('C48', '2025-12-18 11:00:00', 'Finalizada', 'CLI48', 'V48', 'MEC48', 'T48'),
('C49', '2025-12-19 12:00:00', 'Pendiente de Cotización', 'CLI49', 'V49', 'MEC49', 'T49'),
('C50', '2025-12-20 13:00:00', 'En Reparación', 'CLI50', 'V50', 'MEC50', 'T50'),
('CIT-PMsp', '2025-12-12 15:30:00', 'Pendiente', '9mHX58k3EO', 'VEHhTjDv2Je', NULL, NULL),
('CIT3KILD', '2026-02-04 16:48:49', 'Pendiente', 'CLI-N9hKyL', 'VEHo4tNMSw', 'MECUPEAuuv', NULL),
('CIT4eUnQ', '2025-12-06 08:59:00', 'Pendiente', '9mHX58k3EO', 'VEHhTjDv2Je', 'MEC02', 'T02'),
('CIT68lSG', '2026-02-11 09:06:00', 'Completado', 'CLI01', 'VEH66JvGMlU', 'MECUPEAuuv', 'T02WDr'),
('CIT7CByD', '2025-12-05 15:07:00', 'Pendiente', '9mHX58k3EO', 'VEHhTjDv2Je', 'MEC02', 'T02'),
('CIT7ZoMj', '2026-02-26 01:00:00', 'Completado', 'CLI01', 'VEHyjzYbLoK', 'MECUPEAuuv', 'T02WDr'),
('CITavsSM', '2026-01-16 16:23:00', 'Cancelado', 'CLI01', 'V01', 'MEC04', 'T04'),
('CITbPwgt', '2026-02-11 02:18:00', 'Completado', 'CLI01', 'VEH66JvGMlU', 'MECUPEAuuv', 'T02WDr'),
('CITC77TX', '2026-02-11 01:11:00', 'Completado', 'CLI01', 'VEH66JvGMlU', 'MECUPEAuuv', 'T02WDr'),
('CITDXk_r', '2026-02-10 22:26:00', 'Cancelado', 'CLI01', 'VEH94KKO_vd', 'MECUPEAuuv', 'T02WDr'),
('CITEjtB-', '2026-01-23 16:33:00', 'Cancelado', 'CLI01', 'VEH94KKO_vd', NULL, NULL),
('CITF4j8Q', '2026-01-27 17:54:42', 'Pendiente', 'CLIckWR49u', 'VEHnlMHcpHd', 'MECEvCdX0o', 'T2XTqg'),
('CIThvU3e', '2026-01-22 06:45:45', 'Pendiente', 'KhC2yRO3eh', 'VEHXnnk5SL', 'MEC01', 'T01'),
('CITIgaTP', '2026-01-22 06:38:08', 'Pendiente', 'CLIA3NSnOa', 'VEHWv-QEii', 'MEC04', 'T04'),
('CITLucyX', '2026-01-27 18:15:03', 'Pendiente', 'CLItVyvl91', 'VEHnlMHcpHd', 'MECsiUGKz5', 'T5ueot'),
('CITnAf-p', '2026-01-27 17:36:19', 'Pendiente', 'CLIA3NSnOa', 'VEHWv-QEii', 'MEC01', 'T01'),
('CITOJTl0', '2026-01-22 06:47:49', 'Pendiente', 'KhC2yRO3eh', 'VEHXnnk5SL', 'MEC01', 'T01'),
('CITooqvY', '2026-02-06 12:40:00', 'Cancelado', 'CLI01', 'V01', 'MECHF9KnfY', 'T02'),
('CITqjrww', '2026-02-10 22:22:00', 'Completado', 'CLI01', 'VEHyjzYbLoK', 'MECUPEAuuv', 'T02WDr'),
('CITsbWf5', '2026-01-17 14:33:00', 'Cancelado', 'CLI01', 'VEH94KKO_vd', NULL, NULL),
('CITw63jy', '2026-02-20 10:54:00', 'Pendiente', 'CLI01', 'VEHyjzYbLoK', 'MECUPEAuuv', 'T02WDr'),
('CITxdxUI', '2026-02-10 21:12:00', 'Completado', 'CLI01', 'VEHyjzYbLoK', 'MECUPEAuuv', 'T02WDr'),
('CITyXHAE', '2026-01-23 16:15:00', 'Cancelado', 'CLI01', 'VEH94KKO_vd', 'MEC04', 'T04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idUsuario` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idUsuario`) VALUES
('9mHX58k3EO'),
('CLI-N9hKyL'),
('CLI01'),
('CLI02'),
('CLI03'),
('CLI04'),
('CLI05'),
('CLI06'),
('CLI07'),
('CLI08'),
('CLI09'),
('CLI10'),
('CLI11'),
('CLI12'),
('CLI13'),
('CLI14'),
('CLI15'),
('CLI16'),
('CLI17'),
('CLI18'),
('CLI19'),
('CLI20'),
('CLI21'),
('CLI22'),
('CLI23'),
('CLI24'),
('CLI25'),
('CLI26'),
('CLI27'),
('CLI28'),
('CLI29'),
('CLI30'),
('CLI31'),
('CLI32'),
('CLI33'),
('CLI34'),
('CLI35'),
('CLI36'),
('CLI37'),
('CLI38'),
('CLI39'),
('CLI40'),
('CLI41'),
('CLI42'),
('CLI43'),
('CLI44'),
('CLI45'),
('CLI46'),
('CLI47'),
('CLI48'),
('CLI49'),
('CLI50'),
('CLIA3NSnOa'),
('CLIckWR49u'),
('CLItVyvl91'),
('KhC2yRO3eh'),
('UA4hmUO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `coches`
--

CREATE TABLE `coches` (
  `numero_serie` varchar(50) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `placa` varchar(20) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `coches`
--

INSERT INTO `coches` (`numero_serie`, `marca`, `modelo`, `placa`, `fecha_registro`) VALUES
('VIN01', 'Toyota', 'Corolla', 'PUE-001', '2025-12-02 12:03:58'),
('VIN02', 'Nissan', 'Versa', 'PUE-002', '2025-12-02 12:03:58'),
('VIN03', 'Honda', 'Civic', 'PUE-003', '2025-12-02 12:03:58'),
('VIN04', 'Ford', 'Fiesta', 'PUE-004', '2025-12-02 12:03:58'),
('VIN05', 'Chevrolet', 'Aveo', 'PUE-005', '2025-12-02 12:03:58'),
('VIN06', 'Mazda', '3', 'PUE-006', '2025-12-02 12:03:58'),
('VIN07', 'Volkswagen', 'Jetta', 'PUE-007', '2025-12-02 12:03:58'),
('VIN08', 'Hyundai', 'Elantra', 'PUE-008', '2025-12-02 12:03:58'),
('VIN09', 'Kia', 'Rio', 'PUE-009', '2025-12-02 12:03:58'),
('VIN10', 'BMW', 'Serie 3', 'PUE-010', '2025-12-02 12:03:58'),
('VIN11', 'Toyota', 'Yaris', 'PUE-011', '2025-12-02 12:03:58'),
('VIN12', 'Nissan', 'Sentra', 'PUE-012', '2025-12-02 12:03:58'),
('VIN13', 'Honda', 'Accord', 'PUE-013', '2025-12-02 12:03:58'),
('VIN14', 'Ford', 'Focus', 'PUE-014', '2025-12-02 12:03:58'),
('VIN15', 'Chevrolet', 'Spark', 'PUE-015', '2025-12-02 12:03:58'),
('VIN16', 'Mazda', 'CX-5', 'PUE-016', '2025-12-02 12:03:58'),
('VIN17', 'Volkswagen', 'Golf', 'PUE-017', '2025-12-02 12:03:58'),
('VIN18', 'Hyundai', 'Tucson', 'PUE-018', '2025-12-02 12:03:58'),
('VIN19', 'Kia', 'Forte', 'PUE-019', '2025-12-02 12:03:58'),
('VIN20', 'Audi', 'A4', 'PUE-020', '2025-12-02 12:03:58'),
('VIN21', 'Toyota', 'Prius', 'PUE-021', '2025-12-02 12:03:58'),
('VIN22', 'Nissan', 'March', 'PUE-022', '2025-12-02 12:03:58'),
('VIN23', 'Honda', 'CR-V', 'PUE-023', '2025-12-02 12:03:58'),
('VIN24', 'Ford', 'Mustang', 'PUE-024', '2025-12-02 12:03:58'),
('VIN25', 'Chevrolet', 'Camaro', 'PUE-025', '2025-12-02 12:03:58'),
('VIN26', 'Mazda', 'MX-5', 'PUE-026', '2025-12-02 12:03:58'),
('VIN27', 'Volkswagen', 'Polo', 'PUE-027', '2025-12-02 12:03:58'),
('VIN28', 'Hyundai', 'Creta', 'PUE-028', '2025-12-02 12:03:58'),
('VIN29', 'Kia', 'Soul', 'PUE-029', '2025-12-02 12:03:58'),
('VIN30', 'Mercedes', 'Clase C', 'PUE-030', '2025-12-02 12:03:58'),
('VIN31', 'Toyota', 'Hilux', 'PUE-031', '2025-12-02 12:03:58'),
('VIN32', 'Nissan', 'Frontier', 'PUE-032', '2025-12-02 12:03:58'),
('VIN33', 'Honda', 'HR-V', 'PUE-033', '2025-12-02 12:03:58'),
('VIN34', 'Ford', 'Ranger', 'PUE-034', '2025-12-02 12:03:58'),
('VIN35', 'Chevrolet', 'Colorado', 'PUE-035', '2025-12-02 12:03:58'),
('VIN36', 'Mazda', 'CX-3', 'PUE-036', '2025-12-02 12:03:58'),
('VIN37', 'Volkswagen', 'Vento', 'PUE-037', '2025-12-02 12:03:58'),
('VIN38', 'Hyundai', 'Sonata', 'PUE-038', '2025-12-02 12:03:58'),
('VIN39', 'Kia', 'Seltos', 'PUE-039', '2025-12-02 12:03:58'),
('VIN40', 'Jeep', 'Wrangler', 'PUE-040', '2025-12-02 12:03:58'),
('VIN41', 'Toyota', 'Rav4', 'PUE-041', '2025-12-02 12:03:58'),
('VIN42', 'Nissan', 'Kicks', 'PUE-042', '2025-12-02 12:03:58'),
('VIN43', 'Honda', 'Fit', 'PUE-043', '2025-12-02 12:03:58'),
('VIN44', 'Ford', 'Explorer', 'PUE-044', '2025-12-02 12:03:58'),
('VIN45', 'Chevrolet', 'Trax', 'PUE-045', '2025-12-02 12:03:58'),
('VIN46', 'Mazda', 'CX-9', 'PUE-046', '2025-12-02 12:03:58'),
('VIN47', 'Volkswagen', 'Virtus', 'PUE-047', '2025-12-02 12:03:58'),
('VIN48', 'Hyundai', 'Grand i10', 'PUE-048', '2025-12-02 12:03:58'),
('VIN49', 'Kia', 'Sportage', 'PUE-049', '2025-12-02 12:03:58'),
('VIN50', 'Tesla', 'Model 3', 'PUE-050', '2025-12-02 12:03:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion`
--

CREATE TABLE `cotizacion` (
  `idCotizacion` varchar(50) NOT NULL,
  `totalAprobado` float DEFAULT NULL,
  `estado_pago` varchar(50) NOT NULL DEFAULT 'PENDIENTE',
  `metodo_pago` varchar(50) DEFAULT NULL,
  `id_transaccion` varchar(100) DEFAULT NULL,
  `estadoAutorizacion` tinyint(1) DEFAULT NULL,
  `idCita` varchar(50) NOT NULL,
  `diagnostico` text DEFAULT NULL,
  `mano_obra` decimal(10,2) DEFAULT 0.00,
  `costo_refacciones` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cotizacion`
--

INSERT INTO `cotizacion` (`idCotizacion`, `totalAprobado`, `estado_pago`, `metodo_pago`, `id_transaccion`, `estadoAutorizacion`, `idCita`, `diagnostico`, `mano_obra`, `costo_refacciones`) VALUES
('COT0NMjlc', 3000, 'PENDIENTE', NULL, NULL, NULL, 'CITxdxUI', 'los demas componentes del auto estan en buen estado', 0.00, 0.00),
('COT9cOYg1', 3000, 'PENDIENTE', NULL, NULL, NULL, 'CITC77TX', 'Servicios predefinidos', 0.00, 0.00),
('COTP9KBqb', 3000, 'PENDIENTE', NULL, NULL, NULL, 'CIT68lSG', 'wenfibew', 0.00, 0.00),
('COTQb6CI1', 3000, 'PENDIENTE', NULL, NULL, NULL, 'CITqjrww', 'Servicios predefinidos', 0.00, 0.00),
('COTW1ISrI', 3000, 'PENDIENTE', NULL, NULL, NULL, 'CITDXk_r', 'Servicios predefinidos', 0.00, 0.00),
('CT01', 500, 'PENDIENTE', NULL, NULL, 0, 'C01', NULL, 0.00, 0.00),
('CT02', 1500, 'APROBADO', 'PAYPAL', 'TXN02', 1, 'C02', NULL, 0.00, 0.00),
('CT03', 250, 'APROBADO', 'EFECTIVO', 'TXN03', 1, 'C03', NULL, 0.00, 0.00),
('CT04', 800, 'PENDIENTE', NULL, NULL, 0, 'C04', NULL, 0.00, 0.00),
('CT05', 1200, 'APROBADO', 'PAYPAL', 'TXN05', 1, 'C05', NULL, 0.00, 0.00),
('CT06', 300, 'APROBADO', 'EFECTIVO', 'TXN06', 1, 'C06', NULL, 0.00, 0.00),
('CT07', 450, 'PENDIENTE', NULL, NULL, 0, 'C07', NULL, 0.00, 0.00),
('CT08', 2000, 'APROBADO', 'PAYPAL', 'TXN08', 1, 'C08', NULL, 0.00, 0.00),
('CT09', 150, 'APROBADO', 'EFECTIVO', 'TXN09', 1, 'C09', NULL, 0.00, 0.00),
('CT10', 600, 'PENDIENTE', NULL, NULL, 0, 'C10', NULL, 0.00, 0.00),
('CT11', 550, 'APROBADO', 'PAYPAL', 'TXN11', 1, 'C11', NULL, 0.00, 0.00),
('CT12', 1600, 'APROBADO', 'EFECTIVO', 'TXN12', 1, 'C12', NULL, 0.00, 0.00),
('CT13', 280, 'PENDIENTE', NULL, NULL, 0, 'C13', NULL, 0.00, 0.00),
('CT14', 900, 'APROBADO', 'PAYPAL', 'TXN14', 1, 'C14', NULL, 0.00, 0.00),
('CT15', 1300, 'APROBADO', 'EFECTIVO', 'TXN15', 1, 'C15', NULL, 0.00, 0.00),
('CT16', 350, 'PENDIENTE', NULL, NULL, 0, 'C16', NULL, 0.00, 0.00),
('CT17', 480, 'APROBADO', 'PAYPAL', 'TXN17', 1, 'C17', NULL, 0.00, 0.00),
('CT18', 2100, 'APROBADO', 'EFECTIVO', 'TXN18', 1, 'C18', NULL, 0.00, 0.00),
('CT19', 180, 'PENDIENTE', NULL, NULL, 0, 'C19', NULL, 0.00, 0.00),
('CT20', 650, 'APROBADO', 'PAYPAL', 'TXN20', 1, 'C20', NULL, 0.00, 0.00),
('CT21', 520, 'APROBADO', 'EFECTIVO', 'TXN21', 1, 'C21', NULL, 0.00, 0.00),
('CT22', 1550, 'PENDIENTE', NULL, NULL, 0, 'C22', NULL, 0.00, 0.00),
('CT23', 270, 'APROBADO', 'PAYPAL', 'TXN23', 1, 'C23', NULL, 0.00, 0.00),
('CT24', 850, 'APROBADO', 'EFECTIVO', 'TXN24', 1, 'C24', NULL, 0.00, 0.00),
('CT25', 1250, 'PENDIENTE', NULL, NULL, 0, 'C25', NULL, 0.00, 0.00),
('CT26', 320, 'APROBADO', 'PAYPAL', 'TXN26', 1, 'C26', NULL, 0.00, 0.00),
('CT27', 460, 'APROBADO', 'EFECTIVO', 'TXN27', 1, 'C27', NULL, 0.00, 0.00),
('CT28', 2050, 'PENDIENTE', NULL, NULL, 0, 'C28', NULL, 0.00, 0.00),
('CT29', 160, 'APROBADO', 'PAYPAL', 'TXN29', 1, 'C29', NULL, 0.00, 0.00),
('CT30', 620, 'APROBADO', 'EFECTIVO', 'TXN30', 1, 'C30', NULL, 0.00, 0.00),
('CT31', 530, 'PENDIENTE', NULL, NULL, 0, 'C31', NULL, 0.00, 0.00),
('CT32', 1580, 'APROBADO', 'PAYPAL', 'TXN32', 1, 'C32', NULL, 0.00, 0.00),
('CT33', 290, 'APROBADO', 'EFECTIVO', 'TXN33', 1, 'C33', NULL, 0.00, 0.00),
('CT34', 880, 'PENDIENTE', NULL, NULL, 0, 'C34', NULL, 0.00, 0.00),
('CT35', 1280, 'APROBADO', 'PAYPAL', 'TXN35', 1, 'C35', NULL, 0.00, 0.00),
('CT36', 340, 'APROBADO', 'EFECTIVO', 'TXN36', 1, 'C36', NULL, 0.00, 0.00),
('CT37', 490, 'PENDIENTE', NULL, NULL, 0, 'C37', NULL, 0.00, 0.00),
('CT38', 2150, 'APROBADO', 'PAYPAL', 'TXN38', 1, 'C38', NULL, 0.00, 0.00),
('CT39', 190, 'APROBADO', 'EFECTIVO', 'TXN39', 1, 'C39', NULL, 0.00, 0.00),
('CT40', 680, 'PENDIENTE', NULL, NULL, 0, 'C40', NULL, 0.00, 0.00),
('CT41', 540, 'APROBADO', 'PAYPAL', 'TXN41', 1, 'C41', NULL, 0.00, 0.00),
('CT42', 1620, 'APROBADO', 'EFECTIVO', 'TXN42', 1, 'C42', NULL, 0.00, 0.00),
('CT43', 310, 'PENDIENTE', NULL, NULL, 0, 'C43', NULL, 0.00, 0.00),
('CT44', 920, 'APROBADO', 'PAYPAL', 'TXN44', 1, 'C44', NULL, 0.00, 0.00),
('CT45', 1350, 'APROBADO', 'EFECTIVO', 'TXN45', 1, 'C45', NULL, 0.00, 0.00),
('CT46', 360, 'PENDIENTE', NULL, NULL, 0, 'C46', NULL, 0.00, 0.00),
('CT47', 510, 'APROBADO', 'PAYPAL', 'TXN47', 1, 'C47', NULL, 0.00, 0.00),
('CT48', 2200, 'APROBADO', 'EFECTIVO', 'TXN48', 1, 'C48', NULL, 0.00, 0.00),
('CT49', 210, 'PENDIENTE', NULL, NULL, 0, 'C49', NULL, 0.00, 0.00),
('CT50', 700, 'APROBADO', 'PAYPAL', 'TXN50', 1, 'C50', NULL, 0.00, 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion_servicios`
--

CREATE TABLE `cotizacion_servicios` (
  `idCotizacion` varchar(50) NOT NULL,
  `idServicio` varchar(50) NOT NULL,
  `precio` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cotizacion_servicios`
--

INSERT INTO `cotizacion_servicios` (`idCotizacion`, `idServicio`, `precio`) VALUES
('COT0NMjlc', 'SERV-IxJjMo', 3000),
('COT9cOYg1', 'SERV-IxJjMo', 3000),
('COTP9KBqb', 'SERV-IxJjMo', 3000),
('COTQb6CI1', 'SERV-IxJjMo', 3000),
('COTW1ISrI', 'SERV-IxJjMo', 3000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evidencia`
--

CREATE TABLE `evidencia` (
  `idEvidencia` int(11) NOT NULL,
  `urlArchivo` varchar(255) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `idCotizacion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evidencia`
--

INSERT INTO `evidencia` (`idEvidencia`, `urlArchivo`, `tipo`, `descripcion`, `idCotizacion`) VALUES
(1, 'img/evidencia1.jpg', 'Foto', 'Fuga de aceite', 'CT01'),
(2, 'img/evidencia2.jpg', 'Foto', 'Filtro sucio', 'CT02'),
(3, 'img/evidencia3.jpg', 'Foto', 'Bujía quemada', 'CT03'),
(4, 'img/evidencia4.jpg', 'Foto', 'Balata delgada', 'CT04'),
(5, 'img/evidencia5.jpg', 'Foto', 'Amortiguador roto', 'CT05'),
(6, 'img/evidencia6.jpg', 'Foto', 'Nivel bajo', 'CT06'),
(7, 'img/evidencia7.jpg', 'Foto', 'Liquido oscuro', 'CT07'),
(8, 'img/evidencia8.jpg', 'Foto', 'Batería inflada', 'CT08'),
(9, 'img/evidencia9.jpg', 'Foto', 'Goma rota', 'CT09'),
(10, 'img/evidencia10.jpg', 'Foto', 'Foco fundido', 'CT10'),
(11, 'img/evidencia11.jpg', 'Foto', 'Aceite negro', 'CT11'),
(12, 'img/evidencia12.jpg', 'Foto', 'Filtro tapado', 'CT12'),
(13, 'img/evidencia13.jpg', 'Foto', 'Cable roto', 'CT13'),
(14, 'img/evidencia14.jpg', 'Foto', 'Balata cristalizada', 'CT14'),
(15, 'img/evidencia15.jpg', 'Foto', 'Resorte vencido', 'CT15'),
(16, 'img/evidencia16.jpg', 'Foto', 'Deposito sucio', 'CT16'),
(17, 'img/evidencia17.jpg', 'Foto', 'Manguera rota', 'CT17'),
(18, 'img/evidencia18.jpg', 'Foto', 'Alternador fallando', 'CT18'),
(19, 'img/evidencia19.jpg', 'Foto', 'Pintura dañada', 'CT19'),
(20, 'img/evidencia20.jpg', 'Foto', 'Fusible quemado', 'CT20'),
(21, 'img/evidencia21.jpg', 'Foto', 'Aceite bajo', 'CT21'),
(22, 'img/evidencia22.jpg', 'Foto', 'Filtro roto', 'CT22'),
(23, 'img/evidencia23.jpg', 'Foto', 'Bobina estrellada', 'CT23'),
(24, 'img/evidencia24.jpg', 'Foto', 'Disco rayado', 'CT24'),
(25, 'img/evidencia25.jpg', 'Foto', 'Base rota', 'CT25'),
(26, 'img/evidencia26.jpg', 'Foto', 'Nivel agua', 'CT26'),
(27, 'img/evidencia27.jpg', 'Foto', 'Falta grasa', 'CT27'),
(28, 'img/evidencia28.jpg', 'Foto', 'Marcha pegada', 'CT28'),
(29, 'img/evidencia29.jpg', 'Foto', 'Interior sucio', 'CT29'),
(30, 'img/evidencia30.jpg', 'Foto', 'Cable suelto', 'CT30'),
(31, 'img/evidencia31.jpg', 'Foto', 'Aceite quemado', 'CT31'),
(32, 'img/evidencia32.jpg', 'Foto', 'Filtro polvo', 'CT32'),
(33, 'img/evidencia33.jpg', 'Foto', 'Sensor sucio', 'CT33'),
(34, 'img/evidencia34.jpg', 'Foto', 'Tambor ovalado', 'CT34'),
(35, 'img/evidencia35.jpg', 'Foto', 'Buje roto', 'CT35'),
(36, 'img/evidencia36.jpg', 'Foto', 'Tanque sucio', 'CT36'),
(37, 'img/evidencia37.jpg', 'Foto', 'Empaque roto', 'CT37'),
(38, 'img/evidencia38.jpg', 'Foto', 'Radiador picado', 'CT38'),
(39, 'img/evidencia39.jpg', 'Foto', 'Espejo roto', 'CT39'),
(40, 'img/evidencia40.jpg', 'Foto', 'Alfombra rota', 'CT40'),
(41, 'img/evidencia41.jpg', 'Foto', 'Aceite rojo', 'CT41'),
(42, 'img/evidencia42.jpg', 'Foto', 'Banda agrietada', 'CT42'),
(43, 'img/evidencia43.jpg', 'Foto', 'Bomba tirando', 'CT43'),
(44, 'img/evidencia44.jpg', 'Foto', 'Cilindro pegado', 'CT44'),
(45, 'img/evidencia45.jpg', 'Foto', 'Rotula juego', 'CT45'),
(46, 'img/evidencia46.jpg', 'Foto', 'Deposito vacio', 'CT46'),
(47, 'img/evidencia47.jpg', 'Foto', 'Motor sucio', 'CT47'),
(48, 'img/evidencia48.jpg', 'Foto', 'Aspa rota', 'CT48'),
(49, 'img/evidencia49.jpg', 'Foto', 'Volante gastado', 'CT49'),
(50, 'img/evidencia50.jpg', 'Foto', 'Llave rota', 'CT50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `iteminventario`
--

CREATE TABLE `iteminventario` (
  `idItem` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio` float DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `esParaVenta` tinyint(1) DEFAULT NULL,
  `esParaServicio` tinyint(1) DEFAULT NULL,
  `idTaller` varchar(50) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `iteminventario`
--

INSERT INTO `iteminventario` (`idItem`, `nombre`, `precio`, `stock`, `esParaVenta`, `esParaServicio`, `idTaller`, `imagen`) VALUES
('IT01', 'Aceite 5W30', 150, 13, 1, 1, 'T01', 'img/aceitemotod2T.jpg'),
('IT02', 'Filtro Aire', 80, 14, 1, 1, 'T02', NULL),
('IT03', 'Bujía Iridium', 120, 15, 1, 1, 'T03', NULL),
('IT04', 'Balatas Delanteras', 450, 15, 1, 1, 'T04', NULL),
('IT05', 'Amortiguador', 800, 15, 1, 1, 'T05', NULL),
('IT06', 'Anticongelante', 90, 15, 1, 1, 'T06', 'img/anticongelante-amarillo.jpg'),
('IT07', 'Líquido Frenos', 70, 15, 1, 1, 'T07', NULL),
('IT08', 'Batería 12V', 1500, 15, 1, 1, 'T08', NULL),
('IT09', 'Limpiaparabrisas', 150, 15, 1, 0, 'T09', 'img/limpia-parabrisas.jpg'),
('IT10', 'Foco H4', 50, 15, 1, 0, 'T10', NULL),
('IT11', 'Aceite 10W40', 140, 15, 1, 1, 'T11', 'img/aceitemotod2T.jpg'),
('IT12', 'Filtro Aceite', 60, 15, 1, 1, 'T12', 'img/aceitemotod2T.jpg'),
('IT13', 'Cable Bujía', 200, 15, 1, 1, 'T13', NULL),
('IT14', 'Balatas Traseras', 400, 15, 1, 1, 'T14', NULL),
('IT15', 'Resorte', 300, 15, 1, 1, 'T15', NULL),
('IT16', 'Refrigerante', 85, 15, 1, 1, 'T16', NULL),
('IT17', 'Líquido Dirección', 75, 15, 1, 1, 'T17', NULL),
('IT18', 'Alternador', 2000, 15, 1, 1, 'T18', NULL),
('IT19', 'Cera Líquida', 120, 15, 1, 0, 'T19', 'img/cera-liquida.jpg'),
('IT20', 'Fusible 10A', 10, 15, 1, 0, 'T20', NULL),
('IT21', 'Aceite 20W50', 130, 15, 1, 1, 'T21', 'img/aceitemotod2T.jpg'),
('IT22', 'Filtro Gasolina', 90, 15, 1, 1, 'T22', NULL),
('IT23', 'Bobina', 350, 15, 1, 1, 'T23', NULL),
('IT24', 'Disco Freno', 600, 15, 1, 1, 'T24', NULL),
('IT25', 'Base Amortiguador', 250, 15, 1, 1, 'T25', NULL),
('IT26', 'Agua Batería', 20, 15, 1, 1, 'T26', NULL),
('IT27', 'Grasa Chasis', 50, 15, 1, 1, 'T27', NULL),
('IT28', 'Marcha', 1800, 15, 1, 1, 'T28', NULL),
('IT29', 'Aromatizante', 30, 15, 1, 0, 'T29', NULL),
('IT30', 'Cinta Aislar', 15, 15, 1, 0, 'T30', NULL),
('IT31', 'Aceite Sintético', 250, 15, 1, 1, 'T31', 'img/aceitemotod2T.jpg'),
('IT32', 'Filtro Cabina', 110, 15, 1, 1, 'T32', NULL),
('IT33', 'Sensor O2', 800, 15, 1, 1, 'T33', NULL),
('IT34', 'Tambor Freno', 500, 15, 1, 1, 'T34', NULL),
('IT35', 'Buje', 80, 15, 1, 1, 'T35', NULL),
('IT36', 'Aditivo Gas', 60, 15, 1, 1, 'T36', NULL),
('IT37', 'Silicón Automotriz', 40, 15, 1, 1, 'T37', NULL),
('IT38', 'Radiador', 1200, 15, 1, 1, 'T38', NULL),
('IT39', 'Espejo Lateral', 400, 15, 1, 0, 'T39', NULL),
('IT40', 'Tapete', 200, 15, 1, 0, 'T40', NULL),
('IT41', 'Aceite Transmisión', 180, 15, 1, 1, 'T41', 'img/aceitemotod2T.jpg'),
('IT42', 'Banda Tiempo', 300, 15, 1, 1, 'T42', NULL),
('IT43', 'Bomba Agua', 450, 15, 1, 1, 'T43', NULL),
('IT44', 'Cilindro Freno', 150, 15, 1, 1, 'T44', NULL),
('IT45', 'Rotula', 220, 15, 1, 1, 'T45', NULL),
('IT46', 'Anticongelante Rosa', 95, 15, 1, 1, 'T46', 'img/anticongelante-amarillo.jpg'),
('IT47', 'Desengrasante', 55, 15, 1, 1, 'T47', NULL),
('IT48', 'Ventilador', 600, 15, 1, 1, 'T48', NULL),
('IT49', 'Funda Volante', 100, 15, 1, 0, 'T49', NULL),
('IT50', 'Llavero', 25, 15, 1, 0, 'T50', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item_inventario`
--

CREATE TABLE `item_inventario` (
  `id` int(11) NOT NULL,
  `id_producto` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 100,
  `imagen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `item_inventario`
--

INSERT INTO `item_inventario` (`id`, `id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`) VALUES
(1, 'anticongelante-concentrado', 'Anticongelante Concentrado (Verde)', 'Galón (3.78 L). Evita la corrosión y oxidación. Para todas las marcas.', 48.00, 100, 'img/anticongelante-concentrado.jpg'),
(2, 'agua-bateria', 'Agua para Batería', '500 ml.', 13.00, 100, 'img/agua-bateria.jpg'),
(3, 'limpia-parabrisas', 'Limpiaparabrisas', 'Galón. Elimina grasa, diésel, insectos y más.', 38.00, 100, 'img/limpia-parabrisas.jpg'),
(4, 'anticongelante-rosado-org', 'Anticongelante Rosado', 'Galón (3.78 L). Para modelos recientes.', 48.00, 100, 'img/anticongelante-rosado.jpg'),
(5, 'anticongelante-economico', 'Anticongelante Económico', '5 litros. Listo para usar.', 28.00, 100, 'img/anticongelante-verde.jpg'),
(6, 'anticongelante-amarillo-org', 'Anticongelante Listo (Amarillo)', 'Galón (3.78 L).', 38.00, 100, 'img/anticongelante-amarillo.jpg'),
(7, 'cera-liquida', 'Cera Líquida', '1/4 de litro (250 ml).', 55.00, 100, 'img/cera-liquida.jpg'),
(8, 'armorall-vinil-piel', 'Armorall Vinil y Piel', 'Medio litro (500 ml).', 20.00, 100, 'img/almorol.jpg'),
(9, 'abrillantador-llantas', 'Abrillantador de Llantas', 'Medio litro (500 ml).', 20.00, 100, 'img/abillantador-llantas.jpg'),
(10, 'shampoo-espuma', 'Shampoo Espuma Activa', 'Medio litro (500 ml).', 16.00, 100, 'img/shampu-espumaactiva.jpg'),
(11, 'bardahl-antifreeze-premium', 'Anticongelante Premium Bardahl', 'Formulación avanzada. Para una protección superior contra el sobrecalentamiento.', 145.00, 100, 'img/AMG7.jpg'),
(12, 'bardahl-refrigerante-rojo', 'Refrigerante Bardahl (Rojo)', 'Galón. Listo para usar. Ideal para vehículos modernos.', 130.00, 100, 'img/AMG9.jpg'),
(13, 'aditivo-rx80-rymax', 'Aditivo para Combustible RX-80', 'Limpiador de inyectores y sistema de combustible.', 85.00, 100, 'img/AMG15.jpg'),
(14, 'anticongelante-eti-amarillo', 'Anticongelante Listo (ETI Amarillo)', 'Protección contra corrosión y herrumbre.', 35.00, 100, 'img/AMG13.jpg'),
(15, 'refrigerante-concentrado-rojo', 'Refrigerante Concentrado (Rojo)', 'Para diluir. Alto rendimiento y durabilidad.', 52.00, 100, 'img/AMG4.jpg'),
(16, 'bardahl-super-oil-10w30', 'Aceite Bardahl Super Oil 10W-30', 'Aceite multigrado para motor. Medio litro.', 65.00, 100, 'img/AMG23.jpg'),
(17, 'bardahl-super-oil-20w50', 'Aceite Bardahl Super Oil 20W-50', 'Aceite multigrado de alto rendimiento. Medio litro.', 65.00, 100, 'img/AMG2.jpg'),
(18, 'aceite-motor-amarillo', 'Aceite para Motor (Amarillo)', 'Lubricación y protección en condiciones extremas. Medio litro.', 45.00, 100, 'img/AMG34.jpg'),
(19, 'bardahl-aceite-engranajes', 'Aceite para Engranajes (Bardahl)', 'Protección de caja y transmisión. Cuarto de litro.', 58.00, 100, 'img/AMG14.jpg'),
(20, 'bardahl-moto-4t-20w50', 'Aceite para Moto 4T 20W-50 Bardahl', 'Especialmente diseñado para motocicletas de 4 tiempos. Medio litro.', 75.00, 100, 'img/AMG8.jpg'),
(21, 'bardahl-moto-4t-10w30', 'Aceite para Moto 4T 10W-30 Bardahl', 'Para motores de motocicletas modernos que requieren baja viscosidad.', 80.00, 100, 'img/AMG3.jpg'),
(22, 'motorcraft-20w50', 'Aceite Motorcraft 20W-50', 'Aceite multigrado. Recomendado para vehículos Ford y otros.', 115.00, 100, 'img/AMG27.jpg'),
(23, 'anticongelante-naranja', 'Anticongelante Listo (Naranja)', 'Galón. Formulación orgánica de larga duración. Para todas las marcas.', 42.00, 100, 'img/AMG31.jpg'),
(24, 'bardahl-high-performance-25w60', 'Bardahl High Performance SAE 25W-60', 'Aceite multigrado para motores de alto kilometraje.', 125.00, 100, 'img/AMG6.jpg'),
(25, 'aceite-sintetico-5w30', 'Aceite Sintético 5W-30', 'Protección superior y mejor economía de combustible. Medio litro.', 140.00, 100, 'img/AMG30.jpg'),
(26, 'aditivo-limpiador-inyectores', 'Aditivo Limpiador de Inyectores', 'Limpia y protege el sistema de inyección de combustible.', 75.00, 100, 'img/AMG20.jpg'),
(27, 'aditivo-octane-booster', 'Aditivo Octane Booster', 'Mejora el octanaje y el rendimiento del motor. Para gasolina.', 85.00, 100, 'img/AMG19.jpg'),
(28, 'limpiador-frenos-aerosol', 'Limpiador de Frenos en Aerosol', 'Fórmula de secado rápido. Remueve grasa, aceite y líquido de frenos.', 95.00, 100, 'img/AMG312.jpg'),
(29, 'aditivo-diesel', 'Aditivo para Diesel', 'Mejora el rendimiento, lubrica y limpia inyectores en motores diésel.', 88.00, 100, 'img/AMG22.jpg'),
(30, 'aceite-multigrado-eti-15w40', 'Aceite Multigrado 15W-40 (ETI)', 'Galón. Para servicio pesado. Excelente protección contra el desgaste.', 380.00, 100, 'img/AMG29.jpg'),
(31, 'anticongelante-concentrado-rojo', 'Anticongelante Concentrado (Rojo)', 'Botella. Máxima protección contra el punto de ebullición y congelación.', 45.00, 100, 'img/AMG11.jpg'),
(32, 'aditivo-aceite-motor', 'Aditivo para Aceite de Motor', 'Refuerza la protección del aceite, reduce la fricción y el desgaste.', 95.00, 100, 'img/AMG5.jpg'),
(33, 'piston-aceite-15w40', 'Pist-On Aceite Multigrado 15W-40', 'Aceite de motor de calidad premium. Ideal para camiones y flotillas.', 90.00, 100, 'img/AMG1.jpg'),
(34, 'piston-aceite-20w50', 'Pist-On Aceite Multigrado 20W-50', 'Aceite de alta viscosidad para proteger motores en altas temperaturas.', 85.00, 100, 'img/AMG17.jpg'),
(35, 'refrigerante-rosado-concentrado', 'Refrigerante Concentrado (Rosado)', 'Ideal para vehículos que requieren tecnología de ácido orgánico (OAT).', 55.00, 100, 'img/AMG33.jpg'),
(36, 'anticongelante-listo-amarillo-final', 'Anticongelante Listo (Amarillo)', 'Formulación anticongelante y anticorrosiva de alto desempeño.', 38.00, 100, 'img/AMG12.jpg'),
(37, 'anticongelante-listo-rosado-final', 'Anticongelante Listo (Rosado)', 'Tecnología de última generación. Protege de -18°C a 126°C.', 42.00, 100, 'img/AMG26.jpg'),
(38, 'lth-100mil-25w50', 'LTH 100 000 Plus Aceite 25W-50', 'Aceite multigrado para motores con más de 100,000 km. Con fórmula sellante. 946 ml.', 110.00, 100, 'img/AMG16.jpg'),
(39, 'lth-tm-sae140', 'LTH Fluido Transmisión Manual SAE 140', 'Para transmisiones manuales y diferenciales API GL-1. 946 ml.', 95.00, 100, 'img/AMG24.jpg'),
(40, 'lth-tm-sae250', 'LTH Fluido Transmisión Manual SAE 250', 'Para transmisiones manuales y diferenciales API GL-1. Mayor viscosidad. 946 ml.', 105.00, 100, 'img/AMG25.jpg'),
(41, 'lth-tm-80w90', 'LTH Aceite Transmisión Manual 80W-90', 'Para transmisiones y diferenciales API GL-5. 946 ml.', 120.00, 100, 'img/AMG32.jpg'),
(42, 'rm-aceite-moto-2t', 'RM Lubricantes Aceite Motores 2T', 'Para motocicletas y motores pequeños de dos tiempos. 700 ml.', 68.00, 100, 'img/aceitemotod2T.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lineacotizacion`
--

CREATE TABLE `lineacotizacion` (
  `idLineaCotizacion` int(11) NOT NULL,
  `idCotizacion` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `costo` float DEFAULT NULL,
  `idItemInventario` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `lineacotizacion`
--

INSERT INTO `lineacotizacion` (`idLineaCotizacion`, `idCotizacion`, `descripcion`, `costo`, `idItemInventario`) VALUES
(51, 'CT01', 'Cambio de Aceite', 150, 'IT01'),
(52, 'CT02', 'Cambio Filtro Aire', 80, 'IT02'),
(53, 'CT03', 'Cambio Bujias', 120, 'IT03'),
(54, 'CT04', 'Cambio Balatas', 450, 'IT04'),
(55, 'CT05', 'Cambio Amortiguadores', 800, 'IT05'),
(56, 'CT06', 'Relleno Anticongelante', 90, 'IT06'),
(57, 'CT07', 'Liquido Frenos', 70, 'IT07'),
(58, 'CT08', 'Cambio Bateria', 1500, 'IT08'),
(59, 'CT09', 'Cambio Limpiaparabrisas', 150, 'IT09'),
(60, 'CT10', 'Cambio Foco', 50, 'IT10'),
(61, 'CT11', 'Mano de Obra', 200, NULL),
(62, 'CT12', 'Mano de Obra', 300, NULL),
(63, 'CT13', 'Diagnostico', 100, NULL),
(64, 'CT14', 'Mano de Obra', 250, NULL),
(65, 'CT15', 'Mano de Obra', 400, NULL),
(66, 'CT16', 'Revision General', 150, NULL),
(67, 'CT17', 'Mano de Obra', 220, NULL),
(68, 'CT18', 'Mano de Obra', 500, NULL),
(69, 'CT19', 'Ajuste', 50, NULL),
(70, 'CT20', 'Mano de Obra', 180, NULL),
(71, 'CT21', 'Cambio Aceite', 130, 'IT21'),
(72, 'CT22', 'Filtro Gasolina', 90, 'IT22'),
(73, 'CT23', 'Cambio Bobina', 350, 'IT23'),
(74, 'CT24', 'Rectificado Disco', 600, 'IT24'),
(75, 'CT25', 'Base Amortiguador', 250, 'IT25'),
(76, 'CT26', 'Agua Bateria', 20, 'IT26'),
(77, 'CT27', 'Engrasado', 50, 'IT27'),
(78, 'CT28', 'Marcha', 1800, 'IT28'),
(79, 'CT29', 'Aromatizante', 30, 'IT29'),
(80, 'CT30', 'Electrico', 15, 'IT30'),
(81, 'CT31', 'Sintetico', 250, 'IT31'),
(82, 'CT32', 'Filtro Cabina', 110, 'IT32'),
(83, 'CT33', 'Sensor O2', 800, 'IT33'),
(84, 'CT34', 'Tambor', 500, 'IT34'),
(85, 'CT35', 'Bujes', 80, 'IT35'),
(86, 'CT36', 'Aditivo', 60, 'IT36'),
(87, 'CT37', 'Silicon', 40, 'IT37'),
(88, 'CT38', 'Radiador', 1200, 'IT38'),
(89, 'CT39', 'Espejo', 400, 'IT39'),
(90, 'CT40', 'Tapete', 200, 'IT40'),
(91, 'CT41', 'Aceite Trans', 180, 'IT41'),
(92, 'CT42', 'Banda Tiempo', 300, 'IT42'),
(93, 'CT43', 'Bomba Agua', 450, 'IT43'),
(94, 'CT44', 'Cilindro Freno', 150, 'IT44'),
(95, 'CT45', 'Rotula', 220, 'IT45'),
(96, 'CT46', 'Anticongelante', 95, 'IT46'),
(97, 'CT47', 'Limpieza', 55, 'IT47'),
(98, 'CT48', 'Ventilador', 600, 'IT48'),
(99, 'CT49', 'Accesorio', 100, 'IT49'),
(100, 'CT50', 'Llavero', 25, 'IT50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lineapedido`
--

CREATE TABLE `lineapedido` (
  `idLineaPedido` int(11) NOT NULL,
  `idPedido` varchar(50) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `idItemInventario` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `lineapedido`
--

INSERT INTO `lineapedido` (`idLineaPedido`, `idPedido`, `cantidad`, `idItemInventario`) VALUES
(1, 'PED01', 1, 'IT01'),
(2, 'PED02', 1, 'IT02'),
(3, 'PED03', 1, 'IT03'),
(4, 'PED04', 1, 'IT04'),
(5, 'PED05', 1, 'IT05'),
(6, 'PED06', 1, 'IT06'),
(7, 'PED07', 1, 'IT07'),
(8, 'PED08', 1, 'IT08'),
(9, 'PED09', 1, 'IT09'),
(10, 'PED10', 1, 'IT10'),
(11, 'PED11', 1, 'IT11'),
(12, 'PED12', 1, 'IT12'),
(13, 'PED13', 1, 'IT13'),
(14, 'PED14', 1, 'IT14'),
(15, 'PED15', 1, 'IT15'),
(16, 'PED16', 1, 'IT16'),
(17, 'PED17', 1, 'IT17'),
(18, 'PED18', 1, 'IT18'),
(19, 'PED19', 1, 'IT19'),
(20, 'PED20', 1, 'IT20'),
(21, 'PED21', 1, 'IT21'),
(22, 'PED22', 1, 'IT22'),
(23, 'PED23', 1, 'IT23'),
(24, 'PED24', 1, 'IT24'),
(25, 'PED25', 1, 'IT25'),
(26, 'PED26', 1, 'IT26'),
(27, 'PED27', 1, 'IT27'),
(28, 'PED28', 1, 'IT28'),
(29, 'PED29', 1, 'IT29'),
(30, 'PED30', 1, 'IT30'),
(31, 'PED31', 1, 'IT31'),
(32, 'PED32', 1, 'IT32'),
(33, 'PED33', 1, 'IT33'),
(34, 'PED34', 1, 'IT34'),
(35, 'PED35', 1, 'IT35'),
(36, 'PED36', 1, 'IT36'),
(37, 'PED37', 1, 'IT37'),
(38, 'PED38', 1, 'IT38'),
(39, 'PED39', 1, 'IT39'),
(40, 'PED40', 1, 'IT40'),
(41, 'PED41', 1, 'IT41'),
(42, 'PED42', 1, 'IT42'),
(43, 'PED43', 1, 'IT43'),
(44, 'PED44', 1, 'IT44'),
(45, 'PED45', 1, 'IT45'),
(46, 'PED46', 1, 'IT46'),
(47, 'PED47', 1, 'IT47'),
(48, 'PED48', 1, 'IT48'),
(49, 'PED49', 1, 'IT49'),
(50, 'PED50', 1, 'IT50'),
(56, 'PEDJ12wR', 1, 'IT01'),
(57, 'PEDzwlwi', 1, 'IT21'),
(58, 'PEDzwlwi', 1, 'IT23'),
(59, 'PEDzwlwi', 1, 'IT22'),
(60, 'PEDzwlwi', 1, 'IT09'),
(61, 'PEDSkwFJ', 1, 'IT01'),
(62, 'PED41RAS', 1, 'IT02'),
(63, 'PED41RAS', 2, 'IT01'),
(64, 'PEDMQzVG', 1, 'IT01'),
(65, 'PEDMQzVG', 1, 'IT02'),
(66, 'PEDr95WH', 1, 'IT01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mecanico`
--

CREATE TABLE `mecanico` (
  `idUsuario` varchar(50) NOT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `idTaller` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mecanico`
--

INSERT INTO `mecanico` (`idUsuario`, `especialidad`, `idTaller`) VALUES
('MEC01', 'Motor', 'T01'),
('MEC02', 'Suspensión', 'T02'),
('MEC03', 'Motor', 'T03'),
('MEC04', 'Motor', 'T04'),
('MEC05', 'Frenos', 'T05'),
('MEC06', 'Motor', 'T06'),
('MEC07', 'Eléctrico', 'T07'),
('MEC08', 'General', 'T08'),
('MEC09', 'Eléctrico', 'T09'),
('MEC10', 'Suspensión', 'T10'),
('MEC11', 'General', 'T11'),
('MEC12', 'General', 'T12'),
('MEC13', 'Frenos', 'T13'),
('MEC14', 'Suspensión', 'T14'),
('MEC15', 'Frenos', 'T15'),
('MEC16', 'Frenos', 'T16'),
('MEC17', 'Suspensión', 'T17'),
('MEC18', 'Motor', 'T18'),
('MEC19', 'Frenos', 'T19'),
('MEC20', 'Suspensión', 'T20'),
('MEC21', 'Frenos', 'T21'),
('MEC22', 'Suspensión', 'T22'),
('MEC23', 'General', 'T23'),
('MEC24', 'Frenos', 'T24'),
('MEC25', 'Suspensión', 'T25'),
('MEC26', 'Suspensión', 'T26'),
('MEC27', 'Suspensión', 'T27'),
('MEC28', 'General', 'T28'),
('MEC29', 'Frenos', 'T29'),
('MEC30', 'Eléctrico', 'T30'),
('MEC31', 'Eléctrico', 'T31'),
('MEC32', 'Frenos', 'T32'),
('MEC33', 'Frenos', 'T33'),
('MEC34', 'Motor', 'T34'),
('MEC35', 'Motor', 'T35'),
('MEC36', 'General', 'T36'),
('MEC37', 'Motor', 'T37'),
('MEC38', 'Suspensión', 'T38'),
('MEC39', 'Frenos', 'T39'),
('MEC40', 'Suspensión', 'T40'),
('MEC41', 'Eléctrico', 'T41'),
('MEC42', 'Frenos', 'T42'),
('MEC43', 'Motor', 'T43'),
('MEC44', 'Motor', 'T44'),
('MEC45', 'Eléctrico', 'T45'),
('MEC46', 'Suspensión', 'T46'),
('MEC47', 'Eléctrico', 'T47'),
('MEC48', 'General', 'T48'),
('MEC49', 'Suspensión', 'T49'),
('MEC50', 'Eléctrico', 'T50'),
('MECEvCdX0o', 'General', 'T2XTqg'),
('MECFo5uPjo', 'Electrico', 'T02'),
('MECfzCjvV_', 'Suspension', 'T02'),
('MECHF9KnfY', 'General', 'T02'),
('MECsiUGKz5', 'General', 'T5ueot'),
('MECUPEAuuv', 'General', 'T02WDr');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `idPedido` varchar(50) NOT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `total_pedido` float DEFAULT NULL,
  `estado_pago` varchar(50) NOT NULL DEFAULT 'PENDIENTE',
  `metodo_pago` varchar(50) DEFAULT NULL,
  `id_transaccion` varchar(100) DEFAULT NULL,
  `idCliente` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`idPedido`, `estado`, `total_pedido`, `estado_pago`, `metodo_pago`, `id_transaccion`, `idCliente`) VALUES
('PED01', 'Entregado', 150, 'PAGADO', 'PAYPAL', 'TXP01', 'CLI01'),
('PED02', 'Enviado', 80, 'PAGADO', 'TARJETA', 'TXP02', 'CLI02'),
('PED03', 'Procesando', 120, 'PENDIENTE', NULL, NULL, 'CLI03'),
('PED04', 'Entregado', 450, 'PAGADO', 'PAYPAL', 'TXP04', 'CLI04'),
('PED05', 'Enviado', 800, 'PAGADO', 'TARJETA', 'TXP05', 'CLI05'),
('PED06', 'Procesando', 90, 'PENDIENTE', NULL, NULL, 'CLI06'),
('PED07', 'Entregado', 70, 'PAGADO', 'PAYPAL', 'TXP07', 'CLI07'),
('PED08', 'Enviado', 1500, 'PAGADO', 'TARJETA', 'TXP08', 'CLI08'),
('PED09', 'Procesando', 150, 'PENDIENTE', NULL, NULL, 'CLI09'),
('PED10', 'Entregado', 50, 'PAGADO', 'PAYPAL', 'TXP10', 'CLI10'),
('PED11', 'Enviado', 140, 'PAGADO', 'TARJETA', 'TXP11', 'CLI11'),
('PED12', 'Procesando', 60, 'PENDIENTE', NULL, NULL, 'CLI12'),
('PED13', 'Entregado', 200, 'PAGADO', 'PAYPAL', 'TXP13', 'CLI13'),
('PED14', 'Enviado', 400, 'PAGADO', 'TARJETA', 'TXP14', 'CLI14'),
('PED15', 'Procesando', 300, 'PENDIENTE', NULL, NULL, 'CLI15'),
('PED16', 'Entregado', 85, 'PAGADO', 'PAYPAL', 'TXP16', 'CLI16'),
('PED17', 'Enviado', 75, 'PAGADO', 'TARJETA', 'TXP17', 'CLI17'),
('PED18', 'Procesando', 2000, 'PENDIENTE', NULL, NULL, 'CLI18'),
('PED19', 'Entregado', 120, 'PAGADO', 'PAYPAL', 'TXP19', 'CLI19'),
('PED20', 'Enviado', 10, 'PAGADO', 'TARJETA', 'TXP20', 'CLI20'),
('PED21', 'Procesando', 130, 'PENDIENTE', NULL, NULL, 'CLI21'),
('PED22', 'Entregado', 90, 'PAGADO', 'PAYPAL', 'TXP22', 'CLI22'),
('PED23', 'Enviado', 350, 'PAGADO', 'TARJETA', 'TXP23', 'CLI23'),
('PED24', 'Procesando', 600, 'PENDIENTE', NULL, NULL, 'CLI24'),
('PED25', 'Entregado', 250, 'PAGADO', 'PAYPAL', 'TXP25', 'CLI25'),
('PED26', 'Enviado', 20, 'PAGADO', 'TARJETA', 'TXP26', 'CLI26'),
('PED27', 'Procesando', 50, 'PENDIENTE', NULL, NULL, 'CLI27'),
('PED28', 'Entregado', 1800, 'PAGADO', 'PAYPAL', 'TXP28', 'CLI28'),
('PED29', 'Enviado', 30, 'PAGADO', 'TARJETA', 'TXP29', 'CLI29'),
('PED30', 'Procesando', 15, 'PENDIENTE', NULL, NULL, 'CLI30'),
('PED31', 'Entregado', 250, 'PAGADO', 'PAYPAL', 'TXP31', 'CLI31'),
('PED32', 'Enviado', 110, 'PAGADO', 'TARJETA', 'TXP32', 'CLI32'),
('PED33', 'Procesando', 800, 'PENDIENTE', NULL, NULL, 'CLI33'),
('PED34', 'Entregado', 500, 'PAGADO', 'PAYPAL', 'TXP34', 'CLI34'),
('PED35', 'Enviado', 80, 'PAGADO', 'TARJETA', 'TXP35', 'CLI35'),
('PED36', 'Procesando', 60, 'PENDIENTE', NULL, NULL, 'CLI36'),
('PED37', 'Entregado', 40, 'PAGADO', 'PAYPAL', 'TXP37', 'CLI37'),
('PED38', 'Enviado', 1200, 'PAGADO', 'TARJETA', 'TXP38', 'CLI38'),
('PED39', 'Procesando', 400, 'PENDIENTE', NULL, NULL, 'CLI39'),
('PED40', 'Entregado', 200, 'PAGADO', 'PAYPAL', 'TXP40', 'CLI40'),
('PED41', 'Enviado', 180, 'PAGADO', 'TARJETA', 'TXP41', 'CLI41'),
('PED41RAS', 'Procesando', 380, 'PENDIENTE', NULL, NULL, NULL),
('PED42', 'Procesando', 300, 'PENDIENTE', NULL, NULL, 'CLI42'),
('PED43', 'Entregado', 450, 'PAGADO', 'PAYPAL', 'TXP43', 'CLI43'),
('PED44', 'Enviado', 150, 'PAGADO', 'TARJETA', 'TXP44', 'CLI44'),
('PED45', 'Procesando', 220, 'PENDIENTE', NULL, NULL, 'CLI45'),
('PED46', 'Entregado', 95, 'PAGADO', 'PAYPAL', 'TXP46', 'CLI46'),
('PED47', 'Enviado', 55, 'PAGADO', 'TARJETA', 'TXP47', 'CLI47'),
('PED48', 'Procesando', 600, 'PENDIENTE', NULL, NULL, 'CLI48'),
('PED49', 'Entregado', 100, 'PAGADO', 'PAYPAL', 'TXP49', 'CLI49'),
('PED50', 'Enviado', 25, 'PAGADO', 'TARJETA', 'TXP50', 'CLI50'),
('PEDEy51x', 'Procesando', 740, 'PENDIENTE', NULL, NULL, '9mHX58k3EO'),
('PEDJ12wR', 'Procesando', 150, 'PENDIENTE', NULL, NULL, NULL),
('PEDMQzVG', 'Procesando', 230, 'PENDIENTE', NULL, NULL, NULL),
('PEDr95WH', 'Procesando', 150, 'PENDIENTE', NULL, NULL, 'CLI01'),
('PEDSkwFJ', 'Procesando', 150, 'PENDIENTE', NULL, NULL, 'CLI01'),
('PEDzwlwi', 'Procesando', 720, 'PENDIENTE', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resenas`
--

CREATE TABLE `resenas` (
  `idResena` int(11) NOT NULL,
  `idTaller` varchar(50) NOT NULL,
  `idUsuario` varchar(50) NOT NULL,
  `calificacion` int(1) NOT NULL,
  `comentario` text DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `resenas`
--

INSERT INTO `resenas` (`idResena`, `idTaller`, `idUsuario`, `calificacion`, `comentario`, `fecha`) VALUES
(1, 'T01', 'CLI01', 5, 'Excelente servicio en AutoGuest Central, muy rápidos.', '2025-12-03 14:31:38'),
(2, 'T02', 'CLI02', 4, 'En Mecánica Express tardaron un poco, pero quedó bien.', '2025-12-03 14:31:38'),
(3, 'T03', 'CLI03', 5, 'Frenos y Clutch me salvaron el viaje, recomendados.', '2025-12-03 14:31:38'),
(4, 'T04', 'CLI04', 3, 'El precio en Taller El Pistón fue justo pero la atención regular.', '2025-12-03 14:31:38'),
(5, 'T05', 'CLI05', 5, 'Servicio Pro son los mejores en suspensión.', '2025-12-03 14:31:38'),
(6, 'T06', 'CLI06', 4, 'Todo bien en Car Doctor, solo faltó limpieza al final.', '2025-12-03 14:31:38'),
(7, 'T07', 'CLI07', 5, 'Mecánica Integral: Rápidos y honestos.', '2025-12-03 14:31:38'),
(8, 'T08', 'CLI08', 2, 'Performance Motors no arregló el problema a la primera.', '2025-12-03 14:31:38'),
(9, 'T09', 'CLI09', 5, 'Increíble atención al cliente en Taller San José.', '2025-12-03 14:31:38'),
(10, 'T10', 'CLI10', 4, 'AutoFix tiene buenos mecánicos e instalaciones limpias.', '2025-12-03 14:31:38'),
(11, 'T11', 'CLI11', 5, 'Taller Alpha ofrece servicio de primera calidad.', '2025-12-03 14:31:38'),
(12, 'T12', 'CLI12', 3, 'Taller Beta es aceptable para emergencias.', '2025-12-03 14:31:38'),
(13, 'T13', 'CLI13', 5, 'Gran experiencia en Taller Gamma, volveré.', '2025-12-03 14:31:38'),
(14, 'T14', 'CLI14', 4, 'Diagnóstico acertado en Taller Delta.', '2025-12-03 14:31:38'),
(15, 'T15', 'CLI15', 5, 'Taller Epsilon: Precios competitivos y buen trabajo.', '2025-12-03 14:31:38'),
(16, 'T16', 'CLI16', 1, 'Muy mala experiencia en Taller Zeta, no lo recomiendo.', '2025-12-03 14:31:38'),
(17, 'T17', 'CLI17', 5, 'En Taller Eta me explicaron todo el proceso.', '2025-12-03 14:31:38'),
(18, 'T18', 'CLI18', 4, 'Taller Theta cumplió con el tiempo de entrega.', '2025-12-03 14:31:38'),
(19, 'T19', 'CLI19', 5, 'Taller Iota: Profesionales y amables.', '2025-12-03 14:31:38'),
(20, 'T20', 'CLI20', 5, 'El coche quedó como nuevo gracias a Taller Kappa.', '2025-12-03 14:31:38'),
(21, 'T21', 'CLI21', 3, 'Falta organización en la recepción de Servicio Lambda.', '2025-12-03 14:31:38'),
(22, 'T22', 'CLI22', 5, 'Servicio Mu tiene excelente relación calidad-precio.', '2025-12-03 14:31:38'),
(23, 'T23', 'CLI23', 4, 'Reparación rápida en Servicio Nu.', '2025-12-03 14:31:38'),
(24, 'T24', 'CLI24', 5, 'Servicio Xi son muy confiables.', '2025-12-03 14:31:38'),
(25, 'T25', 'CLI25', 2, 'Servicio Omicron cobró más de lo acordado.', '2025-12-03 14:31:38'),
(26, 'T26', 'CLI26', 5, 'Motor Pi: Servicio impecable.', '2025-12-03 14:31:38'),
(27, 'T27', 'CLI27', 4, 'Buenos resultados en hojalatería en Motor Rho.', '2025-12-03 14:31:38'),
(28, 'T28', 'CLI28', 5, 'Atención personalizada en Motor Sigma.', '2025-12-03 14:31:38'),
(29, 'T29', 'CLI29', 5, 'Motor Tau son expertos en motores diésel.', '2025-12-03 14:31:38'),
(30, 'T30', 'CLI30', 3, 'En Motor Upsilon tardaron mucho en atenderme.', '2025-12-03 14:31:38'),
(31, 'T31', 'CLI31', 5, 'Muy contenta con el servicio de Auto Phi.', '2025-12-03 14:31:38'),
(32, 'T32', 'CLI32', 4, 'Todo en orden con Auto Chi.', '2025-12-03 14:31:38'),
(33, 'T33', 'CLI33', 5, 'Auto Psi super recomendados.', '2025-12-03 14:31:38'),
(34, 'T34', 'CLI34', 1, 'Pésimo servicio en Auto Omega.', '2025-12-03 14:31:38'),
(35, 'T35', 'CLI35', 5, 'Calidad garantizada en Auto Infinity.', '2025-12-03 14:31:38'),
(36, 'T36', 'CLI36', 4, 'Master Mechanic es un buen taller local.', '2025-12-03 14:31:38'),
(37, 'T37', 'CLI37', 5, 'Speedy Service: Honestidad ante todo.', '2025-12-03 14:31:38'),
(38, 'T38', 'CLI38', 3, 'Top Gear Taller podría mejorar la sala de espera.', '2025-12-03 14:31:38'),
(39, 'T39', 'CLI39', 5, 'Pit Stop tiene un gran equipo de trabajo.', '2025-12-03 14:31:38'),
(40, 'T40', 'CLI40', 5, 'Check Engine solucionó lo que otros no pudieron.', '2025-12-03 14:31:38'),
(41, 'T41', 'CLI41', 4, 'Taller Norte tiene buen servicio eléctrico.', '2025-12-03 14:31:38'),
(42, 'T42', 'CLI42', 5, 'Taller Sur: Trato amable y respetuoso.', '2025-12-03 14:31:38'),
(43, 'T43', 'CLI43', 2, 'Taller Este dejó el coche sucio.', '2025-12-03 14:31:38'),
(44, 'T44', 'CLI44', 5, 'Rapidez y eficiencia en Taller Oeste.', '2025-12-03 14:31:38'),
(45, 'T45', 'CLI45', 4, 'Taller Central tiene buenos precios en refacciones.', '2025-12-03 14:31:38'),
(46, 'T46', 'CLI46', 5, 'Mecánica 4x4 son especialistas de verdad.', '2025-12-03 14:31:38'),
(47, 'T47', 'CLI47', 5, 'Diesel Pro: Excelente servicio para camiones.', '2025-12-03 14:31:38'),
(48, 'T48', 'CLI48', 3, 'Electromecánica es regular, nada extraordinario.', '2025-12-03 14:31:38'),
(49, 'T49', 'CLI49', 5, 'Hojalatería Express hizo muy buen trabajo de pintura.', '2025-12-03 14:31:38'),
(50, 'T50', 'CLI50', 4, 'Llantas y Susp.: Cambio de llantas rápido.', '2025-12-03 14:31:38');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE `servicio` (
  `idServicio` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `idTaller` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicio`
--

INSERT INTO `servicio` (`idServicio`, `nombre`, `descripcion`, `precio`, `idTaller`) VALUES
('SERV--IGxFl', 'Servicio de mantenimiento', 'Se realiza todos los cambios correspondientes', 200.00, 'T02'),
('SERV-1ymHyH', 'servicio mayor', 'uso de aceite MOTUL\nBujias de iridium(cantidad 4)\nfiltro de aceite\nfiltro de aire\ncalibracion de llantas\nlimpieza y mantenimiento de inyectores\nrevicion de luces\neliminacion de codigos de tablero\nlavado del auto\n', 3500.00, 'T04'),
('SERV-aJqaOw', 'Afinación Mayor', 'Cambio de aceite, filtros y bujías.', 1500.00, 'T01'),
('SERV-dD_6wR', 'Cambio de Balatas', 'Reemplazo de pastillas de freno delanteras.', 800.00, 'T01'),
('SERV-Dllo-y', 'Diagnóstico General', 'Escaneo de computadora y revisión visual.', 500.00, 'T01'),
('SERV-FWcU7g', 'Lavado de inyectores', 'Limpieza general con productos especializados al sistema de inyección (motor a gasolina no diesel)', 1200.00, 'T04'),
('SERV-IxJjMo', 'servicio mayor', 'mantenimiento preventivo especializado', 3000.00, 'T02WDr'),
('SERV-jre0gm', 'Cambio de llantas', 'Las mejores llantes', 300.00, 'T02'),
('SERV-kF_gZ0', 'Afinación Mayor', 'Cambio de aceite, filtros y bujías.', 1500.00, 'T01'),
('SERV-kZTEMq', 'servicio menor', 'mantenimiento preventivo', 2000.00, 'T02WDr'),
('SERV-kzyLFE', 'Diagnóstico General', 'Escaneo de computadora y revisión visual.', 500.00, 'T01'),
('SERV-NVX8Sb', 'servicio menor', 'uso de 4 litros de aceite motorcreft\nbujias normales(cnatidad 4)\nfiltro de aceite', 2500.00, 'T04'),
('SERV-OZqxPs', 'mantenimiento de sistema de frenado', 'limpieza ', 250.00, 'T04'),
('SERV-QIDTIu', 'Cambio de Aceite', 'Aceite Sintético 5W-30', 500.00, 'T2XTqg'),
('SERV-wJja33', 'Revisión de Frenos', 'Ajuste y limpieza de balatas', 300.00, 'T2XTqg'),
('SERV-WvcmoN', 'Lavado de inyectores', 'Mantenimiento de sistema de inyección del vehiculo ', 300.00, 'T02'),
('SERV-xXdNZO', 'Cambio de Balatas', 'Reemplazo de pastillas de freno delanteras.', 800.00, 'T01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `taller`
--

CREATE TABLE `taller` (
  `idTaller` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `taller`
--

INSERT INTO `taller` (`idTaller`, `nombre`, `direccion`) VALUES
('T01', 'AutoGuest Central', 'Av. Reforma 100'),
('T02', 'Mecánica Express', 'Calle 50 Sur #20'),
('T02WDr', 'AutoSur', 'Circuito colonias'),
('T03', 'Frenos y Clutch', 'Blvd. Norte 55'),
('T04', 'Taller El Pistón', 'Calle 8 Pte'),
('T05', 'Servicio Pro', 'Av. Juarez 20'),
('T06', 'Car Doctor', 'Plaza Cristal'),
('T07', 'Mecánica Integral', 'Centro Historico'),
('T08', 'Performance Motors', 'Vía Atlixcayotl'),
('T09', 'Taller San José', 'Av. Las Torres'),
('T10', 'AutoFix', 'Calle 4 Norte'),
('T11', 'Taller Alpha', 'Zona Ind. 1'),
('T12', 'Taller Beta', 'Zona Ind. 2'),
('T13', 'Taller Gamma', 'Zona Ind. 3'),
('T14', 'Taller Delta', 'Zona Ind. 4'),
('T15', 'Taller Epsilon', 'Zona Ind. 5'),
('T16', 'Taller Zeta', 'Colonia La Paz'),
('T17', 'Taller Eta', 'Colonia Amor'),
('T18', 'Taller Theta', 'Colonia Centro'),
('T19', 'Taller Iota', 'Colonia Sur'),
('T20', 'Taller Kappa', 'Colonia Norte'),
('T21', 'Servicio Lambda', 'Calle Roble'),
('T22', 'Servicio Mu', 'Calle Pino'),
('T23', 'Servicio Nu', 'Calle Encino'),
('T24', 'Servicio Xi', 'Calle Cedro'),
('T25', 'Servicio Omicron', 'Calle Nogal'),
('T26', 'Motor Pi', 'Av. Sol'),
('T27', 'Motor Rho', 'Av. Luna'),
('T28', 'Motor Sigma', 'Av. Estrella'),
('T29', 'Motor Tau', 'Av. Cometa'),
('T2XTqg', 'Test Workshop', 'Test Address 123'),
('T30', 'Motor Upsilon', 'Av. Galaxia'),
('T31', 'Auto Phi', 'Calle Rojo'),
('T32', 'Auto Chi', 'Calle Azul'),
('T33', 'Auto Psi', 'Calle Verde'),
('T34', 'Auto Omega', 'Calle Amarillo'),
('T35', 'Auto Infinity', 'Calle Blanco'),
('T36', 'Master Mechanic', 'Calle 1'),
('T37', 'Speedy Service', 'Calle 2'),
('T38', 'Top Gear Taller', 'Calle 3'),
('T39', 'Pit Stop', 'Calle 4'),
('T40', 'Check Engine', 'Calle 5'),
('T41', 'Taller Norte', 'Salida Norte'),
('T42', 'Taller Sur', 'Salida Sur'),
('T43', 'Taller Este', 'Salida Este'),
('T44', 'Taller Oeste', 'Salida Oeste'),
('T45', 'Taller Central', 'Zocalo'),
('T46', 'Mecánica 4x4', 'Av. Montaña'),
('T47', 'Diesel Pro', 'Carretera Fed.'),
('T48', 'Electromecánica', 'Calle Electricistas'),
('T49', 'Hojalatería Express', 'Calle Pintores'),
('T50', 'Llantas y Susp.', 'Calle Ruedas'),
('T5ueot', 'Test Workshop', 'Test Street 123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ticketsoporte`
--

CREATE TABLE `ticketsoporte` (
  `idTicket` varchar(50) NOT NULL,
  `asunto` varchar(100) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `idCliente` varchar(50) NOT NULL,
  `idAdministrador` varchar(50) DEFAULT NULL,
  `idPedido` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ticketsoporte`
--

INSERT INTO `ticketsoporte` (`idTicket`, `asunto`, `estado`, `idCliente`, `idAdministrador`, `idPedido`) VALUES
('TK01', 'Retraso pedido', 'Abierto', 'CLI01', 'ADM01', 'PED01'),
('TK02', 'Producto dañado', 'Cerrado', 'CLI02', 'ADM02', 'PED02'),
('TK03', 'Duda pago', 'Abierto', 'CLI03', 'ADM03', 'PED03'),
('TK04', 'Cambio dirección', 'En Proceso', 'CLI04', 'ADM04', 'PED04'),
('TK05', 'Factura', 'Cerrado', 'CLI05', 'ADM05', 'PED05'),
('TK06', 'Garantía', 'Abierto', 'CLI06', 'ADM06', 'PED06'),
('TK07', 'Devolución', 'En Proceso', 'CLI07', 'ADM07', 'PED07'),
('TK08', 'Pedido incompleto', 'Cerrado', 'CLI08', 'ADM08', 'PED08'),
('TK09', 'Estado envío', 'Abierto', 'CLI09', 'ADM09', 'PED09'),
('TK10', 'Cancelar pedido', 'Cerrado', 'CLI10', 'ADM10', 'PED10'),
('TK11', 'Retraso', 'Abierto', 'CLI11', 'ADM11', 'PED11'),
('TK12', 'Dañado', 'Cerrado', 'CLI12', 'ADM12', 'PED12'),
('TK13', 'Pago', 'Abierto', 'CLI13', 'ADM13', 'PED13'),
('TK14', 'Dirección', 'En Proceso', 'CLI14', 'ADM14', 'PED14'),
('TK15', 'Factura', 'Cerrado', 'CLI15', 'ADM15', 'PED15'),
('TK16', 'Garantía', 'Abierto', 'CLI16', 'ADM16', 'PED16'),
('TK17', 'Devolución', 'En Proceso', 'CLI17', 'ADM17', 'PED17'),
('TK18', 'Incompleto', 'Cerrado', 'CLI18', 'ADM18', 'PED18'),
('TK19', 'Envío', 'Abierto', 'CLI19', 'ADM19', 'PED19'),
('TK20', 'Cancelar', 'Cerrado', 'CLI20', 'ADM20', 'PED20'),
('TK21', 'Retraso', 'Abierto', 'CLI21', 'ADM21', 'PED21'),
('TK22', 'Dañado', 'Cerrado', 'CLI22', 'ADM22', 'PED22'),
('TK23', 'Pago', 'Abierto', 'CLI23', 'ADM23', 'PED23'),
('TK24', 'Dirección', 'En Proceso', 'CLI24', 'ADM24', 'PED24'),
('TK25', 'Factura', 'Cerrado', 'CLI25', 'ADM25', 'PED25'),
('TK26', 'Garantía', 'Abierto', 'CLI26', 'ADM26', 'PED26'),
('TK27', 'Devolución', 'En Proceso', 'CLI27', 'ADM27', 'PED27'),
('TK28', 'Incompleto', 'Cerrado', 'CLI28', 'ADM28', 'PED28'),
('TK29', 'Envío', 'Abierto', 'CLI29', 'ADM29', 'PED29'),
('TK30', 'Cancelar', 'Cerrado', 'CLI30', 'ADM30', 'PED30'),
('TK31', 'Retraso', 'Abierto', 'CLI31', 'ADM31', 'PED31'),
('TK32', 'Dañado', 'Cerrado', 'CLI32', 'ADM32', 'PED32'),
('TK33', 'Pago', 'Abierto', 'CLI33', 'ADM33', 'PED33'),
('TK34', 'Dirección', 'En Proceso', 'CLI34', 'ADM34', 'PED34'),
('TK35', 'Factura', 'Cerrado', 'CLI35', 'ADM35', 'PED35'),
('TK36', 'Garantía', 'Abierto', 'CLI36', 'ADM36', 'PED36'),
('TK37', 'Devolución', 'En Proceso', 'CLI37', 'ADM37', 'PED37'),
('TK38', 'Incompleto', 'Cerrado', 'CLI38', 'ADM38', 'PED38'),
('TK39', 'Envío', 'Abierto', 'CLI39', 'ADM39', 'PED39'),
('TK40', 'Cancelar', 'Cerrado', 'CLI40', 'ADM40', 'PED40'),
('TK41', 'Retraso', 'Abierto', 'CLI41', 'ADM41', 'PED41'),
('TK42', 'Dañado', 'Cerrado', 'CLI42', 'ADM42', 'PED42'),
('TK43', 'Pago', 'Abierto', 'CLI43', 'ADM43', 'PED43'),
('TK44', 'Dirección', 'En Proceso', 'CLI44', 'ADM44', 'PED44'),
('TK45', 'Factura', 'Cerrado', 'CLI45', 'ADM45', 'PED45'),
('TK46', 'Garantía', 'Abierto', 'CLI46', 'ADM46', 'PED46'),
('TK47', 'Devolución', 'En Proceso', 'CLI47', 'ADM47', 'PED47'),
('TK48', 'Incompleto', 'Cerrado', 'CLI48', 'ADM48', 'PED48'),
('TK49', 'Envío', 'Abierto', 'CLI49', 'ADM49', 'PED49'),
('TK50', 'Cancelar', 'Cerrado', 'CLI50', 'ADM50', 'PED50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `nombre`, `email`, `password`, `telefono`) VALUES
('9mHX58k3EO', 'Yazumi Romina Narvaez Canche', 'yazumi@gmail.com', '$2b$10$nHFemkKG5JhIAM8I6Z0ZpukZ4nlD7kH1gpwBT8k/4hy1Y0H/P4qW6', '9992743500'),
('ADM01', 'Carlos Hernández', 'carlos.h@taller.com', '12345', '2221110001'),
('ADM02', 'Miguel Ángel Torres', 'miguel.t@taller.com', '12345', '2221110002'),
('ADM03', 'Laura Martínez', 'laura.m@taller.com', '12345', '2221110003'),
('ADM04', 'Ana Patricia López', 'ana.p@taller.com', '12345', '2221110004'),
('ADM05', 'José Luis Castillo', 'jose.c@taller.com', '12345', '2221110005'),
('ADM06', 'Sofía Vergara', 'sofia.v@taller.com', '12345', '2221110006'),
('ADM07', 'Fernando Ruiz', 'fernando.r@taller.com', '12345', '2221110007'),
('ADM08', 'Lucía Méndez', 'lucia.m@taller.com', '12345', '2221110008'),
('ADM09', 'Ricardo Arjona', 'ricardo.a@taller.com', '12345', '2221110009'),
('ADM10', 'Elena Poniatowska', 'elena.p@taller.com', '12345', '2221110010'),
('ADM11', 'David Zepeda', 'david.z@taller.com', '12345', '2221110011'),
('ADM12', 'Carmen Salinas', 'carmen.s@taller.com', '12345', '2221110012'),
('ADM13', 'Javier Bardem', 'javier.b@taller.com', '12345', '2221110013'),
('ADM14', 'Paula Echevarría', 'paula.e@taller.com', '12345', '2221110014'),
('ADM15', 'Roberto Palazuelos', 'roberto.p@taller.com', '12345', '2221110015'),
('ADM16', 'Andrea Legarreta', 'andrea.l@taller.com', '12345', '2221110016'),
('ADM17', 'Héctor Suárez', 'hector.s@taller.com', '12345', '2221110017'),
('ADM18', 'Rosa Gloria', 'rosa.g@taller.com', '12345', '2221110018'),
('ADM19', 'Manuel Mijares', 'manuel.m@taller.com', '12345', '2221110019'),
('ADM20', 'Teresa Mendoza', 'teresa.m@taller.com', '12345', '2221110020'),
('ADM21', 'Francisco Villa', 'pancho.v@taller.com', '12345', '2221110021'),
('ADM22', 'Emiliano Zapata', 'emiliano.z@taller.com', '12345', '2221110022'),
('ADM23', 'Venustiano Carranza', 'venus.c@taller.com', '12345', '2221110023'),
('ADM24', 'Lázaro Cárdenas', 'lazaro.c@taller.com', '12345', '2221110024'),
('ADM25', 'Frida Kahlo', 'frida.k@taller.com', '12345', '2221110025'),
('ADM26', 'Diego Rivera', 'diego.r@taller.com', '12345', '2221110026'),
('ADM27', 'Octavio Paz', 'octavio.p@taller.com', '12345', '2221110027'),
('ADM28', 'Sor Juana', 'sor.juana@taller.com', '12345', '2221110028'),
('ADM29', 'Benito Juárez', 'benito.j@taller.com', '12345', '2221110029'),
('ADM30', 'Miguel Hidalgo', 'miguel.h@taller.com', '12345', '2221110030'),
('ADM31', 'Josefa Ortiz', 'josefa.o@taller.com', '12345', '2221110031'),
('ADM32', 'Ignacio Allende', 'ignacio.a@taller.com', '12345', '2221110032'),
('ADM33', 'Vicente Guerrero', 'vicente.g@taller.com', '12345', '2221110033'),
('ADM34', 'Guadalupe Victoria', 'guadalupe.v@taller.com', '12345', '2221110034'),
('ADM35', 'Porfirio Díaz', 'porfirio.d@taller.com', '12345', '2221110035'),
('ADM36', 'Francisco I Madero', 'francisco.m@taller.com', '12345', '2221110036'),
('ADM37', 'Álvaro Obregón', 'alvaro.o@taller.com', '12345', '2221110037'),
('ADM38', 'Plutarco Elías', 'plutarco.e@taller.com', '12345', '2221110038'),
('ADM39', 'Adolfo López', 'adolfo.l@taller.com', '12345', '2221110039'),
('ADM40', 'Gustavo Díaz', 'gustavo.d@taller.com', '12345', '2221110040'),
('ADM41', 'Luis Echeverría', 'luis.e@taller.com', '12345', '2221110041'),
('ADM42', 'José López', 'jose.l@taller.com', '12345', '2221110042'),
('ADM43', 'Miguel de la Madrid', 'miguel.m@taller.com', '12345', '2221110043'),
('ADM44', 'Carlos Salinas', 'carlos.s@taller.com', '12345', '2221110044'),
('ADM45', 'Ernesto Zedillo', 'ernesto.z@taller.com', '12345', '2221110045'),
('ADM46', 'Vicente Fox', 'vicente.f@taller.com', '12345', '2221110046'),
('ADM47', 'Felipe Calderón', 'felipe.c@taller.com', '12345', '2221110047'),
('ADM48', 'Enrique Peña', 'enrique.p@taller.com', '12345', '2221110048'),
('ADM49', 'Andrés Manuel', 'andres.m@taller.com', '12345', '2221110049'),
('ADM50', 'Claudia Sheinbaum', 'claudia.s@taller.com', '12345', '2221110050'),
('CLI-N9hKyL', 'Elena Casani May', '9994956356@temp.com', '9994956356', '9994956356'),
('CLI01', 'María Félix M', 'maria.f@gmail.com', '$2b$10$3n7iF.pKveOOs5Vi2Ac4VuFF6LNJ0MsyoMeRLSIHZq7zKGhn6yMum', '22244401'),
('CLI02', 'Pedro Infante', 'pedro.i@gmail.com', '12345', '22244402'),
('CLI03', 'Jorge Negrete', 'jorge.n@gmail.com', '12345', '22244403'),
('CLI04', 'Dolores del Río', 'dolores.d@gmail.com', '12345', '22244404'),
('CLI05', 'Cantinflas', 'mario.m@gmail.com', '12345', '22244405'),
('CLI06', 'Tin Tan', 'german.v@gmail.com', '12345', '22244406'),
('CLI07', 'Pedro Armendáriz', 'pedro.a@gmail.com', '12345', '22244407'),
('CLI08', 'Sara García', 'sara.g@gmail.com', '12345', '22244408'),
('CLI09', 'Joaquín Pardavé', 'joaquin.p@gmail.com', '12345', '22244409'),
('CLI10', 'Ignacio López Tarso', 'ignacio.l@gmail.com', '12345', '22244410'),
('CLI11', 'Silvia Pinal', 'silvia.p@gmail.com', '12345', '22244411'),
('CLI12', 'El Santo', 'rodolfo.g@gmail.com', '12345', '22244412'),
('CLI13', 'Blue Demon', 'alejandro.m@gmail.com', '12345', '22244413'),
('CLI14', 'Mil Máscaras', 'aaron.r@gmail.com', '12345', '22244414'),
('CLI15', 'Rayek', 'rayek.c@gmail.com', '12345', '22244415'),
('CLI16', 'Caifanes', 'saul.h@gmail.com', '12345', '22244416'),
('CLI17', 'Café Tacvba', 'ruben.a@gmail.com', '12345', '22244417'),
('CLI18', 'Molotov', 'tito.f@gmail.com', '12345', '22244418'),
('CLI19', 'Maná', 'fher.o@gmail.com', '12345', '22244419'),
('CLI20', 'Zoé', 'leon.l@gmail.com', '12345', '22244420'),
('CLI21', 'Panteón Rococó', 'dr.shenka@gmail.com', '12345', '22244421'),
('CLI22', 'El Tri', 'alex.lora@gmail.com', '12345', '22244422'),
('CLI23', 'Maldita Vecindad', 'roco.p@gmail.com', '12345', '22244423'),
('CLI24', 'Fobia', 'leonardo.l@gmail.com', '12345', '22244424'),
('CLI25', 'Kinky', 'gil.c@gmail.com', '12345', '22244425'),
('CLI26', 'Jumbo', 'clemente.c@gmail.com', '12345', '22244426'),
('CLI27', 'División Minúscula', 'javier.b@gmail.com', '12345', '22244427'),
('CLI28', 'Enjambre', 'luis.h@gmail.com', '12345', '22244428'),
('CLI29', 'Siddhartha', 'jorge.s@gmail.com', '12345', '22244429'),
('CLI30', 'Caloncho', 'oscar.c@gmail.com', '12345', '22244430'),
('CLI31', 'Mon Laferte', 'monserrat.b@gmail.com', '12345', '22244431'),
('CLI32', 'Natalia Lafourcade', 'natalia.l@gmail.com', '12345', '22244432'),
('CLI33', 'Carla Morrison', 'carla.m@gmail.com', '12345', '22244433'),
('CLI34', 'Ximena Sariñana', 'ximena.s@gmail.com', '12345', '22244434'),
('CLI35', 'Julieta Venegas', 'julieta.v@gmail.com', '12345', '22244435'),
('CLI36', 'Ely Guerra', 'elizabeth.g@gmail.com', '12345', '22244436'),
('CLI37', 'Lila Downs', 'lila.d@gmail.com', '12345', '22244437'),
('CLI38', 'Eugenia León', 'eugenia.l@gmail.com', '12345', '22244438'),
('CLI39', 'Tania Libertad', 'tania.l@gmail.com', '12345', '22244439'),
('CLI40', 'Guadalupe Pineda', 'guadalupe.p@gmail.com', '12345', '22244440'),
('CLI41', 'Aida Cuevas', 'aida.c@gmail.com', '12345', '22244441'),
('CLI42', 'Ana Gabriel', 'maria.g@gmail.com', '12345', '22244442'),
('CLI43', 'Lucero', 'lucero.h@gmail.com', '12345', '22244443'),
('CLI44', 'Thalía', 'ariadna.s@gmail.com', '12345', '22244444'),
('CLI45', 'Paulina Rubio', 'paulina.r@gmail.com', '12345', '22244445'),
('CLI46', 'Gloria Trevi', 'gloria.r@gmail.com', '12345', '22244446'),
('CLI47', 'Alejandra Guzmán', 'alejandra.g@gmail.com', '12345', '22244447'),
('CLI48', 'Yuri', 'yuridia.v@gmail.com', '12345', '22244448'),
('CLI49', 'Daniela Romo', 'teresa.p@gmail.com', '12345', '22244449'),
('CLI50', 'Lupita D\'Alessio', 'guadalupe.c@gmail.com', '12345', '22244450'),
('CLIA3NSnOa', 'Fernando', '9992945682@temp.com', '9992945682', '9992945682'),
('CLIckWR49u', 'Cliente Test', '1231231234@temp.com', '1231231234', '1231231234'),
('CLItVyvl91', 'Test Client', '9876543210@temp.com', '9876543210', '9876543210'),
('KhC2yRO3eh', 'Test User', 'testuser12345@email.com', '$2b$10$mEWo4qv/qSjjlCBVOQzwBO3Okgci.0BG4QXo.oCnP83rTF0rxgeDO', '5551234567'),
('MEC01', 'Jorge Campos', 'jorge.mec@taller.com', '12345', '555001'),
('MEC02', 'Luis García', 'luis.mec@taller.com', '12345', '555002'),
('MEC03', 'Hugo Sánchez', 'hugo.mec@taller.com', '12345', '555003'),
('MEC04', 'Rafael Márquez', 'rafa.mec@taller.com', '12345', '555004'),
('MEC05', 'Cuauhtémoc Blanco', 'cuau.mec@taller.com', '12345', '555005'),
('MEC06', 'Guillermo Ochoa', 'memo.mec@taller.com', '12345', '555006'),
('MEC07', 'Javier Hernández', 'chicharito.mec@taller.com', '12345', '555007'),
('MEC08', 'Andrés Guardado', 'andres.mec@taller.com', '12345', '555008'),
('MEC09', 'Raúl Jiménez', 'raul.mec@taller.com', '12345', '555009'),
('MEC10', 'Hirving Lozano', 'chucky.mec@taller.com', '12345', '555010'),
('MEC11', 'Carlos Vela', 'carlos.mec@taller.com', '12345', '555011'),
('MEC12', 'Héctor Herrera', 'hector.mec@taller.com', '12345', '555012'),
('MEC13', 'Miguel Layún', 'miguel.mec@taller.com', '12345', '555013'),
('MEC14', 'Oribe Peralta', 'oribe.mec@taller.com', '12345', '555014'),
('MEC15', 'Giovani Dos Santos', 'gio.mec@taller.com', '12345', '555015'),
('MEC16', 'Jonathan Dos Santos', 'jona.mec@taller.com', '12345', '555016'),
('MEC17', 'Jesús Corona', 'tecatito.mec@taller.com', '12345', '555017'),
('MEC18', 'Edson Álvarez', 'edson.mec@taller.com', '12345', '555018'),
('MEC19', 'Diego Lainez', 'diego.mec@taller.com', '12345', '555019'),
('MEC20', 'Rodolfo Pizarro', 'rodolfo.mec@taller.com', '12345', '555020'),
('MEC21', 'Uriel Antuna', 'uriel.mec@taller.com', '12345', '555021'),
('MEC22', 'Henry Martín', 'henry.mec@taller.com', '12345', '555022'),
('MEC23', 'Sebastián Córdova', 'sebas.mec@taller.com', '12345', '555023'),
('MEC24', 'Luis Romo', 'luis.r@taller.com', '12345', '555024'),
('MEC25', 'Orbelín Pineda', 'orbelin.mec@taller.com', '12345', '555025'),
('MEC26', 'César Montes', 'cesar.mec@taller.com', '12345', '555026'),
('MEC27', 'Johan Vásquez', 'johan.mec@taller.com', '12345', '555027'),
('MEC28', 'Jorge Sánchez', 'jorge.s@taller.com', '12345', '555028'),
('MEC29', 'Gerardo Arteaga', 'gerardo.mec@taller.com', '12345', '555029'),
('MEC30', 'Jesús Gallardo', 'jesus.g@taller.com', '12345', '555030'),
('MEC31', 'Néstor Araujo', 'nestor.mec@taller.com', '12345', '555031'),
('MEC32', 'Héctor Moreno', 'hector.m@taller.com', '12345', '555032'),
('MEC33', 'Alfredo Talavera', 'alfredo.mec@taller.com', '12345', '555033'),
('MEC34', 'Rodolfo Cota', 'cota.mec@taller.com', '12345', '555034'),
('MEC35', 'Jonathan Orozco', 'jona.o@taller.com', '12345', '555035'),
('MEC36', 'Hugo González', 'hugo.g@taller.com', '12345', '555036'),
('MEC37', 'Gibran Lajud', 'gibran.mec@taller.com', '12345', '555037'),
('MEC38', 'Sebastián Jurado', 'jurado.mec@taller.com', '12345', '555038'),
('MEC39', 'Luis Malagón', 'malagon.mec@taller.com', '12345', '555039'),
('MEC40', 'Carlos Acevedo', 'acevedo.mec@taller.com', '12345', '555040'),
('MEC41', 'Julio González', 'julio.mec@taller.com', '12345', '555041'),
('MEC42', 'Miguel Ponce', 'ponce.mec@taller.com', '12345', '555042'),
('MEC43', 'Hiram Mier', 'hiram.mec@taller.com', '12345', '555043'),
('MEC44', 'Oswaldo Alanís', 'oswaldo.mec@taller.com', '12345', '555044'),
('MEC45', 'Carlos Salcedo', 'salcedo.mec@taller.com', '12345', '555045'),
('MEC46', 'Diego Reyes', 'reyes.mec@taller.com', '12345', '555046'),
('MEC47', 'Antonio Briseño', 'pollo.mec@taller.com', '12345', '555047'),
('MEC48', 'Jair Pereira', 'jair.mec@taller.com', '12345', '555048'),
('MEC49', 'Hugo Ayala', 'ayala.mec@taller.com', '12345', '555049'),
('MEC50', 'Jorge Torres', 'nilo.mec@taller.com', '12345', '555050'),
('MECEvCdX0o', 'Jorge Campos', 'jorge.campos@test.com', 'password123', '1234567890'),
('MECFo5uPjo', 'Jorge Mondragon Chable', 'jorge.t@taller.com', '123456', '9999991561'),
('MECfzCjvV_', 'Elena Casano', 'elena.t@taller.com', '123456', '9999999999'),
('MECHF9KnfY', 'Fabricio Gomez Marin', 'fabricio.t@taller.com', '123456', '9993230529'),
('MECsiUGKz5', 'Test Mechanic', 'testmech@example.com', 'test1234', '1234567890'),
('MECUPEAuuv', 'Diego', 'diego.a@taller.com', '12345', '9993244977'),
('UA4hmUO', 'Diego Mondragon Ortega', 'autoSur1@gmail.com', '12345', '9993244977'),
('UA7joPp', 'Test Admin', 'testtaller@example.com', 'test1234', '1234567890'),
('UAFUg5i', 'Test Admin', 'admin@testworkshop.com', 'password123', '1234567890');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

CREATE TABLE `vehiculo` (
  `idVehiculo` varchar(50) NOT NULL,
  `placa` varchar(20) NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `anio` int(11) DEFAULT NULL,
  `idDuenio` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculo`
--

INSERT INTO `vehiculo` (`idVehiculo`, `placa`, `marca`, `modelo`, `anio`, `idDuenio`) VALUES
('V01', 'PUE-001', 'TOYOTA', 'Corolla', 2020, 'CLI01'),
('V02', 'PUE-002', 'Nissan', 'Versa', 2019, 'CLI02'),
('V03', 'PUE-003', 'Honda', 'Civic', 2021, 'CLI03'),
('V04', 'PUE-004', 'Ford', 'Fiesta', 2018, 'CLI04'),
('V05', 'PUE-005', 'Chevrolet', 'Aveo', 2022, 'CLI05'),
('V06', 'PUE-006', 'Mazda', '3', 2020, 'CLI06'),
('V07', 'PUE-007', 'Volkswagen', 'Jetta', 2019, 'CLI07'),
('V08', 'PUE-008', 'Hyundai', 'Elantra', 2021, 'CLI08'),
('V09', 'PUE-009', 'Kia', 'Rio', 2022, 'CLI09'),
('V10', 'PUE-010', 'BMW', 'Serie 3', 2018, 'CLI10'),
('V11', 'PUE-011', 'Toyota', 'Yaris', 2020, 'CLI11'),
('V12', 'PUE-012', 'Nissan', 'Sentra', 2019, 'CLI12'),
('V13', 'PUE-013', 'Honda', 'Accord', 2021, 'CLI13'),
('V14', 'PUE-014', 'Ford', 'Focus', 2018, 'CLI14'),
('V15', 'PUE-015', 'Chevrolet', 'Spark', 2022, 'CLI15'),
('V16', 'PUE-016', 'Mazda', 'CX-5', 2020, 'CLI16'),
('V17', 'PUE-017', 'Volkswagen', 'Golf', 2019, 'CLI17'),
('V18', 'PUE-018', 'Hyundai', 'Tucson', 2021, 'CLI18'),
('V19', 'PUE-019', 'Kia', 'Forte', 2022, 'CLI19'),
('V20', 'PUE-020', 'Audi', 'A4', 2018, 'CLI20'),
('V21', 'PUE-021', 'Toyota', 'Prius', 2020, 'CLI21'),
('V22', 'PUE-022', 'Nissan', 'March', 2019, 'CLI22'),
('V23', 'PUE-023', 'Honda', 'CR-V', 2021, 'CLI23'),
('V24', 'PUE-024', 'Ford', 'Mustang', 2018, 'CLI24'),
('V25', 'PUE-025', 'Chevrolet', 'Camaro', 2022, 'CLI25'),
('V26', 'PUE-026', 'Mazda', 'MX-5', 2020, 'CLI26'),
('V27', 'PUE-027', 'Volkswagen', 'Polo', 2019, 'CLI27'),
('V28', 'PUE-028', 'Hyundai', 'Creta', 2021, 'CLI28'),
('V29', 'PUE-029', 'Kia', 'Soul', 2022, 'CLI29'),
('V30', 'PUE-030', 'Mercedes', 'Clase C', 2018, 'CLI30'),
('V31', 'PUE-031', 'Toyota', 'Hilux', 2020, 'CLI31'),
('V32', 'PUE-032', 'Nissan', 'Frontier', 2019, 'CLI32'),
('V33', 'PUE-033', 'Honda', 'HR-V', 2021, 'CLI33'),
('V34', 'PUE-034', 'Ford', 'Ranger', 2018, 'CLI34'),
('V35', 'PUE-035', 'Chevrolet', 'Colorado', 2022, 'CLI35'),
('V36', 'PUE-036', 'Mazda', 'CX-3', 2020, 'CLI36'),
('V37', 'PUE-037', 'Volkswagen', 'Vento', 2019, 'CLI37'),
('V38', 'PUE-038', 'Hyundai', 'Sonata', 2021, 'CLI38'),
('V39', 'PUE-039', 'Kia', 'Seltos', 2022, 'CLI39'),
('V40', 'PUE-040', 'Jeep', 'Wrangler', 2018, 'CLI40'),
('V41', 'PUE-041', 'Toyota', 'Rav4', 2020, 'CLI41'),
('V42', 'PUE-042', 'Nissan', 'Kicks', 2019, 'CLI42'),
('V43', 'PUE-043', 'Honda', 'Fit', 2021, 'CLI43'),
('V44', 'PUE-044', 'Ford', 'Explorer', 2018, 'CLI44'),
('V45', 'PUE-045', 'Chevrolet', 'Trax', 2022, 'CLI45'),
('V46', 'PUE-046', 'Mazda', 'CX-9', 2020, 'CLI46'),
('V47', 'PUE-047', 'Volkswagen', 'Virtus', 2019, 'CLI47'),
('V48', 'PUE-048', 'Hyundai', 'Grand i10', 2021, 'CLI48'),
('V49', 'PUE-049', 'Kia', 'Sportage', 2022, 'CLI49'),
('V50', 'PUE-050', 'Tesla', 'Model 3', 2023, 'CLI50'),
('VEH66JvGMlU', 'ZPR-153', 'CHEVROLET', 'ornado', 2024, 'CLI01'),
('VEH94KKO_vd', 'ZMP-052', 'SUSUKI', 'swift', 2024, 'CLI01'),
('VEHhTjDv2Je', 'CCA-897', 'Chevrolet', 'Aveo', 2025, '9mHX58k3EO'),
('VEHnlMHcpHd', 'ABC-123', 'Honda', 'Civic EX', 2023, 'KhC2yRO3eh'),
('VEHo4tNMSw', 'yr0915f', 'Chevrolet', 'S10 max', 2026, 'CLI-N9hKyL'),
('VEHWv-QEii', 'YRC-021', 'Nissan', 'NP300', 2026, 'CLIA3NSnOa'),
('VEHXnnk5SL', 'TST-999', 'Ford', 'Fiesta', 2026, 'KhC2yRO3eh'),
('VEHyjzYbLoK', 'YRG-091', 'CHEVROLET', 'S10', 2024, 'CLI01');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `fk_admin_taller` (`idTaller`);

--
-- Indices de la tabla `chat_mensaje`
--
ALTER TABLE `chat_mensaje`
  ADD PRIMARY KEY (`idMensaje`),
  ADD KEY `idx_idCita` (`idCita`),
  ADD KEY `idx_fechaEnvio` (`fechaEnvio`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`idCita`),
  ADD KEY `idCliente` (`idCliente`),
  ADD KEY `idVehiculo` (`idVehiculo`),
  ADD KEY `idMecanico` (`idMecanico`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idUsuario`);

--
-- Indices de la tabla `coches`
--
ALTER TABLE `coches`
  ADD UNIQUE KEY `numero_serie` (`numero_serie`),
  ADD UNIQUE KEY `placa` (`placa`);

--
-- Indices de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD PRIMARY KEY (`idCotizacion`),
  ADD UNIQUE KEY `id_transaccion` (`id_transaccion`),
  ADD KEY `idCita` (`idCita`);

--
-- Indices de la tabla `cotizacion_servicios`
--
ALTER TABLE `cotizacion_servicios`
  ADD PRIMARY KEY (`idCotizacion`,`idServicio`),
  ADD KEY `idServicio` (`idServicio`);

--
-- Indices de la tabla `evidencia`
--
ALTER TABLE `evidencia`
  ADD PRIMARY KEY (`idEvidencia`),
  ADD KEY `idCotizacion` (`idCotizacion`);

--
-- Indices de la tabla `iteminventario`
--
ALTER TABLE `iteminventario`
  ADD PRIMARY KEY (`idItem`),
  ADD KEY `idTaller` (`idTaller`);

--
-- Indices de la tabla `item_inventario`
--
ALTER TABLE `item_inventario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `lineacotizacion`
--
ALTER TABLE `lineacotizacion`
  ADD PRIMARY KEY (`idLineaCotizacion`),
  ADD KEY `idCotizacion` (`idCotizacion`),
  ADD KEY `idItemInventario` (`idItemInventario`);

--
-- Indices de la tabla `lineapedido`
--
ALTER TABLE `lineapedido`
  ADD PRIMARY KEY (`idLineaPedido`),
  ADD KEY `idPedido` (`idPedido`),
  ADD KEY `idItemInventario` (`idItemInventario`);

--
-- Indices de la tabla `mecanico`
--
ALTER TABLE `mecanico`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `fk_mecanico_taller` (`idTaller`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`idPedido`),
  ADD UNIQUE KEY `id_transaccion` (`id_transaccion`),
  ADD KEY `idCliente` (`idCliente`);

--
-- Indices de la tabla `resenas`
--
ALTER TABLE `resenas`
  ADD PRIMARY KEY (`idResena`),
  ADD KEY `fk_resena_taller` (`idTaller`),
  ADD KEY `fk_resena_usuario` (`idUsuario`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`idServicio`),
  ADD KEY `idTaller` (`idTaller`);

--
-- Indices de la tabla `taller`
--
ALTER TABLE `taller`
  ADD PRIMARY KEY (`idTaller`);

--
-- Indices de la tabla `ticketsoporte`
--
ALTER TABLE `ticketsoporte`
  ADD PRIMARY KEY (`idTicket`),
  ADD KEY `idCliente` (`idCliente`),
  ADD KEY `idAdministrador` (`idAdministrador`),
  ADD KEY `idPedido` (`idPedido`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD PRIMARY KEY (`idVehiculo`),
  ADD UNIQUE KEY `placa` (`placa`),
  ADD KEY `idDuenio` (`idDuenio`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `evidencia`
--
ALTER TABLE `evidencia`
  MODIFY `idEvidencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `item_inventario`
--
ALTER TABLE `item_inventario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `lineacotizacion`
--
ALTER TABLE `lineacotizacion`
  MODIFY `idLineaCotizacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de la tabla `lineapedido`
--
ALTER TABLE `lineapedido`
  MODIFY `idLineaPedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT de la tabla `resenas`
--
ALTER TABLE `resenas`
  MODIFY `idResena` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD CONSTRAINT `administrador_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_admin_taller` FOREIGN KEY (`idTaller`) REFERENCES `taller` (`idTaller`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idUsuario`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`idVehiculo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `cita_ibfk_3` FOREIGN KEY (`idMecanico`) REFERENCES `mecanico` (`idUsuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD CONSTRAINT `cotizacion_ibfk_1` FOREIGN KEY (`idCita`) REFERENCES `cita` (`idCita`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cotizacion_servicios`
--
ALTER TABLE `cotizacion_servicios`
  ADD CONSTRAINT `cotizacion_servicios_ibfk_1` FOREIGN KEY (`idCotizacion`) REFERENCES `cotizacion` (`idCotizacion`),
  ADD CONSTRAINT `cotizacion_servicios_ibfk_2` FOREIGN KEY (`idServicio`) REFERENCES `servicio` (`idServicio`);

--
-- Filtros para la tabla `evidencia`
--
ALTER TABLE `evidencia`
  ADD CONSTRAINT `evidencia_ibfk_1` FOREIGN KEY (`idCotizacion`) REFERENCES `cotizacion` (`idCotizacion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `iteminventario`
--
ALTER TABLE `iteminventario`
  ADD CONSTRAINT `iteminventario_ibfk_1` FOREIGN KEY (`idTaller`) REFERENCES `taller` (`idTaller`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `lineacotizacion`
--
ALTER TABLE `lineacotizacion`
  ADD CONSTRAINT `lineacotizacion_ibfk_1` FOREIGN KEY (`idCotizacion`) REFERENCES `cotizacion` (`idCotizacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lineacotizacion_ibfk_2` FOREIGN KEY (`idItemInventario`) REFERENCES `iteminventario` (`idItem`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `lineapedido`
--
ALTER TABLE `lineapedido`
  ADD CONSTRAINT `lineapedido_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idPedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lineapedido_ibfk_2` FOREIGN KEY (`idItemInventario`) REFERENCES `iteminventario` (`idItem`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `mecanico`
--
ALTER TABLE `mecanico`
  ADD CONSTRAINT `fk_mecanico_taller` FOREIGN KEY (`idTaller`) REFERENCES `taller` (`idTaller`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `mecanico_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idUsuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `resenas`
--
ALTER TABLE `resenas`
  ADD CONSTRAINT `fk_resena_taller` FOREIGN KEY (`idTaller`) REFERENCES `taller` (`idTaller`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_resena_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `cliente` (`idUsuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD CONSTRAINT `servicio_ibfk_1` FOREIGN KEY (`idTaller`) REFERENCES `taller` (`idTaller`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ticketsoporte`
--
ALTER TABLE `ticketsoporte`
  ADD CONSTRAINT `ticketsoporte_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idUsuario`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `ticketsoporte_ibfk_2` FOREIGN KEY (`idAdministrador`) REFERENCES `administrador` (`idUsuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `ticketsoporte_ibfk_3` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idPedido`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD CONSTRAINT `vehiculo_ibfk_1` FOREIGN KEY (`idDuenio`) REFERENCES `cliente` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
