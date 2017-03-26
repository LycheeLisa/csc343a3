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
-- The table with pID and position name
CREATE TABLE position (
  pID integer PRIMARY KEY,
  position varchar(100)
);
-- The table with required skills, level and importance
CREATE TABLE reqSkill  (
  pID integer REFERENCES position,
  what reqSkillDescription NOT NULL,
  skill_level level NOT NULL,
  skill_importance importance NOT NULL
);
-- The table with questions
CREATE TABLE questions (
  pID integer REFERENCES position,
  qID integer PRIMARY KEY,
  question varchar(100)
);
