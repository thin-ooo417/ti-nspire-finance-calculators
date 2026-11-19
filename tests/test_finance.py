"""Business Finance sheets: every output checked against an independent calculation."""

from __future__ import annotations

import math
import random

import pytest

import reference_maths as ref
from form_drivers import V2, check_v2

# (sheet, what to type by field key, expected {row label: value})
CASES = [
    ("01_Holding_Period_Return", {"p0": "104", "p1": "112.36"}, {"r  return": 112.36 / 104 - 1, "r  as %": 112.36 / 104 - 1}),
    ("01_Holding_Period_Return", {"p0": "100", "p1": "110", "inc": "5"}, {"r  return": 0.15}),
    ("02_Discount_Factor", {"r": "0.071773", "t": "10"}, {"DF": 1.071773 ** -10}),
    ("02_Discount_Factor", {"r": "0.05", "t": "0"}, {"DF": 1.0}),
    ("03_Present_Value", {"cf": "5000", "r": "0.07", "t": "1"}, {"PV": 5000 / 1.07}),
    ("03_Present_Value", {"cf": "6000", "r": "0.08", "t": "2"}, {"PV": 6000 / 1.08 ** 2}),
    ("03_Present_Value", {"cf": "7000", "r": "0.095", "t": "3"}, {"PV": 7000 / 1.095 ** 3}),
    ("03_Present_Value", {"cf": "8000", "r": "0.11", "t": "4"}, {"PV": 8000 / 1.11 ** 4}),
    ("03_Present_Value", {"cf": "92.88", "r": "0.08", "t": "1"}, {"PV": 86.0}),
    ("03_Present_Value", {"cf": "-250", "r": "0.1", "t": "2.5"}, {"PV": -250 / 1.1 ** 2.5}),
    ("04_NPV_and_Payback", {"r": "0.12", "c0": "-700", "c1": "-300", "c2": "200", "c3": "300", "c4": "400", "c5": "5600"},
     {"NPV (listed CFs)": ref.npv(0.12, [-700, -300, 200, 300, 400, 5600]),
      "Payback (yrs)": ref.payback([-700, -300, 200, 300, 400, 5600])}),
    ("04_NPV_and_Payback", {"r": "0.1", "c0": "0", "c1": "9", "c2": "2", "c3": "3", "c4": "-4", "c5": "2"},
     {"NPV (listed CFs)": ref.npv(0.10, [0, 9, 2, 3, -4, 2]), "Payback (yrs)": 0.0}),
    ("04_NPV_and_Payback", {"r": "0.088", "c0": "-1000000", "c1": "250000", "c2": "250000", "c3": "250000",
                   "c4": "250000", "c5": "500000"},
     {"NPV (listed CFs)": ref.npv(0.088, [-1e6, 250e3, 250e3, 250e3, 250e3, 500e3]), "Payback (yrs)": 4.0}),
    # growth: the last listed cashflow is the first payment of the growing perpetuity
    ("04_NPV_and_Payback", {"r": "0.12", "g": "0.02", "c0": "-700", "c1": "-300", "c2": "200", "c3": "300",
                   "c4": "400", "c5": "500", "c6": "510"},
     {"NPV (listed CFs)": ref.npv(0.12, [-700, -300, 200, 300, 400, 500, 510]),
      "NPV incl growth TV": ref.npv(0.12, [-700, -300, 200, 300, 400, 500 + 510 / (0.12 - 0.02)])}),
    ("05_IRR", {"c0": "-100", "c1": "110"}, {"IRR (decimal)": 0.10, "IRR  as %": 0.10}),
    ("05_IRR", {"c0": "-1000", "c6": "2000"}, {"IRR (decimal)": 2 ** (1 / 6) - 1}),
    ("05_IRR", {"c0": "-100", "c1": "60", "c2": "60"}, {"IRR (decimal)": (0.6 + math.sqrt(0.36 + 2.4)) / 2 - 1}),
    ("06_Real_vs_Nominal_Rate", {"rn": "0.08", "inf": "0.05"}, {"rreal": 1.08 / 1.05 - 1}),
    ("06_Real_vs_Nominal_Rate", {"rr": "0.03", "inf": "0.02"}, {"rnom": 1.03 * 1.02 - 1}),
    ("06_Real_vs_Nominal_Rate", {"rn": "0.04", "rr": "0.0947368421"}, {"I  inflation": 1.04 / 1.0947368421 - 1}),
    ("07_Compounding_Frequency", {"c": "1000", "r": "0.12", "f": "12", "t": "2"},
     {"FV after t years": 1000 * 1.01 ** 24, "Effective annual rate": 1.01 ** 12 - 1}),
    ("08_Perpetuity", {"c": "3.5", "r": "0.145"}, {"PV": 3.5 / 0.145}),
    ("08_Perpetuity", {"c": "3.5", "r": "0.146"}, {"PV": 3.5 / 0.146}),
    ("08_Perpetuity", {"c": "510", "r": "0.12", "g": "0.02"}, {"PV": 5100.0}),
    ("09_Annuity", {"r": "0.004", "t": "36", "pv": "300000"},
     {"Annuity factor AF": ref.annuity_factor(0.004, 36), "C = PV / AF": 300000 / ref.annuity_factor(0.004, 36)}),
    ("09_Annuity", {"r": "0.05", "t": "10", "c": "100"}, {"PV = C x AF": 100 * ref.annuity_factor(0.05, 10)}),
    ("09_Annuity", {"r": "0", "t": "7", "c": "10"}, {"Annuity factor AF": 7.0, "PV = C x AF": 70.0}),
    ("10_Bond_Price", {"c": "4", "fp": "100", "t": "3", "y": "0.05"},
     {"PB  price": ref.bond_price(4, 100, 0.05, 3), "Current yield C/PB": 4 / ref.bond_price(4, 100, 0.05, 3),
      "P next per. (same y)": ref.bond_price(4, 100, 0.05, 2)}),
    ("10_Bond_Price", {"c": "7", "fp": "100", "t": "2", "y": "0.04", "y2": "0.07"},
     {"PB  price": ref.bond_price(7, 100, 0.04, 2), "P at new YTM": 100.0,
      "Price change": 100 / ref.bond_price(7, 100, 0.04, 2) - 1}),
    ("10_Bond_Price", {"c": "70", "fp": "1000", "t": "20", "y": "0.12"}, {"PB  price": ref.bond_price(70, 1000, 0.12, 20)}),
    ("10_Bond_Price", {"c": "50", "fp": "1000", "t": "3", "y": "0.04"},
     {"PB  price": ref.bond_price(50, 1000, 0.04, 3), "P next per. (same y)": ref.bond_price(50, 1000, 0.04, 2)}),
    ("10_Bond_Price", {"c": "5", "fp": "100", "t": "4", "y": "0"}, {"PB  price": 120.0}),
    ("11_Free_Cash_Flow_Direct", {"to": "1000", "fc": "200", "lc": "150", "rm": "100", "cx": "50", "tax": "60", "wc": "40"},
     {"FCF": 400.0}),
    ("12_Free_Cash_Flow_From_EBIT", {"eb": "430300", "tx": "150605", "dep": "100000", "cx": "150000", "wc": "33129"},
     {"FCF": 430300 - 150605 + 100000 - 150000 - 33129}),
    ("12_Free_Cash_Flow_From_EBIT", {"eb": "500", "tx": "100", "dep": "50", "cx": "80", "fcf": "340"}, {"ChWC": 30.0}),
    ("12_Free_Cash_Flow_From_EBIT", {"tx": "100", "dep": "50", "cx": "80", "wc": "30", "fcf": "340"}, {"EBIT": 500.0}),
    ("13_Expected_Return_and_Risk", {"p1": "0.3", "r1": "0.1", "p2": "0.5", "r2": "0.05", "p3": "0.2", "r3": "-0.02"},
     {"Σ p (must be 1)": 1.0, "E(r) = μ": 0.051,
      "Variance σ²": 0.3 * 0.049 ** 2 + 0.5 * 0.001 ** 2 + 0.2 * 0.071 ** 2,
      "Std dev σ": math.sqrt(0.3 * 0.049 ** 2 + 0.5 * 0.001 ** 2 + 0.2 * 0.071 ** 2)}),
    ("14_Covariance", {"rho": "0.3", "sa": "0.25", "sb": "0.4"}, {"Covariance σA,B": 0.03}),
    ("15_Sharpe_Ratio", {"ri": "0.106", "rf": "0.01", "si": "0.3"}, {"Sharpe ratio S": 0.32}),
    ("15_Sharpe_Ratio", {"ri": "0.1", "rf": "0.04", "si": "0.15"}, {"Sharpe ratio S": 0.4}),
    ("16_Portfolio_Return", {"x1": "0.5", "r1": "0.12", "x2": "0.5", "r2": "0.15"},
     {"Σ x (must be 1)": 1.0, "rP": 0.135, "rP  as %": 0.135}),
    ("17_Portfolio_Variance", {"xa": "0.5", "sa": "0.25", "sb": "0.4", "rho": "0.3"},
     {"xB used": 0.5, "Cov σA,B": 0.03, "Variance σP²": ref.two_asset_variance(0.5, 0.5, 0.25, 0.4, 0.3),
      "Std dev σP": math.sqrt(ref.two_asset_variance(0.5, 0.5, 0.25, 0.4, 0.3))}),
    ("17_Portfolio_Variance", {"xa": "1.5", "xb": "-0.5", "sa": "0.2", "sb": "0.1", "rho": "-0.4"},
     {"Variance σP²": ref.two_asset_variance(1.5, -0.5, 0.2, 0.1, -0.4)}),
    ("18_CAPM", {"rf": "0.03", "beta": "1.3", "mm": "0.1"},
     {"Market risk premium": 0.07, "E(ri)": 0.121, "E(ri)  as %": 0.121}),
    ("18_CAPM", {"rf": "0.01", "beta": "1.2", "mm": "0.09"}, {"E(ri)": 0.106}),
    ("19_Beta_From_Returns", {"eri": "0.121", "rf": "0.03", "erm": "0.1"}, {"βi": 1.3}),
    ("20_Beta_From_Volatility", {"si": "0.2", "rho": "0.25", "sp": "0.083333"}, {"beta": 0.2 * 0.25 / 0.083333}),
    ("20_Beta_From_Volatility", {"b": "0.6", "si": "0.2", "rho": "0.25"}, {"sM": 0.2 * 0.25 / 0.6}),
    ("20_Beta_From_Volatility", {"b": "0.6", "rho": "0.25", "sp": "0.0833333"}, {"si": 0.6 * 0.0833333 / 0.25}),
    ("20_Beta_From_Volatility", {"b": "0.6", "si": "0.2", "sp": "0.0833333"}, {"rho": 0.6 * 0.0833333 / 0.2}),
    ("20_Beta_From_Volatility", {"sp": "0.06", "cov": "0.0036"}, {"beta": 1.0}),
    ("21_Risk_Decomposition", {"si": "0.5", "b": "-2", "sm": "0.18"},
     {"idio var": 0.25 - 4 * 0.0324, "idio sd": math.sqrt(0.25 - 4 * 0.0324)}),
    ("21_Risk_Decomposition", {"b": "1.2", "sm": "0.2", "iv": "0.01"}, {"si  total sd": math.sqrt(1.44 * 0.04 + 0.01)}),
    ("21_Risk_Decomposition", {"si": "0.3", "sm": "0.2", "isd": "0.1"}, {"beta (+/-)": math.sqrt((0.09 - 0.01) / 0.04)}),
    ("21_Risk_Decomposition", {"si": "0.3", "b": "1.2", "iv": "0.0324"}, {"sM": math.sqrt((0.09 - 0.0324) / 1.44)}),
    ("22_Alpha", {"eri": "0.125", "rf": "0.02", "beta": "1.25", "mm": "0.1"},
     {"CAPM E(ri)": 0.12, "α  alpha": 0.005, "α  as %": 0.005}),
    ("23_MM_Proposition_1", {"d": "250000", "e": "837500"}, {"A = D + E": 1087500.0}),
    ("23_MM_Proposition_1", {"a": "1087500", "d": "250000"}, {"E = A - D": 837500.0}),
    ("23_MM_Proposition_1", {"a": "1087500", "e": "837500"}, {"D = A - E": 250000.0}),
    ("24_WACC", {"d": "25", "e": "120", "rd": "0.06", "re": "0.12"},
     {"A = D + E": 145.0, "D/A": 25 / 145, "E/A": 120 / 145, "WACC": (25 * 0.06 + 120 * 0.12) / 145,
      "WACC  as %": (25 * 0.06 + 120 * 0.12) / 145}),
    ("24_WACC", {"d": "45", "e": "120", "rd": "0.06", "re": "0.128276"}, {"WACC": (45 * 0.06 + 120 * 0.128276) / 165}),
    ("25_Asset_Beta", {"d": "0.16", "e": "1", "be": "1.4"}, {"bA  asset beta": 1.4 / 1.16}),
    ("25_Asset_Beta", {"d": "0.3", "e": "1", "bd": "0.15", "be": "1.7"}, {"bA  asset beta": (0.045 + 1.7) / 1.3}),
    ("25_Asset_Beta", {"d": "1.44", "e": "1", "bd": "0.3", "be": "2.6"}, {"bA  asset beta": (0.432 + 2.6) / 2.44}),
    ("25_Asset_Beta", {"de": "0.5", "be": "1.5"}, {"bA  asset beta": 1.0}),
    ("26_Tax_Adjusted_WACC", {"d": "50", "e": "50", "rd": "0.08", "re": "0.12", "tau": "0.3"},
     {"rD used": 0.08, "r*  tax-adj WACC": 0.5 * 0.7 * 0.08 + 0.5 * 0.12}),
    ("26_Tax_Adjusted_WACC", {"d": "50", "e": "150", "int": "3", "re": "0.1", "tau": "0.25"},
     {"rD used": 0.06, "r*  tax-adj WACC": 0.25 * 0.75 * 0.06 + 0.75 * 0.1}),
    ("27_Tax_Shield", {"d": "2000000", "tau": "0.3"}, {"Shield if perpetual": 600000.0}),
    ("27_Tax_Shield", {"d": "250000", "tau": "0.35"}, {"Shield if perpetual": 87500.0}),
    ("27_Tax_Shield", {"d": "1000", "tau": "0.3", "rd": "0.05", "t": "10"},
     {"Shield for T years": 0.3 * 0.05 * 1000 * ref.annuity_factor(0.05, 10)}),
    ("28_Commodity_Futures", {"s0": "10", "rf": "0.04", "t": "2", "st": "0.03", "cy": "0.01"},
     {"net cost yield": 0.02, "Ft  futures price": 10 * 1.06 ** 2}),
    ("28_Commodity_Futures", {"s0": "50", "rf": "0.05", "t": "1", "sd": "2", "cd": "0.5"},
     {"net cost yield": 0.03, "Ft  futures price": 50 * 1.08}),
    ("29_Security_Futures", {"s0": "40", "t": "3", "rf": "0.06", "y": "0.019958"}, {"Ft": 40 * (1.06 - 0.019958) ** 3}),
    ("29_Security_Futures", {"s0": "40", "t": "3", "rf": "0.06", "f": "45"}, {"y  div yield": 1.06 - (45 / 40) ** (1 / 3)}),
    ("29_Security_Futures", {"s0": "40", "t": "3", "y": "0.02", "f": "45"}, {"rf": (45 / 40) ** (1 / 3) - 1 + 0.02}),
    ("30_FX_Forward", {"s0": "0.85", "t": "3", "r1": "0.024094", "r2": "0.045"},
     {"F  forward rate": 0.85 * (1.024094 / 1.045) ** 3}),
    ("30_FX_Forward", {"s0": "0.85", "t": "3", "r2": "0.045", "f": "0.8"},
     {"r1 (ccy1)": 1.045 * (0.8 / 0.85) ** (1 / 3) - 1}),
    ("30_FX_Forward", {"s0": "0.85", "t": "3", "r1": "0.024094", "f": "0.8"},
     {"r2 (ccy2)": 1.024094 / (0.8 / 0.85) ** (1 / 3) - 1}),
    ("31_Option_Payoffs", {"s": "39", "k": "32", "cp": "2", "pp": "1"},
     {"Call payoff": 7.0, "Call PROFIT": 5.0, "Put payoff": 0.0, "Put PROFIT": -1.0, "Straddle profit": 4.0}),
    ("31_Option_Payoffs", {"s": "25", "k": "32", "cp": "2", "pp": "1"},
     {"Call payoff": 0.0, "Call PROFIT": -2.0, "Put payoff": 7.0, "Put PROFIT": 6.0, "Straddle profit": 4.0}),
    ("32_Mean_Variance_Dominance", {"mp": "0.1", "sp": "0.2", "ma": "0.08", "sa": "0.25"}, {"E(rP) - E(rA)": 0.02, "σP - σA": -0.05}),
    ("33_Deferred_Perpetuity", {"c": "100", "r": "0.1", "t": "5"}, {"PV": 100 / (0.1 * 1.1 ** 5)}),
    ("33_Deferred_Perpetuity", {"c": "100", "r": "0.1"}, {"PV": 1000.0}),
    ("34_CAGR_and_Zero_Coupon_Yield", {"p": "1000000", "f": "2000000", "t": "10"},
     {"r per period": 2 ** 0.1 - 1, "Value in 1 period": 1e6 * 2 ** 0.1}),
    ("34_CAGR_and_Zero_Coupon_Yield", {"p": "100", "t": "5", "r": "0.08"}, {"F": 100 * 1.08 ** 5}),
    ("34_CAGR_and_Zero_Coupon_Yield", {"f": "1000", "t": "10", "r": "0.06"}, {"P": 1000 / 1.06 ** 10}),
    ("34_CAGR_and_Zero_Coupon_Yield", {"p": "100", "f": "200", "r": "0.07"}, {"T": math.log(2) / math.log(1.07)}),
    ("35_Cost_of_Delay", {"c0": "100", "gc": "0.12", "r": "0.04"},
     {"Cost next year": 112.0, "PV of next-yr cost": 112 / 1.04, "Cost of delay (PV)": 112 / 1.04 - 100}),
    ("36_Two_Asset_Portfolio", {"xa": "0.5", "ma": "0.12", "mb": "0.15", "sa": "0.25", "sb": "0.4", "rho": "0.3"},
     {"xB used": 0.5, "E(r) portfolio": 0.135, "Variance": 0.070625, "Std dev": math.sqrt(0.070625)}),
    ("37_CAPM_Full_Chain", {"b": "1.2", "si": "0.3", "rf": "0.01", "mm": "0.09"},
     {"beta used": 1.2, "MRP used": 0.08, "E(r) CAPM": 0.106, "Sharpe (CAPM E(r))": 0.32}),
    ("37_CAPM_Full_Chain", {"si": "0.2", "rho": "0.25", "sm": "0.0833333", "rf": "0.02", "mp": "0.06", "p0": "50", "ri": "0.07"},
     {"beta used": 0.2 * 0.25 / 0.0833333, "E(r) CAPM": 0.02 + 0.6 * 0.06,
      "E(P) in 1 yr": 50 * (1 + 0.02 + 0.6 * 0.06), "alpha = ri - E(r)": 0.07 - (0.02 + 0.6 * 0.06)}),
    ("38_MM2_Cost_of_Equity", {"d": "25", "e": "120", "rd": "0.06", "re": "0.12", "dd": "20"},
     {"rA (pre, MM no tax)": 15.9 / 145, "rE new": 15.9 / 145 + 45 / 120 * (15.9 / 145 - 0.06)}),
    ("39_Firm_Value_with_Debt", {"eb": "100", "ru": "0.1", "tau": "0.3", "d": "200"},
     {"VU unlevered": 700.0, "D used": 200.0, "PV tax shield": 60.0, "VL total value": 760.0, "E = VL - D": 560.0}),
    ("39_Firm_Value_with_Debt", {"tau": "0.35", "vu": "1000000", "int": "15000", "rd": "0.06"},
     {"D used": 250000.0, "PV tax shield": 87500.0, "VL total value": 1087500.0, "E = VL - D": 837500.0}),
    ("40_Share_Value", {"b": "1.2", "rf": "0.02", "mp": "0.05", "f1": "100", "g": "0.03", "n": "10"},
     {"r  cost of equity": 0.08, "V  firm value": 2000.0, "Price per share": 200.0}),
    ("40_Share_Value", {"b": "0.8", "rf": "0.03", "mm": "0.1", "f1": "50"},
     {"r  cost of equity": 0.086, "V  firm value": 50 / 0.086}),
    ("41_Working_Capital_PV",
     {"a1": "19", "a2": "25", "a3": "26", "a4": "21", "a5": "23", "v1": "6", "v2": "7", "v3": "11", "v4": "14",
      "v5": "16", "b1": "16", "b2": "21", "b3": "23", "b4": "25", "b5": "27", "r": "0.1"},
     {"PV of WC investment": -ref.npv(0.10, [0, 9, 2, 3, -4, 2])}),
    ("44_Capital_Market_Line", {"rf": "0.04", "mm": "0.1", "sh": "0.4", "mt": "0.08"},
     {"x in market used": 2 / 3, "sdM used": 0.15, "E(r) portfolio": 0.08, "sd portfolio": 0.10}),
    ("44_Capital_Market_Line", {"rf": "0.04", "mm": "0.1", "sm": "0.2", "xm": "1.5"},
     {"E(r) portfolio": 0.13, "sd portfolio": 0.30}),
]


