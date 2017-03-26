DROP SCHEMA IF EXISTS markus CASCADE;
CREATE SCHEMA markus;
SET search_path TO markus;

-- The possible values of a reqSkill
CREATE TYPE reqSkillDescription AS ENUM ('SQL', 'Scheme', 'Python', 'R', 'LaTeX');
-- The possible values of level of reqSkill
CREATE DOMAIN level AS smallint
   CHECK (VALUE <= 5 and VALUE >= 1);
-- The possible values of importance of reqSkill
CREATE DOMAIN importance AS smallint
    CHECK (VALUE <= 5 and VALUE >= 1);
-- The possible interview  scores
CREATE DOMAIN scores AS smallint
   CHECK (VALUE >= 0 and VALUE <= 100);
-- The degree levels
CREATE TYPE degreelevel AS ENUM ('certificate', 'undergraduate', 'professional', 'masters', 'doctoral');
-- The table with pID and position name
CREATE TABLE position (
  pID varchar(20) PRIMARY KEY,
  position varchar(100) NOT NULL
);
-- The table with required skills, level and importance
CREATE TABLE reqSkill  (
  pID varchar(20) REFERENCES position,
  what reqSkillDescription NOT NULL,
  skill_level level NOT NULL,
  skill_importance importance NOT NULL
);
-- The table with questions
CREATE TABLE questions (
  qID varchar(20) PRIMARY KEY,
  question varchar(100) NOT NULL
);
-- The table with interview information
CREATE TABLE interviewer (
  sID varchar(20) PRIMARY KEY,
  forename varchar(20) NOT NULL,
  lastname varchar(20) NOT NULL,
  honorific varchar(20),
  title varchar(20)
);
-- The table with information about interview date, time and location
CREATE TABLE interviewinfo (
  rID varchar(20) REFERENCES resume,
  pID varchar(20) REFERENCES position,
  sID varchar(20) REFERENCES interviewer,
  interviewdate varchar(20) NOT NULL,
  interviewtime varchar(20) NOT NULL,
  interviewlocation varchar(50) NOT NULL
);
-- The table with a candidate's assessment 
CREATE TABLE assessment (
   rID varchar(20),
   pID varchar(20),
   sID varchar(20),
   techProficiency scores NOT NULL,
   communication scores NOT NULL,
   enthusiasm scores NOT NULL,
   collegiality scores,
   FOREIGN KEY (rID, pID, sID) REFERENCES interviewinfo(rID, pID, sID)
);
-- The table with interview questions and responses
CREATE TABLE QandA (
   rID varchar(20) REFERENCES assessment,
   qID varchar(20) REFERENCES questions,
   answer varchar(100) NOT NULL
);
-- The table with candidate's identification
CREATE TABLE resume (
    rID varchar(20) PRIMARY KEY,
    name varchar(20) NOT NULL,
    DOB varchar(30) NOT NULL,
    citizenship varchar(20) NOT NULL,
    address varchar(20) NOT NULL,
    telephone varchar(20) NOT NULL,
    email varchar(20) NOT NULL
);
-- The table with the candidate's name
CREATE TABLE name (
  rID varchar(20),
  forename varchar(20) NOT NULL,
  lastname varchar(20) NOT NULL,
  honorific varchar(20),
  title varchar(50) NOT NULL,
  FOREIGN KEY (rID, forename) REFERENCES resume(rID, name)
)
-- The table with resume summary
CREATE TABLE summary (
  rID varchar(20) REFERENCES resume,
  summary varchar(200)
);
-- The table with candidate's education information
CREATE TABLE education (
  rID varchar(20) REFERENCES resume,
  degreeName varchar(30) NOT NULL,
  institution varchar(50) NOT NULL,
  honors varchar(20),
  period varchar(20) NOT NULL,
  level degreelevel NOT NULL
)
-- The table with candidate's major
CREATE TABLE major (
  rID varchar(20) REFERENCES resume,
  degreeName varchar(30) NOT NULL,
  institution varchar(50) NOT NULL,
  major varchar(20) NOT NULL
);
-- The table with candidate's minor
CREATE TABLE minor (
  rID varchar(20) REFERENCES resume,
  degreeName varchar(30) NOT NULL,
  institution varchar(50) NOT NULL,
  minor varchar(20) NOT NULL
);
