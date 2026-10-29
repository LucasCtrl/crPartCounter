# Cut Rite part counter

A PowerShell script that counts the parts manufactured over a period by summing the `SUM1` quantity of the Cut Rite `.ptn` files in a folder.
Select the period with `-Year YYYY`, `-StartDate DD/MM/YYYY` (until today), or `-StartDate` and `-EndDate`. Each file is dated from its `REV1` line.

```powershell
.\crPartCounter.ps1 -Path C:\CutRite\Data -StartDate 01/03/2026 -EndDate 31/03/2026
```
