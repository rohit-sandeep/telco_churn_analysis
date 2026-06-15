# Telco Churn Analysis

# Combating Early-Stage Customer Churn: A Hypothesis-Driven Diagnostic of Telco Lifespans

## Executive Summary
This project delivers an end-to-end analytics pipeline investigating customer retention mechanics for a telecommunications provider. The primary objective was to diagnose a critical front-heavy retention anomaly: **36% of all month-to-month customer drop-offs occur within the first 90 days of onboarding.**

Through a structured, hypothesis-driven diagnostic framework, traditional internal assumptions regarding billing friction were systematically debunked using baseline data distribution checks (avoiding the Base Rate Fallacy). Instead, a critical service-layer gap was uncovered: **Fiber Optic subscribers are severely over-represented in early-stage churn, specifically when navigating onboarding without support add-ons.**

### 💡 Strategic Recommendation
Introduce a heavily incentivized **"Fiber Starter Bundle"** that automatically embeds `TechSupport` and `OnlineSecurity` into the core product offering for a customer's first 90 days. Relational data proves that moving users from "naked" fiber lines to a protected ecosystem virtually eliminates early-stage churn risk, securing critical Customer Acquisition Cost (CAC) payback windows.

---

## 🏢 Business Context & Problem Statement
In contractual subscription models, blended monthly churn metrics frequently obscure severe operational timeline risks. The timing of customer churn directly dictates company profitability; if a customer leaves before recovering their acquisition cost (CAC), the company loses money on that relationship.

This project maps out the enterprise's customer survival curves to isolate the exact operational windows leaking revenue.

### Key Performance Indicators (KPIs) Discovered:
* **The Onboarding Bottleneck:** 36% of all month-to-month cancellations occur in the `0-3 Month` tenure window.
* **The Premium Revenue Risk:** The early drop-off pool is dominated by high-ARPU (Average Revenue Per User) Fiber Optic contracts, heavily compounding the Monthly Recurring Revenue (MRR) impact.

---

## 🛠 Data Architecture & Quality Engineering
The analysis was performed on an enterprise dataset containing 7,043 unique customer profiles. Before executing advanced segmentation logic, a critical data pipeline vulnerability was identified and resolved during the ETL stage.

### Data Sanitization Protocol
Brand-new accounts (`tenure = 0`) lacked finalized billing cycles, causing historical source files to record their `TotalCharges` as blank character strings (`' '`). To prevent numeric parsing failures and query crashes during downstream analysis, a data-cleaning script was executed to standardize and optimize the database schema:

```sql
-- Step 1: Standardize empty account balances to allow numeric operations
UPDATE telco_customer_records 
SET TotalCharges = '0.00' 
WHERE TotalCharges = ' ' OR TotalCharges = '';

-- Step 2: Optimize column structure from text-storage to precise financial decimal
ALTER TABLE telco_customer_records 
MODIFY COLUMN TotalCharges DECIMAL(10, 2);
