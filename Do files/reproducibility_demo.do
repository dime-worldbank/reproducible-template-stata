
***********************************************
* SETTINGS 
***********************************************

* Set working directory 

global github "C:/Users/wb554347/OneDrive - WBG/GitHub/ce_session"

* Set sub-folder paths
global do "${github}/Do files"

global output "${github}/Outputs"

* Install packages 

local ssc_packages estout ietoolkit 

foreach package in `ssc_packages' {
	capture which `package'
	if _rc != 0 {
		ssc install `package', replace
	}
}

*** First, we run the code without setting a seed. 

* set seed 294343

***

* Let's see what happens 

sysuse auto.dta, clear

reg price mpg i.foreign, vce(bootstrap)

eststo reg1

coefplot

graph export "${output}/graph.png", replace

esttab reg1 using "${output}/table.csv" , se replace

esttab reg1 using "${output}/table.tex", se replace