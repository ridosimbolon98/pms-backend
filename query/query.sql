-- Table: sc_trx.projectmst

-- DROP TABLE IF EXISTS sc_trx.projectmst;

CREATE TABLE IF NOT EXISTS sc_trx.projectmst
(
    projectid character(12) COLLATE pg_catalog."default" NOT NULL,
    projectname character(50) COLLATE pg_catalog."default" NOT NULL,
    description character varying(150) COLLATE pg_catalog."default",
    bagdept character varying(10) COLLATE pg_catalog."default",
    subbagdept character(10) COLLATE pg_catalog."default",
    pic character varying(20) COLLATE pg_catalog."default",
	location character varying(20) COLLATE pg_catalog."default",
    ttlitem numeric(10,0),
	ttlbobot numeric(10,0),
    startproj  date,
    endproj  date,
	status character varying(1) COLLATE pg_catalog."default",
    inputby character varying(20) COLLATE pg_catalog."default",
    inputdate timestamp without time zone,
	CONSTRAINT projectmst_pkey PRIMARY KEY (projectid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sc_trx.projectmst
    OWNER to postgres;

-- Table: sc_trx.projectdtl

-- DROP TABLE IF EXISTS sc_trx.projectdtl;

CREATE TABLE IF NOT EXISTS sc_trx.projectdtl
(
    projectid character(12) COLLATE pg_catalog."default" NOT NULL,
	nourut numeric(10,0),
	dtlprojectname character(50) COLLATE pg_catalog."default" NOT NULL,
	bobot numeric(10,0),
    bagdept character varying(10) COLLATE pg_catalog."default",
    subbagdept character(10) COLLATE pg_catalog."default",
    pic character varying(20) COLLATE pg_catalog."default",
    startproj  date,
    endproj  date,
	status character varying(1) COLLATE pg_catalog."default",
    inputby character varying(20) COLLATE pg_catalog."default",
    inputdate timestamp without time zone,
	CONSTRAINT projectdtl_pkey PRIMARY KEY (projectid,nourut)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS sc_trx.projectdtl
    OWNER to postgres;
	
--========== Insert data ==================

insert into sc_trx.projectdtl values
('PRJ22080001','1','MEMBUAT ALUR DAN KONSEP SYSTEM',10,'QIT','IT','IKHWAN','2022-08-01','2022-08-02','I','IKHWAN',now()),
('PRJ22080001','2','ANALISA KEBUTUHAN DATA',5,'QIT','IT','IKHWAN','2022-08-03','2022-08-05','I','IKHWAN',now()),
('PRJ22080001','3','PENGUMPULAN DATA',5,'QIT','IT','IKHWAN','2022-08-06','2022-08-09','I','IKHWAN',now()),
('PRJ22080001','4','SIMULASI INSERT DATA BY QUERY',10,'QIT','IT','IKHWAN','2022-08-10','2022-08-12','I','IKHWAN',now()),
('PRJ22080001','5','DESAIN & DEVELOP SYSTEM',50,'QIT','IT','IKHWAN','2022-08-13','2022-08-15','I','IKHWAN',now()),
('PRJ22080001','6','TRIAL ERROR',10,'QIT','IT','IKHWAN','2022-08-16','2022-08-19','I','IKHWAN',now()),
('PRJ22080001','7','IMPLEMENTASI',10,'QIT','IT','IKHWAN','2022-08-20','2022-08-30','I','IKHWAN',now());
select * from sc_trx.projectdtl;

insert into sc_trx.projectmst values
('PRJ22080001','SYSTEM PALET','SYSTEM PALET ALL BAGIAN','QIT','IT','IKHWAN','FINISHING LINE',
(select count(nourut) from sc_trx.projectdtl where projectid='PRJ22080001'),
 (select sum(bobot) from sc_trx.projectdtl where projectid='PRJ22080001'),
(select min(startproj) from sc_trx.projectdtl where projectid='PRJ22080001'),
(select max(endproj) from sc_trx.projectdtl where projectid='PRJ22080001'),
 'I','IKHWAN',now());
select * from sc_trx.projectmst;