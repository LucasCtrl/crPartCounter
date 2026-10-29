# Cut Rite part counter

## Goal
The application's goal is to calculate the quantity of parts manufactured during a specific time.

## Input data
- A path to a specific folder
- Date arguments:
  - Year as `YYYY`
  - Start date as `DD/MM/YYYY`
  - End date as `DD/MM/YYYY`

## Code actions
Based on the path given by the user, the application scan the folder and retreive all the files with the extension `.ptn`.
Based on the date argument, the application only keep the files where the date correspond to the timeframe defined.
The data argument shoud be understand as follow :
- Only year. Application keep files from January 1st to December 31th
- Only start date. Application keep files from start date to today
- Start date and end date. Application keep files from start to end date.
Other date argument combination is considered as bad argument and stop the app.

One the files are retrieved, the app scan each files for to get the line starting with `SUM1`.
The line can be interpreted as a CSV. Get the 7 columns which is a quantity.
While opening each files, the app sums up the quantity and output a total quantity at the end of the loop.

## Technical detail
Application is a powershell script that use only default libraries.
