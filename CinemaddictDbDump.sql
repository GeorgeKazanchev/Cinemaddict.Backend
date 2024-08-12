--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2024-08-13 00:52:13

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
-- TOC entry 894 (class 1247 OID 30066)
-- Name: comment_emotion; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.comment_emotion AS ENUM (
    'Smile',
    'Sleeping',
    'Puke',
    'Angry'
);


ALTER TYPE public.comment_emotion OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 29913)
-- Name: actor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actor (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.actor OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 29912)
-- Name: actor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actor_id_seq OWNER TO postgres;

--
-- TOC entry 3459 (class 0 OID 0)
-- Dependencies: 218
-- Name: actor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actor_id_seq OWNED BY public.actor.id;


--
-- TOC entry 233 (class 1259 OID 30035)
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    content text NOT NULL,
    date timestamp with time zone NOT NULL,
    id_film integer NOT NULL,
    id_author integer NOT NULL,
    id_emotion smallint NOT NULL
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 30034)
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO postgres;

--
-- TOC entry 3460 (class 0 OID 0)
-- Dependencies: 232
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- TOC entry 223 (class 1259 OID 29927)
-- Name: director; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.director (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.director OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 29926)
-- Name: director_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.director_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.director_id_seq OWNER TO postgres;

--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 222
-- Name: director_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.director_id_seq OWNED BY public.director.id;


--
-- TOC entry 235 (class 1259 OID 30076)
-- Name: emotion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emotion (
    id smallint NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.emotion OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 30075)
-- Name: emotion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.emotion_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.emotion_id_seq OWNER TO postgres;

--
-- TOC entry 3462 (class 0 OID 0)
-- Dependencies: 234
-- Name: emotion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.emotion_id_seq OWNED BY public.emotion.id;


--
-- TOC entry 215 (class 1259 OID 29897)
-- Name: film; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    alternative_title character varying(100) NOT NULL,
    poster text NOT NULL,
    description text NOT NULL,
    total_rating numeric(3,1) NOT NULL,
    age_rating smallint NOT NULL,
    runtime smallint NOT NULL,
    id_director integer NOT NULL,
    id_release_info integer NOT NULL
);


ALTER TABLE public.film OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 29938)
-- Name: film_actor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film_actor (
    id_film integer NOT NULL,
    id_actor integer NOT NULL
);


ALTER TABLE public.film_actor OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 29933)
-- Name: film_genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film_genre (
    id_film integer NOT NULL,
    id_genre integer NOT NULL
);


ALTER TABLE public.film_genre OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 29896)
-- Name: film_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.film_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.film_id_seq OWNER TO postgres;

--
-- TOC entry 3463 (class 0 OID 0)
-- Dependencies: 214
-- Name: film_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.film_id_seq OWNED BY public.film.id;


--
-- TOC entry 226 (class 1259 OID 29943)
-- Name: film_writer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film_writer (
    id_film integer NOT NULL,
    id_writer integer NOT NULL
);


ALTER TABLE public.film_writer OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 29906)
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.genre OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 29905)
-- Name: genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genre_id_seq OWNER TO postgres;

--
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 216
-- Name: genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genre_id_seq OWNED BY public.genre.id;


--
-- TOC entry 231 (class 1259 OID 29996)
-- Name: release_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.release_info (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    release_country character varying(50) NOT NULL
);


ALTER TABLE public.release_info OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 29995)
-- Name: release_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.release_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.release_info_id_seq OWNER TO postgres;

--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 230
-- Name: release_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.release_info_id_seq OWNED BY public.release_info.id;


--
-- TOC entry 229 (class 1259 OID 29954)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 29948)
-- Name: user_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_details (
    id_user integer NOT NULL,
    id_film integer NOT NULL,
    is_favorite boolean NOT NULL,
    is_in_watchlist boolean NOT NULL,
    is_watched boolean NOT NULL,
    watching_date timestamp with time zone
);


ALTER TABLE public.user_details OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 29953)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 228
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 221 (class 1259 OID 29920)
-- Name: writer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.writer (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.writer OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 29919)
-- Name: writer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.writer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.writer_id_seq OWNER TO postgres;

