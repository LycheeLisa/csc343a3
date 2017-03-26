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
-- The table with pID and position name
CREATE TABLE position (
  pID varchar(20) PRIMARY KEY,
  position varchar(100)
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
  question varchar(100)
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

CREATE DOMAIN assessmentScore AS smallint 
  CHECK (VALUE >=0) and (VALUE <=100);
  
CREATE TABLE assessment (
 rID varchar(20),
 pID varchar(20),
 sID varchar(20),
 techProficiency assessmentScore NOT NULL,
 communication assessmentScore NOT NULL,
 enthusiasm assessmentScore NOT NULL,
 collegiality assessmentScore,
 FOREIGN KEY (rID, pID, sID) REFERENCES interviewinfo(rID, pID, sID)
    
);

CREATE TABLE QandA (
 rID varchar(20) REFERENCES assessment,
 qID varchar(20) REFERENCES questions,
 answer varchar(100)   
 
);
