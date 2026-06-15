Select 
	ROUND((COUNT(Case when tenure > 0 and tenure <=3 THEN 1 END)/COUNT(*))*100) AS Immediate_Churn_Percentage,
    ROUND((COUNT(Case when tenure > 3 and tenure <=12 THEN 1 END)/COUNT(*))*100) AS Short_Term_Churn_Percentage,
    ROUND((COUNT(Case when tenure > 12 and tenure <=24 THEN 1 END)/COUNT(*))*100)AS Mid_Term_Churn_Percentage,
    ROUND((COUNT(Case when tenure > 24 THEN 1 END)/COUNT(*))*100) AS Long_Term_Churn_Percentage
FROM 
	telco_customer_records 
WHERE 
	Churn = 'Yes' AND 
    Contract = 'Month-To-Month';
