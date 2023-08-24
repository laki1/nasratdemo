--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2023-08-24 12:11:56

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

DROP DATABASE nasratdemo;
--
-- TOC entry 3360 (class 1262 OID 103214)
-- Name: nasratdemo; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE nasratdemo WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Czech_Czechia.1252';


ALTER DATABASE nasratdemo OWNER TO postgres;

\connect nasratdemo

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
-- TOC entry 5 (class 2615 OID 103382)
-- Name: postgraphile_watch; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA postgraphile_watch;


ALTER SCHEMA postgraphile_watch OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 103383)
-- Name: notify_watchers_ddl(); Type: FUNCTION; Schema: postgraphile_watch; Owner: postgres
--

CREATE FUNCTION postgraphile_watch.notify_watchers_ddl() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
begin
  perform pg_notify(
    'postgraphile_watch',
    json_build_object(
      'type',
      'ddl',
      'payload',
      (select json_agg(json_build_object('schema', schema_name, 'command', command_tag)) from pg_event_trigger_ddl_commands() as x)
    )::text
  );
end;
$$;


ALTER FUNCTION postgraphile_watch.notify_watchers_ddl() OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 103384)
-- Name: notify_watchers_drop(); Type: FUNCTION; Schema: postgraphile_watch; Owner: postgres
--

CREATE FUNCTION postgraphile_watch.notify_watchers_drop() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
begin
  perform pg_notify(
    'postgraphile_watch',
    json_build_object(
      'type',
      'drop',
      'payload',
      (select json_agg(distinct x.schema_name) from pg_event_trigger_dropped_objects() as x)
    )::text
  );
end;
$$;


ALTER FUNCTION postgraphile_watch.notify_watchers_drop() OWNER TO postgres;

--
-- TOC entry 219 (class 1255 OID 103360)
-- Name: sf_get_data(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sf_get_data(cislo bigint DEFAULT '-1'::integer) RETURNS text
    LANGUAGE plpgsql
    AS $$DECLARE 
	d TIMESTAMP;
BEGIN
	d := CURRENT_TIMESTAMP(0);
	RETURN CONCAT('Now: ', d, ' / ', 'cislo: ', cislo, ' / ', 'double:', cislo*2);
END$$;


ALTER FUNCTION public.sf_get_data(cislo bigint) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 211 (class 1259 OID 103310)
-- Name: blood; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blood (
    rid integer NOT NULL,
    id integer NOT NULL,
    name character varying(32) DEFAULT ''::character varying NOT NULL,
    ra character varying(1) DEFAULT ''::character varying NOT NULL,
    rt timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    ru integer DEFAULT 0 NOT NULL,
    a boolean DEFAULT false,
    v boolean DEFAULT false
);


ALTER TABLE public.blood OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 103309)
-- Name: blood_rid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blood_rid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blood_rid_seq OWNER TO postgres;

--
-- TOC entry 3361 (class 0 OID 0)
-- Dependencies: 210
-- Name: blood_rid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blood_rid_seq OWNED BY public.blood.rid;


--
-- TOC entry 217 (class 1259 OID 103362)
-- Name: emailing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emailing (
    id integer NOT NULL,
    email character varying(64),
    send boolean DEFAULT false NOT NULL,
    data json
);


ALTER TABLE public.emailing OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 103361)
-- Name: emailing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.emailing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.emailing_id_seq OWNER TO postgres;

--
-- TOC entry 3362 (class 0 OID 0)
-- Dependencies: 216
-- Name: emailing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.emailing_id_seq OWNED BY public.emailing.id;


--
-- TOC entry 214 (class 1259 OID 103343)
-- Name: kell; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kell (
    rid integer NOT NULL,
    id integer NOT NULL,
    abbrev character varying(32) NOT NULL,
    note character varying(64) NOT NULL,
    ra character(1) DEFAULT 'c'::bpchar NOT NULL,
    rt timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    a boolean DEFAULT true NOT NULL,
    v boolean DEFAULT true NOT NULL
);


