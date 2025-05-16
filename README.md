# 📊 IHDS-II Poverty, Consumption & Inequality Analysis

This repository contains R scripts and outputs for analyzing household-level poverty, consumption patterns, and inequality in India using data from the **India Human Development Survey-II (IHDS-II)**.

---

## 🧾 Dataset

- **Source**: ICPSR Study 36151 - India Human Development Survey-II (2011–12)
- **Observations**: 42,152 households
- **File**: `36151-0002-Data.rda`
- **Unit of Analysis**: Household-level

---

## 🔍 Objectives

1. Estimate poverty headcount ratio (HCR) at national and state levels.
2. Analyze household consumption expenditure patterns (e.g., rice, wheat, oil).
3. Model income, consumption, and landholding distributions using Pareto and log-normal approximations.
4. Compute inequality metrics using **Lorenz curves** and **Gini coefficients**.

---


---

## ⚙️ Methods Used

### 📉 Poverty Estimation
- Binary BPL variable created from `POOR` status
- Sample and weighted HCR at national, urban-rural, and state levels

### 🥣 Expenditure Analysis
- Share of total consumption (`COTOTAL`) spent on key food and utility items
- Compared across BPL and non-BPL households

### 📈 Distributional Modeling
- **Landholding**, **Income**, and **Consumption** analyzed using:
  - Histograms & density plots
  - Log-transformed distributions
  - **Pareto tail fitting** (MLE for α)
  - Normality tests (Anderson-Darling)

### 📊 Inequality Metrics
- Lorenz curves (with/without weights)
- Gini Coefficients via `Gini()` and `gini.index()` from `DescTools`

---

## 📦 Required R Packages

```r
install.packages(c(
  "dplyr", "tidyverse", "Pareto", 
  "DescTools", "lawstat", "nortest", "ggplot2"
))


