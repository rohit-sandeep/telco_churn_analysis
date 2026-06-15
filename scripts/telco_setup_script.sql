CREATE DATABASE telco_churn_project;
USE telco_churn_project;

CREATE TABLE telco_customer_records (
    customerID VARCHAR(50) NOT NULL,
    gender VARCHAR(20),
    SeniorCitizen INT,                -- 0 = No, 1 = Yes
    Partner VARCHAR(10),              -- Yes / No
    Dependents VARCHAR(10),           -- Yes / No
    tenure INT,                       -- Total months with company
    PhoneService VARCHAR(10),         -- Yes / No
    MultipleLines VARCHAR(50),        -- Yes / No / No phone service
    InternetService VARCHAR(50),      -- DSL / Fiber optic / No
    OnlineSecurity VARCHAR(50),       -- Yes / No / No internet service
    OnlineBackup VARCHAR(50),         -- Yes / No / No internet service
    DeviceProtection VARCHAR(50),     -- Yes / No / No internet service
    TechSupport VARCHAR(50),          -- Yes / No / No internet service
    StreamingTV VARCHAR(50),          -- Yes / No / No internet service
    StreamingMovies VARCHAR(50),      -- Yes / No / No internet service
    Contract VARCHAR(50),             -- Month-to-month / One year / Two year
    PaperlessBilling VARCHAR(10),     -- Yes / No
    PaymentMethod VARCHAR(100),       -- Electronic check, Mailed check, etc.
    MonthlyCharges DECIMAL(10, 2),
    TotalCharges VARCHAR(50),         -- Kept as VARCHAR to prevent import crash on empty strings
    Churn VARCHAR(10),                -- Yes / No
    PRIMARY KEY (customerID)
);