@pytest.mark.parametrize("sheet,typed,expected", CASES, ids=[f"{c[0]}-{i}" for i, c in enumerate(CASES)])
def test_outputs(sheet, typed, expected):
    V2(sheet).set(typed).expect(expected)


def test_every_business_finance_sheet_has_a_numeric_case():
    from conftest import names

    covered = {case[0] for case in CASES} | {"42_Profitability_Index", "43_Option_Strategy"}
    assert set(names(folder="finance")) == covered


# --- behaviour that is not a single number ----------------------------------------

def test_npv_warns_when_growth_reaches_the_rate():
    form = V2("04_NPV_and_Payback").set({"r": "0.05", "g": "0.06", "c0": "-100", "c1": "10", "c2": "10"})
    assert "g >= r: TV invalid." in form.warnings()


def test_npv_payback_never_reached():
    form = V2("04_NPV_and_Payback").set({"r": "0.1", "c0": "-100", "c1": "10"})
    assert form.results()["Payback (yrs)"] == "> last yr"


def test_npv_needs_a_rate_but_still_shows_payback():
    form = V2("04_NPV_and_Payback").set({"c0": "-100", "c1": "60", "c2": "60"})
    assert form.results()["NPV"] == "-"
    check_v2(form.results()["Payback (yrs)"], 1 + 40 / 60)


