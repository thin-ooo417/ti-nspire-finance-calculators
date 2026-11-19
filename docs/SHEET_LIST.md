# Sheet list

Made by `python scripts/make_sheet_list.py` from the files in `src/`. Do not edit by hand.

"Title on screen" is what the calculator shows at the top of the sheet. "Formula or hint" is the
line printed under it. Inputs are listed in the order they appear on screen.

## Business Finance (44 sheets)

Source folder: `src/finance/`

| File | Title on screen | Formula or hint | Inputs | Form layout |
|---|---|---|---|---|
| `01_Holding_Period_Return` | Holding-period return | r = (Pt+1 - Pt + It) / Pt | Pt price at t; Pt+1 price at t+1; It income at t+1 | `form_standard` |
| `02_Discount_Factor` | Discount factor | DF = 1/(1+r)^t | r rate/period (decimal); t periods | `form_standard` |
| `03_Present_Value` | Present value | PV = CFt x 1/(1+r)^t | CFt cashflow at t; r rate (decimal); t periods | `form_standard` |
| `04_NPV_and_Payback` | NPV (+growth TV, payback) | NPV = SUM CFt/(1+r)^t; last CF starts g-perp | r rate (decimal); g growth after last CF; CF0 cashflow t=0; CF1; CF2; CF3; CF4; CF5; CF6 | `form_standard` |
| `05_IRR` | Internal rate of return | Σ CFt/(1+IRR)^t = 0 (t = 0..6) | CF0 cashflow t=0; CF1 cashflow t=1; CF2 cashflow t=2; CF3 cashflow t=3; CF4 cashflow t=4; CF5 cashflow t=5; CF6 cashflow t=6 | `form_standard` |
| `06_Real_vs_Nominal_Rate` | Real vs nominal (solve blank) | 1 + rnom = (1 + rreal)(1 + I) | rnom nominal (decimal); rreal real (decimal); I inflation (decimal) | `form_standard` |
| `07_Compounding_Frequency` | Compounding frequency | FV = C (1 + r/f)^(f t) | C deposit; r annual rate (decimal); f times per year; t years | `form_standard` |
| `08_Perpetuity` | Perpetuity (incl. growing) | PV = C/(r - g) (g = 0: plain) | C yearly payment; r rate (decimal); g growth (decimal) | `form_standard` |
| `09_Annuity` | Annuity (PV or payment) | PV = (C/r)(1 - 1/(1+r)^T) | r rate per period; T periods; C payment (or blank); PV (or blank) | `form_standard` |
| `10_Bond_Price` | Bond price (+shift, +roll) | PB = (C/y)(1-1/(1+y)^T) + F/(1+y)^T | C coupon per period; F par value; T periods; YTM per period (dec); new YTM (optional) | `form_standard` |
| `11_Free_Cash_Flow_Direct` | Free cash flow (direct) | FCF = TO-FC-LC-RM-CapEx-Tax-ChWC | TO turnover; FC fixed costs; LC labour costs; RM raw materials; CapEx; Tax paid; ChWC chg working cap | `form_standard` |
| `12_Free_Cash_Flow_From_EBIT` | FCF accounting (solve blank) | FCF = EBIT - Tax + Depr - CapEx - ChWC | EBIT; Tax paid; Depreciation; CapEx; ChWC net WC invest; FCF (blank to solve) | `form_standard` |
| `13_Expected_Return_and_Risk` | Expected return, var, SD | μ = Σ pi ri; σ² = Σ pi(ri-μ)² | p1 probability; r1 return (decimal); p2; r2; p3; r3; p4; r4 | `form_standard` |
| `14_Covariance` | Covariance of returns | σA,B = ρA,B σA σB | ρA,B correlation; σA std dev A; σB std dev B | `form_standard` |
| `15_Sharpe_Ratio` | Sharpe ratio | S = (ri - rf) / σi | ri return of i (decimal); rf risk-free (decimal); σi sd of excess returns | `form_standard` |
| `16_Portfolio_Return` | Portfolio (expected) return | rP = x1 r1 + ... + x4 r4 | x1 weight; r1 return (decimal); x2; r2; x3; r3; x4; r4 | `form_standard` |
| `17_Portfolio_Variance` | Portfolio variance (2 assets) | σP² = xA²σA² + xB²σB² + 2xAxBρσAσB | xA weight A; xB (blank = 1-xA); σA std dev A; σB std dev B; ρA,B correlation | `form_standard` |
| `18_CAPM` | CAPM / security market line | E(ri) = rf + βi(μM - rf) | rf risk-free (decimal); βi beta; μM market E(r) (decimal) | `form_standard` |
| `19_Beta_From_Returns` | Beta (rearranged CAPM) | βi = (E(ri)-rf)/(E(rM)-rf) | E(ri) (decimal); rf risk-free (decimal); E(rM) (decimal) | `form_standard` |
| `20_Beta_From_Volatility` | Beta via vol (solve blank) | b = (si/sM) rho = cov/sM^2 | beta (or blank); si sd of stock; rho correlation; sM sd mkt/portfolio; cov (optional route) | `form_standard` |
| `21_Risk_Decomposition` | Risk decomp (solve blank) | si^2 = b^2 sM^2 + idio var | si sd of stock; beta; sM sd of market; idio VARIANCE (opt); idio SD (opt) | `form_standard` |
| `22_Alpha` | Alpha | E(ri) = α + rf + βi(μM - rf) | E(ri) actual (decimal); rf risk-free (decimal); βi beta; μM market E(r) (decimal) | `form_standard` |
| `23_MM_Proposition_1` | Modigliani-Miller I | A = D + E | A total assets; D debt; E equity | `form_standard` |
| `24_WACC` | MMII / WACC | WACC = (D/A) rD + (E/A) rE | D debt value; E equity value; rD cost of debt (dec); rE cost of equity (dec) | `form_standard` |
| `25_Asset_Beta` | Asset beta (levels or D/E) | bA = (D bD + E bE)/(D+E) | D debt value; E equity value; or D/E ratio; bD debt beta; bE equity beta | `form_standard` |
| `26_Tax_Adjusted_WACC` | Tax-adjusted WACC | r* = (D/A)(1-T)rD + (E/A)rE | D debt value; E equity value; rD (or blank w/ int); interest exp (opt); rE cost of equity; T tax rate (decimal) | `form_standard` |
| `27_Tax_Shield` | PV tax shield (perp/finite) | perp: D T; T-yr: T rD D x AF(rD,T) | D debt value; T tax rate (decimal); rD (only if finite); years (blank = perp) | `form_standard` |
| `28_Commodity_Futures` | Commodity futures | Ft = S0(1+rf+store-conv)^t | S0 spot price; rf risk-free (dec); t periods; storage (fraction); conv yield (fraction); storage $ per unit; conv $ per unit | `form_standard` |
| `29_Security_Futures` | Security futures (solve) | Ft = S0(1 + rf - y)^t | S0 spot price; t periods; rf (or blank); y div yield (or blank); Ft (or blank) | `form_standard` |
| `30_FX_Forward` | FX forward (solve blank) | F = S ((1+r1)/(1+r2))^t; r1: price ccy | S spot (ccy1 per ccy2); t periods; r1 of ccy1 (or blank); r2 of ccy2 (or blank); F forward (or blank) | `form_standard` |
| `31_Option_Payoffs` | Option payoff AND profit | profit = payoff - premium | S price at expiry; K exercise price; call premium; put premium | `form_standard` |
| `32_Mean_Variance_Dominance` | Mean-variance criterion | P beats A if E(rP)>=E(rA) and σP<=σA | E(rP) portfolio P; σP std dev of P; E(rA) portfolio A; σA std dev of A | `form_standard` |
| `33_Deferred_Perpetuity` | Deferred perpetuity | PV = C / (r (1+r)^T) first pay T+1 | C yearly payment; r rate (decimal); T years deferred | `form_standard` |
| `34_CAGR_and_Zero_Coupon_Yield` | CAGR / zero-coupon YTM | F = P(1+r)^T (solve any one) | P value today; F future value; T periods; r rate (or blank) | `form_standard` |
| `35_Cost_of_Delay` | Cost of delaying one year | delay = C0(1+gc)/(1+r) - C0 | C0 cost now; gc cost growth (dec); r interest (decimal) | `form_standard` |
| `36_Two_Asset_Portfolio` | 2-asset portfolio (mu + sd) | one entry: E(r), variance, sd | xA weight of A; xB (blank = 1-xA); E(rA) (decimal); E(rB); sdA; sdB; rho correlation | `form_standard` |
| `37_CAPM_Full_Chain` | CAPM chain: b, E(r), P1, SR, a | E(r) = rf + b(muM - rf) | beta (blank = derive); si sd stock (opt); rho corr (opt); sM sd market (opt); rf risk-free (dec); E(rM) (or blank); MRP (or blank); P0 price now (opt); own E(r) for alpha | `form_standard` |
| `38_MM2_Cost_of_Equity` | MM2: new rE after more debt | rE' = rA + (D'/E)(rA - rD) | D current debt; E current equity; rD (decimal); rE current (decimal); new debt raised | `form_standard` |
| `39_Firm_Value_with_Debt` | Firm value w/ debt shield | VL = EBIT(1-T)/rU + D T; E = VL - D | EBIT (perpetual); rU unlevered r (dec); T tax rate (decimal); or VU directly; D perpetual debt; or interest paid; rD (with interest) | `form_standard` |
| `40_Share_Value` | Share value: CAPM + g-perp | r = rf + b MRP; P = FCF1/((r-g)N) | beta; rf (decimal); E(rM) (or blank); MRP (or blank); FCF year 1; g growth (decimal); N shares (opt) | `form_standard` |
| `41_Working_Capital_PV` | PV of working capital (5y) | NWC = AR+Inv-AP; PV of -dNWC | AR y1; AR y2; AR y3; AR y4; AR y5; Inv y1; Inv y2; Inv y3; Inv y4; Inv y5; AP y1; AP y2; AP y3; AP y4; AP y5; r rate (decimal) | `form_standard` |
| `42_Profitability_Index` | Profitability index rank | PI = NPV / initial investment | Inv 1; NPV 1; Inv 2; NPV 2; Inv 3; NPV 3; Inv 4; NPV 4; Inv 5; NPV 5; Inv 6; NPV 6 | `form_standard` |
| `43_Option_Strategy` | Option strategy (3 legs) | leg: 1=call 2=put 3=stock; q<0 short | ST price at expiry; L1 type 1c 2p 3stk; L1 qty (- = short); L1 K / entry price; L1 premium; L2 type (blank off); L2 qty; L2 K / entry; L2 premium; L3 type (blank off); L3 qty; L3 K / entry; L3 premium | `form_standard` |
| `44_Capital_Market_Line` | Mix market + risk-free | E(r) = rf + x(muM - rf); sd = x sdM | rf (decimal); E(rM) (decimal); sdM (or blank); Sharpe mkt (or blank); x weight in mkt; or target E(r) | `form_standard` |

Total: 44 sheets.