--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 220
-- Name: writer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.writer_id_seq OWNED BY public.writer.id;


--
-- TOC entry 3234 (class 2604 OID 29916)
-- Name: actor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor ALTER COLUMN id SET DEFAULT nextval('public.actor_id_seq'::regclass);


--
-- TOC entry 3239 (class 2604 OID 30038)
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- TOC entry 3236 (class 2604 OID 29930)
-- Name: director id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director ALTER COLUMN id SET DEFAULT nextval('public.director_id_seq'::regclass);


--
-- TOC entry 3240 (class 2604 OID 30079)
-- Name: emotion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emotion ALTER COLUMN id SET DEFAULT nextval('public.emotion_id_seq'::regclass);


--
-- TOC entry 3232 (class 2604 OID 29900)
-- Name: film id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film ALTER COLUMN id SET DEFAULT nextval('public.film_id_seq'::regclass);


--
-- TOC entry 3233 (class 2604 OID 29909)
-- Name: genre id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre ALTER COLUMN id SET DEFAULT nextval('public.genre_id_seq'::regclass);


--
-- TOC entry 3238 (class 2604 OID 29999)
-- Name: release_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.release_info ALTER COLUMN id SET DEFAULT nextval('public.release_info_id_seq'::regclass);


--
-- TOC entry 3237 (class 2604 OID 29957)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 3235 (class 2604 OID 29923)
-- Name: writer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writer ALTER COLUMN id SET DEFAULT nextval('public.writer_id_seq'::regclass);


--
-- TOC entry 3437 (class 0 OID 29913)
-- Dependencies: 219
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.actor (id, name) VALUES (1, 'Frank Sinatra');
INSERT INTO public.actor (id, name) VALUES (2, 'Eleanor Parker');
INSERT INTO public.actor (id, name) VALUES (3, 'Kim Novak');
INSERT INTO public.actor (id, name) VALUES (4, 'Erich von Stroheim');
INSERT INTO public.actor (id, name) VALUES (5, 'Mary Beth Hughes');
INSERT INTO public.actor (id, name) VALUES (6, 'Carole Lombard');
INSERT INTO public.actor (id, name) VALUES (7, 'James Stewart');
INSERT INTO public.actor (id, name) VALUES (8, 'Jack Mercer');
INSERT INTO public.actor (id, name) VALUES (9, 'Mae Questel');
INSERT INTO public.actor (id, name) VALUES (10, 'Gus Wickie');
INSERT INTO public.actor (id, name) VALUES (11, 'John Wayne');
INSERT INTO public.actor (id, name) VALUES (12, 'Nancy Shubert');
INSERT INTO public.actor (id, name) VALUES (13, 'Lane Chandler');
INSERT INTO public.actor (id, name) VALUES (14, 'John Call');
INSERT INTO public.actor (id, name) VALUES (15, 'Leonard Hicks');
INSERT INTO public.actor (id, name) VALUES (16, 'Vincent Beck');
INSERT INTO public.actor (id, name) VALUES (17, 'Hal Skelly');
INSERT INTO public.actor (id, name) VALUES (18, 'Nancy Carroll');
INSERT INTO public.actor (id, name) VALUES (19, 'Humphrey Bogart');
INSERT INTO public.actor (id, name) VALUES (20, 'Ingrid Bergman');
INSERT INTO public.actor (id, name) VALUES (21, 'Paul Henreid');
INSERT INTO public.actor (id, name) VALUES (22, 'Claude Rains');