def test_irr_makes_npv_zero_for_random_projects():
    rng = random.Random(44)
    for _ in range(25):
        flows = [-rng.randint(200, 2000)] + [rng.randint(0, 900) for _ in range(6)]
        if sum(flows[1:]) == 0:
            continue
        typed = {f"c{i}": str(v) for i, v in enumerate(flows)}
        shown = V2("05_IRR").set(typed).results()["IRR (decimal)"]
        irr = float(shown)
        scale = sum(abs(v) for v in flows)
        # the display rounds the rate to 6 significant figures, so allow for that
        slope = abs(sum(-t * cf / (1 + irr) ** (t + 1) for t, cf in enumerate(flows)))
        assert abs(ref.npv(irr, flows)) <= slope * 6e-6 * max(abs(irr), 1e-3) + scale * 1e-9, flows


def test_irr_reports_multiple_roots():
    form = V2("05_IRR").set({"c0": "-100", "c1": "230", "c2": "-132"})   # roots at 10% and 20%
    check_v2(form.results()["IRR (decimal)"], 0.10)
    assert any("Multiple IRRs exist (2)" in w for w in form.warnings())


def test_irr_needs_both_signs():
    form = V2("05_IRR").set({"c0": "100", "c1": "50"})
    assert form.results()["IRR (decimal)"] == "-"
    assert "Needs both + and - cashflows." in form.warnings()


