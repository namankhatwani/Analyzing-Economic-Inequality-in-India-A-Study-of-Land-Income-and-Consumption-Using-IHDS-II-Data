library(dplyr)
library(tidyverse)
library(Pareto)
library(DescTools)
library(lawstat)
library(nortest)
library(ggplot2)

load("data/36151-0002-Data.rda")
ihds2 <- da36151.0002


# POVERTY HEADCOUNT RATIO
ihds2 <- mutate(ihds2, BPL = ifelse(POOR == "(0) nonpoor 0", 0, 1))
ihds2 <- mutate(ihds2, BPLPersons = BPL * NPERSONS)

# Sample estimate
sample_HCR <- sum(ihds2$BPLPersons, na.rm = TRUE) / sum(ihds2$NPERSONS, na.rm = TRUE)

# Population-weighted estimate
pop_HCR <- sum(ihds2$BPLPersons * ihds2$FWT, na.rm = TRUE) / sum(ihds2$NPERSONS * ihds2$FWT, na.rm = TRUE)

# HCR by sector
hcr_urban <- ihds2 %>% group_by(URBAN2011) %>%
  summarise(HCR = sum(BPLPersons * FWT, na.rm = TRUE) / sum(NPERSONS * FWT, na.rm = TRUE))

# HCR by state and sector
hcr_state <- ihds2 %>% group_by(STATEID, URBAN2011) %>%
  summarise(HCR = sum(BPLPersons * FWT, na.rm = TRUE) / sum(NPERSONS * FWT, na.rm = TRUE))


# CONSUMPTION EXPENDITURE SHARES
ihds2 <- ihds2 %>% drop_na(COTOTAL) %>%
  mutate(
    rice_share   = CO1X / COTOTAL,
    wheat_share  = CO2X / COTOTAL,
    sugar_share  = CO3X / COTOTAL,
    edible_oil_share = CO9X / COTOTAL,
    milk_share   = CO11X / COTOTAL,
    pulses_share = CO6X / COTOTAL,
    meat_share   = CO7X / COTOTAL,
    eggs_share   = CO10X / COTOTAL,
    vegetables_share = CO14X / COTOTAL,
    electricity_share = CO22 / COTOTAL,
    fuel_share = CO21 / COTOTAL
  )

# National average shares by BPL status
exp_share <- ihds2 %>% group_by(BPL) %>%
  summarise(across(ends_with("share"), ~mean(.x, na.rm = TRUE), .names = "avg_{.col}"))

# State-level average shares
statewise_exp_share <- ihds2 %>% group_by(STATEID, URBAN2011, BPL) %>%
  summarise(across(ends_with("share"), ~mean(.x, na.rm = TRUE)))


# LANDHOLDING & PARETO FIT
ihds2 <- mutate(ihds2, Land = ifelse(FM1 == "(0) No 0", 0, 1),
                LandHolding = replace_na(FM4A / FM3, 0))

HouseholdData3 <- ihds2 %>% filter(LandHolding > 0) %>%
  mutate(logLand = log(LandHolding))

pareto_land <- Pareto_ML_Estimator_Alpha(HouseholdData3$LandHolding, t = min(HouseholdData3$LandHolding))


# INCOME ANALYSIS
ihds2$INCOME[is.na(ihds2$INCOME)] <- 0
data_income2 <- ihds2 %>% filter(INCOME > 0) %>%
  mutate(logINCOME = log(INCOME))

income_ad_test <- ad.test(data_income2$logINCOME)
pareto_income <- Pareto_ML_Estimator_Alpha(data_income2$INCOME, t = 100)


# CONSUMPTION ANALYSIS
ihds2$COTOTAL[is.na(ihds2$COTOTAL)] <- 0
data_cons2 <- ihds2 %>% filter(COTOTAL > 0) %>%
  mutate(logCons = log(COTOTAL))

cons_ad_test <- ad.test(data_cons2$logCons)
pareto_cons <- Pareto_ML_Estimator_Alpha(data_cons2$COTOTAL, t = 180)


# GINI COEFFICIENTS
gini_land <- Gini(HouseholdData3$LandHolding)
gini_income <- Gini(data_income2$INCOME)
gini_cons <- Gini(data_cons2$COTOTAL)
