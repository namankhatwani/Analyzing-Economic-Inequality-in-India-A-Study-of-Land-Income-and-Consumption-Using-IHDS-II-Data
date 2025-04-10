# ================================================================
# Economic Inequality Analysis using IHDS-II Data
# ================================================================

# ----------------------------
# Load Required Libraries
# ----------------------------
library(dplyr)
library(ggplot2)
library(Pareto)
library(nortest)
library(DescTools)
library(lawstat)

# ----------------------------
# Load IHDS-II Dataset
# ----------------------------
load(file = "D:/sem 6/Applied Econometrics Lab/36151-0002-Data.rda")
ihds2 <- da36151.0002

# ----------------------------
# HISTOGRAMS FOR INCOME VARIABLES
# ----------------------------
hist(ihds2$INCANIMAL, col = "lightblue", breaks = 5)
hist(ihds2$INCAG, col = "lightblue", breaks = 5)
hist(ihds2$INCBUS, col = "lightblue", breaks = 5)
hist(ihds2$INCOME, col = "lightblue", breaks = 5)
hist(ihds2$INCNONAG, col = "lightblue", breaks = 5)
hist(ihds2$INCAGLAB, col = "lightblue", breaks = 5)
hist(ihds2$INCSALARY, col = "lightblue", breaks = 5)
hist(ihds2$INCNONNREGA, col = "lightblue", breaks = 5)
hist(ihds2$INCCROP, col = "lightblue", breaks = 5)
hist(ihds2$INCAGPROP, col = "lightblue", breaks = 5)

# ----------------------------
# Histograms by Urban/Rural Classification
# ----------------------------
income_vars <- c("INCANIMAL", "INCAG", "INCBUS", "INCOME", "INCNONAG",
                 "INCAGLAB", "INCSALARY", "INCNONNREGA", "INCCROP", "INCAGPROP")

for (var in income_vars) {
  ihds2 %>%
    ggplot(aes_string(x = var, fill = "as.factor(URBAN2011)")) +
    geom_histogram(bins = 50, alpha = 0.7, color = "black") +
    facet_wrap(~URBAN2011, labeller = as_labeller(c("0" = "Rural", "1" = "Urban"))) +
    scale_fill_manual(values = c("blue", "red"), labels = c("Rural", "Urban")) +
    theme_minimal() +
    ggtitle(paste("Histogram of", var, "by Urban/Rural"))
}

# ----------------------------
# LANDHOLDING ANALYSIS
# ----------------------------

# Create binary variable for land ownership
HouseholdData1 <- mutate(ihds2, Land = ifelse(FM1 == "(0) No 0", 0, 1))

# Convert land into single unit
HouseholdData1 <- mutate(HouseholdData1, LandHolding = FM4A / FM3)
HouseholdData1$LandHolding[is.na(HouseholdData1$LandHolding)] <- 0

# Filter data with landholding > 0
HouseholdData3 <- filter(HouseholdData1, LandHolding > 0)

# Log transform of Land
HouseholdData3 <- mutate(HouseholdData3, logLand = log(LandHolding))

# Pareto MLE Estimation for LandHolding
min_land <- min(HouseholdData3$LandHolding)
alpha_land <- Pareto_ML_Estimator_Alpha(HouseholdData3$LandHolding, t = min_land)

# Pareto PDF & CDF Plots for Land
plot(pPareto(HouseholdData3$LandHolding, min_land, alpha_land), xlab = "x", ylab = "y")
plot(dPareto(HouseholdData3$LandHolding, min_land, alpha_land), xlab = "x", ylab = "y")

# ----------------------------
# INCOME DISTRIBUTION ANALYSIS
# ----------------------------
data_income <- ihds2
data_income$INCOME[is.na(data_income$INCOME)] <- 0

# Filter positive income
data_income2 <- filter(data_income, INCOME > 0)
data_income2 <- mutate(data_income2, logINCOME = log(INCOME))

# Normality test for log(INCOME)
ad.test(data_income2$logINCOME)

# Pareto MLE Estimation for Income
min_income <- min(data_income2$INCOME)
alpha_income <- Pareto_ML_Estimator_Alpha(data_income2$INCOME, t = min_income)

# Pareto PDF & CDF Plots for Income
plot(pPareto(data_income2$INCOME, min_income, alpha_income), xlab = "x", ylab = "y")
plot(dPareto(data_income2$INCOME, min_income, alpha_income), xlab = "x", ylab = "y")

# ----------------------------
# CONSUMPTION DISTRIBUTION ANALYSIS
# ----------------------------
data_cons <- ihds2
data_cons$COTOTAL[is.na(data_cons$COTOTAL)] <- 0

# Filter positive consumption
data_cons2 <- filter(data_cons, COTOTAL > 0)
data_cons2 <- mutate(data_cons2, logCons = log(COTOTAL))

# Normality test for log(COTOTAL)
ad.test(data_cons2$logCons)

# Pareto MLE Estimation for Consumption
min_cons <- min(data_cons2$COTOTAL)
alpha_cons <- Pareto_ML_Estimator_Alpha(data_cons2$COTOTAL, t = min_cons)

# Pareto PDF & CDF Plots for Consumption
plot(pPareto(data_cons2$COTOTAL, min_cons, alpha_cons), xlab = "x", ylab = "y")
plot(dPareto(data_cons2$COTOTAL, min_cons, alpha_cons), xlab = "x", ylab = "y")


# ----------------------------
# INEQUALITY MEASURES (GINI & LORENZ)
# ----------------------------

# Lorenz Curve for Landholding (with weights)
lorenz.curve(HouseholdData3$LandHolding, weight = HouseholdData3$WT)

# Gini Index for Landholding
gini.index(HouseholdData3$LandHolding)
Gini(HouseholdData3$LandHolding)

# Gini Index for Income
gini.index(data_income2$INCOME)

# Gini Index for Consumption
gini.index(data_cons2$COTOTAL)