def test_real_nominal_needs_two_inputs():
    assert V2("06_Real_vs_Nominal_Rate").set({"rn": "0.08"}).warnings() == ["Enter any two."]


def test_perpetuity_warns_when_growth_reaches_the_rate():
    assert "g >= r: formula invalid." in V2("08_Perpetuity").set({"c": "10", "r": "0.03", "g": "0.03"}).warnings()


def test_annuity_asks_for_payment_or_value():
    assert "Enter C or PV." in V2("09_Annuity").set({"r": "0.05", "t": "10"}).warnings()


def test_bond_needs_its_four_inputs():
    assert V2("10_Bond_Price").set({"c": "5", "fp": "100"}).warnings() == ["Need C, F, T, YTM."]


def test_probabilities_must_sum_to_one():
    form = V2("13_Expected_Return_and_Risk").set({"p1": "0.5", "r1": "0.1", "p2": "0.4", "r2": "0.2"})
    assert "Probabilities do not sum to 1." in form.warnings()


@pytest.mark.parametrize("sheet,typed,message", [
    ("14_Covariance", {"rho": "1.2", "sa": "0.1", "sb": "0.1"}, "ρ must lie between -1 and 1."),
    ("17_Portfolio_Variance", {"xa": "0.5", "sa": "0.1", "sb": "0.1", "rho": "-1.5"}, "ρ must lie between -1 and 1."),
    ("20_Beta_From_Volatility", {"b": "2", "si": "0.1", "sp": "0.2"}, "rho outside [-1, 1]."),
    ("36_Two_Asset_Portfolio", {"xa": "0.5", "rho": "2"}, "rho outside [-1, 1]."),
    ("37_CAPM_Full_Chain", {"rho": "-3"}, "rho outside [-1, 1]."),
    ("16_Portfolio_Return", {"x1": "0.5", "r1": "0.1", "x2": "0.4", "r2": "0.2"}, "Weights do not sum to 1."),
    ("21_Risk_Decomposition", {"si": "0.1", "b": "2", "sm": "0.2"}, "idio var < 0: check inputs."),
    ("21_Risk_Decomposition", {"si": "0.3", "sm": "0.2", "isd": "0.1"}, "beta from sqrt: sign unknown."),
    ("27_Tax_Shield", {"d": "100", "tau": "0.3", "t": "5"}, "Finite case needs rD."),
    ("33_Deferred_Perpetuity", {"c": "100", "r": "-0.1"}, "r <= 0: formula invalid."),
    ("33_Deferred_Perpetuity", {"c": "100", "r": "0.1", "t": "2.5"}, "T should be a whole number >= 0."),
    ("40_Share_Value", {"b": "1", "rf": "0.02", "mp": "0.03", "f1": "10", "g": "0.06"}, "g >= r: invalid."),
])
def test_domain_warnings(sheet, typed, message):
    assert message in V2(sheet).set(typed).warnings()


