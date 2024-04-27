-- 1
CREATE OR REPLACE FUNCTION PreReqsFor(courseNum INTEGER, OUT preReqList INTEGER[]) AS 
$$
BEGIN
    SELECT ARRAY(SELECT preReqNum FROM Prerequisites WHERE courseNum = courseNum) INTO preReqList;
END;
$$ 
LANGUAGE plpgsql;

-- 2
CREATE OR REPLACE FUNCTION IsPreReqFor(courseNum INTEGER, OUT courseList INTEGER[]) AS 
$$
BEGIN
    SELECT ARRAY(SELECT courseNum FROM Prerequisites WHERE preReqNum = courseNum) INTO courseList;
END;
$$ 
LANGUAGE plpgsql;

-- Optional Challenge
CREATE OR REPLACE FUNCTION GetAllPrerequisites(courseNum INTEGER, OUT preReqList INTEGER[]) AS
$$
DECLARE
    tempPrereqList INTEGER[];
    immediatePrereqs INTEGER[];
    prereq INTEGER;
BEGIN
    SELECT ARRAY(SELECT preReqNum FROM Prerequisites WHERE courseNum = courseNum) INTO immediatePrereqs;
    
    preReqList := immediatePrereqs;
    
    FOREACH prereq IN ARRAY immediatePrereqs LOOP
        CALL GetAllPrerequisites(prereq, tempPrereqList);
        preReqList := ARRAY(SELECT DISTINCT unnest(preReqList) UNION SELECT DISTINCT unnest(tempPrereqList)));
    END LOOP;
END;
$$
LANGUAGE plpgsql;

-- Examples of functions in use
-- Get prerequisites for course number 499
SELECT * FROM PreReqsFor(499);

-- Get courses for which course number 120 is an immediate prerequisite
SELECT * FROM IsPreReqFor(120);

-- Get all prerequisites for course number 499
SELECT * FROM GetAllPrerequisites(499);
