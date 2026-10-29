# Cut Rite part counter

> 🇫🇷 Explication en français [ci-dessous](#français).

## English

A PowerShell script that counts the parts manufactured over a period by summing the `SUM1` quantity of the Cut Rite `.ptn` files in a folder.
Select the period with `-Year YYYY`, `-StartDate DD/MM/YYYY` (until today), or `-StartDate` and `-EndDate`. Each file is dated from its `REV1` line.

```powershell
.\crPartCounter.ps1 -Path C:\CutRite\Data -StartDate 01/03/2026 -EndDate 31/03/2026
```

## Français

Un script PowerShell qui compte les pièces fabriquées sur une période en additionnant la quantité de la ligne `SUM1` des fichiers Cut Rite `.ptn` d'un dossier.
Choisissez la période avec `-Year AAAA`, `-StartDate JJ/MM/AAAA` (jusqu'à aujourd'hui), ou `-StartDate` et `-EndDate`. La date de chaque fichier est lue sur sa ligne `REV1`.

```powershell
.\crPartCounter.ps1 -Path C:\CutRite\Data -StartDate 01/03/2026 -EndDate 31/03/2026
```
