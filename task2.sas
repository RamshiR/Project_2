/* Import Excel file into SAS */
proc import datafile="/home/u63659459/task2/task2.xlsx"
    out=work.task2
    dbms=xlsx
    replace;
getnames=yes;
run;
/* Create a dataset with high and low-rated movies */
data work.task2_topic;
    set work.task2;
    length target_rating_group $10;
    if vote_average >= 9 then target_rating_group = "High";
    else if vote_average <= 3 then target_rating_group = "Low";
    else delete; /* Remove records that are neither high nor low-rated */
run;
/* Assign a permanent library */
libname mydata '/home/u63659459/task2';
/* Save the dataset to the permanent library */
data mydata.task2_topic;
    set work.task2_topic;
run;
