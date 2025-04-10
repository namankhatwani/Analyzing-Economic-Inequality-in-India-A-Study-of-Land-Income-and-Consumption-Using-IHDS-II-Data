# 📊 Economic Inequality Analysis using IHDS-II Data

This project explores the **distribution of landholding, income, and consumption** among Indian households using data from the **India Human Development Survey-II (IHDS-II)** conducted in 2011-12. The analysis is performed as part of the **Applied Econometrics Lab** coursework.

---

## 📁 Dataset

The dataset used is from the [ICPSR Study 36151](https://www.icpsr.umich.edu/web/ICPSR/studies/36151), which covers:
- Household-level data on income, landholding, and consumption.
- Rural and urban classification (URBAN2011).
- Weights for sampling (WT).

---

## 🧠 Objectives

- To analyze the **distribution patterns** of household **income, landholding, and consumption**.
- To test if the variables follow **log-normal or Pareto distributions**.
- To calculate **inequality measures** like the **Gini coefficient**.
- To visualize distribution differences across **rural and urban households**.

---

## 🔍 Methods Used

- **Histogram and Density Plots** using `ggplot2` and base R.
- **Log Transformation** and distribution fitting.
- **Pareto MLE Estimation** using the `Pareto` package.
- **Normality Testing** via the **Anderson-Darling Test** (`nortest`).
- **Gini Coefficient** and **Lorenz Curve** using `DescTools`.

---

## 📈 Key Findings

- **Income and consumption distributions** are right-skewed and fit well with **log-normal** and **Pareto** models.
- **Landholding** distribution shows a high level of inequality.
- **Gini Coefficients**:
  - Landholding: `0.588`
  - Income: `0.538`
  - Consumption: `0.405`
- Inequality is significantly higher in **land ownership** compared to income and consumption.

---

## 🛠️ Technologies

- **R Programming**
- Libraries: `dplyr`, `ggplot2`, `Pareto`, `nortest`, `DescTools`, `lawstat`

---

## 📚 Folder Structure