@pytest.mark.parametrize("typed,verdict", [
    ({"mp": "0.1", "sp": "0.2", "ma": "0.08", "sa": "0.25"}, "P dominates A"),
    ({"mp": "0.08", "sp": "0.25", "ma": "0.1", "sa": "0.2"}, "A dominates P"),
    ({"mp": "0.1", "sp": "0.2", "ma": "0.1", "sa": "0.2"}, "identical"),
    ({"mp": "0.12", "sp": "0.3", "ma": "0.1", "sa": "0.2"}, "neither dominates"),
])
def test_mean_variance_verdict(typed, verdict):
    assert verdict in V2("32_Mean_Variance_Dominance").set(typed).warnings()


def test_working_capital_shows_levels_and_changes():
    typed = {"a1": "19", "a2": "25", "a3": "26", "a4": "21", "a5": "23", "v1": "6", "v2": "7", "v3": "11",
             "v4": "14", "v5": "16", "b1": "16", "b2": "21", "b3": "23", "b4": "25", "b5": "27", "r": "0.1"}
    shown = V2("41_Working_Capital_PV").set(typed).results()
    assert shown["NWC:"].split() == ["9", "11", "14", "10", "12"]
    assert shown["chg:"].split() == ["9", "2", "3", "-4", "2"]


