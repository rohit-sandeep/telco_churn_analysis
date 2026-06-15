Select 
	ROUND((COUNT(CASE WHEN TechSupport = 'Yes' AND OnlineSecurity = 'Yes' THEN 1 END)/COUNT(*))*100) as Support_Churn,
    ROUND((COUNT(CASE WHEN TechSupport = 'No' AND OnlineSecurity = 'No' THEN 1 END)/COUNT(*))*100) as Non_Support_Churn
FROM telco_customer_records 
WHERE tenure > 0 and tenure <=3  and Churn = 'Yes' and InternetService = 'Fiber Optic';