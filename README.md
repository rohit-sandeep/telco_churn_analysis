# Combating Early-Stage Customer Churn: A Hypothesis-Driven Diagnostic of Telco Lifespans

## Executive Summary

This project delivers an end-to-end analytics pipeline investigating customer retention mechanics for a telecommunications provider. The primary objective was to diagnose a critical front-heavy retention anomaly:

> **36% of all month-to-month customer churn occurs within the first 90 days of onboarding.**

Using a structured, hypothesis-driven diagnostic framework, traditional assumptions regarding billing friction were systematically tested and debunked through baseline distribution analysis, avoiding the Base Rate Fallacy.

Instead, the analysis uncovered a critical service-layer gap:

> **Fiber Optic subscribers are significantly over-represented in early-stage churn, particularly when onboarding without support add-ons.**

### Strategic Recommendation

Introduce a heavily incentivized **Fiber Starter Bundle** that automatically includes:

- Tech Support
- Online Security

for the first 90 days of a customer's lifecycle.

The analysis demonstrates that customers moving from standalone Fiber subscriptions into a supported ecosystem exhibit dramatically lower early-stage churn, protecting Customer Acquisition Cost (CAC) recovery and improving long-term retention.

---

## Business Context & Problem Statement

In subscription-based business models, overall churn rates often mask significant retention risks occurring at specific stages of the customer lifecycle.

The timing of churn is critical:

- Customers who churn before acquisition costs are recovered generate negative ROI.
- Early-stage churn prevents recurring revenue accumulation.
- High-value customer segments can disproportionately impact profitability.

This project maps customer tenure distributions to identify where revenue leakage occurs and which operational factors drive early departures.

### Key Findings

| KPI | Finding |
|-------|---------|
| Onboarding Bottleneck | 36% of all month-to-month cancellations occur within the first 3 months |
| Revenue Risk | Early churn is heavily concentrated among Fiber Optic subscribers, increasing MRR loss |
| Support Gap | Lack of support services is strongly associated with Fiber Optic churn |

---

## Dataset Overview

The analysis was performed on a customer dataset containing:

- **7,043 customer records**
- Customer demographics
- Contract information
- Billing details
- Service subscriptions
- Churn outcomes

---

## Tools & Technologies

- SQL (MySQL)
- Data Cleaning & Transformation
- Exploratory Data Analysis (EDA)
- Hypothesis Testing
- Customer Segmentation
- Churn Analytics

---

## Data Quality Engineering

During exploratory analysis, a data quality issue was identified.

New customer accounts (`tenure = 0`) had not completed their first billing cycle, causing `TotalCharges` to be stored as blank strings instead of numeric values.

### Data Sanitization Process

```sql
-- Standardize empty balances
UPDATE telco_customer_records
SET TotalCharges = '0.00'
WHERE TotalCharges = ' '
   OR TotalCharges = '';

-- Convert to numeric format
ALTER TABLE telco_customer_records
MODIFY COLUMN TotalCharges DECIMAL(10,2);
```

This ensured downstream calculations could be performed safely without casting errors.

---

## Hypothesis-Driven Investigation

### Hypothesis 1: Payment Friction Theory (Debunked)

#### Assumption

Customers using manual payment methods experience greater transactional friction and therefore churn earlier.

#### Test

Compare payment method distributions among:

- Early-stage churners (0–3 months)
- Overall new customer population

#### Findings

While:

- 87% of early churners used manual payment methods

the baseline population showed:

- 86% of all new signups also selected manual payment methods

Therefore, payment behavior simply reflected customer preferences rather than acting as an independent churn driver.

#### Conclusion

❌ **Payment friction was not a significant cause of early-stage churn.**

---

### Hypothesis 2: Onboarding Complexity Theory (Confirmed)

#### Assumption

Fiber Optic installations involve more complex setup requirements than DSL services, creating greater risk of customer dissatisfaction during onboarding.

#### Test

