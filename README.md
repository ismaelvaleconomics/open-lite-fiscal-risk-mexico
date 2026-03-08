# Open Fiscal Risk Mexico

This repository contains a small open-economy macroeconomic model with a fiscal block, designed to study the relationship between fiscal consolidation, public debt, and sovereign risk premia in Mexico.

The model is implemented in Dynare and documented in LaTeX. Its main purpose is to analyze how changes in fiscal policy—through government spending or revenues—affect the primary balance, debt dynamics, sovereign risk, the exchange rate, inflation, and monetary policy.

## Motivation

A central question in macro-financial analysis is whether fiscal consolidation can reduce sovereign risk premia by improving debt dynamics. This repository provides a parsimonious framework to study that mechanism in a linearized open-economy setting.

The core channel is simple:

- fiscal consolidation improves the primary balance,
- lower debt reduces the sovereign risk premium,
- a lower risk premium affects exchange-rate dynamics through UIP,
- exchange-rate movements influence inflation through pass-through,
- inflation and exchange-rate changes shape the monetary policy response.

## Model structure

The model includes the following blocks:

1. **Aggregate demand (IS block)**  
   Output gap dynamics depend on persistence and lagged fiscal variables.

2. **Phillips curve**  
   Inflation depends on expected inflation, the output gap, and exchange-rate depreciation.

3. **Monetary policy rule**  
   The domestic interest rate reacts to inflation, the output gap, and exchange-rate depreciation.

4. **External sector (UIP)**  
   The exchange rate is determined by uncovered interest parity with a sovereign risk premium.

5. **Fiscal block**  
   Government spending and revenues follow simple rules with inertia and cyclical responses.

6. **Debt accumulation**  
   Public debt evolves according to the primary balance.

7. **Sovereign risk premium**  
   The risk premium depends on its own persistence and on lagged public debt.

## Main research question

The main question behind the model is:

> How does fiscal consolidation affect the sovereign risk premium through its effect on public debt dynamics?

The key parameter is `k_rp`, which captures the sensitivity of the sovereign risk premium to debt.

## Repository contents

```text
.
├── model/
│   └── open_fiscal.mod
├── docs/
│   └── model_description.tex
├── outputs/
│   └── irfs/
├── figures/
├── README.md
└── LICENSE

## Reproducibility

To replicate the simulations:

1. Install Dynare (version 5 or later).
2. Open MATLAB or GNU Octave.
3. Navigate to the `model` folder.
4. Run:

dynare open_fiscal.mod

Dynare will generate impulse response functions for the following variables:

- output gap
- inflation
- interest rate
- exchange rate
- government spending
- tax revenues
- primary balance
- public debt
- sovereign risk premium