--
-- TOC entry 3451 (class 0 OID 30035)
-- Dependencies: 233
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.comment (id, content, date, id_film, id_author, id_emotion) VALUES (1, 'This great movie brought out into the open the horrors of heroin addiction. It captured the struggle of a man, Frankie Machine, with a "monkey on his back". Frank Sinatra did his homework, well. The acting is superb, the score is first rate and the actors all gave above average performances. Frank gave one of his best performances. This movie has much to offer.', '1999-12-10 16:00:00-08', 1, 1, 1);
INSERT INTO public.comment (id, content, date, id_film, id_author, id_emotion) VALUES (2, 'It''s hard to believe this movie did not get censorship approval. No where in the film do the characters mention what drug was involved or that drugs were even being used. Really the story teaches a morality lesson and that should be applauded.', '2008-04-03 17:00:00-07', 1, 2, 1);
INSERT INTO public.comment (id, content, date, id_film, id_author, id_emotion) VALUES (3, 'As a whole, this movie doesn''t work at all. Different parts of the story jump around here and there and fail to form a cohesive piece -- the result of a poorly written script. For instance, halfway into the movie and you still get no idea of where it is all going. You get a vague sense that Johnny''s (Jimmy Stewart) inability to support his family and the consequent strain on his relationship with his wife is part of the main plot, only to be completely thrown off by a new development in the story, which doesn''t fit into the first portion of the film at all. It''s almost like watching two different stories at the same time.', '2008-07-26 17:00:00-07', 3, 3, 2);
INSERT INTO public.comment (id, content, date, id_film, id_author, id_emotion) VALUES (4, 'Martians kidnap Santa Claus due to an elder''s belief that the Martian children need to experience Christmas and the joys of childhood. This leads to two human children discovering the conspiracy and work to get Santa Claus back by Christmas.', '2017-12-23 16:00:00-08', 6, 4, 4);
INSERT INTO public.comment (id, content, date, id_film, id_author, id_emotion) VALUES (5, 'This film is a monumental piece of film history. I can honestly it might just be one of the best movies of all time. If anything, you have to acknowledge the writing. Almost every single line of dialogue in the film is a household terminology to this day, most people paying tribute to the film without even knowing it. That''s why I wanted to use a less popular quote for the title, and it has its own meanings within the film. Another joy of the film is composer Max Steiner; yes, Max Steiner of 1933''s "King Kong". His music is timeless, and he captures the mystery and romance of the film perfectly.', '2012-01-31 16:00:00-08', 8, 5, 1);


--
-- TOC entry 3441 (class 0 OID 29927)
-- Dependencies: 223
-- Data for Name: director; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.director (id, name) VALUES (1, 'Otto Preminger');
INSERT INTO public.director (id, name) VALUES (2, 'Anthony Mann');
INSERT INTO public.director (id, name) VALUES (3, 'John Cromwell');
INSERT INTO public.director (id, name) VALUES (4, 'Dave Fleischer');
INSERT INTO public.director (id, name) VALUES (5, 'Armand Schaefer');
INSERT INTO public.director (id, name) VALUES (6, 'Nicholas Webster');
INSERT INTO public.director (id, name) VALUES (7, 'Michael Curtiz');


--
-- TOC entry 3453 (class 0 OID 30076)
-- Dependencies: 235
-- Data for Name: emotion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.emotion (id, name) VALUES (1, 'Smile');
INSERT INTO public.emotion (id, name) VALUES (2, 'Sleeping');
INSERT INTO public.emotion (id, name) VALUES (3, 'Puke');
INSERT INTO public.emotion (id, name) VALUES (4, 'Angry');


