********************************************************************************
***    DEMO Code for CE Session: Common Reproducibility Mistakes in Stata    ***
********************************************************************************


* Master Scripts should be set up like this: 

********************************************************************************
* USER SETTINGS 
********************************************************************************
 
  ieboilstart, v(14.0) // Sets the same version for whoever runs the code
  `r(version)'
  
  
// Working directory -----------------------------------------------------------

global github "C:/Users/wb554347/OneDrive - WBG/GitHub/ce_session"

// Sub-folders

global do "${github}/Do files"

global output "${github}/Outputs"

// Packages 

local ssc_packages estout ietoolkit 

foreach package in `ssc_packages' {
	capture which `package'
	if _rc != 0 {
		ssc install `package', replace
	}
}

********************************************************************************
* CODE
********************************************************************************

*** Normally, we will only include one line of code here - to run a do-file that
*** is located in the relevant folder set-up above. But in this case, for this 
*** demo, we have the code in the same script.

*** First, we run the code without setting a seed. So this part of the code has 
*** been commented out. We will later come back to Line 48.

* set seed 294343 // Generated using https://bit.ly/stata-random

***


*** Load one of Stata's system datasets.

sysuse auto.dta, clear

*** Run a regression that involves bootstrapping. This is the part of the code
*** where Stata uses a random number generator in the background.

reg price mpg i.foreign, vce(bootstrap)

*** Store regression results in an object.

eststo reg1

*** Plot the regression stats.

coefplot

*** Export to .PNG. Always use .PNG to track changes to graphs. 

graph export "${output}/graph.png", replace

*** Export regression stats to 2 tables, one in .CSV, and one to a LaTeX table.

esttab reg1 using "${output}/table.csv" , se replace

esttab reg1 using "${output}/table.tex", se replace

********************************************************************************