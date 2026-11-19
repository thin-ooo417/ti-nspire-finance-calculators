# Checking on a real calculator

The automated tests run on a computer and cannot show that a sheet looks right on a TI-Nspire.
Before you rely on a new build, and after any change to `src/shared/`, work through this list.
It takes about ten minutes. `docs/LOADING_GUIDE.txt` explains how to copy the files across.

## 1. One sheet of each layout

Words in square brackets are keys to press; the rest are numbers to type.

| Sheet | Press | You should see |
|---|---|---|
| `03_Present_Value` | 5000 [enter] 0.07 [enter] 1 | PV 4672.9 |
| `10_Bond_Price` | 4 [enter] 100 [enter] 3 [enter] 0.05 | PB  price 97.2768 |

For each, also check:

- the title, labels and boxes are all on screen and nothing overlaps;
- a letter key does nothing;
- the `(-)` key types a minus sign in an empty field.

## 2. Changes in version 1.0.0

| Check | How |
|---|---|
| Large values keep their digits | `03_Present_Value`: 4329476.67, enter, 0, enter, 1. PV should read 4329476.67, not 4.32948e+06. |
| Position type is checked | `43_Option_Strategy`: 120, enter, 4, enter, enter, 100. Expect "Leg 1 type must be 1, 2 or 3." and no profit rows. |
| The two fullest screens | `41_Working_Capital_PV` with all 16 fields filled, and `43_Option_Strategy` with three positions on different strikes. The last result row should be fully visible. |

## If something is wrong

Note the sheet, what you typed and what the screen showed, and open an issue.