--
-- TOC entry 3433 (class 0 OID 29897)
-- Dependencies: 215
-- Data for Name: film; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.film (id, title, alternative_title, poster, description, total_rating, age_rating, runtime, id_director, id_release_info) VALUES (1, 'The Man with the Golden Arm', 'The Man with the Golden Arm', './img/posters/the-man-with-the-golden-arm.jpg', 'A junkie must face his true self to kick his drug addiction.', 9.0, 6, 119, 1, 3);
INSERT INTO public.film (id, title, alternative_title, poster, description, total_rating, age_rating, runtime, id_director, id_release_info) VALUES (2, 'The Great Flamarion', 'The Great Flamarion', './img/posters/the-great-flamarion.jpg', 'Part of an entertainment act, a beautiful but unscrupulous female performer manipulates all the men in her life in order to achieve her aims.', 8.9, 6, 78, 2, 4);
INSERT INTO public.film (id, title, alternative_title, poster, description, total_rating, age_rating, runtime, id_director, id_release_info) VALUES (3, 'Made for Each Other', 'Made for Each Other', './img/posters/made-for-each-other.png', 'While on a business trip, an ambitious young lawyer meets and immediately falls in love with a stranger. They wed the following day, and tragedy soon strikes.', 5.8, 6, 92, 3, 5);
INSERT INTO public.film (id, title, alternative_title, poster, description, total_rating, age_rating, runtime, id_director, id_release_info) VALUES (4, 'Popeye the Sailor Meets Sindbad the Sailor', 'Popeye the Sailor Meets Sindbad the Sailor', './img/posters/popeye-meets-sinbad.png', 'The legendary sailors Popeye and Sindbad do battle to see which one is the greatest.', 6.3, 6, 16, 4, 6);
INSERT INTO public.film (id, title, alternative_title, poster, description, total_rating, age_rating, runtime, id_director, id_release_info) VALUES (5, 'Sagebrush Trail', 'Sagebrush Trail', './img/posters/sagebrush-trail.jpg', 'A man framed for murder escapes prison and goes west, where he joins a gang with the real killer involved.', 5.4, 6, 54, 5, 7);
INSERT INTO public.film (id, title, alternative_title, poster, description, total_rating, age_rating, runtime, id_director, id_release_info) VALUES (6, 'Santa Claus Conquers the Martians', 'Santa Claus Conquers the Martians', './img/posters/santa-claus-conquers-the-martians.jpg', 'The Martians kidnap Santa Claus because there is nobody on Mars to give their children presents.', 2.7, 12, 81, 6, 8);
INSERT INTO public.film (id, title, alternative_title, poster, description, total_rating, age_rating, runtime, id_director, id_release_info) VALUES (7, 'The Dance of Life', 'The Dance of Life', './img/posters/the-dance-of-life.jpg', 'When a vaudeville comic and a pretty young dancer have little luck in their separate careers, they decide to combine their acts; to save money on the road, they get married.', 6.8, 12, 115, 3, 9);
INSERT INTO public.film (id, title, alternative_title, poster, description, total_rating, age_rating, runtime, id_director, id_release_info) VALUES (8, 'Casablanca', 'Casablanca', './img/posters/casablanca.jpg', 'A cynical expatriate American cafe owner struggles to decide whether or not to help his former lover and her fugitive husband escape the Nazis in French Morocco.', 8.5, 12, 102, 7, 10);


--
-- TOC entry 3443 (class 0 OID 29938)
-- Dependencies: 225
-- Data for Name: film_actor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.film_actor (id_film, id_actor) VALUES (1, 1);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (1, 2);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (1, 3);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (2, 4);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (2, 5);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (3, 6);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (3, 7);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (4, 8);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (4, 9);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (4, 10);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (5, 11);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (5, 12);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (5, 13);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (6, 14);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (6, 15);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (6, 16);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (7, 17);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (7, 18);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (8, 19);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (8, 20);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (8, 21);
INSERT INTO public.film_actor (id_film, id_actor) VALUES (8, 22);


--
-- TOC entry 3442 (class 0 OID 29933)
-- Dependencies: 224
-- Data for Name: film_genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.film_genre (id_film, id_genre) VALUES (1, 1);
INSERT INTO public.film_genre (id_film, id_genre) VALUES (2, 2);
INSERT INTO public.film_genre (id_film, id_genre) VALUES (3, 3);
INSERT INTO public.film_genre (id_film, id_genre) VALUES (4, 4);
INSERT INTO public.film_genre (id_film, id_genre) VALUES (5, 5);
INSERT INTO public.film_genre (id_film, id_genre) VALUES (6, 3);
INSERT INTO public.film_genre (id_film, id_genre) VALUES (7, 6);
INSERT INTO public.film_genre (id_film, id_genre) VALUES (8, 1);
INSERT INTO public.film_genre (id_film, id_genre) VALUES (8, 7);


--
-- TOC entry 3444 (class 0 OID 29943)
-- Dependencies: 226
-- Data for Name: film_writer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.film_writer (id_film, id_writer) VALUES (1, 1);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (1, 2);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (1, 3);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (2, 4);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (2, 5);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (2, 6);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (3, 7);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (3, 8);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (4, 9);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (4, 10);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (4, 11);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (5, 12);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (5, 13);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (6, 14);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (7, 15);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (7, 16);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (8, 17);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (8, 18);
INSERT INTO public.film_writer (id_film, id_writer) VALUES (8, 19);


