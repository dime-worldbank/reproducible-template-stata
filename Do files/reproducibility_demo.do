
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

sysuse auto.dta, clear

sort price 

gen id = _n

export delimited using "${output}/auto_id.csv", replace