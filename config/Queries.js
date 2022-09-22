/**
 * ==========================================================
 * +  List Query yang digunakan untuk koneksi ke database   +
 * ==========================================================
 * @author Rido Martupa Simbolon
 * IT NBI SMG
 */

import pkg from 'pg';
const { Pool } = pkg;
import dotenv from "dotenv";
dotenv.config();

 // konfigurasi manual koneksi ke database
const pool = new Pool({
  user: process.env.DB_USERNAME,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASS,
  port: process.env.DB_PORT
});

export default pool;