--
-- TOC entry 3435 (class 0 OID 29906)
-- Dependencies: 217
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.genre (id, name) VALUES (1, 'Drama');
INSERT INTO public.genre (id, name) VALUES (2, 'Mystery');
INSERT INTO public.genre (id, name) VALUES (3, 'Comedy');
INSERT INTO public.genre (id, name) VALUES (4, 'Cartoon');
INSERT INTO public.genre (id, name) VALUES (5, 'Western');
INSERT INTO public.genre (id, name) VALUES (6, 'Musical');
INSERT INTO public.genre (id, name) VALUES (7, 'Romance');


--
-- TOC entry 3449 (class 0 OID 29996)
-- Dependencies: 231
-- Data for Name: release_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.release_info (id, date, release_country) VALUES (3, '1955-12-14 16:00:00-08', 'United States');
INSERT INTO public.release_info (id, date, release_country) VALUES (4, '1945-03-29 17:00:00-07', 'United States');
INSERT INTO public.release_info (id, date, release_country) VALUES (5, '1939-02-09 16:00:00-08', 'United States');
INSERT INTO public.release_info (id, date, release_country) VALUES (6, '1936-11-26 16:00:00-08', 'United States');
INSERT INTO public.release_info (id, date, release_country) VALUES (7, '1933-12-14 16:00:00-08', 'United States');
INSERT INTO public.release_info (id, date, release_country) VALUES (8, '1964-11-13 16:00:00-08', 'United States');
INSERT INTO public.release_info (id, date, release_country) VALUES (9, '1929-08-15 16:00:00-08', 'United States');
INSERT INTO public.release_info (id, date, release_country) VALUES (10, '1942-11-25 17:00:00-07', 'United States');


--
-- TOC entry 3447 (class 0 OID 29954)
-- Dependencies: 229
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."user" (id, name) VALUES (1, 'RALL');
INSERT INTO public."user" (id, name) VALUES (2, 'bull-frog');
INSERT INTO public."user" (id, name) VALUES (3, 'MerryArtist');
INSERT INTO public."user" (id, name) VALUES (4, 'JamesMovieGuy_117');
INSERT INTO public."user" (id, name) VALUES (5, 'gigan-92');
INSERT INTO public."user" (id, name) VALUES (6, 'Frank Sinatra');