ALTER TABLE public.kell OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 103342)
-- Name: kell_rid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kell_rid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kell_rid_seq OWNER TO postgres;

--
-- TOC entry 3363 (class 0 OID 0)
-- Dependencies: 213
-- Name: kell_rid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kell_rid_seq OWNED BY public.kell.rid;


--
-- TOC entry 218 (class 1259 OID 103395)
-- Name: restore_point; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.restore_point
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.restore_point OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 103338)
-- Name: v_blood; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_blood AS
 SELECT blood.id,
    blood.name
   FROM public.blood
  WHERE ((blood.a = true) AND (blood.v = true))
  ORDER BY blood.id;


ALTER TABLE public.v_blood OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 103351)
-- Name: v_kell; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_kell AS
 SELECT kell.id,
    kell.abbrev,
    kell.note
   FROM public.kell
  WHERE ((kell.a = true) AND (kell.v = true))
  ORDER BY kell.id;


ALTER TABLE public.v_kell OWNER TO postgres;

--
-- TOC entry 3192 (class 2604 OID 103313)
-- Name: blood rid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood ALTER COLUMN rid SET DEFAULT nextval('public.blood_rid_seq'::regclass);


--
-- TOC entry 3201 (class 2604 OID 103365)
-- Name: emailing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emailing ALTER COLUMN id SET DEFAULT nextval('public.emailing_id_seq'::regclass);


--
-- TOC entry 3196 (class 2604 OID 103346)
-- Name: kell rid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kell ALTER COLUMN rid SET DEFAULT nextval('public.kell_rid_seq'::regclass);


--
-- TOC entry 3349 (class 0 OID 103310)
-- Dependencies: 211
-- Data for Name: blood; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (182, 99, 'AB0 Rh? (směs)', 'c', '2023-08-04 14:07:25', 0, true, true);
INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (3, 28, 'AB Rh-', 'c', '2023-08-04 13:54:06', 0, true, true);
INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (1, 6, 'A Rh-', 'c', '2023-08-04 13:48:02', 0, true, true);
INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (2, 17, 'B Rh-', 'c', '2023-08-04 13:48:24', 0, true, true);
INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (4, 51, '0 Rh+', 'c', '2023-08-04 13:56:24', 0, true, true);
INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (5, 55, '0 Rh?', 'c', '2023-08-04 13:58:04', 0, true, true);
INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (6, 62, 'A Rh+', 'c', '2023-08-04 14:02:10', 0, true, true);
INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (31, 66, 'A Rh?', 'c', '2023-08-04 14:03:14', 0, true, true);
INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (53, 73, 'B Rh+', 'c', '2023-08-04 14:03:50', 0, true, true);
INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (70, 77, 'B Rh?', 'c', '2023-08-04 14:04:36', 0, true, true);
INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (135, 84, 'AB Rh+', 'c', '2023-08-04 14:05:52', 0, true, true);
INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (146, 88, 'AB Rh?', 'c', '2023-08-04 14:06:18', 0, true, true);
INSERT INTO public.blood (rid, id, name, ra, rt, ru, a, v) VALUES (169, 95, '0 Rh-', 'c', '2023-08-04 14:07:01', 0, true, true);


--
-- TOC entry 3353 (class 0 OID 103362)
-- Dependencies: 217
-- Data for Name: emailing; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.emailing (id, email, send, data) VALUES (1, 'blbec_k_veceri@seznam.cz', true, '{"testInt":1,"testString":"Ha!","pi":3.14159132}');


