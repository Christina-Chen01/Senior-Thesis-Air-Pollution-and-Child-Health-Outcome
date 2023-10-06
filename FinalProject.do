use "/Users/chujunchen/Desktop/ECON 0466/Research Paper/DHS2019-2021/IAKR7EFL.DTA"
* geographic fixed effects; 

* v440 height age sd -- need to divide by 100

keep v006 v007 v024 v025 v106 v161 v481 h31 m19 v440 v463a v190
save "DHS_cleaned.dta", replace

use "/Users/chujunchen/Desktop/ECON 0466/Research Paper/DHS2019-2021/DHS_cleaned.dta"
rename v006 month
rename v007 year
rename v025 urban
rename v024 state

rename v106 education
rename v161 cookfuel
drop if cookfuel >96
rename v481 insurance
rename h31 cough
drop if cough == 8

rename m19 birthweight

replace birthweight = birthweight / 1000
drop if birthweight > 5
* Question here: can I drop birth weight  greater than 5kg?? the heaviest is 10kg??

rename v440 heightforage
replace heightforage = heightforage / 100
drop if heightforage >= 3 | heightforage < -3
* mention it in the methodlogy

rename v463a smoke
rename v190 wealthindex

* summary statistics
sum ibn.cough birthweight heightforage ibn.cookfuel ibn.education ibn.wealthindex ibn.smoke ibn.urban ibn.insurance ibn.state


* Relationship bewteen cough and air pollution
regress cough i.cookfuel, robust
outreg2 using results, excel
regress cough i.cookfuel i.smoke i.insurance i.education i.urban i.wealthindex i.state,robust
outreg2 using results, excel append


* Relationship between birthweight and air pollution
regress birthweight i.cookfuel, robust
outreg2 using results, excel append
regress birthweight i.cookfuel i.smoke i.insurance i.education i.urban i.wealthindex i.state, robust
outreg2 using results, excel append


* Relationship between height
regress heightforage i.cookfuel, robust
outreg2 using results, excel append
regress heightforage i.cookfuel i.smoke i.insurance i.education i.urban i.wealthindex i.state, robust
outreg2 using results, excel append