--
-- TOC entry 3445 (class 0 OID 29948)
-- Dependencies: 227
-- Data for Name: user_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (1, 1, true, false, true, '1999-12-10 16:00:00-08');
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (1, 2, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (1, 3, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (1, 4, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (1, 5, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (1, 6, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (1, 7, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (1, 8, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (2, 1, true, false, true, '2008-04-03 17:00:00-07');
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (2, 2, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (2, 3, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (2, 4, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (2, 5, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (2, 6, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (2, 7, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (2, 8, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (3, 1, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (3, 2, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (3, 3, false, true, true, '2008-07-26 17:00:00-07');
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (3, 4, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (3, 5, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (3, 6, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (3, 7, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (3, 8, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (4, 1, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (4, 2, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (4, 3, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (4, 4, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (4, 5, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (4, 6, false, false, true, '2017-12-23 16:00:00-08');
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (4, 7, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (4, 8, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (5, 1, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (5, 2, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (5, 3, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (5, 4, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (5, 5, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (5, 6, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (5, 7, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (5, 8, true, true, true, '2012-01-31 16:00:00-08');
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (6, 1, true, false, true, '2023-07-03 00:00:00-07');
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (6, 2, true, true, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (6, 3, true, false, true, '2024-05-25 00:00:00-07');
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (6, 4, true, false, true, '2020-01-01 00:00:00-08');
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (6, 5, false, false, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (6, 6, false, true, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (6, 7, true, true, false, NULL);
INSERT INTO public.user_details (id_user, id_film, is_favorite, is_in_watchlist, is_watched, watching_date) VALUES (6, 8, true, true, false, NULL);


--
-- TOC entry 3439 (class 0 OID 29920)
-- Dependencies: 221
-- Data for Name: writer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.writer (id, name) VALUES (1, 'Walter Newman');
INSERT INTO public.writer (id, name) VALUES (2, 'Lewis Meltzer');
INSERT INTO public.writer (id, name) VALUES (3, 'Ben Hecht');
INSERT INTO public.writer (id, name) VALUES (4, 'Heinz Herald');
INSERT INTO public.writer (id, name) VALUES (5, 'Richard Weil');
INSERT INTO public.writer (id, name) VALUES (6, 'Anne Wigton');
INSERT INTO public.writer (id, name) VALUES (7, 'Jo Swerling');
INSERT INTO public.writer (id, name) VALUES (8, 'Frank Ryan');
INSERT INTO public.writer (id, name) VALUES (9, 'Joe Stultz');
INSERT INTO public.writer (id, name) VALUES (10, 'Bill Turner');
INSERT INTO public.writer (id, name) VALUES (11, 'Jack Ward');
INSERT INTO public.writer (id, name) VALUES (12, 'Lindsley Parsons');
INSERT INTO public.writer (id, name) VALUES (13, 'Will Beale');
INSERT INTO public.writer (id, name) VALUES (14, 'Paul L. Jacobson');
INSERT INTO public.writer (id, name) VALUES (15, 'Benjamin Glazer');
INSERT INTO public.writer (id, name) VALUES (16, 'Julian Johnson');
INSERT INTO public.writer (id, name) VALUES (17, 'Julius J. Epstein');
INSERT INTO public.writer (id, name) VALUES (18, 'Philip G. Epstein');
INSERT INTO public.writer (id, name) VALUES (19, 'Howard Koch');


--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 218
-- Name: actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actor_id_seq', 22, true);


--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 232
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_id_seq', 5, true);


--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 222
-- Name: director_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.director_id_seq', 7, true);


--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 234
-- Name: emotion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.emotion_id_seq', 4, true);


--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 214
-- Name: film_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.film_id_seq', 8, true);


--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 216
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genre_id_seq', 7, true);


--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 230
-- Name: release_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.release_info_id_seq', 10, true);


--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 228
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 6, true);


--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 220
-- Name: writer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.writer_id_seq', 19, true);


--
-- TOC entry 3248 (class 2606 OID 29918)
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (id);


--
-- TOC entry 3250 (class 2606 OID 30029)
-- Name: actor actor_uk_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_uk_name UNIQUE (name);


--
-- TOC entry 3274 (class 2606 OID 30042)
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- TOC entry 3256 (class 2606 OID 29932)
-- Name: director director_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_pkey PRIMARY KEY (id);


--
-- TOC entry 3258 (class 2606 OID 30033)
-- Name: director director_uk_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.director
    ADD CONSTRAINT director_uk_name UNIQUE (name);


--
-- TOC entry 3276 (class 2606 OID 30081)
-- Name: emotion emotion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emotion
    ADD CONSTRAINT emotion_pkey PRIMARY KEY (id);


--
-- TOC entry 3262 (class 2606 OID 29942)
-- Name: film_actor film_actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_actor
    ADD CONSTRAINT film_actor_pkey PRIMARY KEY (id_film, id_actor);


--
-- TOC entry 3260 (class 2606 OID 29937)
-- Name: film_genre film_genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_genre
    ADD CONSTRAINT film_genre_pkey PRIMARY KEY (id_film, id_genre);


--
-- TOC entry 3242 (class 2606 OID 29902)
-- Name: film film_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_pkey PRIMARY KEY (id);


--
-- TOC entry 3264 (class 2606 OID 29947)
-- Name: film_writer film_writer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_writer
    ADD CONSTRAINT film_writer_pkey PRIMARY KEY (id_film, id_writer);


--
-- TOC entry 3244 (class 2606 OID 29911)
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- TOC entry 3246 (class 2606 OID 30027)
-- Name: genre genre_uk_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_uk_name UNIQUE (name);


--
-- TOC entry 3272 (class 2606 OID 30001)
-- Name: release_info release_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.release_info
    ADD CONSTRAINT release_info_pkey PRIMARY KEY (id);


--
-- TOC entry 3266 (class 2606 OID 29952)
-- Name: user_details user_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_details
    ADD CONSTRAINT user_details_pkey PRIMARY KEY (id_user, id_film);


--
-- TOC entry 3268 (class 2606 OID 29959)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3270 (class 2606 OID 30064)
-- Name: user user_uk_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_uk_name UNIQUE (name);


--
-- TOC entry 3252 (class 2606 OID 29925)
-- Name: writer writer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writer
    ADD CONSTRAINT writer_pkey PRIMARY KEY (id);


--
-- TOC entry 3254 (class 2606 OID 30031)
-- Name: writer writer_uk_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writer
    ADD CONSTRAINT writer_uk_name UNIQUE (name);


--
-- TOC entry 3287 (class 2606 OID 30048)
-- Name: comment comment_fk_author; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_fk_author FOREIGN KEY (id_author) REFERENCES public."user"(id) NOT VALID;


--
-- TOC entry 3288 (class 2606 OID 30082)
-- Name: comment comment_fk_emotion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_fk_emotion FOREIGN KEY (id_emotion) REFERENCES public.emotion(id) NOT VALID;


--
-- TOC entry 3289 (class 2606 OID 30043)
-- Name: comment comment_fk_film; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_fk_film FOREIGN KEY (id_film) REFERENCES public.film(id) NOT VALID;


--
-- TOC entry 3281 (class 2606 OID 29985)
-- Name: film_actor film_actor_fk_actor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_actor
    ADD CONSTRAINT film_actor_fk_actor FOREIGN KEY (id_actor) REFERENCES public.actor(id) NOT VALID;


--
-- TOC entry 3282 (class 2606 OID 29980)
-- Name: film_actor film_actor_fk_film; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_actor
    ADD CONSTRAINT film_actor_fk_film FOREIGN KEY (id_film) REFERENCES public.film(id) NOT VALID;


--
-- TOC entry 3277 (class 2606 OID 29990)
-- Name: film film_fk_director; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_fk_director FOREIGN KEY (id_director) REFERENCES public.director(id) NOT VALID;


--
-- TOC entry 3278 (class 2606 OID 30002)
-- Name: film film_fk_release_info; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_fk_release_info FOREIGN KEY (id_release_info) REFERENCES public.release_info(id) NOT VALID;


--
-- TOC entry 3279 (class 2606 OID 29960)
-- Name: film_genre film_genre_fk_film; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_genre
    ADD CONSTRAINT film_genre_fk_film FOREIGN KEY (id_film) REFERENCES public.film(id) NOT VALID;


--
-- TOC entry 3280 (class 2606 OID 29965)
-- Name: film_genre film_genre_fk_genre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_genre
    ADD CONSTRAINT film_genre_fk_genre FOREIGN KEY (id_genre) REFERENCES public.genre(id) NOT VALID;


--
-- TOC entry 3283 (class 2606 OID 29970)
-- Name: film_writer film_writer_fk_film; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_writer
    ADD CONSTRAINT film_writer_fk_film FOREIGN KEY (id_film) REFERENCES public.film(id) NOT VALID;


--
-- TOC entry 3284 (class 2606 OID 29975)
-- Name: film_writer film_writer_fk_writer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film_writer
    ADD CONSTRAINT film_writer_fk_writer FOREIGN KEY (id_writer) REFERENCES public.writer(id) NOT VALID;


--
-- TOC entry 3285 (class 2606 OID 30058)
-- Name: user_details user_details_fk_film; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_details
    ADD CONSTRAINT user_details_fk_film FOREIGN KEY (id_film) REFERENCES public.film(id) NOT VALID;


--
-- TOC entry 3286 (class 2606 OID 30053)
-- Name: user_details user_details_fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_details
    ADD CONSTRAINT user_details_fk_user FOREIGN KEY (id_user) REFERENCES public."user"(id) NOT VALID;


-- Completed on 2024-08-13 00:52:13

--
-- PostgreSQL database dump complete
--

