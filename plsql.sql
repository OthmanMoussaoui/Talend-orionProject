DECLARE
  vQuarter CHARACTER(6);
  vMonth_Name VARCHAR(20);
  vWeekday_Name VARCHAR(20);
  vMonth_Num SMALLINT;
  vWeekday_Num SMALLINT;
  vDate_ID DATE := TO_DATE('01-01-1998', 'DD-MM-YYYY'); -- set the start date to 1st January 2023
BEGIN
  WHILE vDate_ID < TO_DATE('31-12-2002', 'DD-MM-YYYY') LOOP -- loop for 365 days, until 1st January 2024
    vQuarter := TO_CHAR(vDate_ID,'YYYY')||'Q'||TO_CHAR(vDate_ID,'Q');
    vMonth_Num := TO_NUMBER(TO_CHAR(vDate_ID,'MM'));
    vMonth_Name := TO_CHAR(vDate_ID, 'Month');
    vWeekday_Num := TO_NUMBER(TO_CHAR(vDate_ID,'D'));
    vWeekday_Name := TO_CHAR(vDate_ID, 'Day');
    INSERT INTO Time_Dim (Date_ID, Year_ID, Quarter, Month_Name, Weekday_Name, Month_Num, Weekday_Num) 
    VALUES (vDate_ID, TO_CHAR(vDate_ID, 'YYYY'), vQuarter, vMonth_Name, vWeekday_Name, vMonth_Num, vWeekday_Num);
    vDate_ID := vDate_ID + 1; -- increment the date by one day
  END LOOP;
  COMMIT; -- commit the changes
  DBMS_OUTPUT.PUT_LINE('Time_Dim table populated successfully.'); -- display a message
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM); -- display an error message
END;
/

