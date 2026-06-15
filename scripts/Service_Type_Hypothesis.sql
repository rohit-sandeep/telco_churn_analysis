Select 
	ROUND((COUNT(CASE WHEN InternetService = 'DSL' THEN 1 END)/COUNT(*))*100) as DSL_Churn,
    ROUND((COUNT(CASE WHEN InternetService = 'Fiber Optic' THEN 1 END)/COUNT(*))*100) as Fiber_Optic_Churn
FROM telco_customer_records 
WHERE tenure > 0 and tenure <=3  and Churn = 'Yes';

Select 
	ROUND((COUNT(CASE WHEN InternetService = 'DSL' THEN 1 END)/COUNT(*))*100) as DSL_New_Customer,
    ROUND((COUNT(CASE WHEN InternetService = 'Fiber Optic' THEN 1 END)/COUNT(*))*100) as Fiber_Optic_New 
FROM telco_customer_records 
WHERE tenure > 0 and tenure <=3