Compare internet service distributions between:

- Early-stage churners
- Overall customer baseline

#### Findings

| Service Type | Share of Signups | Share of Early Churn | Status |
|-------------|-----------------|---------------------|---------|
| DSL | 35% | 32% | Stable |
| Fiber Optic | 41% | 56% | Over-Represented |

Fiber customers accounted for:

- 41% of total signups
- 56% of early churners

This indicates a significant onboarding friction point within the Fiber customer journey.

#### Conclusion

✅ **Fiber Optic customers face disproportionately higher early-stage churn risk.**

---

## Deep Dive: Support Service Effectiveness

To identify an actionable intervention, Fiber Optic churners were segmented based on support-service adoption.

### Results

| Customer Segment | Share of Early Fiber Churn |
|-----------------|----------------------------|
| No Tech Support + No Online Security | 91.3% |
| Tech Support + Online Security | 0.6% |

### Key Insight

The overwhelming majority of Fiber churn occurs among customers attempting to navigate onboarding without access to support services.

Conversely, customers utilizing both support offerings demonstrate near-zero representation within the early churn population.

---

## Featured Analytical Query

```sql
SELECT
    ROUND(
        (COUNT(
            CASE
                WHEN TechSupport = 'Yes'
                 AND OnlineSecurity = 'Yes'
                THEN 1
            END
        ) / COUNT(*)) * 100,
        1
    ) AS Support_Bundle_Churn_Pct,

    ROUND(
        (COUNT(
            CASE
                WHEN TechSupport = 'No'
                 AND OnlineSecurity = 'No'
                THEN 1
            END
        ) / COUNT(*)) * 100,
        1
    ) AS Naked_Line_Churn_Pct

FROM telco_customer_records

WHERE tenure > 0
  AND tenure <= 3
  AND Churn = 'Yes'
  AND InternetService = 'Fiber Optic';
```

---

## Strategic Recommendations

### 1. Launch a Fiber Starter Bundle

Automatically include:

- Tech Support
- Online Security

for the first 90 days of every Fiber Optic subscription.

**Expected Outcome:** Reduced onboarding friction and improved customer retention.

---

### 2. Implement 45-Day Customer Success Interventions

Create automated workflows that:

- Identify Fiber customers without support add-ons
- Trigger proactive outreach
- Offer onboarding assistance before the highest-risk churn window

**Expected Outcome:** Increased engagement before churn behavior emerges.

---

### 3. Refine Customer Acquisition Strategy

Prioritize acquisition channels that attract:

- Bundled-service customers
- Higher-LTV customer profiles
- Customers demonstrating stronger retention patterns

Reduce emphasis on standalone Fiber-only acquisitions.

**Expected Outcome:** Improved retention-adjusted ROI on marketing spend.

---

## Repository Structure

```plaintext
├── data/
│   └── WA_Fn-UseC_-Telco-Customer-Churn.csv
│
├── sql_scripts/
│   ├── 01_database_setup.sql
│   ├── 02_data_sanitization.sql
│   └── 03_diagnostic_analytics.sql
│
└── README.md
```

### File Descriptions

| File | Purpose |
|--------|---------|
| `01_database_setup.sql` | Database creation and schema definition |
| `02_data_sanitization.sql` | Data cleansing and type conversion |
| `03_diagnostic_analytics.sql` | Churn analysis, segmentation, and hypothesis testing |
| `README.md` | Project documentation and business findings |

---

## Business Impact

This analysis demonstrates that early-stage churn is not primarily a billing problem, but an onboarding support problem concentrated within the Fiber Optic customer segment.

By bundling support services into the onboarding journey, the business can:

- Improve retention during the critical CAC recovery period
- Reduce revenue leakage from premium customers
- Increase customer lifetime value (LTV)
- Strengthen long-term recurring revenue growth

### Core Insight

> Customers are not leaving because of how they pay—they are leaving because they lack the support needed to successfully adopt the service.
