# 📊 IHDS-II Analysis: Poverty, Expenditure, and Inequality

This report analyzes household-level data from the IHDS-II dataset to estimate poverty, study consumption expenditure patterns, and measure economic inequality using the Lorenz curve and Gini index.

---

## 🧾 Dataset Summary

- **Dataset**: IHDS-II (India Human Development Survey)
- **Observations**: 42,152 households
- **Variables**: 758 (includes income, consumption, land, demographic details)

---

## 📌 Poverty Headcount Estimation

- **Poor Households**: 6,917
- **Non-Poor Households**: 35,212
- **Headcount Ratio (Sample)**: 20.0%
- **Headcount Ratio (Population weighted)**: **21.29%**

### By Sector:
| Sector     | HCR   |
|------------|--------|
| Rural      | 25.0%  |
| Urban      | 13.4%  |

### By State and Sector (First Few):
| State                  | Sector | HCR     |
|------------------------|--------|---------|
| Jammu & Kashmir        | Rural  | 1.38%   |
| Jammu & Kashmir        | Urban  | 0.77%   |
| Himachal Pradesh       | Rural  | 14.3%   |
| Himachal Pradesh       | Urban  | 10.7%   |
| Punjab                 | Rural  | 9.31%   |
| Punjab                 | Urban  | 4.99%   |

---

## 🍚 Share of Consumption Expenditure by Item

### By Poverty Status:
| Item           | Non-Poor Avg Share | Poor Avg Share |
|----------------|-------------------|----------------|
| Rice           | 0.0045            | 0.0082         |
| Wheat          | 0.0026            | 0.0042         |
| Sugar          | 0.0015            | 0.0021         |
| Edible Oil     | 0.0031            | 0.0047         |
| Milk           | 0.0059            | 0.0046         |
| Pulses         | 0.0022            | 0.0035         |
| Meat           | 0.0024            | 0.0028         |
| Eggs           | 0.0009            | 0.0011         |
| Vegetables     | 0.0047            | 0.0064         |
| Electricity    | 0.0014            | 0.0011         |
| Fuel           | 0.0023            | 0.0028         |

> **Interpretation**: Poor households spend a larger proportion on basic food items like rice, pulses, and edible oil, indicating a focus on necessities.

---

## 🌾 Landholding Analysis

- Households owning land: 18,784
- **Pareto shape parameter (α)**: 0.1624
- **Minimum land observed**: 0.0031 acres

> **Interpretation**: The distribution of land is heavily skewed, fitting a Pareto distribution. This suggests high land inequality.

---

## 💰 Income Distribution

- Transformed using log(INCOME)
- **Mean log income**: 11.23
- **SD log income**: 1.06
- **Anderson-Darling test**: *p < 2.2e-16* → strong evidence against normality
- **Pareto α (t = 100)**: 0.15105

> **Interpretation**: Income distribution is highly skewed and heavy-tailed, well modeled by the Pareto distribution.

---

## 🥣 Consumption Distribution

- **Transformed with log(COTOTAL)**
- **Anderson-Darling test**: *p < 2.2e-16* → not normal
- **Pareto α (t = 180)**: 0.16119

> **Interpretation**: Total household consumption is not normally distributed but aligns with Pareto behavior, especially in the right tail.

---

## 📈 Gini Coefficient Results

| Indicator    | Gini Index |
|--------------|------------|
| Landholding  | **0.5883** |
| Income       | **0.5382** |
| Consumption  | **0.4054** |

> **Interpretation**:  
> - **Land inequality** is the highest among the three.  
> - **Income inequality** is slightly lower but still substantial.  
> - **Consumption inequality** is comparatively moderate.

---

## 📊 Visual Outputs (Suggested)

Include the following in `/outputs/plots/`:
- Histogram plots for INCOME, COTOTAL by sector
- Density plots for log-transformed income, land, and consumption
- Pareto PDFs and CDFs
- Lorenz curves for each indicator

---

## 📦 Packages Used

```r
library(dplyr)
library(tidyverse)
library(Pareto)
library(DescTools)
library(lawstat)
library(nortest)
library(ggplot2)
