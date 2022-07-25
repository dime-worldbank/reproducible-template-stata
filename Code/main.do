********************************************************************************
***    DEMO Code for CE Session: Common Reproducibility Mistakes in Stata    ***
********************************************************************************

********************************************************************************
* USER SETTINGS 
********************************************************************************
  
// Working directory -----------------------------------------------------------

global github 	"C:\Users\wb501238\Documents\GitHub\reproducible-template-stata"

// Sub-folders

global do 		"${github}/Code"
global output 	"${github}/Output"

// Packages 
sysdir set PLUS "${github}/Code/ado"

// Version ---------------------------------------------------------------------

  ieboilstart, v(14.0) // Sets the same version for whoever runs the code
  `r(version)'

********************************************************************************
* CODE
********************************************************************************

*** Normally, we will only include one line of code here - to run a do-file that
*** is located in the relevant folder set-up above. But in this case, for this 
*** demo, we have the code in the same script.

*** First, we run the code without setting a seed. So this part of the code has 
*** been commented out. We will later come back to Line 48.

set seed 928381 // Generated using https://bit.ly/stata-random

*** Load one of Stata's system datasets.

sysuse auto.dta, clear

*** Run a regression that involves bootstrapping. This is the part of the code
*** where Stata uses a random number generator in the background.

isid make, sort
reg price mpg i.foreign, vce(bootstrap)

*** Store regression results in an object.

eststo reg1

*** Plot the regression stats.

coefplot

*** Export to .PNG. 

graph export "${output}/graph.png", replace

*** Export regression stats to 2 tables, one in .CSV, and one to a LaTeX table.

esttab reg1 using "${output}/table.csv" , se replace

esttab reg1 using "${output}/table.tex", se replace

********************************************************************************