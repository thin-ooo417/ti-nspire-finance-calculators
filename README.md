# TI-Nspire Business Finance Calculators

44 calculator sheets for time value of money, bonds, NPV and IRR, portfolios, CAPM, capital structure, futures and options. Each sheet opens as a simple form on a TI-Nspire CX or CX CAS: type the numbers you
have and the answer appears underneath.

> **Version 1.0.0.** Every sheet has been tested on a computer but this version has not yet
> been tried on a calculator. Check one sheet first (step 6 below).

## Contents

1. [Put the sheets on your calculator](#1-put-the-sheets-on-your-calculator)
2. [Use a sheet](#2-use-a-sheet)
3. [The sheets](#3-the-sheets)
4. [Notes on particular sheets](#4-notes-on-particular-sheets)
5. [If something goes wrong](#5-if-something-goes-wrong)
6. [Known limitations](#6-known-limitations)
7. [For developers](#7-for-developers)
8. [Licence, security and support](#8-licence-security-and-support)

## 1. Put the sheets on your calculator

You need a TI-Nspire CX or CX CAS, its USB cable, and **TI-Nspire Computer Link Software** (free from
education.ti.com) on a Windows or Mac computer.

1. **Download.** Open this repository's **Releases** page, download `ti-nspire-finance-calculators-1.0.0.zip` and unzip it.
   You get a folder called `finance` and a `README.txt`.
2. **Connect.** Turn the calculator on and plug it into the computer.
3. **Open Computer Link.** In the Select Handheld window, click your calculator, then **Select**.
4. **Copy.** The top pane shows your computer and the bottom pane shows the calculator. Drag the
   `finance` folder from the top pane to the bottom pane.
5. **Leave `README.txt` behind.** Computer Link only copies calculator files and cancels the whole
   copy if you include anything else.
6. **Check.** On the calculator press [home], open **My Documents**, then `finance`, then
   `03_Present_Value`. Press 5000 [enter] 0.07 [enter] 1 (words in square brackets are keys; the rest
   are numbers to type). You should see **PV** 4672.9.

The `README.txt` in the zip has the same steps in more detail, with fixes for common problems.
No release yet? Build the zip yourself (section 7).

## 2. Use a sheet

| Sheets | Move | Type | Reset |
|---|---|---|---|
| All sheets | [up] [down], or [enter] / [tab] for the next field | number keys, `.` and `(-)`; [backspace] deletes | [esc] empties the field you are on |

- Type rates, yields, growth, probabilities and tax rates as decimals: `0.08` for 8%.
- Bond sheets work per period. For a semi-annual bond, halve the coupon and the yield and double the number of periods.
- "Solve blank" in a sheet's title means: fill in all but one of the values and the sheet works out the missing one.
- **Grey** values are defaults used while a field is empty. **Orange** text is a warning
  about your inputs. **Red** means an entry is not a complete number yet; results stay
  hidden until you fix it.
- If the calculator asks to save changes when you close a sheet, either answer is fine.

**Example.** Bond price (`10_Bond_Price`): coupon 4, par 100, 3 periods, yield 0.05. Press 4 [enter] 100 [enter] 3 [enter] 0.05:

| Row | Shows |
|---|---|
| PB  price | 97.2768 |
| Current yield C/PB | 4.112% |
| P next per. (same y) | 98.1406 |

## 3. The sheets

| Sheet | What it works out |
|---|---|
| `01_Holding_Period_Return` | Return over one period from start price, end price and income |
| `02_Discount_Factor` | Discount factor 1/(1+r)^t |
| `03_Present_Value` | Present value of a single cashflow |
| `04_NPV_and_Payback` | NPV of up to seven cashflows, optional growing tail, and payback period |
| `05_IRR` | Internal rate of return of up to seven cashflows, with a warning if there are several |
| `06_Real_vs_Nominal_Rate` | Nominal rate, real rate or inflation from the other two |
| `07_Compounding_Frequency` | Future value and effective annual rate for any compounding frequency |
| `08_Perpetuity` | Present value of a level or growing perpetuity |
| `09_Annuity` | Annuity factor, and present value from payment or payment from present value |
| `10_Bond_Price` | Bond price, current yield, price next period, and price change for a new yield |
| `11_Free_Cash_Flow_Direct` | Free cash flow from turnover and costs |
| `12_Free_Cash_Flow_From_EBIT` | Free cash flow from EBIT, or the missing EBIT or working-capital figure |
| `13_Expected_Return_and_Risk` | Expected return, variance and standard deviation over up to four scenarios |
| `14_Covariance` | Covariance from correlation and two standard deviations |
| `15_Sharpe_Ratio` | Sharpe ratio |
| `16_Portfolio_Return` | Expected return of a portfolio of up to four assets |
| `17_Portfolio_Variance` | Variance and standard deviation of a two-asset portfolio |
| `18_CAPM` | Expected return from the CAPM and the market risk premium |
| `19_Beta_From_Returns` | Beta from expected returns |
| `20_Beta_From_Volatility` | Beta from volatilities and correlation, or any one of them from the rest |
| `21_Risk_Decomposition` | Split total risk into market and idiosyncratic parts, or solve for the missing one |
| `22_Alpha` | Alpha against the CAPM expected return |
| `23_MM_Proposition_1` | Assets, debt or equity from the other two |
| `24_WACC` | Weighted average cost of capital (no tax) |
| `25_Asset_Beta` | Asset beta from debt and equity betas |
| `26_Tax_Adjusted_WACC` | After-tax weighted average cost of capital |
| `27_Tax_Shield` | Present value of the interest tax shield, perpetual or for a set number of years |
| `28_Commodity_Futures` | Commodity futures price with storage costs and convenience yield |
| `29_Security_Futures` | Futures price on a share, or the implied yield or rate |
| `30_FX_Forward` | Forward exchange rate, or either interest rate from the other figures |
| `31_Option_Payoffs` | Call and put payoff and profit at expiry, and a straddle |
| `32_Mean_Variance_Dominance` | Whether one portfolio dominates another on return and risk |
| `33_Deferred_Perpetuity` | Present value of a perpetuity that starts later |
| `34_CAGR_and_Zero_Coupon_Yield` | Growth rate or zero-coupon yield, or the missing value or term |
| `35_Cost_of_Delay` | Present-value cost of putting a project off for a year |
| `36_Two_Asset_Portfolio` | Expected return, variance and standard deviation of a two-asset portfolio |
| `37_CAPM_Full_Chain` | Beta, CAPM return, next-year price, Sharpe ratio and alpha in one place |
| `38_MM2_Cost_of_Equity` | New cost of equity after taking on more debt (no tax) |
| `39_Firm_Value_with_Debt` | Levered firm value and equity with a perpetual debt tax shield |
| `40_Share_Value` | Firm value and share price from CAPM and a growing cashflow |
| `41_Working_Capital_PV` | Present value of five years of working-capital investment |
| `42_Profitability_Index` | Profitability index for up to six projects, ranked |
| `43_Option_Strategy` | Profit of a strategy of up to three option or stock positions |
| `44_Capital_Market_Line` | Return and risk of a mix of the market and the risk-free asset |

[docs/SHEET_LIST.md](docs/SHEET_LIST.md) lists every input of every sheet.

## 4. Notes on particular sheets

- **`04_NPV_and_Payback`.** Takes cashflows for years 0 to 6. If you enter a growth rate, the **last** cashflow you list is treated as the first payment of a growing perpetuity, so enter the year-after cashflow there.
- **`05_IRR`.** Takes cashflows for years 0 to 6. Searches −99% to 1000%. If there is more than one answer it shows the lowest and warns you.
- **`10_Bond_Price`.** Also shows the price one period later at the same yield, and the price change if you enter a new yield.
- **`37_CAPM_Full_Chain`.** Fill in whatever you have; it works out beta, CAPM return, next-year price, Sharpe ratio and alpha from it.
- **`41_Working_Capital_PV`.** 16 fields: receivables, inventory and payables for five years, then the rate. The answer is the present value of the yearly changes.
- **`43_Option_Strategy`.** Up to three positions. Type 1 is a call, 2 a put, 3 the share itself; a negative quantity is a short position.

## 5. If something goes wrong

| Problem | What to do |
|---|---|
| The calculator is not in the Select Handheld list | Turn it on, push the cable in fully at both ends, click Refresh. Try another USB port. |
| Computer Link says a file is not supported and copies nothing | You included `README.txt`. Drag only the `finance` folder or `.tns` files. |
| A sheet will not open | Copy that file again. If it still fails, open an issue saying which sheet. |
| A percentage looks 100 times too big or small | Type rates as decimals: `0.08`, not `8`. |
| Nothing appears under the fields | The sheet needs more inputs. A dash means that row cannot be worked out yet. |
| A number looks wrong | Open an issue with the sheet name, what you typed and what it showed. |

## 6. Known limitations

- Not yet tried on a calculator in this version. Check one sheet first (step 6 above).
- Made for the TI-Nspire CX and CX CAS. CX II models have not been tried.
- `41_Working_Capital_PV` and `43_Option_Strategy` use the last row of the screen when every field is filled. Check they fit on your calculator.
- Sheets that solve for a blank do not check the inputs agree when nothing is left blank.
- When growth is at or above the discount rate, `04_NPV_and_Payback`, `08_Perpetuity` and `40_Share_Value` still show the number, with a warning beside it.

## 7. For developers

### What is in this repository

```
ti-nspire-finance-calculators/
├── src/
│   ├── finance/                 one .lua file per sheet (44)
│   └── shared/                  code the sheets share
│       └── form_standard.lua
├── scripts/
│   ├── build.py                 builds every sheet into dist/
│   ├── tns_file.py              reads and writes .tns calculator files
│   ├── des_cipher.py            the cipher the .tns format needs
│   └── make_sheet_list.py       rebuilds docs/SHEET_LIST.md
├── tests/                       automated tests
├── docs/
│   ├── LOADING_GUIDE.txt        becomes README.txt in the download
│   ├── SHEET_LIST.md            every sheet and its inputs
│   ├── CHECK_ON_CALCULATOR.md   what to check on a real calculator
│   ├── HOW_IT_WORKS.md          how the build and tests work
│   └── TNS_FILE_FORMAT.md       the calculator file format
├── .github/workflows/           automatic tests and releases
├── CHANGELOG.md  CONTRIBUTING.md  SECURITY.md  THIRD_PARTY_NOTICES.md
└── VERSION  pyproject.toml  requirements-dev.txt
```

### Set up

You need Python 3.10 or later. Nothing else: no compiler and no TI software.

```bash
git clone <GITHUB_REPOSITORY_URL>
cd ti-nspire-finance-calculators
python -m venv .venv
# Windows: .venv\Scripts\activate     macOS or Linux: source .venv/bin/activate
python -m pip install -r requirements-dev.txt
```

### Build

```bash
python scripts/build.py --zip
```

This writes `dist/finance/` (the `.tns` files), `dist/README.txt` and `dist/ti-nspire-finance-calculators-1.0.0.zip`.
Each build checks every sheet compiles as Lua 5.1 (the calculator's version) and that every file
holds exactly its source.

| Option | What it does |
|---|---|
| `--zip` | also make the zip |
| `--check` | change nothing; fail if `dist/` does not match `src/` |
| `--out FOLDER` | write somewhere other than `dist/` |

### Test

```bash
python -m pytest
ruff check .
python scripts/make_sheet_list.py --check
```

The tests check every result against an independent calculation, press random keys on every
sheet, and type the worked checks from the loading guide into the sheets.
[docs/HOW_IT_WORKS.md](docs/HOW_IT_WORKS.md) explains more.

### One file at a time

```bash
python scripts/tns_file.py pack   my_sheet.lua my_sheet.tns
python scripts/tns_file.py unpack my_sheet.tns my_sheet.lua
```

`unpack` cannot read a file the calculator has saved over; rebuild it from `src/` instead.

## 8. Licence, security and support

- **Licence:** none chosen yet, so all rights are reserved. See
  [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for code this project draws on.
- **Security:** the sheets cannot read files or use a network, and the repository holds no
  passwords or personal data. See [SECURITY.md](SECURITY.md).
- **Assessments:** check the rules before taking stored programs into any test or exam.
- **Contributing:** see [CONTRIBUTING.md](CONTRIBUTING.md).
- **Support:** open an issue on this repository.
