--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 13.4

-- Started on 2023-02-09 14:35:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 25 (class 2615 OID 42447)
-- Name: sc_pms; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sc_pms;


ALTER SCHEMA sc_pms OWNER TO postgres;

--
-- TOC entry 536 (class 1255 OID 42912)
-- Name: insertSubtaskNotif(character varying, character varying, character varying, character varying, timestamp with time zone, timestamp with time zone, character varying, character varying, text, text, character varying, character varying, boolean, timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: sc_pms; Owner: postgres
--

CREATE FUNCTION sc_pms."insertSubtaskNotif"(subtaskid character varying, taskid character varying, subtask_name character varying, pic character varying, "createdAt" timestamp with time zone, "updatedAt" timestamp with time zone, id character varying, description character varying, taskfrom text, taskto text, trxtype character varying, foreignid character varying, read_status boolean, createdat timestamp with time zone, updatedat timestamp with time zone) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$BEGIN
    INSERT INTO sc_pms.sub_task(subtaskid, taskid, subtask_name, pic, "createdAt", "updatedAt") 
    VALUES($1,$2,$3,$4,$5,$6);
    INSERT INTO sc_pms.notifications(id, description, taskfrom, taskto, trxtype, foreignid, read_status, "createdAt", "updatedAt")
    VALUES($7,$8,$9,$10,$11,$12,$13,$14,$15);
    RETURN true;
END;$_$;


ALTER FUNCTION sc_pms."insertSubtaskNotif"(subtaskid character varying, taskid character varying, subtask_name character varying, pic character varying, "createdAt" timestamp with time zone, "updatedAt" timestamp with time zone, id character varying, description character varying, taskfrom text, taskto text, trxtype character varying, foreignid character varying, read_status boolean, createdat timestamp with time zone, updatedat timestamp with time zone) OWNER TO postgres;

--
-- TOC entry 3199 (class 0 OID 0)
-- Dependencies: 536
-- Name: FUNCTION "insertSubtaskNotif"(subtaskid character varying, taskid character varying, subtask_name character varying, pic character varying, "createdAt" timestamp with time zone, "updatedAt" timestamp with time zone, id character varying, description character varying, taskfrom text, taskto text, trxtype character varying, foreignid character varying, read_status boolean, createdat timestamp with time zone, updatedat timestamp with time zone); Type: COMMENT; Schema: sc_pms; Owner: postgres
--

COMMENT ON FUNCTION sc_pms."insertSubtaskNotif"(subtaskid character varying, taskid character varying, subtask_name character varying, pic character varying, "createdAt" timestamp with time zone, "updatedAt" timestamp with time zone, id character varying, description character varying, taskfrom text, taskto text, trxtype character varying, foreignid character varying, read_status boolean, createdat timestamp with time zone, updatedat timestamp with time zone) IS 'insert subtask dan notif task';


SET default_tablespace = '';

--
-- TOC entry 494 (class 1259 OID 42898)
-- Name: notifications; Type: TABLE; Schema: sc_pms; Owner: postgres
--

CREATE TABLE sc_pms.notifications (
    id character varying(20) NOT NULL,
    description character varying(200) NOT NULL,
    taskfrom text NOT NULL,
    taskto text NOT NULL,
    trxtype character varying(100) NOT NULL,
    foreignid character varying(20),
    read_status boolean NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE sc_pms.notifications OWNER TO postgres;

--
-- TOC entry 491 (class 1259 OID 42569)
-- Name: project; Type: TABLE; Schema: sc_pms; Owner: postgres
--

CREATE TABLE sc_pms.project (
    id integer NOT NULL,
    projectid character varying(255) NOT NULL,
    projectname character varying(255) NOT NULL,
    description character varying(1000) NOT NULL,
    bagdept character varying(255) NOT NULL,
    subbagdept character varying(255) NOT NULL,
    pic text NOT NULL,
    location text NOT NULL,
    ttlitem integer NOT NULL,
    ttlbobot integer NOT NULL,
    startproj date NOT NULL,
    endproj date NOT NULL,
    status character varying(255) NOT NULL,
    inputby character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE sc_pms.project OWNER TO postgres;

--
-- TOC entry 490 (class 1259 OID 42567)
-- Name: project_id_seq; Type: SEQUENCE; Schema: sc_pms; Owner: postgres
--

CREATE SEQUENCE sc_pms.project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sc_pms.project_id_seq OWNER TO postgres;

--
-- TOC entry 3200 (class 0 OID 0)
-- Dependencies: 490
-- Name: project_id_seq; Type: SEQUENCE OWNED BY; Schema: sc_pms; Owner: postgres
--

ALTER SEQUENCE sc_pms.project_id_seq OWNED BY sc_pms.project.id;


--
-- TOC entry 489 (class 1259 OID 42561)
-- Name: sub_task; Type: TABLE; Schema: sc_pms; Owner: postgres
--

CREATE TABLE sc_pms.sub_task (
    id integer NOT NULL,
    subtaskid character varying(20) NOT NULL,
    taskid character varying(20) NOT NULL,
    subtask_name character varying(1000) NOT NULL,
    pic character varying(20),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE sc_pms.sub_task OWNER TO postgres;

--
-- TOC entry 488 (class 1259 OID 42559)
-- Name: sub_task_id_seq; Type: SEQUENCE; Schema: sc_pms; Owner: postgres
--

CREATE SEQUENCE sc_pms.sub_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sc_pms.sub_task_id_seq OWNER TO postgres;

--
-- TOC entry 3201 (class 0 OID 0)
-- Dependencies: 488
-- Name: sub_task_id_seq; Type: SEQUENCE OWNED BY; Schema: sc_pms; Owner: postgres
--

ALTER SEQUENCE sc_pms.sub_task_id_seq OWNED BY sc_pms.sub_task.id;


--
-- TOC entry 493 (class 1259 OID 42746)
-- Name: task; Type: TABLE; Schema: sc_pms; Owner: postgres
--

CREATE TABLE sc_pms.task (
    id integer NOT NULL,
    taskid character varying(20) NOT NULL,
    projectid character varying(20) NOT NULL,
    task_name character varying(50) NOT NULL,
    progress character varying(5),
    bobot character varying(5),
    pic character varying(20),
    due_date date,
    t_status boolean,
    startdate date,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE sc_pms.task OWNER TO postgres;

--
-- TOC entry 492 (class 1259 OID 42744)
-- Name: task_id_seq; Type: SEQUENCE; Schema: sc_pms; Owner: postgres
--

CREATE SEQUENCE sc_pms.task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sc_pms.task_id_seq OWNER TO postgres;

--
-- TOC entry 3202 (class 0 OID 0)
-- Dependencies: 492
-- Name: task_id_seq; Type: SEQUENCE OWNED BY; Schema: sc_pms; Owner: postgres
--

ALTER SEQUENCE sc_pms.task_id_seq OWNED BY sc_pms.task.id;


--
-- TOC entry 487 (class 1259 OID 42492)
-- Name: users; Type: TABLE; Schema: sc_pms; Owner: postgres
--

CREATE TABLE sc_pms.users (
    id integer NOT NULL,
    uuid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE sc_pms.users OWNER TO postgres;

--
-- TOC entry 486 (class 1259 OID 42490)
-- Name: users_id_seq; Type: SEQUENCE; Schema: sc_pms; Owner: postgres
--

CREATE SEQUENCE sc_pms.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sc_pms.users_id_seq OWNER TO postgres;

--
-- TOC entry 3203 (class 0 OID 0)
-- Dependencies: 486
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: sc_pms; Owner: postgres
--

ALTER SEQUENCE sc_pms.users_id_seq OWNED BY sc_pms.users.id;


--
-- TOC entry 3058 (class 2604 OID 42572)
-- Name: project id; Type: DEFAULT; Schema: sc_pms; Owner: postgres
--

ALTER TABLE ONLY sc_pms.project ALTER COLUMN id SET DEFAULT nextval('sc_pms.project_id_seq'::regclass);


--
-- TOC entry 3057 (class 2604 OID 42564)
-- Name: sub_task id; Type: DEFAULT; Schema: sc_pms; Owner: postgres
--

ALTER TABLE ONLY sc_pms.sub_task ALTER COLUMN id SET DEFAULT nextval('sc_pms.sub_task_id_seq'::regclass);


--
-- TOC entry 3059 (class 2604 OID 42749)
-- Name: task id; Type: DEFAULT; Schema: sc_pms; Owner: postgres
--

ALTER TABLE ONLY sc_pms.task ALTER COLUMN id SET DEFAULT nextval('sc_pms.task_id_seq'::regclass);


--
-- TOC entry 3056 (class 2604 OID 42495)
-- Name: users id; Type: DEFAULT; Schema: sc_pms; Owner: postgres
--

ALTER TABLE ONLY sc_pms.users ALTER COLUMN id SET DEFAULT nextval('sc_pms.users_id_seq'::regclass);


--
-- TOC entry 3193 (class 0 OID 42898)
-- Dependencies: 494
-- Data for Name: notifications; Type: TABLE DATA; Schema: sc_pms; Owner: postgres
--

COPY sc_pms.notifications (id, description, taskfrom, taskto, trxtype, foreignid, read_status, "createdAt", "updatedAt") FROM stdin;
ND16641647239925	New Task: SOSIALISASI. Project ID: 1664164723988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1664164723988	t	2022-09-26 10:58:43.992+07	2022-09-26 11:56:13+07
ND16641647239924	New Task: DEPLOYMENT. Project ID: 1664164723988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1664164723988	t	2022-09-26 10:58:43.992+07	2022-09-26 11:56:20+07
ND16641647239923	New Task: TESTING. Project ID: 1664164723988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1664164723988	t	2022-09-26 10:58:43.992+07	2022-09-26 11:56:26+07
ND16641647239922	New Task: IMPLEMENTASI. Project ID: 1664164723988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1664164723988	t	2022-09-26 10:58:43.992+07	2022-09-26 11:56:33+07
ND1664168056472	New Sub Task: Melakukan ujicoba fungsional sistem. Project ID: 1664164723988	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1664164723988	t	2022-09-26 11:54:16+07	2022-09-26 11:56:56+07
ND16641647239921	New Task: DESIGN. Project ID: 1664164723988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1664164723988	t	2022-09-26 10:58:43.992+07	2022-09-26 11:57:17+07
ND16641647239920	New Task: ANALYSIS. Project ID: 1664164723988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1664164723988	t	2022-09-26 10:58:43.992+07	2022-09-26 11:57:34+07
ND1664168123938	New Sub Task: Sosialisasi penggunaan sistem kepada user. Project ID: 1664164723988	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1664164723988	t	2022-09-26 11:55:23+07	2022-09-26 11:57:42+07
ND1664168101751	New Sub Task: Deploy source code program ke server live. Project ID: 1664164723988	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1664164723988	t	2022-09-26 11:55:01+07	2022-09-26 11:57:50+07
ND1664168077944	New Sub Task: Melakukan ujicoba sistem bersama user. Project ID: 1664164723988	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1664164723988	t	2022-09-26 11:54:37+07	2022-09-26 11:57:56+07
ND1664168035078	New Sub Task: Membuat database berdasarkan hasil design sebelumnya. Project ID: 1664164723988	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1664164723988	t	2022-09-26 11:53:55+07	2022-09-26 11:58:05+07
ND1664168012254	New Sub Task: Implementasi program. Project ID: 1664164723988	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1664164723988	t	2022-09-26 11:53:32+07	2022-09-26 11:58:13+07
ND1664167992727	New Sub Task: Design Database. Project ID: 1664164723988	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1664164723988	t	2022-09-26 11:53:12+07	2022-09-26 11:58:21+07
ND1664167978206	New Sub Task: Design UI dan Alur Proses. Project ID: 1664164723988	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1664164723988	t	2022-09-26 11:52:58+07	2022-09-26 11:58:28+07
ND1664164961305	New Sub Task: Membuat analisis terkait alur proses sistem. Project ID: 1664164723988	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1664164723988	t	2022-09-26 11:02:41+07	2022-09-26 11:58:36+07
ND1664164886152	New Sub Task: Diskusi dengan tim dokumen kontrol perihal kebutuhan sistem. Project ID: 1664164723988	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1664164723988	t	2022-09-26 11:01:26+07	2022-09-26 11:58:45+07
ND1664182595252	New Task: test. Project ID: 1664164723988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1664164723988	f	2022-09-26 15:56:35.252+07	2022-09-26 15:56:35.252+07
ND16657187693450	New Task: PERSIAPAN HARDWARE. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665718769331	f	2022-10-14 10:39:29.345+07	2022-10-14 10:39:29.345+07
ND16657187693451	New Task: PENGUMPULAN DATA. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665718769331	f	2022-10-14 10:39:29.345+07	2022-10-14 10:39:29.345+07
ND16657187693462	New Task: PEMBUATAN KONSEP. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665718769331	f	2022-10-14 10:39:29.346+07	2022-10-14 10:39:29.346+07
ND16657187693463	New Task: DEVELOPMENT. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	aeac8e47-b4e9-4121-bb3f-175b0d224aa4	New Task	1665718769331	f	2022-10-14 10:39:29.346+07	2022-10-14 10:39:29.346+07
ND16657187693464	New Task: SOSIALISASI. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	aeac8e47-b4e9-4121-bb3f-175b0d224aa4	New Task	1665718769331	f	2022-10-14 10:39:29.347+07	2022-10-14 10:39:29.347+07
ND16657187693475	New Task: TRIAL ERROR. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665718769331	f	2022-10-14 10:39:29.347+07	2022-10-14 10:39:29.347+07
ND16657187693476	New Task: IMPLEMENTASI. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665718769331	f	2022-10-14 10:39:29.347+07	2022-10-14 10:39:29.347+07
ND16657191379550	New Task: PENGUMPULAN DATA. Project ID: 1665719137946	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665719137946	f	2022-10-14 10:45:37.955+07	2022-10-14 10:45:37.955+07
ND16657191379551	New Task: KONSEP. Project ID: 1665719137946	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665719137946	f	2022-10-14 10:45:37.956+07	2022-10-14 10:45:37.956+07
ND16657191379562	New Task: DEVELOP. Project ID: 1665719137946	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	aeac8e47-b4e9-4121-bb3f-175b0d224aa4	New Task	1665719137946	f	2022-10-14 10:45:37.956+07	2022-10-14 10:45:37.956+07
ND16657191379563	New Task: PENGUJIAN. Project ID: 1665719137946	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1665719137946	f	2022-10-14 10:45:37.956+07	2022-10-14 10:45:37.956+07
ND16657191379574	New Task: SOSIALISASI. Project ID: 1665719137946	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665719137946	f	2022-10-14 10:45:37.957+07	2022-10-14 10:45:37.957+07
ND16657191379575	New Task: IMPLEMENTASI. Project ID: 1665719137946	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665719137946	f	2022-10-14 10:45:37.957+07	2022-10-14 10:45:37.957+07
ND16657194368690	New Task: PENGADAAN PERANGKAT. Project ID: 1665719436860	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	New Task	1665719436860	f	2022-10-14 10:50:36.869+07	2022-10-14 10:50:36.869+07
ND16657194368701	New Task: TARIK JARINGAN. Project ID: 1665719436860	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	New Task	1665719436860	f	2022-10-14 10:50:36.87+07	2022-10-14 10:50:36.87+07
ND16657194368702	New Task: INSTALASI CCTV. Project ID: 1665719436860	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	New Task	1665719436860	f	2022-10-14 10:50:36.87+07	2022-10-14 10:50:36.87+07
ND16657194368713	New Task: TRIAL ERROR. Project ID: 1665719436860	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665719436860	f	2022-10-14 10:50:36.871+07	2022-10-14 10:50:36.871+07
ND16657194368714	New Task: IMPLEMENTASI. Project ID: 1665719436860	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665719436860	f	2022-10-14 10:50:36.871+07	2022-10-14 10:50:36.871+07
ND16657197295650	New Task: PENGAJUAN BARANG. Project ID: 1665719729558	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665719729558	f	2022-10-14 10:55:29.565+07	2022-10-14 10:55:29.565+07
ND16657197295651	New Task: SETTING DAN INSTALASI. Project ID: 1665719729558	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	6b7ab1cc-5412-4051-b492-1bfef2405b1c	New Task	1665719729558	f	2022-10-14 10:55:29.565+07	2022-10-14 10:55:29.565+07
ND16657197295652	New Task: TRIAL ERROR. Project ID: 1665719729558	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665719729558	f	2022-10-14 10:55:29.565+07	2022-10-14 10:55:29.565+07
ND16657197295663	New Task: IMPLEMENTASI. Project ID: 1665719729558	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	6b7ab1cc-5412-4051-b492-1bfef2405b1c	New Task	1665719729558	f	2022-10-14 10:55:29.566+07	2022-10-14 10:55:29.566+07
ND16657200535840	New Task: PENGUMPULAN DATA. Project ID: 1665720053578	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665720053578	f	2022-10-14 11:00:53.584+07	2022-10-14 11:00:53.584+07
ND16657200535851	New Task: DESIGN ALUR. Project ID: 1665720053578	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665720053578	f	2022-10-14 11:00:53.585+07	2022-10-14 11:00:53.585+07
ND16657200535852	New Task: DEVELOPMENT. Project ID: 1665720053578	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	aeac8e47-b4e9-4121-bb3f-175b0d224aa4	New Task	1665720053578	f	2022-10-14 11:00:53.585+07	2022-10-14 11:00:53.585+07
ND16657200535853	New Task: TRIAL ERROR. Project ID: 1665720053578	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665720053578	f	2022-10-14 11:00:53.585+07	2022-10-14 11:00:53.585+07
ND16657200535864	New Task: DEPLOYMENT. Project ID: 1665720053578	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	aeac8e47-b4e9-4121-bb3f-175b0d224aa4	New Task	1665720053578	f	2022-10-14 11:00:53.586+07	2022-10-14 11:00:53.586+07
ND16657204780460	New Task: ANALSYS. Project ID: 1665720478037	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665720478037	f	2022-10-14 11:07:58.046+07	2022-10-14 11:07:58.046+07
ND16657204780461	New Task: DESIGN. Project ID: 1665720478037	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1665720478037	f	2022-10-14 11:07:58.046+07	2022-10-14 11:07:58.046+07
ND16657204780472	New Task: DEVELOPMENT. Project ID: 1665720478037	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1665720478037	f	2022-10-14 11:07:58.047+07	2022-10-14 11:07:58.047+07
ND16657204780473	New Task: PENGUJIAN SISTEM. Project ID: 1665720478037	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665720478037	f	2022-10-14 11:07:58.047+07	2022-10-14 11:07:58.047+07
ND16657204780474	New Task: SOSIALISASI. Project ID: 1665720478037	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665720478037	f	2022-10-14 11:07:58.047+07	2022-10-14 11:07:58.047+07
ND16657204780485	New Task: DEPLOYMENT. Project ID: 1665720478037	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1665720478037	f	2022-10-14 11:07:58.048+07	2022-10-14 11:07:58.048+07
ND1665720599902	New Task: Development. Project ID: 1665720478037	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665720478037	f	2022-10-14 11:09:59.902+07	2022-10-14 11:09:59.902+07
ND16657211430190	New Task: PEMBUATAN KONSEP. Project ID: 1665721143012	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1665721143012	f	2022-10-14 11:19:03.019+07	2022-10-14 11:19:03.019+07
ND16657211430201	New Task: DESIGN UI/UX. Project ID: 1665721143012	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1665721143012	f	2022-10-14 11:19:03.02+07	2022-10-14 11:19:03.02+07
ND16657211430202	New Task: DESIGN ALUR. Project ID: 1665721143012	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665721143012	f	2022-10-14 11:19:03.02+07	2022-10-14 11:19:03.02+07
ND16657211430203	New Task: DEVELOPMENT. Project ID: 1665721143012	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1665721143012	f	2022-10-14 11:19:03.02+07	2022-10-14 11:19:03.02+07
ND16657211430214	New Task: TRIAL ERROR. Project ID: 1665721143012	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665721143012	f	2022-10-14 11:19:03.021+07	2022-10-14 11:19:03.021+07
ND16657211430215	New Task: DEPLOYMENT. Project ID: 1665721143012	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1665721143012	f	2022-10-14 11:19:03.021+07	2022-10-14 11:19:03.021+07
ND16657216471990	New Task: KONSEP. Project ID: 1665721647192	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	6b7ab1cc-5412-4051-b492-1bfef2405b1c	New Task	1665721647192	f	2022-10-14 11:27:27.199+07	2022-10-14 11:27:27.199+07
ND16657216472001	New Task: DEVELOPMENT. Project ID: 1665721647192	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	aeac8e47-b4e9-4121-bb3f-175b0d224aa4	New Task	1665721647192	f	2022-10-14 11:27:27.2+07	2022-10-14 11:27:27.2+07
ND16657216472002	New Task: TRIAL ERROR. Project ID: 1665721647192	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665721647192	f	2022-10-14 11:27:27.2+07	2022-10-14 11:27:27.2+07
ND1665721689449	New Task: sosialisasi. Project ID: 1665721647192	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	6b7ab1cc-5412-4051-b492-1bfef2405b1c	New Task	1665721647192	f	2022-10-14 11:28:09.449+07	2022-10-14 11:28:09.449+07
ND1665721719878	New Task: Deployment. Project ID: 1665721647192	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665721647192	f	2022-10-14 11:28:39.878+07	2022-10-14 11:28:39.878+07
ND16657230956950	New Task: PENGUMPULAN DATA. Project ID: 1665723095688	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1665723095688	f	2022-10-14 11:51:35.695+07	2022-10-14 11:51:35.695+07
ND16657230956951	New Task: DESIGN DAN ANALISA. Project ID: 1665723095688	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665723095688	f	2022-10-14 11:51:35.695+07	2022-10-14 11:51:35.695+07
ND16657230956952	New Task: DEVELOPMENT. Project ID: 1665723095688	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	aeac8e47-b4e9-4121-bb3f-175b0d224aa4	New Task	1665723095688	f	2022-10-14 11:51:35.695+07	2022-10-14 11:51:35.695+07
ND1665729979319	New Sub Task: Membuat Design Model ERD. Project ID: 1665723095688	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665723095688	f	2022-10-14 13:46:19+07	2022-10-14 13:46:19+07
ND1665731616542	New Sub Task: Diskusi terkait kebutuhan sistem. Project ID: 1665723095688	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665723095688	f	2022-10-14 14:13:36+07	2022-10-14 14:13:36+07
ND1665732260232	New Sub Task: Membuat design alur dan UI SIVENIT. Project ID: 1665720478037	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665720478037	f	2022-10-14 14:24:20+07	2022-10-14 14:24:20+07
ND1665732289508	New Sub Task: Perbaiki alur dan UI berdasarkan kebutuhan sistem. Project ID: 1665720478037	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665720478037	f	2022-10-14 14:24:49+07	2022-10-14 14:24:49+07
ND1665732383191	New Sub Task: implementasi program frontend. Project ID: 1665720478037	0547c3e9-7ca7-4770-ad80-4bd43449fc34	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665720478037	f	2022-10-14 14:26:23+07	2022-10-14 14:26:23+07
ND1665732414240	New Sub Task: Implementasi program backend serta konfigurasi dengan database. Project ID: 1665720478037	0547c3e9-7ca7-4770-ad80-4bd43449fc34	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665720478037	f	2022-10-14 14:26:54+07	2022-10-14 14:26:54+07
ND1665732440754	New Sub Task: Diskusi bersama terkait alur proses sistem. Project ID: 1665720478037	0547c3e9-7ca7-4770-ad80-4bd43449fc34	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665720478037	f	2022-10-14 14:27:20+07	2022-10-14 14:27:20+07
ND1665732464309	New Sub Task: Membuat alur proses berdasarkan hasil analisa sebelumnya. Project ID: 1665720478037	0547c3e9-7ca7-4770-ad80-4bd43449fc34	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665720478037	f	2022-10-14 14:27:44+07	2022-10-14 14:27:44+07
ND1665732521276	New Sub Task: Melakukan ujicoba pertama terkait fungsionalitas sistem. Project ID: 1665720478037	0547c3e9-7ca7-4770-ad80-4bd43449fc34	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665720478037	f	2022-10-14 14:28:41+07	2022-10-14 14:28:41+07
ND1665732540360	New Sub Task: Melakukan ujicoba di sisi user. Project ID: 1665720478037	0547c3e9-7ca7-4770-ad80-4bd43449fc34	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	New Sub Task	1665720478037	f	2022-10-14 14:29:00+07	2022-10-14 14:29:00+07
ND1665732560593	New Sub Task: Sosialisasi bersama user. Project ID: 1665720478037	0547c3e9-7ca7-4770-ad80-4bd43449fc34	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665720478037	f	2022-10-14 14:29:20+07	2022-10-14 14:29:20+07
ND1665732590205	New Sub Task: Perbaikan bug atas hasil ujicoba. Project ID: 1665720478037	0547c3e9-7ca7-4770-ad80-4bd43449fc34	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665720478037	f	2022-10-14 14:29:50+07	2022-10-14 14:29:50+07
ND1665732625699	New Sub Task: Deployment source code dan skema basis data ke server live. Project ID: 1665720478037	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665720478037	f	2022-10-14 14:30:25+07	2022-10-14 14:30:25+07
ND1665732670372	New Sub Task: Diskusi bersama PIC (Ikhwan) terkait kebutuhan sistem manajemen proyek. Project ID: 1665721143012	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665721143012	f	2022-10-14 14:31:10+07	2022-10-14 14:31:10+07
ND1665732701517	New Sub Task: Pembuatan konsep sederhana berdasarkan hasil diskusi dengan stakeholder sebelumnya. Project ID: 1665721143012	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665721143012	f	2022-10-14 14:31:41+07	2022-10-14 14:31:41+07
ND1665732736139	New Sub Task: Membuat diagram flow berdasarkan hasil analisa. Project ID: 1665721143012	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665721143012	f	2022-10-14 14:32:16+07	2022-10-14 14:32:16+07
ND1665732765383	New Sub Task: Membuat design skema database berdasarkan alur proses sebelumnya. Project ID: 1665721143012	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665721143012	f	2022-10-14 14:32:45+07	2022-10-14 14:32:45+07
ND1665732799787	New Sub Task: Membuat design user interface atau antarmuka sistem. Project ID: 1665721143012	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665721143012	f	2022-10-14 14:33:19+07	2022-10-14 14:33:19+07
ND1665732832250	New Sub Task: Perbaikan design user interface berdasarkan hasil diskusi dengan stakeholder. Project ID: 1665721143012	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665721143012	f	2022-10-14 14:33:52+07	2022-10-14 14:33:52+07
ND1665732918336	New Sub Task: Implementasi pragram frontend berdasarkan hasil design user interface sebelumnya menggunakan library React JS , Bootstrap dan CSS. Project ID: 1665721143012	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665721143012	f	2022-10-14 14:35:18+07	2022-10-14 14:35:18+07
ND1665733120802	New Sub Task: Implementasi program backend menggunakan framework Node JS (Express JS) berdasarkan hasil analisa dan design alur sebelumnya. Project ID: 1665721143012	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665721143012	f	2022-10-14 14:38:40+07	2022-10-14 14:38:40+07
ND1665733154880	New Sub Task: Perbaikan bug tidak bisa submit New Task. Project ID: 1665721143012	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665721143012	f	2022-10-14 14:39:14+07	2022-10-14 14:39:14+07
ND1665733203652	New Sub Task: Build project menggunakan PM2 service management. Project ID: 1665721143012	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665721143012	f	2022-10-14 14:40:03+07	2022-10-14 14:40:03+07
ND1665733232930	New Sub Task: Deployment source code yang sudah di build sebelumnya ke server live. Project ID: 1665721143012	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665721143012	f	2022-10-14 14:40:32+07	2022-10-14 14:40:32+07
ND1665733262203	New Sub Task: Melakukan konfigurasi database di server live. Project ID: 1665721143012	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665721143012	f	2022-10-14 14:41:02+07	2022-10-14 14:41:02+07
ND1665733663755	New Sub Task: Pengembangan scanner QR code inventaris web base responsive. Project ID: 1665720478037	0547c3e9-7ca7-4770-ad80-4bd43449fc34	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665720478037	f	2022-10-14 14:47:43+07	2022-10-14 14:47:43+07
ND16657354320150	New Task: KONSEP. Project ID: 1665735431998	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665735431998	f	2022-10-14 15:17:12.016+07	2022-10-14 15:17:12.016+07
ND1665735461849	New Sub Task: Pembuatan konsep dashboard. Project ID: 1665735431998	0547c3e9-7ca7-4770-ad80-4bd43449fc34	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665735431998	f	2022-10-14 15:17:41+07	2022-10-14 15:17:41+07
ND1665735549314	New Sub Task: Trial aplikasi mulai dari create SJ hingga selesai. Project ID: 1665721647192	0547c3e9-7ca7-4770-ad80-4bd43449fc34	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665721647192	f	2022-10-14 15:19:09+07	2022-10-14 15:19:09+07
ND1665735575489	New Sub Task: Trial bersama IT SBY, GPJ dan Tim Karlo ke distributor. Project ID: 1665721647192	0547c3e9-7ca7-4770-ad80-4bd43449fc34	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665721647192	f	2022-10-14 15:19:35+07	2022-10-14 15:19:35+07
ND1668072515100	New Sub Task: implentasi ke gudang internal NBI. Project ID: 1665721647192	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665721647192	f	2022-11-10 16:28:35+07	2022-11-10 16:28:35+07
ND1668072581835	New Sub Task: perluasan ke transporter lain. Project ID: 1665721647192	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665721647192	f	2022-11-10 16:29:41+07	2022-11-10 16:29:41+07
ND1668072665497	New Sub Task: pengajuan genset revisi UPS 6000VA. Project ID: 1665719729558	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665719729558	f	2022-11-10 16:31:05+07	2022-11-10 16:31:05+07
ND16681372293120	New Task: PEMBUATAN MODUL. Project ID: 1668137229305	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1668137229305	f	2022-11-11 10:27:09.312+07	2022-11-11 10:27:09.312+07
ND1668137261280	New Task: DEPLOYMENT. Project ID: 1668137229305	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1668137229305	f	2022-11-11 10:27:41.28+07	2022-11-11 10:27:41.28+07
ND1668154086314	New Task: COBA. Project ID: 1668137229305	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1668137229305	f	2022-11-11 15:08:06.314+07	2022-11-11 15:08:06.314+07
ND1668154399868	New Task: ASD. Project ID: 1668137229305	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1668137229305	f	2022-11-11 15:13:19.869+07	2022-11-11 15:13:19.869+07
ND1668154413719	New Sub Task: werwerw. Project ID: 1668137229305	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1668137229305	f	2022-11-11 15:13:33+07	2022-11-11 15:13:33+07
ND1668155300725	New Sub Task: sudah di lakukan pengumpulan data dari tahun 2018. Project ID: 1665719137946	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665719137946	f	2022-11-11 15:28:20+07	2022-11-11 15:28:20+07
ND1668156462591	New Sub Task: konsep input master dan komponen by system ( trial mengalami kesulitan )\n. Project ID: 1665719137946	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665719137946	f	2022-11-11 15:47:42+07	2022-11-11 15:47:42+07
ND1668156526528	New Sub Task: konsep import file master format KPI excel ( terlalu sering perbahan sampai sub terkecil ) sehingga admin kesulitan mengikutinya. Project ID: 1665719137946	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665719137946	f	2022-11-11 15:48:46+07	2022-11-11 15:48:46+07
ND1668156554385	New Sub Task: sudah di lakukan 2 develope konsep. Project ID: 1665719137946	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665719137946	f	2022-11-11 15:49:14+07	2022-11-11 15:49:14+07
ND1668156747091	New Sub Task: sudah di lakukan trial error 2 konsep perubahan. Project ID: 1665719137946	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	6b7ab1cc-5412-4051-b492-1bfef2405b1c	New Sub Task	1665719137946	f	2022-11-11 15:52:27+07	2022-11-11 15:52:27+07
ND1668157202373	New Task: MIXING. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665718769331	f	2022-11-11 16:00:02.373+07	2022-11-11 16:00:02.373+07
ND1668157237623	New Task: BALLMIL. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665718769331	f	2022-11-11 16:00:37.623+07	2022-11-11 16:00:37.623+07
ND1668157268597	New Task: CUTTING. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665718769331	f	2022-11-11 16:01:08.597+07	2022-11-11 16:01:08.597+07
ND1668157317655	New Sub Task: PENGUMPULAN DATA. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665718769331	f	2022-11-11 16:01:57+07	2022-11-11 16:01:57+07
ND1668157334040	New Sub Task: KONSEP. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665718769331	f	2022-11-11 16:02:13+07	2022-11-11 16:02:13+07
ND1668157357408	New Sub Task: DEVELOPE. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665718769331	f	2022-11-11 16:02:37+07	2022-11-11 16:02:37+07
ND1668157371905	New Sub Task: TRIAL ERROR. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665718769331	f	2022-11-11 16:02:51+07	2022-11-11 16:02:51+07
ND1668157385595	New Sub Task: IMPLEMENTASI. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665718769331	f	2022-11-11 16:03:05+07	2022-11-11 16:03:05+07
ND1668157435708	New Task: AUTOCLAVE. Project ID: 1665718769331	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665718769331	f	2022-11-11 16:03:55.709+07	2022-11-11 16:03:55.709+07
ND1668157498581	New Sub Task: TRIAL ERROR. Project ID: 1665735431998	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1665735431998	f	2022-11-11 16:04:58+07	2022-11-11 16:04:58+07
ND1668157555472	New Task: PENGUMPULAN DATA. Project ID: 1665735431998	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665735431998	f	2022-11-11 16:05:55.472+07	2022-11-11 16:05:55.472+07
ND1668157614933	New Task: DEVELOPE. Project ID: 1665735431998	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665735431998	f	2022-11-11 16:06:54.933+07	2022-11-11 16:06:54.933+07
ND1668157652609	New Task: TRIAL ERROR. Project ID: 1665735431998	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665735431998	f	2022-11-11 16:07:32.61+07	2022-11-11 16:07:32.61+07
ND1668157697481	New Task: IMPLENTASI. Project ID: 1665735431998	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1665735431998	f	2022-11-11 16:08:17.481+07	2022-11-11 16:08:17.481+07
ND1671091557137	New Sub Task: Perbaikan master data employee, position dan jobarea pada sistem KPI terbaru 2022. Project ID: 1665719137946	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665719137946	f	2022-12-15 15:05:57+07	2022-12-15 15:05:57+07
ND16715108620650	New Task: GENESIS. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671510861987	f	2022-12-20 11:34:22.066+07	2022-12-20 11:34:22.066+07
ND16715108620661	New Task: ANALISIS. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671510861987	f	2022-12-20 11:34:22.067+07	2022-12-20 11:34:22.067+07
ND16715108620672	New Task: DESIGN. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671510861987	f	2022-12-20 11:34:22.067+07	2022-12-20 11:34:22.067+07
ND16715108620684	New Task: TESTING. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671510861987	f	2022-12-20 11:34:22.068+07	2022-12-20 11:34:22.068+07
ND16715108620673	New Task: IMPLEMENTASI. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671510861987	f	2022-12-20 11:34:22.067+07	2022-12-20 11:34:22.067+07
ND1671510943248	New Sub Task: Diskusi bersama dengan bagian QMS untuk menentukan konsep awal dalam pengembangan sistem. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:35:43+07	2022-12-20 11:35:43+07
ND1671510973987	New Sub Task: Menentukan batas-batas serta ruang lingkup sistem. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:36:13+07	2022-12-20 11:36:13+07
ND1671511016715	New Sub Task: Melakukan analisa SRS (System Requirement Spesification). Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:36:56+07	2022-12-20 11:36:56+07
ND1671511039937	New Sub Task: Membuat SRS berdasarkan kebutuhan user Auditor dan Auditie. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:37:19+07	2022-12-20 11:37:19+07
ND1671511089498	New Sub Task: Membuat desain alur berdasarkan hasil analisa sebelumnya. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:38:09+07	2022-12-20 11:38:09+07
ND1671511114818	New Sub Task: Membuat konsep skema basis data. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:38:34+07	2022-12-20 11:38:34+07
ND1671511133693	New Sub Task: Membuat desain interface sistem. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:38:53+07	2022-12-20 11:38:53+07
ND1671511172150	New Sub Task: Implementasi dari hasil desain ke bentuk program. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:39:32+07	2022-12-20 11:39:32+07
ND1671511202198	New Sub Task: Membuat basis data berdasarkan hasil desain skema basis data sebelumnya. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:40:02+07	2022-12-20 11:40:02+07
ND1671511234790	New Sub Task: Melakukan perbaikan berdasarkan hasil revisi dari tim audit 5R. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:40:34+07	2022-12-20 11:40:34+07
ND1671511269411	New Sub Task: Melakukan ujicoba per fungsi dari sistem. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:41:09+07	2022-12-20 11:41:09+07
ND1671511289716	New Sub Task: Melakukan ujicoba bersama tim audit 5R. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:41:29+07	2022-12-20 11:41:29+07
ND1671511321474	New Sub Task: Melakukan sosialisasi bersama user (Auditor dan Auditie). Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:42:01+07	2022-12-20 11:42:01+07
ND16715113391200	New Task: PENAWARAN VENDOR. Project ID: 1671511339112	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671511339112	f	2022-12-20 11:42:19.12+07	2022-12-20 11:42:19.12+07
ND16715113391211	New Task: PENGAJUAN. Project ID: 1671511339112	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671511339112	f	2022-12-20 11:42:19.121+07	2022-12-20 11:42:19.121+07
ND16715113391212	New Task: INSTALASI. Project ID: 1671511339112	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671511339112	f	2022-12-20 11:42:19.121+07	2022-12-20 11:42:19.121+07
ND1671511363171	New Task: DEPLOYMENT. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671510861987	f	2022-12-20 11:42:43.172+07	2022-12-20 11:42:43.172+07
ND1671511394244	New Sub Task: Deployment source code sistem ke server live. Project ID: 1671510861987	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671510861987	f	2022-12-20 11:43:14+07	2022-12-20 11:43:14+07
ND1671511485100	New Task: PENGEMBANGAN SISTEM. Project ID: 1665723095688	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1665723095688	f	2022-12-20 11:44:45.1+07	2022-12-20 11:44:45.1+07
ND1671511506377	New Sub Task: Membuat form input limbah. Project ID: 1665723095688	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665723095688	f	2022-12-20 11:45:06+07	2022-12-20 11:45:06+07
ND1671511532084	New Sub Task: Membuat fitur kelola data limbah. Project ID: 1665723095688	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665723095688	f	2022-12-20 11:45:32+07	2022-12-20 11:45:32+07
ND1671511553117	New Sub Task: Membuat fitur kelola master kategori limbah. Project ID: 1665723095688	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665723095688	f	2022-12-20 11:45:53+07	2022-12-20 11:45:53+07
ND1671511570056	New Sub Task: Membuat fitur transaksi limbah. Project ID: 1665723095688	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665723095688	f	2022-12-20 11:46:10+07	2022-12-20 11:46:10+07
ND1671511590750	New Sub Task: Membuat fitur report limbah. Project ID: 1665723095688	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665723095688	f	2022-12-20 11:46:30+07	2022-12-20 11:46:30+07
ND16715116849950	New Task: PENAWARAN. Project ID: 1671511684988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671511684988	f	2022-12-20 11:48:04.995+07	2022-12-20 11:48:04.995+07
ND16715116849951	New Task: INSTALASI. Project ID: 1671511684988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671511684988	f	2022-12-20 11:48:04.995+07	2022-12-20 11:48:04.995+07
ND16715116849952	New Task: IMPLEMENTASI. Project ID: 1671511684988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671511684988	f	2022-12-20 11:48:04.996+07	2022-12-20 11:48:04.996+07
ND1671511744816	New Sub Task: MENCARI LEBIH DARI 3 VENDOR . Project ID: 1671511684988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671511684988	f	2022-12-20 11:49:04+07	2022-12-20 11:49:04+07
ND1671511788194	New Sub Task: PENGAJUAN BEBERAPA KALI TIDAK DI ACC KARENA PERBANDINGAN HARGA. Project ID: 1671511684988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671511684988	f	2022-12-20 11:49:48+07	2022-12-20 11:49:48+07
ND1671511836365	New Sub Task: SETELAH MENDAPATKAN VENDOR DAN HARGA YG SESUAI DI ACC DGN VENDOR "AYU KONDANG". Project ID: 1671511684988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671511684988	f	2022-12-20 11:50:36+07	2022-12-20 11:50:36+07
ND1671511881854	New Sub Task: DARI VENDOR TEKNISI SURVEY LOKASI. Project ID: 1671511684988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671511684988	f	2022-12-20 11:51:21+07	2022-12-20 11:51:21+07
ND16715119162250	New Task: ANALISA ALUR. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671511916215	f	2022-12-20 11:51:56.225+07	2022-12-20 11:51:56.225+07
ND16715119162251	New Task: DESIGN SISTEM. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671511916215	f	2022-12-20 11:51:56.225+07	2022-12-20 11:51:56.225+07
ND16715119162252	New Task: PENGEMBANGAN SISTEM. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671511916215	f	2022-12-20 11:51:56.225+07	2022-12-20 11:51:56.225+07
ND16715119162263	New Task: UJICOBA SISTEM. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671511916215	f	2022-12-20 11:51:56.226+07	2022-12-20 11:51:56.226+07
ND1671511921384	New Sub Task: PROSES INSTALASI TERKENDALA PADA MEDAN PABRIK YG BERESIKO. Project ID: 1671511684988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671511684988	f	2022-12-20 11:52:01+07	2022-12-20 11:52:01+07
ND1671511953422	New Sub Task: Membuat alur proses sistem berdasarkan form excel sebelumnya. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671511916215	f	2022-12-20 11:52:33+07	2022-12-20 11:52:33+07
ND1671511985808	New Sub Task: Membuat desain sederhana dari UI dan database sistem. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671511916215	f	2022-12-20 11:53:05+07	2022-12-20 11:53:05+07
ND1671512012790	New Sub Task: Membuat karangka sistem. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671511916215	f	2022-12-20 11:53:32+07	2022-12-20 11:53:32+07
ND1671512037202	New Sub Task: Membuat fitur kelola data daily activity. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671511916215	f	2022-12-20 11:53:57+07	2022-12-20 11:53:57+07
ND1671512056245	New Sub Task: Membuat fitur kelola todo list. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671511916215	f	2022-12-20 11:54:16+07	2022-12-20 11:54:16+07
ND1671512087606	New Sub Task: Membuat fitur ubah password user. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671511916215	f	2022-12-20 11:54:47+07	2022-12-20 11:54:47+07
ND1671512105691	New Sub Task: Membuat fitur export data activity. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671511916215	f	2022-12-20 11:55:05+07	2022-12-20 11:55:05+07
ND1671512131717	New Sub Task: Melakukan ujicoba dengan karyawan bagian QA/IT. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671511916215	f	2022-12-20 11:55:31+07	2022-12-20 11:55:31+07
ND1671512139577	New Sub Task: PELATIHAN KE USER DAN SERAH TERIMA PROJECT. Project ID: 1671511684988	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671511684988	f	2022-12-20 11:55:39+07	2022-12-20 11:55:39+07
ND1671512161072	New Task: DEPLOYMENT. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671511916215	f	2022-12-20 11:56:01.072+07	2022-12-20 11:56:01.072+07
ND1671512181988	New Sub Task: Deploy sistem ke live server sehingga bisa digunakan langsung oleh user. Project ID: 1671511916215	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671511916215	f	2022-12-20 11:56:21+07	2022-12-20 11:56:21+07
ND1671512233368	New Sub Task: Perbaikan master data yang tidak sesuai. Project ID: 1665719137946	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1665719137946	f	2022-12-20 11:57:13+07	2022-12-20 11:57:13+07
ND16715123913030	New Task: ANALISA KEBUTUHAN. Project ID: 1671512391293	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671512391293	f	2022-12-20 11:59:51.304+07	2022-12-20 11:59:51.304+07
ND16715123913041	New Task: IMPLEMENTASI PROGRAM. Project ID: 1671512391293	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671512391293	f	2022-12-20 11:59:51.304+07	2022-12-20 11:59:51.304+07
ND16715123913042	New Task: UJICOBA PROGRAM. Project ID: 1671512391293	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671512391293	f	2022-12-20 11:59:51.304+07	2022-12-20 11:59:51.304+07
ND16715123913043	New Task: DEPLOYMENT. Project ID: 1671512391293	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671512391293	f	2022-12-20 11:59:51.305+07	2022-12-20 11:59:51.305+07
ND1671512424695	New Sub Task: Implementasi kedalam bentuk program. Project ID: 1671512391293	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671512391293	f	2022-12-20 12:00:24+07	2022-12-20 12:00:24+07
ND1671512445760	New Sub Task: Melakukan ujibcoba. Project ID: 1671512391293	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671512391293	f	2022-12-20 12:00:45+07	2022-12-20 12:00:45+07
ND1671512487104	New Sub Task: Melakukan deploy source code ke server live. Project ID: 1671512391293	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671512391293	f	2022-12-20 12:01:27+07	2022-12-20 12:01:27+07
ND16715129282920	New Task: PENAWARAN. Project ID: 1671512928282	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671512928282	f	2022-12-20 12:08:48.292+07	2022-12-20 12:08:48.292+07
ND16715129282921	New Task: PENGAJUAN. Project ID: 1671512928282	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671512928282	f	2022-12-20 12:08:48.292+07	2022-12-20 12:08:48.292+07
ND16715129282922	New Task: SETTING DAN INSTALASI. Project ID: 1671512928282	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671512928282	f	2022-12-20 12:08:48.292+07	2022-12-20 12:08:48.292+07
ND16715129282923	New Task: IMPLEMENTASI. Project ID: 1671512928282	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671512928282	f	2022-12-20 12:08:48.292+07	2022-12-20 12:08:48.292+07
ND16715134441390	New Task: PENAWARAN GENSET. Project ID: 1671513444122	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671513444122	f	2022-12-20 12:17:24.139+07	2022-12-20 12:17:24.139+07
ND16715134441391	New Task: PENAWARAN UPS 6000W. Project ID: 1671513444122	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671513444122	f	2022-12-20 12:17:24.139+07	2022-12-20 12:17:24.139+07
ND16715134441392	New Task: PENAGJUAN UPS 6000W. Project ID: 1671513444122	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671513444122	f	2022-12-20 12:17:24.14+07	2022-12-20 12:17:24.14+07
ND16715134441403	New Task: INSTALASI. Project ID: 1671513444122	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671513444122	f	2022-12-20 12:17:24.14+07	2022-12-20 12:17:24.14+07
ND1671513518064	New Sub Task: BEBERAPA KALI PENGAJUAN GENSET TIDAK DI ACC KARENA ADA BEBERAPA PERTIMBANGAN TEMPAT,INSTALASI DAN BIAYA. Project ID: 1671513444122	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671513444122	f	2022-12-20 12:18:38+07	2022-12-20 12:18:38+07
ND1671513568665	New Sub Task: AKHIR REKOMENDASI  DARI DIREKSI COBA UNTUK MENCARI PENAWARAN UPS DGN KAPASITAS SESUAI KEBUTUHAN. Project ID: 1671513444122	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671513444122	f	2022-12-20 12:19:28+07	2022-12-20 12:19:28+07
ND1671513600602	New Sub Task: ACC PENGAJUAN UPS 6000W EXT BAT. Project ID: 1671513444122	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671513444122	f	2022-12-20 12:20:00+07	2022-12-20 12:20:00+07
ND1671513681595	New Sub Task: INSTALASI DAN PEMBAGIAN POWER DI BAGI 2 REDUNDANCE A(UPS) DAN B(PLN) UNTUK KEBUTUHAN POWER SERV. Project ID: 1671513444122	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671513444122	f	2022-12-20 12:21:21+07	2022-12-20 12:21:21+07
ND16715142540660	New Task: ANALISA. Project ID: 1671514254059	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671514254059	f	2022-12-20 12:30:54.067+07	2022-12-20 12:30:54.067+07
ND16715142540671	New Task: PENGEMBANGAN. Project ID: 1671514254059	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671514254059	f	2022-12-20 12:30:54.067+07	2022-12-20 12:30:54.067+07
ND16715142540672	New Task: TRIAL ERROR. Project ID: 1671514254059	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671514254059	f	2022-12-20 12:30:54.067+07	2022-12-20 12:30:54.067+07
ND16715142540673	New Task: IMPLEMENTASI. Project ID: 1671514254059	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671514254059	f	2022-12-20 12:30:54.067+07	2022-12-20 12:30:54.067+07
ND16715147114490	New Task: ANALISA MASALAH. Project ID: 1671514711439	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671514711439	f	2022-12-20 12:38:31.449+07	2022-12-20 12:38:31.449+07
ND16715147114491	New Task: PENGUMPULAN DATA. Project ID: 1671514711439	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671514711439	f	2022-12-20 12:38:31.449+07	2022-12-20 12:38:31.449+07
ND16715147114492	New Task: PENGEMBANGAN APLIKASI. Project ID: 1671514711439	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671514711439	f	2022-12-20 12:38:31.449+07	2022-12-20 12:38:31.449+07
ND16715147114503	New Task: IMPEMENTASI. Project ID: 1671514711439	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671514711439	f	2022-12-20 12:38:31.45+07	2022-12-20 12:38:31.45+07
ND16715152451370	New Task: PENGADAAN. Project ID: 1671515245116	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671515245116	f	2022-12-20 12:47:25.137+07	2022-12-20 12:47:25.137+07
ND16715152451371	New Task: SETTING. Project ID: 1671515245116	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671515245116	f	2022-12-20 12:47:25.137+07	2022-12-20 12:47:25.137+07
ND16715152451382	New Task: REGISTRASI KARYAWAN. Project ID: 1671515245116	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671515245116	f	2022-12-20 12:47:25.138+07	2022-12-20 12:47:25.138+07
ND16715152451383	New Task: IMPLEMENTASI. Project ID: 1671515245116	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671515245116	f	2022-12-20 12:47:25.138+07	2022-12-20 12:47:25.138+07
ND16715158826750	New Task: ANALISA MASALAH. Project ID: 1671515882666	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671515882666	f	2022-12-20 12:58:02.675+07	2022-12-20 12:58:02.675+07
ND16715158826761	New Task: KEBUTUHAN PERANGKAT. Project ID: 1671515882666	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	New Task	1671515882666	f	2022-12-20 12:58:02.676+07	2022-12-20 12:58:02.676+07
ND16715158826762	New Task: PENGEMBANGAN. Project ID: 1671515882666	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671515882666	f	2022-12-20 12:58:02.676+07	2022-12-20 12:58:02.676+07
ND16715158826763	New Task: TRIAL DAN IMPLENTASI. Project ID: 1671515882666	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671515882666	f	2022-12-20 12:58:02.676+07	2022-12-20 12:58:02.676+07
ND1671515936637	New Sub Task: sering dan banyaknya selisih perhitungan kantin. Project ID: 1671515882666	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671515882666	f	2022-12-20 12:58:56+07	2022-12-20 12:58:56+07
ND1671515978946	New Sub Task: inspect lapangan ( penjagaan,hitung manual,dan tap karyawan ). Project ID: 1671515882666	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671515882666	f	2022-12-20 12:59:38+07	2022-12-20 12:59:38+07
ND1671515999461	New Sub Task: pengadaan perangkat dan instalasi. Project ID: 1671515882666	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	New Sub Task	1671515882666	f	2022-12-20 12:59:59+07	2022-12-20 12:59:59+07
ND1671516043812	New Sub Task: pembacaan langsng dari mesin dengan SDK dan .Net. Project ID: 1671515882666	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671515882666	f	2022-12-20 13:00:43+07	2022-12-20 13:00:43+07
ND1671516081564	New Sub Task: tahap awal hasil cukup signifikan selisihnya. Project ID: 1671515882666	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671515882666	f	2022-12-20 13:01:21+07	2022-12-20 13:01:21+07
ND16715163876070	New Task: PENGADAAN. Project ID: 1671516387598	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	New Task	1671516387598	f	2022-12-20 13:06:27.607+07	2022-12-20 13:06:27.607+07
ND16715163876072	New Task: SETTING. Project ID: 1671516387598	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	6b7ab1cc-5412-4051-b492-1bfef2405b1c	New Task	1671516387598	f	2022-12-20 13:06:27.607+07	2022-12-20 13:06:27.607+07
ND16715163876071	New Task: INSTALASI. Project ID: 1671516387598	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	New Task	1671516387598	f	2022-12-20 13:06:27.607+07	2022-12-20 13:06:27.607+07
ND16715165730980	New Task: DEVELOPMENT. Project ID: 1671516573091	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671516573091	f	2022-12-20 13:09:33.098+07	2022-12-20 13:09:33.098+07
ND1671516625069	New Sub Task: Membuat form PPIT dan Tracking PPIT berdasarkan aplikasi bawaan yakni versi dekstop ke versi web supaya bisa diakses secara publik. Project ID: 1671516573091	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671516573091	f	2022-12-20 13:10:25+07	2022-12-20 13:10:25+07
ND16715168056690	New Task: DESAIN. Project ID: 1671516805656	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671516805656	f	2022-12-20 13:13:25.669+07	2022-12-20 13:13:25.669+07
ND16715168056691	New Task: CODING. Project ID: 1671516805656	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671516805656	f	2022-12-20 13:13:25.669+07	2022-12-20 13:13:25.669+07
ND16715168056692	New Task: DEVOPS. Project ID: 1671516805656	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671516805656	f	2022-12-20 13:13:25.669+07	2022-12-20 13:13:25.669+07
ND16715168056703	New Task: DEPLOYMENT. Project ID: 1671516805656	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671516805656	f	2022-12-20 13:13:25.67+07	2022-12-20 13:13:25.67+07
ND1671516835766	New Sub Task: Merancang tipe pesan dan auto reply. Project ID: 1671516805656	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671516805656	f	2022-12-20 13:13:55+07	2022-12-20 13:13:55+07
ND1671516855881	New Sub Task: Merancang alur proses backend. Project ID: 1671516805656	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671516805656	f	2022-12-20 13:14:15+07	2022-12-20 13:14:15+07
ND1671516889426	New Sub Task: Implementasi ke kode program berdasarkan hasil desain. Project ID: 1671516805656	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671516805656	f	2022-12-20 13:14:49+07	2022-12-20 13:14:49+07
ND1671516918060	New Sub Task: Instalasi dependencies yang dibutuhkan untuk menjalakan service di server. Project ID: 1671516805656	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671516805656	f	2022-12-20 13:15:18+07	2022-12-20 13:15:18+07
ND1671516946086	New Sub Task: Deploy ke live server. Project ID: 1671516805656	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671516805656	f	2022-12-20 13:15:46+07	2022-12-20 13:15:46+07
ND16715170577080	New Task: DEVELOPMENT. Project ID: 1671517057701	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671517057701	f	2022-12-20 13:17:37.708+07	2022-12-20 13:17:37.708+07
ND1671517088202	New Sub Task: Implementasi kode program dan ujicoba program. Project ID: 1671517057701	7c1a8998-4611-416a-9a31-54fa198e2142	7c1a8998-4611-416a-9a31-54fa198e2142	New Sub Task	1671517057701	f	2022-12-20 13:18:08+07	2022-12-20 13:18:08+07
ND16715171073250	New Task: PENGEMBANGAN. Project ID: 1671517107318	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671517107318	f	2022-12-20 13:18:27.325+07	2022-12-20 13:18:27.325+07
ND16715171073251	New Task: TRIAL DAN IMPLEMENTASI. Project ID: 1671517107318	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671517107318	f	2022-12-20 13:18:27.325+07	2022-12-20 13:18:27.325+07
ND16715175977400	New Task: MENCARI REFRENSI DAN TUTORIAL. Project ID: 1671517597733	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671517597733	f	2022-12-20 13:26:37.74+07	2022-12-20 13:26:37.74+07
ND16715175977411	New Task: INSTALASI DAN TRIAL. Project ID: 1671517597733	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671517597733	f	2022-12-20 13:26:37.741+07	2022-12-20 13:26:37.741+07
ND16715175977412	New Task: SETTING DAN IMPLEMENTASI. Project ID: 1671517597733	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	6b7ab1cc-5412-4051-b492-1bfef2405b1c	New Task	1671517597733	f	2022-12-20 13:26:37.741+07	2022-12-20 13:26:37.741+07
ND1671517980526	New Task: INPUT ALL DATA ASET. Project ID: 1665735431998	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	New Task	1665735431998	f	2022-12-20 13:33:00.526+07	2022-12-20 13:33:00.526+07
ND16715839330810	New Task: KONSEP. Project ID: 1671583933063	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671583933063	f	2022-12-21 07:52:13.082+07	2022-12-21 07:52:13.082+07
ND16715839330821	New Task: COMPILE/UPGRADE. Project ID: 1671583933063	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	aeac8e47-b4e9-4121-bb3f-175b0d224aa4	New Task	1671583933063	f	2022-12-21 07:52:13.082+07	2022-12-21 07:52:13.082+07
ND16715839330822	New Task: TRIAL USER. Project ID: 1671583933063	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	6b7ab1cc-5412-4051-b492-1bfef2405b1c	New Task	1671583933063	f	2022-12-21 07:52:13.083+07	2022-12-21 07:52:13.083+07
ND16715839330833	New Task: IMPLEMENTASI. Project ID: 1671583933063	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	New Task	1671583933063	f	2022-12-21 07:52:13.083+07	2022-12-21 07:52:13.083+07
ND16715843051800	New Task: PENGUMPULAN DATA. Project ID: 1671584305171	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	6b7ab1cc-5412-4051-b492-1bfef2405b1c	New Task	1671584305171	f	2022-12-21 07:58:25.181+07	2022-12-21 07:58:25.181+07
ND16715843051811	New Task: PENGEMBANGAN. Project ID: 1671584305171	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	aeac8e47-b4e9-4121-bb3f-175b0d224aa4	New Task	1671584305171	f	2022-12-21 07:58:25.181+07	2022-12-21 07:58:25.181+07
ND16715843051812	New Task: TRIAL ERROR. Project ID: 1671584305171	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	6b7ab1cc-5412-4051-b492-1bfef2405b1c	New Task	1671584305171	f	2022-12-21 07:58:25.181+07	2022-12-21 07:58:25.181+07
ND16715843051823	New Task: IMPLEMENTASI. Project ID: 1671584305171	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	6b7ab1cc-5412-4051-b492-1bfef2405b1c	New Task	1671584305171	f	2022-12-21 07:58:25.182+07	2022-12-21 07:58:25.182+07
ND16715843051824	New Task: KONSEP. Project ID: 1671584305171	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671584305171	f	2022-12-21 07:58:25.182+07	2022-12-21 07:58:25.182+07
ND16715844721520	New Task: UPGRADE SYSTEM YG SUDAH ADA. Project ID: 1671584472145	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671584472145	f	2022-12-21 08:01:12.152+07	2022-12-21 08:01:12.152+07
ND16715847860850	New Task: KONSEP. Project ID: 1671584786079	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671584786079	f	2022-12-21 08:06:26.086+07	2022-12-21 08:06:26.086+07
ND16715847860861	New Task: PENGEMBANGAN SYSTEM. Project ID: 1671584786079	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671584786079	f	2022-12-21 08:06:26.086+07	2022-12-21 08:06:26.086+07
ND16715847860862	New Task: PENGADAAN PERANGKAT. Project ID: 1671584786079	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	New Task	1671584786079	f	2022-12-21 08:06:26.086+07	2022-12-21 08:06:26.086+07
ND16715847860873	New Task: IMPLEMENTASI. Project ID: 1671584786079	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	New Task	1671584786079	f	2022-12-21 08:06:26.087+07	2022-12-21 08:06:26.087+07
ND1671585004974	New Sub Task: .konsep mengambil dari HRMS Citicon ( import jadwal). Project ID: 1671583933063	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Sub Task	1671583933063	f	2022-12-21 08:10:04+07	2022-12-21 08:10:04+07
ND1671585182910	New Task: NEW KONSEP PMMC. Project ID: 1671584472145	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671584472145	f	2022-12-21 08:13:02.911+07	2022-12-21 08:13:02.911+07
ND1671585230603	New Task: TRIAL ERROR NEW KONSEP. Project ID: 1671584472145	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	0547c3e9-7ca7-4770-ad80-4bd43449fc34	New Task	1671584472145	f	2022-12-21 08:13:50.603+07	2022-12-21 08:13:50.603+07
ND1671585283882	New Task: RESET DAN TRIAL INPUT. Project ID: 1671584472145	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	7c1a8998-4611-416a-9a31-54fa198e2142	New Task	1671584472145	f	2022-12-21 08:14:43.882+07	2022-12-21 08:14:43.882+07
ND1671585498513	New Task: IMPLEMENTASI. Project ID: 1671584472145	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	6b7ab1cc-5412-4051-b492-1bfef2405b1c	New Task	1671584472145	f	2022-12-21 08:18:18.514+07	2022-12-21 08:18:18.514+07
\.


--
-- TOC entry 3190 (class 0 OID 42569)
-- Dependencies: 491
-- Data for Name: project; Type: TABLE DATA; Schema: sc_pms; Owner: postgres
--

COPY sc_pms.project (id, projectid, projectname, description, bagdept, subbagdept, pic, location, ttlitem, ttlbobot, startproj, endproj, status, inputby, "createdAt", "updatedAt") FROM stdin;
81	1671512928282	UPGRADE SERVER	UPGRADE SERVER DARI TOWER KE RACK	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"}]}	[{"task":"PENAWARAN","bobot":"30","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2020-01-01","duedate":"2020-12-31"},{"task":"PENGAJUAN","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2019-04-01","duedate":"2019-04-30"},{"task":"SETTING DAN INSTALASI","bobot":"50","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2019-05-20","duedate":"2020-10-01"},{"task":"IMPLEMENTASI","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2020-10-01","duedate":"2020-12-31"}]	4	100	2019-04-01	2020-12-31	CLOSE	ADMIN	2022-12-20 12:08:48.283+07	2022-12-20 12:08:48.283+07
63	1664164723988	Document Control Management System	Pembangunan sistem manajemen dokumen untuk  mempermudah Dokumen Kontrol dalam distribusi dokumen.	QIT	QMS	{"data":[{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"ANALYSIS","bobot":"10","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2021-11-01","duedate":"2021-11-14"},{"task":"DESIGN","bobot":"20","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2021-11-15","duedate":"2021-11-30"},{"task":"IMPLEMENTASI","bobot":"35","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2021-12-01","duedate":"2022-01-21"},{"task":"TESTING","bobot":"15","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-01-17","duedate":"2022-01-20"},{"task":"DEPLOYMENT","bobot":"10","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-01-21","duedate":"2022-01-23"},{"task":"SOSIALISASI","bobot":"10","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-01-25","duedate":"2022-01-30"}]	6	100	2021-11-01	2022-01-30	CLOSE	ADMIN	2022-09-26 10:58:43.988+07	2022-09-26 10:58:43.988+07
91	1671517107318	WABOT (PPIT)	setiap user yg mengisi PPIT akan automatis emngirimkan WA ke group IT, dan jika status PIPIT selesai akan mengirimkan notifikasi WA ke User	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"}]}	[{"task":"PENGEMBANGAN","bobot":"60","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-02-01","duedate":"2022-02-28"},{"task":"TRIAL DAN IMPLEMENTASI","bobot":"40","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-02-01","duedate":"2022-02-28"}]	2	100	2022-02-01	2022-02-28	CLOSE	ADMIN	2022-12-20 13:18:27.319+07	2022-12-20 13:18:27.319+07
67	1665719436860	CCTV (Area Timur)	Implementasi Pemasangan CCTV di area Timur	QIT	ITOUT	{"data":[{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"}]}	[{"task":"PENGADAAN PERANGKAT","bobot":"15","pic":{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},"startdate":"2022-01-01","duedate":""},{"task":"TARIK JARINGAN","bobot":"20","pic":{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},"startdate":"2022-02-15","duedate":""},{"task":"INSTALASI CCTV","bobot":"40","pic":{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},"startdate":"2022-02-20","duedate":"2022-05-01"},{"task":"TRIAL ERROR","bobot":"20","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-05-01","duedate":"2022-05-30"},{"task":"IMPLEMENTASI","bobot":"5","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-06-01","duedate":"2022-06-30"}]	5	0	2022-01-01	2022-06-30	OPEN	ADMIN	2022-10-14 10:50:36.862+07	2022-10-14 10:50:36.862+07
72	1665721647192	Sistem Karlo	Dibangun untuk pantau proses distribusi Barang	OP	GPJ	{"data":[{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"IT SBY","value":8,"uid":"aeac8e47-b4e9-4121-bb3f-175b0d224aa4"}]}	[{"task":"KONSEP","bobot":"20","pic":{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},"startdate":"2022-01-01","duedate":"2022-01-30"},{"task":"DEVELOPMENT","bobot":"40","pic":{"label":"IT SBY","value":8,"uid":"aeac8e47-b4e9-4121-bb3f-175b0d224aa4"},"startdate":"2022-02-01","duedate":"2022-05-30"},{"task":"TRIAL ERROR","bobot":"20","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-06-01","duedate":"2022-06-15"}]	3	90	2022-01-01	2022-06-30	OPEN	ADMIN	2022-10-14 11:27:27.194+07	2022-10-14 11:27:27.194+07
82	1671513444122	GENSET R. SERVER	KARENA SERINGNYA LISTRIK PADAM MAKA RUANG SERVER PERLU DI ADAKAN POWER BACKUP	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"}]}	[{"task":"PENAWARAN GENSET","bobot":"30","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2021-01-20","duedate":"2021-12-31"},{"task":"PENAWARAN UPS 6000W","bobot":"20","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-01-01","duedate":"2022-06-30"},{"task":"PENAGJUAN UPS 6000W","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-07-20","duedate":"2022-10-31"},{"task":"INSTALASI","bobot":"40","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-01-11","duedate":"2022-12-12"}]	4	100	2021-01-20	2022-12-12	CLOSE	ADMIN	2022-12-20 12:17:24.124+07	2022-12-20 12:17:24.124+07
73	1665723095688	Sistem Limbah	Dibangun untuk mengelola data limbah Pabrik maupun Non-Pabrik di seluruh perusahaan	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},{"label":"IT SBY","value":8,"uid":"aeac8e47-b4e9-4121-bb3f-175b0d224aa4"}]}	[{"task":"PENGUMPULAN DATA","bobot":"10","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-01-01","duedate":"2022-01-30"},{"task":"DESIGN DAN ANALISA","bobot":"20","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-02-01","duedate":""},{"task":"DEVELOPMENT","bobot":"20","pic":{"label":"IT SBY","value":8,"uid":"aeac8e47-b4e9-4121-bb3f-175b0d224aa4"},"startdate":"2022-03-01","duedate":"2022-06-01"}]	3	45	2022-01-01	2022-08-30	OPEN	ADMIN	2022-10-14 11:51:35.688+07	2022-10-14 11:51:35.688+07
76	1671510861987	Sistem Audit 5R	Sistem ini digunakan untuk membantu auditor maupun tim audit 5R dalam melakukan audit 5R	QIT	QMS	{"data":[{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"GENESIS","bobot":"10","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-04-04","duedate":"2022-04-18"},{"task":"ANALISIS","bobot":"15","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-04-15","duedate":"2022-04-25"},{"task":"DESIGN","bobot":"25","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-04-25","duedate":"2022-05-15"},{"task":"IMPLEMENTASI","bobot":"30","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-05-20","duedate":"2022-07-10"},{"task":"TESTING","bobot":"10","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-07-10","duedate":"2022-07-20"}]	5	100	2022-04-04	2022-07-30	CLOSE	USER	2022-12-20 11:34:21.988+07	2022-12-20 11:34:21.988+07
80	1671512391293	IT Logbook Maintenance System	Sistem untuk pencatatan logbook perawatan peralatan IT.	QIT	IT	{"data":[{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"ANALISA KEBUTUHAN","bobot":"25","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-05-01","duedate":"2022-05-10"},{"task":"IMPLEMENTASI PROGRAM","bobot":"45","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-05-10","duedate":"2022-05-28"},{"task":"UJICOBA PROGRAM","bobot":"10","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-05-28","duedate":"2022-05-29"},{"task":"DEPLOYMENT","bobot":"10","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-05-30","duedate":"2022-05-30"}]	4	90	2022-05-01	2022-05-30	OPEN	USER	2022-12-20 11:59:51.294+07	2022-12-20 11:59:51.294+07
85	1671515245116	PENGGANTIAN MESIN PRESENSI DARI FINGER KE RF-ID	dikarenakan seringnya bermsalah pada proses presensi finger (antrian panjang dan jari karyawan tidak terbaca karena kotor) maka di gantilah ke rf-id	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"}]}	[{"task":"PENGADAAN","bobot":"20","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2014-01-01","duedate":"2014-03-01"},{"task":"SETTING","bobot":"20","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2014-04-01","duedate":"2014-04-30"},{"task":"REGISTRASI KARYAWAN","bobot":"50","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2014-06-01","duedate":"2014-07-30"},{"task":"IMPLEMENTASI","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2014-06-01","duedate":"2014-08-01"}]	4	100	2014-01-01	2014-08-01	CLOSE	ADMIN	2022-12-20 12:47:25.118+07	2022-12-20 12:47:25.118+07
83	1671514254059	PPIT ( PERMINTAAN PERAWATAN IT)	DI TUJUKAN UNTUK USER AGAR WO TERMONITORING DAN TERSTRUKTUR	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"}]}	[{"task":"ANALISA","bobot":"20","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2017-01-20","duedate":"2017-01-31"},{"task":"PENGEMBANGAN","bobot":"50","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2017-02-01","duedate":"2017-03-30"},{"task":"TRIAL ERROR","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2017-04-01","duedate":"2017-04-30"},{"task":"IMPLEMENTASI","bobot":"20","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2017-05-01","duedate":"2017-06-01"}]	4	100	2017-01-20	2017-06-01	CLOSE	ADMIN	2022-12-20 12:30:54.06+07	2022-12-20 12:30:54.06+07
87	1671516387598	UPGRADE NETWORK LAN TO FIBER OPTIC	agar proses transaksi system berjalan secara maksimal	QIT	IT	{"data":[{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"PENGADAAN","bobot":"30","pic":{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},"startdate":"2022-01-01","duedate":"2022-08-01"},{"task":"INSTALASI","bobot":"50","pic":{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},"startdate":"2022-11-01","duedate":"2022-11-30"},{"task":"SETTING","bobot":"20","pic":{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},"startdate":"2022-11-01","duedate":"2022-11-30"}]	3	100	2022-01-01	2022-11-30	CLOSE	ADMIN	2022-12-20 13:06:27.6+07	2022-12-20 13:06:27.6+07
92	1671517597733	TRUENAS (Integrated Central Master File)	agar semua file pekerjaan tersimpan jadi 1 di server dan bisa saling sharing file	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"}]}	[{"task":"MENCARI REFRENSI DAN TUTORIAL","bobot":"30","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2020-01-20","duedate":"2020-01-31"},{"task":"INSTALASI DAN TRIAL","bobot":"50","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2020-02-01","duedate":"2020-02-29"},{"task":"SETTING DAN IMPLEMENTASI","bobot":"20","pic":{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},"startdate":"2020-03-01","duedate":"2020-06-20"}]	3	100	2020-01-20	2020-06-20	CLOSE	ADMIN	2022-12-20 13:26:37.733+07	2022-12-20 13:26:37.733+07
70	1665720478037	Sistem Inventaris IT	Pengembangan Sistem Inventaris IT (mulai dari pencatatan SPPB, BBK, BBM, STOCK, dan Preventive Perangkat)	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"ANALSYS","bobot":"15","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2021-10-01","duedate":"2021-11-30"},{"task":"DESIGN","bobot":"15","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2021-10-30","duedate":"2021-11-30"},{"task":"DEVELOPMENT","bobot":"35","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2021-12-01","duedate":""},{"task":"PENGUJIAN SISTEM","bobot":"15","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-03-01","duedate":"2022-03-20"},{"task":"SOSIALISASI","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-04-01","duedate":"2022-04-15"},{"task":"DEPLOYMENT","bobot":"10","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-04-16","duedate":"2022-04-30"}]	6	100	2021-10-01	2022-04-30	CLOSE	ADMIN	2022-10-14 11:07:58.039+07	2022-10-14 11:07:58.039+07
84	1671514711439	APLIKASI REKAM MEDIS	UNTUK PENGOLAHAN DATA REKAM MEDIS POLI PT. NBI	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"}]}	[{"task":"ANALISA MASALAH","bobot":"30","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2019-01-01","duedate":"2019-02-01"},{"task":"PENGUMPULAN DATA","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2019-02-01","duedate":"2019-02-01"},{"task":"PENGEMBANGAN APLIKASI","bobot":"50","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2019-03-01","duedate":"2019-04-01"},{"task":"IMPEMENTASI","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2019-05-01","duedate":"2019-06-01"}]	4	100	2019-01-01	2019-06-01	CLOSE	ADMIN	2022-12-20 12:38:31.44+07	2022-12-20 12:38:31.44+07
79	1671511916215	Daily Activity Karyawan	Sistem digunakan untuk pencatatan aktivitas harian yang dilakukan oleh setiap karyawan QA/IT.	QIT	QMS	{"data":[{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"ANALISA ALUR","bobot":"15","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-02-01","duedate":"2022-02-07"},{"task":"DESIGN SISTEM","bobot":"20","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-02-07","duedate":"2022-02-15"},{"task":"PENGEMBANGAN SISTEM","bobot":"35","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-02-15","duedate":"2022-02-28"},{"task":"UJICOBA SISTEM","bobot":"10","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-02-28","duedate":"2022-02-28"}]	4	100	2022-02-01	2022-03-01	CLOSE	USER	2022-12-20 11:51:56.216+07	2022-12-20 11:51:56.216+07
86	1671515882666	SYSTEM COUNTER KANTIN	UNTUK MENGHITUNG KARYAWAN YANG MAKAN KANTIN DGAN CARA TAP IDCARD KE MESIN MAKA SYSTEM AKAN MENGHITUNG OTOMATIS	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"}]}	[{"task":"ANALISA MASALAH","bobot":"30","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-08-01","duedate":"2022-09-01"},{"task":"KEBUTUHAN PERANGKAT","bobot":"20","pic":{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},"startdate":"2022-09-01","duedate":"2022-09-01"},{"task":"PENGEMBANGAN","bobot":"40","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-09-01","duedate":"2022-09-01"},{"task":"TRIAL DAN IMPLENTASI","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-10-01","duedate":"2022-10-01"}]	4	100	2022-08-01	2022-10-01	CLOSE	ADMIN	2022-12-20 12:58:02.667+07	2022-12-20 12:58:02.667+07
88	1671516573091	Permintaan Perbaikan IT (PPIT) Web Version	Web App untuk mempermudah setiap bagian baik Timur, Tengah dan Barat dalam permintaan bantuan IT baik Software, Network, dan Hardware.	QIT	IT	{"data":[{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"DEVELOPMENT","bobot":"100","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-01-01","duedate":"2022-01-31"}]	1	100	2022-01-01	2022-01-31	CLOSE	USER	2022-12-20 13:09:33.093+07	2022-12-20 13:09:33.093+07
89	1671516805656	Whatsapp BOT Audit 5R	Membantu Tim Audit 5R untuk mengirimkan notifikasi temuan audit, otorisasi audit, tindak lanjut audit, closed temuan audit, ranking audit, dan reminder jadwal audit 5R ke auditie mapun auditor.	QIT	IT	{"data":[{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"DESAIN","bobot":"25","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-08-01","duedate":"2022-08-05"},{"task":"CODING","bobot":"40","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-08-05","duedate":"2022-08-15"},{"task":"DEVOPS","bobot":"15","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-08-15","duedate":"2022-08-17"},{"task":"DEPLOYMENT","bobot":"20","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-08-16","duedate":"20200-08-20"}]	4	100	2022-08-01	20200-08-19	CLOSE	USER	2022-12-20 13:13:25.657+07	2022-12-20 13:13:25.657+07
71	1665721143012	Project Management System	Sistem yang dibangun untuk mengelola semua project-project yang berlangsung baik tahapan maupun sub task hingga progressnya	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"PEMBUATAN KONSEP","bobot":"15","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-04-01","duedate":"2022-04-30"},{"task":"DESIGN UI/UX","bobot":"20","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-05-01","duedate":"2022-05-30"},{"task":"DESIGN ALUR","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-05-01","duedate":"2022-05-30"},{"task":"DEVELOPMENT","bobot":"35","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-05-20","duedate":"2022-08-10"},{"task":"TRIAL ERROR","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-08-10","duedate":"2022-08-20"},{"task":"DEPLOYMENT","bobot":"10","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-08-20","duedate":"2022-08-30"}]	6	80	2022-04-01	2022-08-30	OPEN	ADMIN	2022-10-14 11:19:03.012+07	2022-10-14 11:19:03.012+07
65	1665718769331	Sistem Produksi (Loader)	Project ini untuk integrasi data timbangan ke sistem SISPRO	PB	PRD	{"data":[{"label":"IT SBY","value":8,"uid":"aeac8e47-b4e9-4121-bb3f-175b0d224aa4"},{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"}]}	[{"task":"PERSIAPAN HARDWARE","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-01-01","duedate":"2022-01-10"},{"task":"PENGUMPULAN DATA","bobot":"15","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-01-05","duedate":"2022-01-15"},{"task":"PEMBUATAN KONSEP","bobot":"15","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-01-10","duedate":"2022-01-20"},{"task":"DEVELOPMENT","bobot":"35","pic":{"label":"IT SBY","value":8,"uid":"aeac8e47-b4e9-4121-bb3f-175b0d224aa4"},"startdate":"2022-01-15","duedate":"2022-02-10"},{"task":"SOSIALISASI","bobot":"5","pic":{"label":"IT SBY","value":8,"uid":"aeac8e47-b4e9-4121-bb3f-175b0d224aa4"},"startdate":"2022-02-05","duedate":"2022-02-10"},{"task":"TRIAL ERROR","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-02-05","duedate":"2022-02-15"},{"task":"IMPLEMENTASI","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-02-15","duedate":"2022-02-20"}]	7	15	2022-08-01	2023-02-28	OPEN	ADMIN	2022-10-14 10:39:29.336+07	2022-10-14 10:39:29.336+07
66	1665719137946	Sistem KPI	Pengembangan Sistem KPI untuk membantu Divisi BSC untuk mengelola data KPI	QIT	QMS	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"IT SBY","value":8,"uid":"aeac8e47-b4e9-4121-bb3f-175b0d224aa4"},{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"}]}	[{"task":"PENGUMPULAN DATA","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-01-01","duedate":"2022-04-01"},{"task":"KONSEP","bobot":"15","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-04-01","duedate":"2022-06-01"},{"task":"DEVELOP","bobot":"40","pic":{"label":"IT SBY","value":8,"uid":"aeac8e47-b4e9-4121-bb3f-175b0d224aa4"},"startdate":"2022-01-01","duedate":"2022-12-01"},{"task":"PENGUJIAN","bobot":"20","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-03-01","duedate":"2022-05-01"},{"task":"SOSIALISASI","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-06-01","duedate":"2022-12-01"},{"task":"IMPLEMENTASI","bobot":"5","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-08-01","duedate":"2022-12-01"}]	6	65	2022-01-01	2022-12-01	OPEN	ADMIN	2022-10-14 10:45:37.947+07	2022-10-14 10:45:37.947+07
77	1671511339112	LISENCE WINDOWS TAHAP 1	PEMBELIAN LISENCE WINDOWS TAHAP 1 40 PC	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"}]}	[{"task":"PENAWARAN VENDOR","bobot":"30","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-01-01","duedate":"2019-03-31"},{"task":"PENGAJUAN","bobot":"20","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2019-04-01","duedate":"2019-04-30"},{"task":"INSTALASI","bobot":"50","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2019-06-01","duedate":"2019-12-31"}]	3	100	2019-04-01	2019-12-31	CLOSE	ADMIN	2022-12-20 11:42:19.114+07	2022-12-20 11:42:19.114+07
78	1671511684988	PENGADAAN CCTV	PENGADAAN CCTV 64 TITIK	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"}]}	[{"task":"PENAWARAN","bobot":"30","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2018-01-01","duedate":"2019-12-31"},{"task":"INSTALASI","bobot":"50","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2019-01-01","duedate":"2019-04-30"},{"task":"IMPLEMENTASI","bobot":"20","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2019-05-20","duedate":"2019-05-20"}]	3	100	2018-01-01	2019-12-31	CLOSE	ADMIN	2022-12-20 11:48:04.989+07	2022-12-20 11:48:04.989+07
90	1671517057701	Scanner Stock Opname Perangkat IT	Aplikasi untuk membantu stock opname perangkat IT di lingkungan perusahaan.	QIT	IT	{"data":[{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"DEVELOPMENT","bobot":"40","pic":{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"},"startdate":"2022-06-01","duedate":"2022-06-20"}]	1	40	2022-06-01	2022-06-20	OPEN	USER	2022-12-20 13:17:37.702+07	2022-12-20 13:17:37.702+07
74	1665735431998	 DASHBOARD IT (WO,INV,MTC,RK)	Dashboard ini digunakan untuk monitoring oleh tim IT	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"KONSEP","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2022-01-01","duedate":"2022-01-20"}]	1	90	2021-04-11	2022-05-14	OPEN	ADMIN	2022-10-14 15:17:12.005+07	2022-10-14 15:17:12.005+07
96	1671584786079	SISTEM INFORMASI DIGITAL	untuk menampilkan informasi internal secara digital, target utama adalah karyawan	QIT	IT	{"data":[{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"KONSEP","bobot":"30","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2023-01-01","duedate":"2023-01-30"},{"task":"PENGEMBANGAN SYSTEM","bobot":"30","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2023-02-01","duedate":""},{"task":"PENGADAAN PERANGKAT","bobot":"30","pic":{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},"startdate":"2023-03-01","duedate":"2023-04-30"},{"task":"IMPLEMENTASI","bobot":"10","pic":{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},"startdate":"2023-06-01","duedate":"2023-06-30"}]	4	0	2023-01-01	2023-06-30	OPEN	ADMIN	2022-12-21 08:06:26.08+07	2022-12-21 08:06:26.08+07
93	1671583933063	UPGRADE OSIN NEW FEATURE	PENJADWALAN, INPUT CUTI,IJIN,DINAS	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},{"label":"IT SBY","value":8,"uid":"aeac8e47-b4e9-4121-bb3f-175b0d224aa4"}]}	[{"task":"KONSEP","bobot":"20","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2023-02-01","duedate":"2023-02-01"},{"task":"COMPILE/UPGRADE","bobot":"20","pic":{"label":"IT SBY","value":8,"uid":"aeac8e47-b4e9-4121-bb3f-175b0d224aa4"},"startdate":"2023-03-01","duedate":"2023-03-01"},{"task":"TRIAL USER","bobot":"20","pic":{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},"startdate":"2023-04-01","duedate":"2023-04-01"},{"task":"IMPLEMENTASI","bobot":"30","pic":{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},"startdate":"2023-04-01","duedate":"2023-04-01"}]	4	20	2023-02-01	2023-04-01	OPEN	ADMIN	2022-12-21 07:52:13.071+07	2022-12-21 07:52:13.071+07
95	1671584472145	PMMC	Pengelolaan aset mesin	QIT	IT	{"data":[{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"UPGRADE SYSTEM YG SUDAH ADA","bobot":"100","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2023-01-01","duedate":"2023-12-30"}]	1	30	2023-01-01	2023-06-30	OPEN	ADMIN	2022-12-21 08:01:12.146+07	2022-12-21 08:01:12.146+07
94	1671584305171	SYSTEM PALET	System Management Palet	QIT	IT	{"data":[{"label":"Rino","value":2,"uid":"ba35aaf8-1b29-44ec-a860-d3f124b17e3b"},{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},{"label":"Rido Martupa","value":1,"uid":"7c1a8998-4611-416a-9a31-54fa198e2142"}]}	[{"task":"PENGUMPULAN DATA","bobot":"10","pic":{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},"startdate":"2023-01-01","duedate":"2023-01-01"},{"task":"PENGEMBANGAN","bobot":"50","pic":{"label":"IT SBY","value":8,"uid":"aeac8e47-b4e9-4121-bb3f-175b0d224aa4"},"startdate":"2023-02-01","duedate":"2023-03-01"},{"task":"TRIAL ERROR","bobot":"20","pic":{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},"startdate":"2023-04-01","duedate":"2023-04-30"},{"task":"IMPLEMENTASI","bobot":"10","pic":{"label":"Tino","value":3,"uid":"6b7ab1cc-5412-4051-b492-1bfef2405b1c"},"startdate":"2023-04-01","duedate":"2023-04-30"},{"task":"KONSEP","bobot":"10","pic":{"label":"Ikhwan","value":4,"uid":"0547c3e9-7ca7-4770-ad80-4bd43449fc34"},"startdate":"2023-01-01","duedate":"2023-01-30"}]	5	20	2023-01-01	2023-04-30	OPEN	ADMIN	2022-12-21 07:58:25.173+07	2022-12-21 07:58:25.173+07
\.


--
-- TOC entry 3188 (class 0 OID 42561)
-- Dependencies: 489
-- Data for Name: sub_task; Type: TABLE DATA; Schema: sc_pms; Owner: postgres
--

COPY sc_pms.sub_task (id, subtaskid, taskid, subtask_name, pic, "createdAt", "updatedAt") FROM stdin;
43	1664164886091	1664164723991	Diskusi dengan tim dokumen kontrol perihal kebutuhan sistem	1	2022-09-26 11:01:26+07	2022-09-26 11:01:26+07
44	1664164961264	1664164723991	Membuat analisis terkait alur proses sistem	1	2022-09-26 11:02:41+07	2022-09-26 11:02:41+07
45	1664167978162	1664164723992	Design UI dan Alur Proses	1	2022-09-26 11:52:58+07	2022-09-26 11:52:58+07
46	1664167992690	1664164723992	Design Database	1	2022-09-26 11:53:12+07	2022-09-26 11:53:12+07
47	1664168012212	1664164723993	Implementasi program	1	2022-09-26 11:53:32+07	2022-09-26 11:53:32+07
48	1664168035041	1664164723993	Membuat database berdasarkan hasil design sebelumnya	1	2022-09-26 11:53:55+07	2022-09-26 11:53:55+07
49	1664168056434	1664164723994	Melakukan ujicoba fungsional sistem	1	2022-09-26 11:54:16+07	2022-09-26 11:54:16+07
50	1664168077905	1664164723994	Melakukan ujicoba sistem bersama user	1	2022-09-26 11:54:37+07	2022-09-26 11:54:37+07
51	1664168101709	1664164723995	Deploy source code program ke server live	1	2022-09-26 11:55:01+07	2022-09-26 11:55:01+07
52	1664168123899	1664164723996	Sosialisasi penggunaan sistem kepada user	1	2022-09-26 11:55:23+07	2022-09-26 11:55:23+07
53	1665729979269	1665723095695	Membuat Design Model ERD	1	2022-10-14 13:46:19+07	2022-10-14 13:46:19+07
54	1665731616501	1665723095695	Diskusi terkait kebutuhan sistem	1	2022-10-14 14:13:36+07	2022-10-14 14:13:36+07
55	1665732260153	1665720478046	Membuat design alur dan UI SIVENIT	1	2022-10-14 14:24:20+07	2022-10-14 14:24:20+07
56	1665732289460	1665720478046	Perbaiki alur dan UI berdasarkan kebutuhan sistem	1	2022-10-14 14:24:49+07	2022-10-14 14:24:49+07
57	1665732383137	1665720599838	implementasi program frontend	1	2022-10-14 14:26:23+07	2022-10-14 14:26:23+07
58	1665732414192	1665720599838	Implementasi program backend serta konfigurasi dengan database	4	2022-10-14 14:26:54+07	2022-10-14 14:26:54+07
59	1665732440711	1665720478045	Diskusi bersama terkait alur proses sistem	4	2022-10-14 14:27:20+07	2022-10-14 14:27:20+07
60	1665732464265	1665720478045	Membuat alur proses berdasarkan hasil analisa sebelumnya	4	2022-10-14 14:27:44+07	2022-10-14 14:27:44+07
61	1665732521236	1665720478048	Melakukan ujicoba pertama terkait fungsionalitas sistem	1	2022-10-14 14:28:41+07	2022-10-14 14:28:41+07
62	1665732540310	1665720478048	Melakukan ujicoba di sisi user	2	2022-10-14 14:29:00+07	2022-10-14 14:29:00+07
63	1665732560531	1665720478049	Sosialisasi bersama user	4	2022-10-14 14:29:20+07	2022-10-14 14:29:20+07
64	1665732590160	1665720599838	Perbaikan bug atas hasil ujicoba	4	2022-10-14 14:29:50+07	2022-10-14 14:29:50+07
65	1665732625626	1665720478050	Deployment source code dan skema basis data ke server live	1	2022-10-14 14:30:25+07	2022-10-14 14:30:25+07
66	1665732670302	1665721143019	Diskusi bersama PIC (Ikhwan) terkait kebutuhan sistem manajemen proyek	1	2022-10-14 14:31:10+07	2022-10-14 14:31:10+07
67	1665732701470	1665721143019	Pembuatan konsep sederhana berdasarkan hasil diskusi dengan stakeholder sebelumnya	1	2022-10-14 14:31:41+07	2022-10-14 14:31:41+07
68	1665732736079	1665721143020	Membuat diagram flow berdasarkan hasil analisa	1	2022-10-14 14:32:16+07	2022-10-14 14:32:16+07
69	1665732765343	1665721143020	Membuat design skema database berdasarkan alur proses sebelumnya	1	2022-10-14 14:32:45+07	2022-10-14 14:32:45+07
70	1665732799732	1665721143020	Membuat design user interface atau antarmuka sistem	1	2022-10-14 14:33:19+07	2022-10-14 14:33:19+07
71	1665732832209	1665721143020	Perbaikan design user interface berdasarkan hasil diskusi dengan stakeholder	1	2022-10-14 14:33:52+07	2022-10-14 14:33:52+07
72	1665732918285	1665721143022	Implementasi pragram frontend berdasarkan hasil design user interface sebelumnya menggunakan library React JS , Bootstrap dan CSS	1	2022-10-14 14:35:18+07	2022-10-14 14:35:18+07
74	1665733120762	1665721143022	Implementasi program backend menggunakan framework Node JS (Express JS) berdasarkan hasil analisa dan design alur sebelumnya	1	2022-10-14 14:38:40+07	2022-10-14 14:38:40+07
75	1665733154838	1665721143022	Perbaikan bug tidak bisa submit New Task	1	2022-10-14 14:39:14+07	2022-10-14 14:39:14+07
76	1665733203605	1665721143024	Build project menggunakan PM2 service management	1	2022-10-14 14:40:03+07	2022-10-14 14:40:03+07
77	1665733232877	1665721143024	Deployment source code yang sudah di build sebelumnya ke server live	1	2022-10-14 14:40:32+07	2022-10-14 14:40:32+07
78	1665733262077	1665721143024	Melakukan konfigurasi database di server live	1	2022-10-14 14:41:02+07	2022-10-14 14:41:02+07
79	1665733663715	1665720599838	Pengembangan scanner QR code inventaris web base responsive	1	2022-10-14 14:47:43+07	2022-10-14 14:47:43+07
81	1665735549259	1665721647201	Trial aplikasi mulai dari create SJ hingga selesai	4	2022-10-14 15:19:09+07	2022-10-14 15:19:09+07
82	1665735575433	1665721647201	Trial bersama IT SBY, GPJ dan Tim Karlo ke distributor	4	2022-10-14 15:19:35+07	2022-10-14 15:19:35+07
83	1668072515053	1665721719829	implentasi ke gudang internal NBI	4	2022-11-10 16:28:35+07	2022-11-10 16:28:35+07
84	1668072581791	1665721719829	perluasan ke transporter lain	4	2022-11-10 16:29:41+07	2022-11-10 16:29:41+07
85	1668072665456	1665719729564	pengajuan genset revisi UPS 6000VA	4	2022-11-10 16:31:05+07	2022-11-10 16:31:05+07
87	1668155300676	1665719137954	sudah di lakukan pengumpulan data dari tahun 2018	4	2022-11-11 15:28:20+07	2022-11-11 15:28:20+07
88	1668156462542	1665719137955	konsep input master dan komponen by system ( trial mengalami kesulitan )\n	4	2022-11-11 15:47:42+07	2022-11-11 15:47:42+07
89	1668156526471	1665719137955	konsep import file master format KPI excel ( terlalu sering perbahan sampai sub terkecil ) sehingga admin kesulitan mengikutinya	4	2022-11-11 15:48:46+07	2022-11-11 15:48:46+07
90	1668156554321	1665719137956	sudah di lakukan 2 develope konsep	4	2022-11-11 15:49:14+07	2022-11-11 15:49:14+07
91	1668156747041	1665719137957	sudah di lakukan trial error 2 konsep perubahan	3	2022-11-11 15:52:27+07	2022-11-11 15:52:27+07
92	1668157317555	1668157202297	PENGUMPULAN DATA	4	2022-11-11 16:01:57+07	2022-11-11 16:01:57+07
93	1668157333989	1668157202297	KONSEP	4	2022-11-11 16:02:13+07	2022-11-11 16:02:13+07
94	1668157357363	1668157202297	DEVELOPE	4	2022-11-11 16:02:37+07	2022-11-11 16:02:37+07
95	1668157371851	1668157202297	TRIAL ERROR	4	2022-11-11 16:02:51+07	2022-11-11 16:02:51+07
96	1668157385592	1668157202297	IMPLEMENTASI	4	2022-11-11 16:03:05+07	2022-11-11 16:03:05+07
98	1671091557061	1665719137957	Perbaikan master data employee, position dan jobarea pada sistem KPI terbaru 2022	1	2022-12-15 15:05:57+07	2022-12-15 15:05:57+07
99	1671510943198	1671510862064	Diskusi bersama dengan bagian QMS untuk menentukan konsep awal dalam pengembangan sistem	1	2022-12-20 11:35:43+07	2022-12-20 11:35:43+07
100	1671510973949	1671510862064	Menentukan batas-batas serta ruang lingkup sistem	1	2022-12-20 11:36:13+07	2022-12-20 11:36:13+07
101	1671511016711	1671510862065	Melakukan analisa SRS (System Requirement Spesification)	1	2022-12-20 11:36:56+07	2022-12-20 11:36:56+07
102	1671511039887	1671510862065	Membuat SRS berdasarkan kebutuhan user Auditor dan Auditie	1	2022-12-20 11:37:19+07	2022-12-20 11:37:19+07
103	1671511089433	1671510862066	Membuat desain alur berdasarkan hasil analisa sebelumnya	1	2022-12-20 11:38:09+07	2022-12-20 11:38:09+07
104	1671511114748	1671510862066	Membuat konsep skema basis data	1	2022-12-20 11:38:34+07	2022-12-20 11:38:34+07
105	1671511133657	1671510862066	Membuat desain interface sistem	1	2022-12-20 11:38:53+07	2022-12-20 11:38:53+07
106	1671511172111	1671510862067	Implementasi dari hasil desain ke bentuk program	1	2022-12-20 11:39:32+07	2022-12-20 11:39:32+07
107	1671511202143	1671510862067	Membuat basis data berdasarkan hasil desain skema basis data sebelumnya	1	2022-12-20 11:40:02+07	2022-12-20 11:40:02+07
108	1671511234743	1671510862067	Melakukan perbaikan berdasarkan hasil revisi dari tim audit 5R	1	2022-12-20 11:40:34+07	2022-12-20 11:40:34+07
109	1671511269347	1671510862068	Melakukan ujicoba per fungsi dari sistem	1	2022-12-20 11:41:09+07	2022-12-20 11:41:09+07
110	1671511289677	1671510862068	Melakukan ujicoba bersama tim audit 5R	1	2022-12-20 11:41:29+07	2022-12-20 11:41:29+07
111	1671511321411	1671510862068	Melakukan sosialisasi bersama user (Auditor dan Auditie)	1	2022-12-20 11:42:01+07	2022-12-20 11:42:01+07
112	1671511394241	1671511362861	Deployment source code sistem ke server live	1	2022-12-20 11:43:14+07	2022-12-20 11:43:14+07
113	1671511506331	1671511485060	Membuat form input limbah	1	2022-12-20 11:45:06+07	2022-12-20 11:45:06+07
114	1671511532018	1671511485060	Membuat fitur kelola data limbah	1	2022-12-20 11:45:32+07	2022-12-20 11:45:32+07
115	1671511553075	1671511485060	Membuat fitur kelola master kategori limbah	1	2022-12-20 11:45:53+07	2022-12-20 11:45:53+07
116	1671511570005	1671511485060	Membuat fitur transaksi limbah	1	2022-12-20 11:46:10+07	2022-12-20 11:46:10+07
117	1671511590709	1671511485060	Membuat fitur report limbah	1	2022-12-20 11:46:30+07	2022-12-20 11:46:30+07
118	1671511744814	1671511684994	MENCARI LEBIH DARI 3 VENDOR 	4	2022-12-20 11:49:04+07	2022-12-20 11:49:04+07
119	1671511788127	1671511684994	PENGAJUAN BEBERAPA KALI TIDAK DI ACC KARENA PERBANDINGAN HARGA	4	2022-12-20 11:49:48+07	2022-12-20 11:49:48+07
120	1671511836310	1671511684994	SETELAH MENDAPATKAN VENDOR DAN HARGA YG SESUAI DI ACC DGN VENDOR "AYU KONDANG"	4	2022-12-20 11:50:36+07	2022-12-20 11:50:36+07
121	1671511881801	1671511684995	DARI VENDOR TEKNISI SURVEY LOKASI	4	2022-12-20 11:51:21+07	2022-12-20 11:51:21+07
122	1671511921273	1671511684995	PROSES INSTALASI TERKENDALA PADA MEDAN PABRIK YG BERESIKO	4	2022-12-20 11:52:01+07	2022-12-20 11:52:01+07
123	1671511953366	1671511916224	Membuat alur proses sistem berdasarkan form excel sebelumnya	1	2022-12-20 11:52:33+07	2022-12-20 11:52:33+07
124	1671511985758	1671511916225	Membuat desain sederhana dari UI dan database sistem	1	2022-12-20 11:53:05+07	2022-12-20 11:53:05+07
125	1671512012730	1671511916226	Membuat karangka sistem	1	2022-12-20 11:53:32+07	2022-12-20 11:53:32+07
126	1671512037164	1671511916226	Membuat fitur kelola data daily activity	1	2022-12-20 11:53:57+07	2022-12-20 11:53:57+07
127	1671512056152	1671511916226	Membuat fitur kelola todo list	1	2022-12-20 11:54:16+07	2022-12-20 11:54:16+07
128	1671512087532	1671511916226	Membuat fitur ubah password user	1	2022-12-20 11:54:47+07	2022-12-20 11:54:47+07
129	1671512105629	1671511916226	Membuat fitur export data activity	1	2022-12-20 11:55:05+07	2022-12-20 11:55:05+07
130	1671512131660	1671511916227	Melakukan ujicoba dengan karyawan bagian QA/IT	1	2022-12-20 11:55:31+07	2022-12-20 11:55:31+07
131	1671512139575	1671511684996	PELATIHAN KE USER DAN SERAH TERIMA PROJECT	4	2022-12-20 11:55:39+07	2022-12-20 11:55:39+07
132	1671512181984	1671512161065	Deploy sistem ke live server sehingga bisa digunakan langsung oleh user	1	2022-12-20 11:56:21+07	2022-12-20 11:56:21+07
133	1671512233306	1665719137957	Perbaikan master data yang tidak sesuai	1	2022-12-20 11:57:13+07	2022-12-20 11:57:13+07
134	1671512424653	1671512391304	Implementasi kedalam bentuk program	1	2022-12-20 12:00:24+07	2022-12-20 12:00:24+07
135	1671512445685	1671512391305	Melakukan ujibcoba	1	2022-12-20 12:00:45+07	2022-12-20 12:00:45+07
136	1671512487050	1671512391306	Melakukan deploy source code ke server live	1	2022-12-20 12:01:27+07	2022-12-20 12:01:27+07
137	1671513518060	1671513444138	BEBERAPA KALI PENGAJUAN GENSET TIDAK DI ACC KARENA ADA BEBERAPA PERTIMBANGAN TEMPAT,INSTALASI DAN BIAYA	4	2022-12-20 12:18:38+07	2022-12-20 12:18:38+07
138	1671513568662	1671513444139	AKHIR REKOMENDASI  DARI DIREKSI COBA UNTUK MENCARI PENAWARAN UPS DGN KAPASITAS SESUAI KEBUTUHAN	4	2022-12-20 12:19:28+07	2022-12-20 12:19:28+07
139	1671513600601	1671513444140	ACC PENGAJUAN UPS 6000W EXT BAT	4	2022-12-20 12:20:00+07	2022-12-20 12:20:00+07
140	1671513681593	1671513444141	INSTALASI DAN PEMBAGIAN POWER DI BAGI 2 REDUNDANCE A(UPS) DAN B(PLN) UNTUK KEBUTUHAN POWER SERV	4	2022-12-20 12:21:21+07	2022-12-20 12:21:21+07
141	1671515936636	1671515882675	sering dan banyaknya selisih perhitungan kantin	4	2022-12-20 12:58:56+07	2022-12-20 12:58:56+07
142	1671515978945	1671515882675	inspect lapangan ( penjagaan,hitung manual,dan tap karyawan )	4	2022-12-20 12:59:38+07	2022-12-20 12:59:38+07
143	1671515999460	1671515882676	pengadaan perangkat dan instalasi	2	2022-12-20 12:59:59+07	2022-12-20 12:59:59+07
144	1671516043811	1671515882677	pembacaan langsng dari mesin dengan SDK dan .Net	4	2022-12-20 13:00:43+07	2022-12-20 13:00:43+07
145	1671516081562	1671515882678	tahap awal hasil cukup signifikan selisihnya	4	2022-12-20 13:01:21+07	2022-12-20 13:01:21+07
146	1671516625013	1671516573098	Membuat form PPIT dan Tracking PPIT berdasarkan aplikasi bawaan yakni versi dekstop ke versi web supaya bisa diakses secara publik	1	2022-12-20 13:10:25+07	2022-12-20 13:10:25+07
147	1671516835708	1671516805668	Merancang tipe pesan dan auto reply	1	2022-12-20 13:13:55+07	2022-12-20 13:13:55+07
148	1671516855840	1671516805668	Merancang alur proses backend	1	2022-12-20 13:14:15+07	2022-12-20 13:14:15+07
149	1671516889425	1671516805669	Implementasi ke kode program berdasarkan hasil desain	1	2022-12-20 13:14:49+07	2022-12-20 13:14:49+07
150	1671516918020	1671516805670	Instalasi dependencies yang dibutuhkan untuk menjalakan service di server	1	2022-12-20 13:15:18+07	2022-12-20 13:15:18+07
151	1671516946049	1671516805671	Deploy ke live server	1	2022-12-20 13:15:46+07	2022-12-20 13:15:46+07
152	1671517088162	1671517057707	Implementasi kode program dan ujicoba program	1	2022-12-20 13:18:08+07	2022-12-20 13:18:08+07
153	1671585004933	1671583933080	.konsep mengambil dari HRMS Citicon ( import jadwal)	4	2022-12-21 08:10:04+07	2022-12-21 08:10:04+07
\.


--
-- TOC entry 3192 (class 0 OID 42746)
-- Dependencies: 493
-- Data for Name: task; Type: TABLE DATA; Schema: sc_pms; Owner: postgres
--

COPY sc_pms.task (id, taskid, projectid, task_name, progress, bobot, pic, due_date, t_status, startdate, "createdAt", "updatedAt") FROM stdin;
19	1664164723991	1664164723988	ANALYSIS	100	10	1	2021-11-14	t	2021-11-01	2022-09-26 10:58:43.992+07	2022-09-26 10:58:43.992+07
20	1664164723992	1664164723988	DESIGN	100	20	1	2021-11-30	t	2021-11-15	2022-09-26 10:58:43.992+07	2022-09-26 10:58:43.992+07
21	1664164723993	1664164723988	IMPLEMENTASI	100	35	1	2022-01-21	t	2021-12-01	2022-09-26 10:58:43.992+07	2022-09-26 10:58:43.992+07
22	1664164723994	1664164723988	TESTING	100	15	1	2022-01-20	t	2022-01-17	2022-09-26 10:58:43.992+07	2022-09-26 10:58:43.992+07
23	1664164723995	1664164723988	DEPLOYMENT	100	10	1	2022-01-23	t	2022-01-21	2022-09-26 10:58:43.992+07	2022-09-26 10:58:43.992+07
54	1665720478046	1665720478037	DESIGN	100	15	1	2021-11-30	t	2021-10-30	2022-10-14 11:07:58.046+07	2022-10-14 11:07:58.046+07
53	1665720478045	1665720478037	ANALSYS	100	15	4	2021-11-30	t	2021-10-01	2022-10-14 11:07:58.046+07	2022-10-14 11:07:58.046+07
55	1665720478048	1665720478037	PENGUJIAN SISTEM	100	15	4	2022-03-20	t	2022-03-01	2022-10-14 11:07:58.047+07	2022-10-14 11:07:58.047+07
56	1665720478049	1665720478037	SOSIALISASI	100	10	4	2022-04-15	t	2022-04-01	2022-10-14 11:07:58.047+07	2022-10-14 11:07:58.047+07
24	1664164723996	1664164723988	SOSIALISASI	100	10	1	2022-01-30	t	2022-01-25	2022-09-26 10:58:43.992+07	2022-09-26 10:58:43.992+07
40	1665719137958	1665719137946	SOSIALISASI	0	10	4	2022-12-01	f	2022-06-01	2022-10-14 10:45:37.956+07	2022-10-14 10:45:37.956+07
41	1665719137959	1665719137946	IMPLEMENTASI	0	5	4	2022-12-01	f	2022-08-01	2022-10-14 10:45:37.957+07	2022-10-14 10:45:37.957+07
42	1665719436871	1665719436860	INSTALASI CCTV	0	40	2	2022-05-01	f	2022-02-20	2022-10-14 10:50:36.87+07	2022-10-14 10:50:36.87+07
43	1665719436872	1665719436860	TRIAL ERROR	0	20	4	2022-05-30	f	2022-05-01	2022-10-14 10:50:36.871+07	2022-10-14 10:50:36.871+07
44	1665719436873	1665719436860	IMPLEMENTASI	0	5	4	2022-06-30	f	2022-06-01	2022-10-14 10:50:36.871+07	2022-10-14 10:50:36.871+07
46	1665719729565	1665719729558	SETTING DAN INSTALASI	0	45	3	2022-06-01	f	2022-02-01	2022-10-14 10:55:29.565+07	2022-10-14 10:55:29.565+07
47	1665719729566	1665719729558	TRIAL ERROR	0	20	4	2022-06-25	f	2022-06-01	2022-10-14 10:55:29.565+07	2022-10-14 10:55:29.565+07
48	1665719729567	1665719729558	IMPLEMENTASI	0	20	3	2022-06-30	f	2022-06-20	2022-10-14 10:55:29.566+07	2022-10-14 10:55:29.566+07
49	1665720053584	1665720053578	PENGUMPULAN DATA	0	10	4	2021-01-15	f	2021-01-01	2022-10-14 11:00:53.584+07	2022-10-14 11:00:53.584+07
50	1665720053585	1665720053578	DESIGN ALUR	0	20	4	2021-01-31	f	2021-01-15	2022-10-14 11:00:53.585+07	2022-10-14 11:00:53.585+07
51	1665720053586	1665720053578	DEVELOPMENT	0	40	8	2021-02-20	f	2021-02-01	2022-10-14 11:00:53.585+07	2022-10-14 11:00:53.585+07
52	1665720053587	1665720053578	TRIAL ERROR	0	15	4	2021-02-25	f	2021-02-20	2022-10-14 11:00:53.585+07	2022-10-14 11:00:53.585+07
45	1665719729564	1665719729558	PENGAJUAN BARANG	100	15	4	2022-01-31	t	2022-01-01	2022-10-14 10:55:29.565+07	2022-10-14 10:55:29.565+07
61	1665721143021	1665721143012	DESIGN ALUR	0	10	4	2022-05-30	f	2022-05-01	2022-10-14 11:19:03.02+07	2022-10-14 11:19:03.02+07
63	1665721143023	1665721143012	TRIAL ERROR	0	10	4	2022-08-20	f	2022-08-10	2022-10-14 11:19:03.02+07	2022-10-14 11:19:03.02+07
79	1668157268530	1665718769331	CUTTING	0	20	4	2023-01-31	f	2023-01-01	2022-11-11 16:01:08.592+07	2022-11-11 16:01:08.592+07
36	1665719137954	1665719137946	PENGUMPULAN DATA SRS	100	10	4	2022-04-01	t	2022-01-01	2022-10-14 10:45:37.955+07	2022-12-15 13:49:33+07
88	1671510862067	1671510861987	IMPLEMENTASI	100	30	1	2022-07-10	t	2022-05-20	2022-12-20 11:34:22.067+07	2022-12-20 11:34:22.067+07
58	1665720599838	1665720478037	DEVELOPMENT	100	35	4	2022-03-01	t	2022-01-01	2022-10-14 11:09:59.897+07	2022-10-14 11:09:59.897+07
57	1665720478050	1665720478037	DEPLOYMENT	100	10	1	2022-04-30	t	2022-04-16	2022-10-14 11:07:58.048+07	2022-10-14 11:07:58.048+07
59	1665721143019	1665721143012	PEMBUATAN KONSEP	100	15	1	2022-04-30	t	2022-04-01	2022-10-14 11:19:03.019+07	2022-10-14 11:19:03.019+07
60	1665721143020	1665721143012	DESIGN UI/UX	100	20	1	2022-05-30	t	2022-05-01	2022-10-14 11:19:03.02+07	2022-10-14 11:19:03.02+07
62	1665721143022	1665721143012	DEVELOPMENT	100	35	1	2022-08-10	t	2022-05-20	2022-10-14 11:19:03.02+07	2022-10-14 11:19:03.02+07
64	1665721143024	1665721143012	DEPLOYMENT	100	10	1	2022-08-30	t	2022-08-20	2022-10-14 11:19:03.021+07	2022-10-14 11:19:03.021+07
89	1671510862068	1671510861987	TESTING	100	10	1	2022-07-20	t	2022-07-10	2022-12-20 11:34:22.068+07	2022-12-20 11:34:22.068+07
67	1665721647201	1665721647192	TRIAL ERROR	100	20	4	2022-06-15	t	2022-06-01	2022-10-14 11:27:27.2+07	2022-10-14 11:27:27.2+07
65	1665721647199	1665721647192	KONSEP	100	20	3	2022-01-30	t	2022-01-01	2022-10-14 11:27:27.199+07	2022-10-14 11:27:27.199+07
66	1665721647200	1665721647192	DEVELOPMENT	100	40	8	2022-05-30	t	2022-02-01	2022-10-14 11:27:27.2+07	2022-10-14 11:27:27.2+07
68	1665721689397	1665721647192	SOSIALISASI	100	5	3	2022-06-20	t	2022-06-15	2022-10-14 11:28:09.445+07	2022-10-14 11:28:09.445+07
80	1668157435648	1665718769331	AUTOCLAVE	0	20	4	2023-02-28	f	2023-02-01	2022-11-11 16:03:55.703+07	2022-11-11 16:03:55.703+07
77	1668157202297	1665718769331	MIXING	100	15	4	2022-09-30	t	2022-08-01	2022-11-11 16:00:02.354+07	2022-11-11 16:00:02.354+07
37	1665719137955	1665719137946	KONSEP	100	15	4	2022-06-01	t	2022-04-01	2022-10-14 10:45:37.955+07	2022-10-14 10:45:37.955+07
38	1665719137956	1665719137946	DEVELOP	100	40	8	2022-12-01	t	2022-01-01	2022-10-14 10:45:37.956+07	2022-10-14 10:45:37.956+07
78	1668157237557	1665718769331	BALLMIL	0	10	4	2022-11-30	f	2022-11-01	2022-11-11 16:00:37.618+07	2022-11-11 16:00:37.618+07
81	1668157555414	1665735431998	PENGUMPULAN DATA	100	10	4	2022-01-01	t	2021-04-11	2022-11-11 16:05:55.468+07	2022-11-11 16:05:55.468+07
83	1668157652549	1665735431998	TRIAL ERROR	100	20	4	2022-04-09	t	2022-04-01	2022-11-11 16:07:32.605+07	2022-11-11 16:07:32.605+07
69	1665721719829	1665721647192	DEPLOYMENT	100	5	4	2022-06-30	t	2022-06-20	2022-10-14 11:28:39.873+07	2022-10-14 11:28:39.873+07
82	1668157614843	1665735431998	DEVELOPMENT	100	30	4	2022-04-04	t	2022-01-01	2022-11-11 16:06:54.929+07	2022-12-15 15:04:55+07
90	1671511339119	1671511339112	PENAWARAN VENDOR	100	30	4	2019-03-31	t	2022-01-01	2022-12-20 11:42:19.12+07	2022-12-20 11:42:19.12+07
39	1665719137957	1665719137946	PENGUJIAN DAN PERBAIKAN DATA	0	20	1	2022-05-01	f	2022-03-01	2022-10-14 10:45:37.956+07	2022-12-15 15:07:18+07
70	1665723095695	1665723095688	PENGUMPULAN DATA SISTEM	100	10	1	2022-01-30	t	2022-01-01	2022-10-14 11:51:35.695+07	2022-12-20 11:21:37+07
85	1671510862064	1671510861987	GENESIS	100	10	1	2022-04-18	t	2022-04-04	2022-12-20 11:34:22.065+07	2022-12-20 11:34:22.065+07
86	1671510862065	1671510861987	ANALISIS	100	15	1	2022-04-25	t	2022-04-15	2022-12-20 11:34:22.066+07	2022-12-20 11:34:22.066+07
87	1671510862066	1671510861987	DESIGN	100	25	1	2022-05-15	t	2022-04-25	2022-12-20 11:34:22.067+07	2022-12-20 11:34:22.067+07
91	1671511339120	1671511339112	PENGAJUAN	100	20	4	2019-04-30	t	2019-04-01	2022-12-20 11:42:19.12+07	2022-12-20 11:42:19.12+07
92	1671511339121	1671511339112	INSTALASI	100	50	4	2019-12-31	t	2019-06-01	2022-12-20 11:42:19.121+07	2022-12-20 11:42:19.121+07
93	1671511362861	1671510861987	DEPLOYMENT	100	10	1	2022-07-30	t	2022-07-20	2022-12-20 11:42:43.084+07	2022-12-20 11:42:43.084+07
94	1671511485060	1665723095688	PENGEMBANGAN SISTEM	100	35	1	2022-08-30	t	2022-06-01	2022-12-20 11:44:45.097+07	2023-01-05 16:07:37+07
98	1671511916224	1671511916215	ANALISA ALUR	100	15	1	2022-02-07	t	2022-02-01	2022-12-20 11:51:56.225+07	2022-12-20 11:51:56.225+07
99	1671511916225	1671511916215	DESIGN SISTEM	100	20	1	2022-02-15	t	2022-02-07	2022-12-20 11:51:56.225+07	2022-12-20 11:51:56.225+07
100	1671511916226	1671511916215	PENGEMBANGAN SISTEM	100	35	1	2022-02-28	t	2022-02-15	2022-12-20 11:51:56.225+07	2022-12-20 11:51:56.225+07
95	1671511684994	1671511684988	PENAWARAN	100	30	4	2019-12-31	t	2018-01-01	2022-12-20 11:48:04.995+07	2022-12-20 11:48:04.995+07
96	1671511684995	1671511684988	INSTALASI	100	50	4	2019-04-30	t	2019-01-01	2022-12-20 11:48:04.995+07	2022-12-20 11:48:04.995+07
101	1671511916227	1671511916215	UJICOBA SISTEM	100	10	1	2022-02-28	t	2022-02-28	2022-12-20 11:51:56.226+07	2022-12-20 11:51:56.226+07
102	1671512161065	1671511916215	DEPLOYMENT	100	20	1	2022-03-01	t	2022-03-01	2022-12-20 11:56:01.067+07	2022-12-20 11:56:01.067+07
97	1671511684996	1671511684988	IMPLEMENTASI	100	20	4	2019-05-20	t	2019-05-20	2022-12-20 11:48:04.995+07	2022-12-20 11:56:32+07
104	1671512391304	1671512391293	IMPLEMENTASI PROGRAM	100	45	1	2022-05-28	t	2022-05-10	2022-12-20 11:59:51.304+07	2022-12-20 11:59:51.304+07
84	1668157697414	1665735431998	IMPLENTASI	100	30	4	2022-05-14	t	2022-05-01	2022-11-11 16:08:17.476+07	2022-11-11 16:08:17.476+07
71	1665723095697	1665723095688	DEVELOPMENT	0	20	8	2022-06-01	f	2022-03-01	2022-10-14 11:51:35.695+07	2023-01-05 16:06:19+07
103	1671512391303	1671512391293	ANALISA KEBUTUHAN	100	25	1	2022-05-10	t	2022-05-01	2022-12-20 11:59:51.303+07	2022-12-20 11:59:51.303+07
105	1671512391305	1671512391293	UJICOBA PROGRAM	100	10	1	2022-05-29	t	2022-05-28	2022-12-20 11:59:51.304+07	2022-12-20 11:59:51.304+07
106	1671512391306	1671512391293	DEPLOYMENT	100	10	1	2022-05-30	t	2022-05-30	2022-12-20 11:59:51.304+07	2022-12-20 11:59:51.304+07
107	1671512928292	1671512928282	PENAWARAN	100	30	4	2020-12-31	t	2020-01-01	2022-12-20 12:08:48.292+07	2022-12-20 12:08:48.292+07
108	1671512928293	1671512928282	PENGAJUAN	100	10	4	2019-04-30	t	2019-04-01	2022-12-20 12:08:48.292+07	2022-12-20 12:08:48.292+07
109	1671512928294	1671512928282	SETTING DAN INSTALASI	100	50	4	2020-10-01	t	2019-05-20	2022-12-20 12:08:48.292+07	2022-12-20 12:08:48.292+07
110	1671512928295	1671512928282	IMPLEMENTASI	100	10	4	2020-12-31	t	2020-10-01	2022-12-20 12:08:48.292+07	2022-12-20 12:08:48.292+07
111	1671513444138	1671513444122	PENAWARAN GENSET	100	30	4	2021-12-31	t	2021-01-20	2022-12-20 12:17:24.139+07	2022-12-20 12:17:24.139+07
112	1671513444139	1671513444122	PENAWARAN UPS 6000W	100	20	4	2022-06-30	t	2022-01-01	2022-12-20 12:17:24.139+07	2022-12-20 12:17:24.139+07
113	1671513444140	1671513444122	PENAGJUAN UPS 6000W	100	10	4	2022-10-31	t	2022-07-20	2022-12-20 12:17:24.139+07	2022-12-20 12:17:24.139+07
114	1671513444141	1671513444122	INSTALASI	100	40	4	2022-12-12	t	2022-01-11	2022-12-20 12:17:24.14+07	2022-12-20 12:17:24.14+07
115	1671514254066	1671514254059	ANALISA	100	20	4	2017-01-31	t	2017-01-20	2022-12-20 12:30:54.066+07	2022-12-20 12:30:54.066+07
116	1671514254067	1671514254059	PENGEMBANGAN	100	50	4	2017-03-30	t	2017-02-01	2022-12-20 12:30:54.067+07	2022-12-20 12:30:54.067+07
117	1671514254068	1671514254059	TRIAL ERROR	100	10	4	2017-04-30	t	2017-04-01	2022-12-20 12:30:54.067+07	2022-12-20 12:30:54.067+07
118	1671514254069	1671514254059	IMPLEMENTASI	100	20	4	2017-06-01	t	2017-05-01	2022-12-20 12:30:54.067+07	2022-12-20 12:30:54.067+07
119	1671514711449	1671514711439	ANALISA MASALAH	100	30	4	2019-02-01	t	2019-01-01	2022-12-20 12:38:31.449+07	2022-12-20 12:38:31.449+07
120	1671514711450	1671514711439	PENGUMPULAN DATA	100	10	4	2019-02-01	t	2019-02-01	2022-12-20 12:38:31.449+07	2022-12-20 12:38:31.449+07
121	1671514711451	1671514711439	PENGEMBANGAN APLIKASI	100	50	4	2019-04-01	t	2019-03-01	2022-12-20 12:38:31.449+07	2022-12-20 12:38:31.449+07
122	1671514711452	1671514711439	IMPEMENTASI	100	10	4	2019-06-01	t	2019-05-01	2022-12-20 12:38:31.45+07	2022-12-20 12:38:31.45+07
123	1671515245137	1671515245116	PENGADAAN	100	20	4	2014-03-01	t	2014-01-01	2022-12-20 12:47:25.137+07	2022-12-20 12:47:25.137+07
124	1671515245138	1671515245116	SETTING	100	20	4	2014-04-30	t	2014-04-01	2022-12-20 12:47:25.137+07	2022-12-20 12:47:25.137+07
125	1671515245139	1671515245116	REGISTRASI KARYAWAN	100	50	4	2014-07-30	t	2014-06-01	2022-12-20 12:47:25.138+07	2022-12-20 12:47:25.138+07
126	1671515245140	1671515245116	IMPLEMENTASI	100	10	4	2014-08-01	t	2014-06-01	2022-12-20 12:47:25.138+07	2022-12-20 12:47:25.138+07
127	1671515882675	1671515882666	ANALISA MASALAH	100	30	4	2022-09-01	t	2022-08-01	2022-12-20 12:58:02.675+07	2022-12-20 12:58:02.675+07
128	1671515882676	1671515882666	KEBUTUHAN PERANGKAT	100	20	2	2022-09-01	t	2022-09-01	2022-12-20 12:58:02.676+07	2022-12-20 12:58:02.676+07
129	1671515882677	1671515882666	PENGEMBANGAN	100	40	4	2022-09-01	t	2022-09-01	2022-12-20 12:58:02.676+07	2022-12-20 12:58:02.676+07
130	1671515882678	1671515882666	TRIAL DAN IMPLENTASI	100	10	4	2022-10-01	t	2022-10-01	2022-12-20 12:58:02.676+07	2022-12-20 12:58:02.676+07
131	1671516387606	1671516387598	PENGADAAN	100	30	2	2022-08-01	t	2022-01-01	2022-12-20 13:06:27.606+07	2022-12-20 13:06:27.606+07
132	1671516387607	1671516387598	INSTALASI	100	50	2	2022-11-30	t	2022-11-01	2022-12-20 13:06:27.607+07	2022-12-20 13:06:27.607+07
133	1671516387608	1671516387598	SETTING	100	20	3	2022-11-30	t	2022-11-01	2022-12-20 13:06:27.607+07	2022-12-20 13:06:27.607+07
134	1671516573098	1671516573091	DEVELOPMENT	100	100	1	2022-01-31	t	2022-01-01	2022-12-20 13:09:33.098+07	2022-12-20 13:09:33.098+07
135	1671516805668	1671516805656	DESAIN	100	25	1	2022-08-05	t	2022-08-01	2022-12-20 13:13:25.669+07	2022-12-20 13:13:25.669+07
136	1671516805669	1671516805656	CODING	100	40	1	2022-08-15	t	2022-08-05	2022-12-20 13:13:25.669+07	2022-12-20 13:13:25.669+07
137	1671516805670	1671516805656	DEVOPS	100	15	1	2022-08-17	t	2022-08-15	2022-12-20 13:13:25.669+07	2022-12-20 13:13:25.669+07
138	1671516805671	1671516805656	DEPLOYMENT	100	20	1	20200-08-19	t	2022-08-16	2022-12-20 13:13:25.67+07	2022-12-20 13:13:25.67+07
140	1671517107324	1671517107318	PENGEMBANGAN	100	60	4	2022-02-28	t	2022-02-01	2022-12-20 13:18:27.325+07	2022-12-20 13:18:27.325+07
141	1671517107325	1671517107318	TRIAL DAN IMPLEMENTASI	100	40	4	2022-02-28	t	2022-02-01	2022-12-20 13:18:27.325+07	2022-12-20 13:18:27.325+07
139	1671517057707	1671517057701	DEVELOPMENT	100	40	1	2022-06-20	t	2022-06-01	2022-12-20 13:17:37.708+07	2022-12-20 13:17:37.708+07
142	1671517597740	1671517597733	MENCARI REFRENSI DAN TUTORIAL	100	30	4	2020-01-31	t	2020-01-20	2022-12-20 13:26:37.74+07	2022-12-20 13:26:37.74+07
143	1671517597741	1671517597733	INSTALASI DAN TRIAL	100	50	4	2020-02-29	t	2020-02-01	2022-12-20 13:26:37.741+07	2022-12-20 13:26:37.741+07
144	1671517597742	1671517597733	SETTING DAN IMPLEMENTASI	100	20	3	2020-06-20	t	2020-03-01	2022-12-20 13:26:37.741+07	2022-12-20 13:26:37.741+07
145	1671517980480	1665735431998	INPUT ALL DATA ASET	0	40	2	2022-12-31	f	2022-12-01	2022-12-20 13:33:00.518+07	2022-12-20 13:33:00.518+07
147	1671583933081	1671583933063	COMPILE/UPGRADE	0	20	8	2023-03-01	f	2023-03-01	2022-12-21 07:52:13.082+07	2022-12-21 07:52:13.082+07
148	1671583933082	1671583933063	TRIAL USER	0	20	3	2023-04-01	f	2023-04-01	2022-12-21 07:52:13.082+07	2022-12-21 07:52:13.082+07
149	1671583933083	1671583933063	IMPLEMENTASI	0	30	2	2023-04-01	f	2023-04-01	2022-12-21 07:52:13.083+07	2022-12-21 07:52:13.083+07
151	1671584305181	1671584305171	PENGEMBANGAN	0	50	8	2023-03-01	f	2023-02-01	2022-12-21 07:58:25.181+07	2022-12-21 07:58:25.181+07
152	1671584305182	1671584305171	TRIAL ERROR	0	20	3	2023-04-30	f	2023-04-01	2022-12-21 07:58:25.181+07	2022-12-21 07:58:25.181+07
153	1671584305183	1671584305171	IMPLEMENTASI	0	10	3	2023-04-30	f	2023-04-01	2022-12-21 07:58:25.182+07	2022-12-21 07:58:25.182+07
156	1671584786085	1671584786079	KONSEP	0	30	4	2023-01-30	f	2023-01-01	2022-12-21 08:06:26.085+07	2022-12-21 08:06:26.085+07
157	1671584786087	1671584786079	PENGADAAN PERANGKAT	0	30	2	2023-04-30	f	2023-03-01	2022-12-21 08:06:26.086+07	2022-12-21 08:06:26.086+07
158	1671584786088	1671584786079	IMPLEMENTASI	0	10	2	2023-06-30	f	2023-06-01	2022-12-21 08:06:26.087+07	2022-12-21 08:06:26.087+07
146	1671583933080	1671583933063	KONSEP	100	20	4	2023-02-01	t	2023-02-01	2022-12-21 07:52:13.081+07	2022-12-21 07:52:13.081+07
150	1671584305180	1671584305171	PENGUMPULAN DATA	100	10	3	2023-01-01	t	2023-01-01	2022-12-21 07:58:25.18+07	2022-12-21 07:58:25.18+07
154	1671584305184	1671584305171	KONSEP	100	10	4	2023-01-30	t	2023-01-01	2022-12-21 07:58:25.182+07	2022-12-21 07:58:25.182+07
160	1671585230564	1671584472145	TRIAL ERROR NEW KONSEP	0	10	4	2023-02-28	f	2023-02-01	2022-12-21 08:13:50.599+07	2022-12-21 08:13:50.599+07
161	1671585283842	1671584472145	RESET DAN TRIAL INPUT	0	30	1	2023-03-30	f	2023-03-01	2022-12-21 08:14:43.878+07	2022-12-21 08:14:43.878+07
162	1671585498466	1671584472145	IMPLEMENTASI	0	30	3	2023-06-30	f	2023-05-01	2022-12-21 08:18:18.509+07	2022-12-21 08:18:18.509+07
159	1671585182861	1671584472145	NEW KONSEP PMMC	100	30	4	2023-01-30	t	2023-01-01	2022-12-21 08:13:02.905+07	2022-12-21 08:13:02.905+07
\.


--
-- TOC entry 3186 (class 0 OID 42492)
-- Dependencies: 487
-- Data for Name: users; Type: TABLE DATA; Schema: sc_pms; Owner: postgres
--

COPY sc_pms.users (id, uuid, name, email, password, role, "createdAt", "updatedAt") FROM stdin;
2	ba35aaf8-1b29-44ec-a860-d3f124b17e3b	Rino	rino@itnbi.local	$argon2id$v=19$m=4096,t=3,p=1$StgXQCY+33TeQKS8Y222Yg$HUGlxlaySoVEOGNuT64rwO8EAQE7ZoEj9YT9HA1jqMY	user	2022-09-15 15:39:29.946+07	2022-09-15 15:39:29.946+07
3	6b7ab1cc-5412-4051-b492-1bfef2405b1c	Tino	tino@itnbi.local	$argon2id$v=19$m=4096,t=3,p=1$qzRraUHrDjtqkV7vhy8FDA$BnaglYcFu/1XTEpdfEcBlS+tzTFYYrhbnlSwAZEnEvs	user	2022-09-16 09:23:19.16+07	2022-09-16 09:23:19.16+07
4	0547c3e9-7ca7-4770-ad80-4bd43449fc34	Ikhwan	ikhwan@itnbi.local	$argon2id$v=19$m=4096,t=3,p=1$a+dcRQvnuJEkKh5Yosa8ew$8n0cpUM/iRtOgBJvH3oOKz54OEnrl+D+hGLX6Jvo9Zg	user	2022-09-16 09:23:29.956+07	2022-09-16 09:23:29.956+07
5	5507e7a3-23a2-4587-a325-e887439a0629	Mario	mario@itnbi.local	$argon2id$v=19$m=4096,t=3,p=1$nT1N9BUELppXR5tdoVAruQ$ZjMKky+czJNrEMLbP8NJhqpymuLwae+0F7GUBc7IQ2Y	user	2022-09-16 09:23:50.25+07	2022-09-16 09:23:50.25+07
6	1fcc43d1-5e3a-48e0-8c47-f9ce862c5d31	Administrator	admin@itnbi.local	$argon2id$v=19$m=4096,t=3,p=1$5r/y8rzPQ0BFwJP/0y6A/Q$ACTk8TepiQnwOEtBfXDbXi1By9CKXB0Cxw+pinsjeVw	admin	2022-09-16 10:27:15.716+07	2022-09-16 10:27:15.716+07
1	7c1a8998-4611-416a-9a31-54fa198e2142	Rido Martupa	rido@itnbi.local	$argon2id$v=19$m=4096,t=3,p=1$Sn4yElzsKDEfFvtm8auHSg$vmiwK8ROyHIhiKfHUIkziS9NwOAm4q60hyGBC+AmUqY	user	2022-09-14 16:48:01.135+07	2022-09-14 16:48:01.135+07
8	aeac8e47-b4e9-4121-bb3f-175b0d224aa4	IT SBY	itsby@itnbi.local	$argon2id$v=19$m=4096,t=3,p=1$bN87dfRISaUH6RXv3Xb15Q$kg54l7ZkvHDhyTaPA44B/jIpEFS8jIegV+8leXAeWDM	user	2022-10-14 10:34:28.142+07	2022-10-14 10:34:28.142+07
9	f46913fb-e241-4998-bb6a-b66114724a8c	Admin SBY	adm_sby@itnbi.local	$argon2id$v=19$m=4096,t=3,p=1$T6oCVqglL+nwWJVU0alJ0A$EFstVo7o2Lru6jwVnxlLf2rjQDsaKQ0BhWOtzZ78Fxo	admin	2022-10-14 14:23:10.022+07	2022-10-14 14:23:10.022+07
\.


--
-- TOC entry 3204 (class 0 OID 0)
-- Dependencies: 490
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: sc_pms; Owner: postgres
--

SELECT pg_catalog.setval('sc_pms.project_id_seq', 96, true);


--
-- TOC entry 3205 (class 0 OID 0)
-- Dependencies: 488
-- Name: sub_task_id_seq; Type: SEQUENCE SET; Schema: sc_pms; Owner: postgres
--

SELECT pg_catalog.setval('sc_pms.sub_task_id_seq', 153, true);


--
-- TOC entry 3206 (class 0 OID 0)
-- Dependencies: 492
-- Name: task_id_seq; Type: SEQUENCE SET; Schema: sc_pms; Owner: postgres
--

SELECT pg_catalog.setval('sc_pms.task_id_seq', 162, true);


--
-- TOC entry 3207 (class 0 OID 0)
-- Dependencies: 486
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: sc_pms; Owner: postgres
--

SELECT pg_catalog.setval('sc_pms.users_id_seq', 9, true);


--
-- TOC entry 3069 (class 2606 OID 42905)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: sc_pms; Owner: postgres
--

ALTER TABLE ONLY sc_pms.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- TOC entry 3065 (class 2606 OID 42577)
-- Name: project project_pkey; Type: CONSTRAINT; Schema: sc_pms; Owner: postgres
--

ALTER TABLE ONLY sc_pms.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- TOC entry 3063 (class 2606 OID 42566)
-- Name: sub_task subtask_pkey; Type: CONSTRAINT; Schema: sc_pms; Owner: postgres
--

ALTER TABLE ONLY sc_pms.sub_task
    ADD CONSTRAINT subtask_pkey PRIMARY KEY (id, subtaskid, taskid);


--
-- TOC entry 3067 (class 2606 OID 42751)
-- Name: task task_project_pkey; Type: CONSTRAINT; Schema: sc_pms; Owner: postgres
--

ALTER TABLE ONLY sc_pms.task
    ADD CONSTRAINT task_project_pkey PRIMARY KEY (id, taskid);


--
-- TOC entry 3061 (class 2606 OID 42500)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: sc_pms; Owner: postgres
--

ALTER TABLE ONLY sc_pms.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


-- Completed on 2023-02-09 14:35:48

--
-- PostgreSQL database dump complete
--

