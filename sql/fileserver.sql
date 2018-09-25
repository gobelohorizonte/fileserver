--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.9
-- Dumped by pg_dump version 9.6.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: fi_4f44781103890609ff507f62317e8a10ab078f1f; Type: TABLE; Schema: public; Owner: fileserver
--

CREATE TABLE public.fi_4f44781103890609ff507f62317e8a10ab078f1f (
    work_id integer NOT NULL,
    work_uid character varying(200) NOT NULL,
    work_uiduser character varying(200) NOT NULL,
    work_uidfolder character varying(200) NOT NULL,
    work_name character varying(200) NOT NULL,
    work_uidwks character varying(200) NOT NULL,
    work_data_criacao date DEFAULT ('now'::text)::date NOT NULL,
    work_data_up date DEFAULT ('now'::text)::date NOT NULL,
    work_hora_criacao time without time zone DEFAULT ('now'::text)::time with time zone NOT NULL,
    work_hora_up time without time zone DEFAULT ('now'::text)::time with time zone NOT NULL,
    work_user_up character varying(200) NOT NULL,
    work_user_criacao character varying(200) NOT NULL,
    work_ip character varying(50) NOT NULL,
    work_browser character varying(200) NOT NULL,
    work_type character varying(200),
    work_size numeric DEFAULT 0.0,
    work_timespent character varying(60) NOT NULL,
    work_descricao text,
    work_remocao integer DEFAULT 2 NOT NULL,
    work_remocao_data date DEFAULT ('now'::text)::date,
    work_remocao_hora time without time zone DEFAULT ('now'::text)::time with time zone,
    work_remocao_user character varying(200),
    work_remocao_ip character varying(50),
    work_remocao_browser character varying(200)
);


ALTER TABLE public.fi_4f44781103890609ff507f62317e8a10ab078f1f OWNER TO fileserver;

--
-- Name: fi_4f44781103890609ff507f62317e8a10ab078f1f_work_id_seq; Type: SEQUENCE; Schema: public; Owner: fileserver
--

CREATE SEQUENCE public.fi_4f44781103890609ff507f62317e8a10ab078f1f_work_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fi_4f44781103890609ff507f62317e8a10ab078f1f_work_id_seq OWNER TO fileserver;

--
-- Name: fi_4f44781103890609ff507f62317e8a10ab078f1f_work_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fileserver
--

ALTER SEQUENCE public.fi_4f44781103890609ff507f62317e8a10ab078f1f_work_id_seq OWNED BY public.fi_4f44781103890609ff507f62317e8a10ab078f1f.work_id;


--
-- Name: fileserver_login; Type: TABLE; Schema: public; Owner: fileserver
--