--
-- TOC entry 3351 (class 0 OID 103343)
-- Dependencies: 214
-- Data for Name: kell; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kell (rid, id, abbrev, note, ra, rt, a, v) VALUES (1, 1, 'K-', 'k netypováno', 'c', '2023-08-04 14:46:12', true, true);
INSERT INTO public.kell (rid, id, abbrev, note, ra, rt, a, v) VALUES (3, 3, 'K+', 'k netypováno', 'c', '2023-08-04 14:47:04', true, true);
INSERT INTO public.kell (rid, id, abbrev, note, ra, rt, a, v) VALUES (4, 4, 'K+, k-', 'oba znaky otypovány', 'c', '2023-08-04 14:47:30', true, true);
INSERT INTO public.kell (rid, id, abbrev, note, ra, rt, a, v) VALUES (5, 5, 'K+, k+', 'oba znaky otypovány a přítomny', 'c', '2023-08-04 14:47:51', true, true);
INSERT INTO public.kell (rid, id, abbrev, note, ra, rt, a, v) VALUES (6, 9, 'netypováno', 'netypováno nebo nestandarní výsledek typizace', 'c', '2023-08-04 14:48:10', true, true);
INSERT INTO public.kell (rid, id, abbrev, note, ra, rt, a, v) VALUES (2, 2, 'K-, k+', 'k otypováno a přítomno', 'c', '2023-08-04 14:46:31', true, true);


--
-- TOC entry 3364 (class 0 OID 0)
-- Dependencies: 210
-- Name: blood_rid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blood_rid_seq', 197, true);


--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 216
-- Name: emailing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.emailing_id_seq', 2, true);


--
-- TOC entry 3366 (class 0 OID 0)
-- Dependencies: 213
-- Name: kell_rid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kell_rid_seq', 6, true);


--
-- TOC entry 3367 (class 0 OID 0)
-- Dependencies: 218
-- Name: restore_point; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.restore_point', 1, true);


--
-- TOC entry 3204 (class 2606 OID 103330)
-- Name: blood blood_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood
    ADD CONSTRAINT blood_pkey PRIMARY KEY (rid);


--
-- TOC entry 3206 (class 2606 OID 103370)
-- Name: emailing emailing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emailing
    ADD CONSTRAINT emailing_pkey PRIMARY KEY (id);


--
-- TOC entry 3187 (class 3466 OID 103385)
-- Name: postgraphile_watch_ddl; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER postgraphile_watch_ddl ON ddl_command_end
         WHEN TAG IN ('ALTER AGGREGATE', 'ALTER DOMAIN', 'ALTER EXTENSION', 'ALTER FOREIGN TABLE', 'ALTER FUNCTION', 'ALTER POLICY', 'ALTER SCHEMA', 'ALTER TABLE', 'ALTER TYPE', 'ALTER VIEW', 'COMMENT', 'CREATE AGGREGATE', 'CREATE DOMAIN', 'CREATE EXTENSION', 'CREATE FOREIGN TABLE', 'CREATE FUNCTION', 'CREATE INDEX', 'CREATE POLICY', 'CREATE RULE', 'CREATE SCHEMA', 'CREATE TABLE', 'CREATE TABLE AS', 'CREATE VIEW', 'DROP AGGREGATE', 'DROP DOMAIN', 'DROP EXTENSION', 'DROP FOREIGN TABLE', 'DROP FUNCTION', 'DROP INDEX', 'DROP OWNED', 'DROP POLICY', 'DROP RULE', 'DROP SCHEMA', 'DROP TABLE', 'DROP TYPE', 'DROP VIEW', 'GRANT', 'REVOKE', 'SELECT INTO')
   EXECUTE FUNCTION postgraphile_watch.notify_watchers_ddl();


ALTER EVENT TRIGGER postgraphile_watch_ddl OWNER TO postgres;

--
-- TOC entry 3188 (class 3466 OID 103386)
-- Name: postgraphile_watch_drop; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER postgraphile_watch_drop ON sql_drop
   EXECUTE FUNCTION postgraphile_watch.notify_watchers_drop();


ALTER EVENT TRIGGER postgraphile_watch_drop OWNER TO postgres;

-- Completed on 2023-08-24 12:11:56

--
-- PostgreSQL database dump complete
--