def test_profitability_index_ranks_projects():
    invest = [75, 80, 85, 125, 25, 45]
    value = [22.65, 19.44, 14.69, 28.97, 5.32, 15.28]
    typed = {}
    for i, (inv, val) in enumerate(zip(invest, value, strict=True), start=1):
        typed[f"i{i}"] = str(inv)
        typed[f"n{i}"] = str(val)
    form = V2("42_Profitability_Index").set(typed)
    rows = form.rows()
    shown = {}
    for label, text in rows:
        if label == "PI:":
            for part in text.split():
                index, pi = part.split(":")
                shown[int(index)] = float(pi)
    for i, (inv, val) in enumerate(zip(invest, value, strict=True), start=1):
        assert abs(shown[i] - val / inv) <= 0.0005
    expected_order = sorted(range(1, 7), key=lambda i: -value[i - 1] / invest[i - 1])
    assert dict(rows)["Rank best->worst"].split() == [str(i) for i in expected_order]


def test_profitability_index_asks_for_pairs():
    assert V2("42_Profitability_Index").set({"i1": "100"}).warnings() == ["Enter Inv and NPV pairs."]


def _strategy(legs, at):
    total = 0.0
    for kind, qty, strike, premium in legs:
        if kind == 1:
            total += qty * (max(at - strike, 0) - premium)
        elif kind == 2:
            total += qty * (max(strike - at, 0) - premium)
        else:
            total += qty * (at - strike)
    return total


