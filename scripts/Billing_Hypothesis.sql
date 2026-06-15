Select 
	ROUND((COUNT(CASE WHEN PaymentMethod LIKE '%automatic%' THEN 1 END)/COUNT(*))*100) as Automatic_Churn,
    ROUND((COUNT(CASE WHEN PaymentMethod LIKE '%check%' THEN 1 END)/COUNT(*))*100) as Mannual_Payment_Churn
FROM telco_customer_records 
WHERE tenure > 0 and tenure <= 3 and Churn = 'Yes';

Select 
	ROUND((COUNT(CASE WHEN PaymentMethod LIKE '%automatic%' THEN 1 END)/COUNT(*))*100) as Automatic_New_Percentage,
    ROUND((COUNT(CASE WHEN PaymentMethod LIKE '%check%' THEN 1 END)/COUNT(*))*100) as Mannual_Payment_New_Customer_Percentage
FROM telco_customer_records 
WHERE tenure > 0 and tenure <= 3 