CREATE TABLE public.fileserver_login (
    logi_id integer NOT NULL,
    logi_uid character varying(200) NOT NULL,
    logi_token_access character varying(100) NOT NULL,
    logi_key_access character varying(100) NOT NULL,
    logi_email character varying(120) NOT NULL,
    logi_name character varying(100) NOT NULL,
    logi_last_name character varying(100) NOT NULL,
    logi_country character varying(100) NOT NULL,
    logi_birth date NOT NULL,
    logi_password character varying(100) NOT NULL,
    logi_change_password integer DEFAULT 2,
    logi_password_key character varying(100),
    logi_data_criacao date DEFAULT ('now'::text)::date NOT NULL,
    logi_hora_criacao time without time zone DEFAULT ('now'::text)::time with time zone,
    logi_user_criacao character varying(100) NOT NULL,
    logi_user_update character varying(100) NOT NULL,
    logi_data_update date DEFAULT ('now'::text)::date NOT NULL,
    logi_hora_update time without time zone DEFAULT ('now'::text)::time with time zone NOT NULL,
    logi_browser character varying(5500) NOT NULL,
    logi_ip character varying(20) NOT NULL,
    logi_verified integer DEFAULT 2 NOT NULL,
    logi_avatar_device integer DEFAULT 1 NOT NULL,
    logi_plan character varying(50) DEFAULT 'free'::character varying NOT NULL,
    logi_level integer DEFAULT 1 NOT NULL,
    logi_status integer DEFAULT 1 NOT NULL,
    logi_contract integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.fileserver_login OWNER TO fileserver;

--
-- Name: COLUMN fileserver_login.logi_verified; Type: COMMENT; Schema: public; Owner: fileserver
--

COMMENT ON COLUMN public.fileserver_login.logi_verified IS '2 - Nao, 1 - Sim';


--
-- Name: COLUMN fileserver_login.logi_avatar_device; Type: COMMENT; Schema: public; Owner: fileserver
--

COMMENT ON COLUMN public.fileserver_login.logi_avatar_device IS '1 - upload  2 - gravatar 3 - facebook';


--
-- Name: COLUMN fileserver_login.logi_status; Type: COMMENT; Schema: public; Owner: fileserver
--

COMMENT ON COLUMN public.fileserver_login.logi_status IS '1 - ative, 2 - inative';


--
-- Name: fileserver_login_logi_id_seq; Type: SEQUENCE; Schema: public; Owner: fileserver
--

CREATE SEQUENCE public.fileserver_login_logi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fileserver_login_logi_id_seq OWNER TO fileserver;

--
-- Name: fileserver_login_logi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fileserver
--

ALTER SEQUENCE public.fileserver_login_logi_id_seq OWNED BY public.fileserver_login.logi_id;


--
-- Name: fileserver_workspace; Type: TABLE; Schema: public; Owner: fileserver
--

CREATE TABLE public.fileserver_workspace (
    wks_id integer NOT NULL,
    wks_uid character varying(200) NOT NULL,
    wks_data date DEFAULT ('now'::text)::date NOT NULL,
    wks_hora time without time zone DEFAULT ('now'::text)::time with time zone NOT NULL,
    wks_uiduser character varying(200) NOT NULL,
    wks_ip character varying(20) NOT NULL,
    wks_browser text NOT NULL,
    wks_status integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.fileserver_workspace OWNER TO fileserver;

--
-- Name: COLUMN fileserver_workspace.wks_status; Type: COMMENT; Schema: public; Owner: fileserver
--

COMMENT ON COLUMN public.fileserver_workspace.wks_status IS 'comentario';


--
-- Name: fileserver_workspace_wks_id_seq; Type: SEQUENCE; Schema: public; Owner: fileserver
--

CREATE SEQUENCE public.fileserver_workspace_wks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fileserver_workspace_wks_id_seq OWNER TO fileserver;

--
-- Name: fileserver_workspace_wks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fileserver
--

ALTER SEQUENCE public.fileserver_workspace_wks_id_seq OWNED BY public.fileserver_workspace.wks_id;


--
-- Name: fo_4f44781103890609ff507f62317e8a10ab078f1f; Type: TABLE; Schema: public; Owner: fileserver
--

CREATE TABLE public.fo_4f44781103890609ff507f62317e8a10ab078f1f (
    workf_id integer NOT NULL,
    workf_uid character varying(200) NOT NULL,
    workf_name character varying(100) NOT NULL,
    workf_uidpai character varying(200),
    workf_uiduser character varying(200) NOT NULL,
    workf_uidwks character varying(200) NOT NULL,
    workf_data_criacao date DEFAULT ('now'::text)::date NOT NULL,
    workf_data_up date DEFAULT ('now'::text)::date NOT NULL,
    workf_hora_criacao time without time zone DEFAULT ('now'::text)::time with time zone NOT NULL,
    workf_hora_up time without time zone DEFAULT ('now'::text)::time with time zone NOT NULL,
    workf_ip character varying(50) NOT NULL,
    workf_browser character varying(200) NOT NULL,
    workf_user_up character varying(200) NOT NULL,
    workf_user_criacao character varying(200) NOT NULL,
    workf_remocao integer DEFAULT 2 NOT NULL,
    workf_remocao_data date DEFAULT ('now'::text)::date NOT NULL,
    workf_remocao_hora time without time zone DEFAULT ('now'::text)::time with time zone NOT NULL,
    workf_remocao_user character varying(200) NOT NULL,
    workf_remocao_ip character varying(50) NOT NULL,
    workf_remocao_browser character varying(200) NOT NULL
);


ALTER TABLE public.fo_4f44781103890609ff507f62317e8a10ab078f1f OWNER TO fileserver;

--
-- Name: fo_4f44781103890609ff507f62317e8a10ab078f1f_workf_id_seq; Type: SEQUENCE; Schema: public; Owner: fileserver
--

CREATE SEQUENCE public.fo_4f44781103890609ff507f62317e8a10ab078f1f_workf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fo_4f44781103890609ff507f62317e8a10ab078f1f_workf_id_seq OWNER TO fileserver;

--
-- Name: fo_4f44781103890609ff507f62317e8a10ab078f1f_workf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fileserver
--

ALTER SEQUENCE public.fo_4f44781103890609ff507f62317e8a10ab078f1f_workf_id_seq OWNED BY public.fo_4f44781103890609ff507f62317e8a10ab078f1f.workf_id;


--
-- Name: fi_4f44781103890609ff507f62317e8a10ab078f1f work_id; Type: DEFAULT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fi_4f44781103890609ff507f62317e8a10ab078f1f ALTER COLUMN work_id SET DEFAULT nextval('public.fi_4f44781103890609ff507f62317e8a10ab078f1f_work_id_seq'::regclass);


--
-- Name: fileserver_login logi_id; Type: DEFAULT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fileserver_login ALTER COLUMN logi_id SET DEFAULT nextval('public.fileserver_login_logi_id_seq'::regclass);


--
-- Name: fileserver_workspace wks_id; Type: DEFAULT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fileserver_workspace ALTER COLUMN wks_id SET DEFAULT nextval('public.fileserver_workspace_wks_id_seq'::regclass);


--
-- Name: fo_4f44781103890609ff507f62317e8a10ab078f1f workf_id; Type: DEFAULT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fo_4f44781103890609ff507f62317e8a10ab078f1f ALTER COLUMN workf_id SET DEFAULT nextval('public.fo_4f44781103890609ff507f62317e8a10ab078f1f_workf_id_seq'::regclass);


--
-- Data for Name: fi_4f44781103890609ff507f62317e8a10ab078f1f; Type: TABLE DATA; Schema: public; Owner: fileserver
--



--
-- Name: fi_4f44781103890609ff507f62317e8a10ab078f1f_work_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fileserver
--

SELECT pg_catalog.setval('public.fi_4f44781103890609ff507f62317e8a10ab078f1f_work_id_seq', 8, true);


--
-- Data for Name: fileserver_login; Type: TABLE DATA; Schema: public; Owner: fileserver
--

INSERT INTO public.fileserver_login VALUES (1, '4f44781103890609ff507f62317e8a10ab078f1f', '2dd3d7ed797b356829fc1b4c8c4c3814b0de504e', 'b5b34a626f76b0c5768c7df77dcb4b53d58e3fe3', 'jeff.otoni@gmail.com', '"jefferson"', 'otoni lima', 'brasil', '1990-10-20', '$2a$10$hSZXFdq6r2xL.bt/QjSpOuRsHaInXjIO.RhrHyG7ZOGDDZeyxMLNi', 2, NULL, '2018-09-24', '22:37:51.81287', 'fileserver', 'fileserver', '2018-09-24', '22:37:51.81287', 'curl', '127.0.0.1', 2, 1, 'free', 1, 1, 1);


--
-- Name: fileserver_login_logi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fileserver
--

SELECT pg_catalog.setval('public.fileserver_login_logi_id_seq', 1, true);


--
-- Data for Name: fileserver_workspace; Type: TABLE DATA; Schema: public; Owner: fileserver
--

INSERT INTO public.fileserver_workspace VALUES (1, '0165716cb70f1c57fa38adf90b5cd217f41552a7', '2018-09-24', '22:40:03.415487', '4f44781103890609ff507f62317e8a10ab078f1f', '127.0.0.1', 'curl', 1);


--
-- Name: fileserver_workspace_wks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fileserver
--

SELECT pg_catalog.setval('public.fileserver_workspace_wks_id_seq', 2, true);


--
-- Data for Name: fo_4f44781103890609ff507f62317e8a10ab078f1f; Type: TABLE DATA; Schema: public; Owner: fileserver
--

INSERT INTO public.fo_4f44781103890609ff507f62317e8a10ab078f1f VALUES (1, 'f1b4bb0641bdd862bb359abb59f5463b4515d3f4', '0123456789.0123456789.0123456789.0123456789.0123456789.0123456789', NULL, '4f44781103890609ff507f62317e8a10ab078f1f', '0165716cb70f1c57fa38adf90b5cd217f41552a7', '2018-09-25', '2018-09-25', '00:53:40.522133', '00:53:40.522133', '127.0.0.1', 'curl', '4f44781103890609ff507f62317e8a10ab078f1f', '4f44781103890609ff507f62317e8a10ab078f1f', 2, '2018-09-25', '00:53:40.522133', '', '', '');


--
-- Name: fo_4f44781103890609ff507f62317e8a10ab078f1f_workf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fileserver
--

SELECT pg_catalog.setval('public.fo_4f44781103890609ff507f62317e8a10ab078f1f_workf_id_seq', 3, true);


--
-- Name: fi_4f44781103890609ff507f62317e8a10ab078f1f fi_4f44781103890609ff507f62317e8a10ab078f1f_pkey; Type: CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fi_4f44781103890609ff507f62317e8a10ab078f1f
    ADD CONSTRAINT fi_4f44781103890609ff507f62317e8a10ab078f1f_pkey PRIMARY KEY (work_id);


--
-- Name: fi_4f44781103890609ff507f62317e8a10ab078f1f fi_4f44781103890609ff507f62317e8a10ab078f1f_work_uid_key; Type: CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fi_4f44781103890609ff507f62317e8a10ab078f1f
    ADD CONSTRAINT fi_4f44781103890609ff507f62317e8a10ab078f1f_work_uid_key UNIQUE (work_uid);


--
-- Name: fileserver_login fileserver_login_logi_email_key; Type: CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fileserver_login
    ADD CONSTRAINT fileserver_login_logi_email_key UNIQUE (logi_email);


--
-- Name: fileserver_login fileserver_login_logi_uid_key; Type: CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fileserver_login
    ADD CONSTRAINT fileserver_login_logi_uid_key UNIQUE (logi_uid);


--
-- Name: fileserver_login fileserver_login_pkey; Type: CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fileserver_login
    ADD CONSTRAINT fileserver_login_pkey PRIMARY KEY (logi_id);


--
-- Name: fileserver_workspace fileserver_workspace_pkey; Type: CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fileserver_workspace
    ADD CONSTRAINT fileserver_workspace_pkey PRIMARY KEY (wks_id);


--
-- Name: fileserver_workspace fileserver_workspace_wks_id_wks_uid_key; Type: CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fileserver_workspace
    ADD CONSTRAINT fileserver_workspace_wks_id_wks_uid_key UNIQUE (wks_uid);


--
-- Name: fileserver_workspace fileserver_workspace_wks_uid_wks_uiduser_key; Type: CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fileserver_workspace
    ADD CONSTRAINT fileserver_workspace_wks_uid_wks_uiduser_key UNIQUE (wks_uid, wks_uiduser);


--
-- Name: fileserver_workspace fileserver_workspace_wks_uiduser_key; Type: CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fileserver_workspace
    ADD CONSTRAINT fileserver_workspace_wks_uiduser_key UNIQUE (wks_uiduser);


--
-- Name: fo_4f44781103890609ff507f62317e8a10ab078f1f fo_4f44781103890609ff507f62317e8a10ab078f1f_pkey; Type: CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fo_4f44781103890609ff507f62317e8a10ab078f1f
    ADD CONSTRAINT fo_4f44781103890609ff507f62317e8a10ab078f1f_pkey PRIMARY KEY (workf_id);


--
-- Name: fo_4f44781103890609ff507f62317e8a10ab078f1f fo_4f44781103890609ff507f62317e8a10ab078f1f_workf_uid_key; Type: CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fo_4f44781103890609ff507f62317e8a10ab078f1f
    ADD CONSTRAINT fo_4f44781103890609ff507f62317e8a10ab078f1f_workf_uid_key UNIQUE (workf_uid);


--
-- Name: fi_iname_4f44781103890609ff507f62317e8a10ab078f1f; Type: INDEX; Schema: public; Owner: fileserver
--

CREATE INDEX fi_iname_4f44781103890609ff507f62317e8a10ab078f1f ON public.fi_4f44781103890609ff507f62317e8a10ab078f1f USING btree (work_name);


--
-- Name: ukfo_iname_fo_4f44781103890609ff507f62317e8a10ab078f1f; Type: INDEX; Schema: public; Owner: fileserver
--

CREATE INDEX ukfo_iname_fo_4f44781103890609ff507f62317e8a10ab078f1f ON public.fo_4f44781103890609ff507f62317e8a10ab078f1f USING btree (workf_name);


--
-- Name: ukfo_ipai_id_fo_4f44781103890609ff507f62317e8a10ab078f1f; Type: INDEX; Schema: public; Owner: fileserver
--

CREATE INDEX ukfo_ipai_id_fo_4f44781103890609ff507f62317e8a10ab078f1f ON public.fo_4f44781103890609ff507f62317e8a10ab078f1f USING btree (workf_uidpai);


--
-- Name: fi_4f44781103890609ff507f62317e8a10ab078f1f fi_4f44781103890609ff507f62317e8a10ab078f1f_work_uidfolder_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fi_4f44781103890609ff507f62317e8a10ab078f1f
    ADD CONSTRAINT fi_4f44781103890609ff507f62317e8a10ab078f1f_work_uidfolder_fkey FOREIGN KEY (work_uidfolder) REFERENCES public.fo_4f44781103890609ff507f62317e8a10ab078f1f(workf_uid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fi_4f44781103890609ff507f62317e8a10ab078f1f fi_4f44781103890609ff507f62317e8a10ab078f1f_work_uiduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fi_4f44781103890609ff507f62317e8a10ab078f1f
    ADD CONSTRAINT fi_4f44781103890609ff507f62317e8a10ab078f1f_work_uiduser_fkey FOREIGN KEY (work_uidwks, work_uiduser) REFERENCES public.fileserver_workspace(wks_uid, wks_uiduser) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fileserver_workspace fileserver_workspace_wks_uiduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fileserver_workspace
    ADD CONSTRAINT fileserver_workspace_wks_uiduser_fkey FOREIGN KEY (wks_uiduser) REFERENCES public.fileserver_login(logi_uid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fo_4f44781103890609ff507f62317e8a10ab078f1f fo_4f44781103890609ff507f62317e8a10ab078f1f_workf_uidpai_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fileserver
--

ALTER TABLE ONLY public.fo_4f44781103890609ff507f62317e8a10ab078f1f
    ADD CONSTRAINT fo_4f44781103890609ff507f62317e8a10ab078f1f_workf_uidpai_fkey FOREIGN KEY (workf_uidpai) REFERENCES public.fo_4f44781103890609ff507f62317e8a10ab078f1f(workf_uid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

