create database bankloan;

select * from finance_1;
select * from finance_2;

-- 1. Year wise loan amount
SELECT YEAR(issue_d), SUM(loan_amnt) FROM finance_1 
GROUP BY issue_d
ORDER BY issue_d;

-- 2. Grade-Subgrade wise revolution balance
SELECT f1.grade, f1.sub_grade, SUM(f2.revol_bal) AS total_revol_bal FROM finance_1 AS f1
INNER JOIN finance_2 AS f2 ON f1.id = f2.id
GROUP BY f1.grade, f1.sub_grade
ORDER BY f1.grade, f1.sub_grade;

-- 3. Total payment for verified status vs Non verified status
SELECT f1.verification_status, 
CONCAT("$", FORMAT(ROUND(SUM(f2.total_pymnt)/100000, 2) ,2), "M") AS total_payment
FROM finance_1 AS f1
INNER JOIN finance_2 AS f2 ON f1.id = f2.id
GROUP BY f1.verification_status;

-- 4. State wise last credit pull_d wise loan status
SELECT f1.addr_state, f2.last_credit_pull_d, f1.loan_status 
FROM finance_1 AS f1
INNER JOIN finance_2 AS f2 ON f1.id = f2.id
GROUP BY f1.addr_state, f2.last_credit_pull_d, f1.loan_status
ORDER BY f2.last_credit_pull_d;

-- 5. Home ownership vs last payment date stats
SELECT f1.home_ownership, YEAR(f2.last_pymnt_d),
CONCAT("$", FORMAT(ROUND(SUM(f2.last_pymnt_amnt)/10000, 2) ,2), "K") AS total_amount 
FROM finance_1 AS f1
INNER JOIN finance_2 AS f2 ON f1.id = f2.id
GROUP BY f1.home_ownership, f2.last_pymnt_d
ORDER BY f1.home_ownership, f2.last_pymnt_d;

