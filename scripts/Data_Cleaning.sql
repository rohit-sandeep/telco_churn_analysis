-- Step 1: Standardize the empty values to '0.00'
UPDATE telco_customer_records 
SET TotalCharges = '0.00' 
WHERE TotalCharges = ' ' OR TotalCharges = '';

-- Step 2: Convert the column to a numeric data type (Decimal)
ALTER TABLE telco_customer_records 
MODIFY COLUMN TotalCharges DECIMAL(10, 2);