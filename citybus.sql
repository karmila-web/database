-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 03 Jul 2019 pada 17.42
-- Versi server: 10.1.38-MariaDB
-- Versi PHP: 7.1.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `citybus`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `bus`
--

CREATE TABLE `bus` (
  `nobus` varchar(10) NOT NULL,
  `namasupir` varchar(25) DEFAULT NULL,
  `rute` varchar(50) DEFAULT NULL,
  `classbus` varchar(25) DEFAULT NULL,
  `hargatiket` decimal(15,0) DEFAULT NULL,
  `jmlseats` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `detailtiket`
--

CREATE TABLE `detailtiket` (
  `notiket` varchar(10) DEFAULT NULL,
  `nobus` varchar(10) DEFAULT NULL,
  `noseats` varchar(10) DEFAULT NULL,
  `hargatiket` decimal(15,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `keberangkatan`
--

CREATE TABLE `keberangkatan` (
  `kodekeberangkatan` varchar(10) NOT NULL,
  `hariberangkat` varchar(25) DEFAULT NULL,
  `tanggalberangkat` datetime(6) DEFAULT NULL,
  `waktuberangkat` datetime(6) DEFAULT NULL,
  `waktukumpul` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `login`
--

CREATE TABLE `login` (
  `username` varchar(25) NOT NULL,
  `kodepetugas` varchar(10) DEFAULT NULL,
  `userpassword` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran`
--

CREATE TABLE `pembayaran` (
  `nobayar` varchar(10) NOT NULL,
  `tanggalbayar` datetime(6) DEFAULT NULL,
  `kodepetugas` varchar(10) DEFAULT NULL,
  `notiket` varchar(10) DEFAULT NULL,
  `gtotal` decimal(15,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penumpang`
--

CREATE TABLE `penumpang` (
  `kodekonsumen` varchar(10) NOT NULL,
  `hariberangkat` varchar(25) DEFAULT NULL,
  `tanggalberangkat` datetime(6) DEFAULT NULL,
  `waktuberangkat` datetime(6) DEFAULT NULL,
  `waktunkumpul` datetime(6) DEFAULT NULL,
  `nama` varchar(30) DEFAULT NULL,
  `usia` int(3) DEFAULT NULL,
  `notelp` int(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `petugastiket`
--

CREATE TABLE `petugastiket` (
  `kodepetugas` varchar(10) NOT NULL,
  `namapetugas` varchar(25) DEFAULT NULL,
  `jeniskelamin` varchar(25) DEFAULT NULL,
  `notelp` varchar(25) DEFAULT NULL,
  `namaagen` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tiket`
--

CREATE TABLE `tiket` (
  `notiket` varchar(10) NOT NULL,
  `tgltiket` datetime(6) DEFAULT NULL,
  `kodekonsumen` varchar(10) DEFAULT NULL,
  `kodepetugas` varchar(10) DEFAULT NULL,
  `kodekeberangkatan` varchar(10) DEFAULT NULL,
  `gtotal` decimal(15,0) DEFAULT NULL,
  `keterangan` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bus`
--
ALTER TABLE `bus`
  ADD PRIMARY KEY (`nobus`);

--
-- Indeks untuk tabel `detailtiket`
--
ALTER TABLE `detailtiket`
  ADD KEY `nobus` (`nobus`),
  ADD KEY `notiket` (`notiket`);

--
-- Indeks untuk tabel `keberangkatan`
--
ALTER TABLE `keberangkatan`
  ADD PRIMARY KEY (`kodekeberangkatan`);

--
-- Indeks untuk tabel `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`username`),
  ADD KEY `kodepetugas` (`kodepetugas`);

--
-- Indeks untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`nobayar`),
  ADD KEY `notiket` (`notiket`);

--
-- Indeks untuk tabel `penumpang`
--
ALTER TABLE `penumpang`
  ADD PRIMARY KEY (`kodekonsumen`);

--
-- Indeks untuk tabel `petugastiket`
--
ALTER TABLE `petugastiket`
  ADD PRIMARY KEY (`kodepetugas`);

--
-- Indeks untuk tabel `tiket`
--
ALTER TABLE `tiket`
  ADD PRIMARY KEY (`notiket`),
  ADD KEY `kodekonsumen` (`kodekonsumen`),
  ADD KEY `kodepetugas` (`kodepetugas`),
  ADD KEY `kodekeberangkatan` (`kodekeberangkatan`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `detailtiket`
--
ALTER TABLE `detailtiket`
  ADD CONSTRAINT `detailtiket_ibfk_1` FOREIGN KEY (`nobus`) REFERENCES `bus` (`nobus`),
  ADD CONSTRAINT `detailtiket_ibfk_2` FOREIGN KEY (`notiket`) REFERENCES `tiket` (`notiket`);

--
-- Ketidakleluasaan untuk tabel `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `login_ibfk_1` FOREIGN KEY (`kodepetugas`) REFERENCES `petugastiket` (`kodepetugas`);

--
-- Ketidakleluasaan untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`notiket`) REFERENCES `tiket` (`notiket`);

--
-- Ketidakleluasaan untuk tabel `tiket`
--
ALTER TABLE `tiket`
  ADD CONSTRAINT `tiket_ibfk_1` FOREIGN KEY (`kodekonsumen`) REFERENCES `penumpang` (`kodekonsumen`),
  ADD CONSTRAINT `tiket_ibfk_2` FOREIGN KEY (`kodepetugas`) REFERENCES `petugastiket` (`kodepetugas`),
  ADD CONSTRAINT `tiket_ibfk_3` FOREIGN KEY (`kodekeberangkatan`) REFERENCES `keberangkatan` (`kodekeberangkatan`),
  ADD CONSTRAINT `tiket_ibfk_4` FOREIGN KEY (`kodekeberangkatan`) REFERENCES `keberangkatan` (`kodekeberangkatan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