@pytest.mark.parametrize("legs,expiry", [
    ([(1, 1, 100, 5)], 120),                                     # long call
    ([(1, 1, 100, 5), (1, -1, 110, 2)], 120),                    # bull call spread
    ([(3, 1, 50, 0), (2, 1, 45, 3)], 30),                        # protective put
    ([(3, -1, 40, 0), (1, 1, 45, 2)], 80),                       # short stock plus call
    ([(1, 1, 90, 12), (1, -2, 100, 6), (1, 1, 110, 2)], 104),    # butterfly
])
def test_option_strategy(legs, expiry):
    typed = {"st": str(expiry)}
    for n, (kind, qty, strike, premium) in enumerate(legs, start=1):
        typed.update({f"t{n}": str(kind), f"q{n}": str(qty), f"k{n}": str(strike), f"c{n}": str(premium)})
    form = V2("43_Option_Strategy").set(typed)
    shown = form.results()
    check_v2(shown["Profit at ST"], _strategy(legs, expiry))
    check_v2(shown["Profit at S=0"], _strategy(legs, 0))
    for kind, _, strike, _ in legs:
        if kind in (1, 2):
            check_v2(shown[f"at S={strike:g}"], _strategy(legs, strike))
    check_v2(shown["Slope for big S"], sum(q for kind, q, _, _ in legs if kind in (1, 3)))
    assert form.warnings() == []


def test_option_strategy_rejects_unknown_leg_type():
    """A type other than 1, 2 or 3 used to be priced as stock without a word."""
    form = V2("43_Option_Strategy").set({"st": "120", "t1": "4", "k1": "100", "c1": "5"})
    assert form.warnings() == ["Leg 1 type must be 1, 2 or 3."]
    assert form.results() == {}


def test_option_strategy_bad_leg_does_not_hide_good_ones():
    form = V2("43_Option_Strategy").set({"st": "120", "t1": "1", "k1": "100", "c1": "5", "t2": "7", "k2": "90"})
    assert "Leg 2 type must be 1, 2 or 3." in form.warnings()
    check_v2(form.results()["Profit at ST"], 15.0)


def test_irr_scan_cost_is_bounded():
    """The IRR sheet scans for roots on every repaint; keep that affordable without an FPU."""
    from conftest import load

    sheet = load("05_IRR")
    for value in ("-1000", "300", "300", "300", "300", "300", "300"):
        sheet.type(value)
        sheet.enter()
    assert sheet.instructions(sheet.paint) <= 150_000


def test_option_strategy_leg_needs_a_strike():
    assert V2("43_Option_Strategy").set({"t1": "1"}).warnings() == ["Leg 1 needs K/entry."]
