// ECON 280 | Part 3: Replicating the Main Result (Two Ways) //


/// assignment submitted by: Shubhro Bhattacharya


/// project title: Disrupting Education? Experimental Evidence on Technology-Aided Instruction in India

/// authors: karthik muralidharan, abhijeet singh & alejandro ganimian 


/// replication assignment: replicate the main table




	
			
// set-up *********************************************** //



//SET-UP: Basic Definitions

drop _all    
label drop _all 
clear           
clear mata      
clear matrix  
clear all 

/*SETTINGS*/
set more off   
set memory 300m  
set matsize 1000 
set maxvar 32767 
set seed 12345678



cd "/Users/shubhro/Desktop/UCSD FY 2024-25/econ280_shubhro_replication/assignment_3/"
use "ms_blel_jpal_wide.dta",clear



* We will log in
capture log close 

log using "mainresult_$S_DATE.txt", replace text

* We will add this line from time to time if the program takes time to compute or uses a lot of loops
noisily display as text "The date is " as result "--$S_DATE--" as text " and the time is " as result "--$S_TIME




************************************************************

global	establishglobals 	"1"
global	gentables			"0"
global	gengraphs			"1"
global	plotmathiccs		"0" 
*ajg: takes a long time to run
global	plothindiiccs		"0"
*ajg: takes a long time to run


/// table 2: intent-to-treat effects in a regression framework
		
			
	///	relabel vars
	
		lab var m_theta_mle1	"Baseline score"
		lab var h_theta_mle1	"Baseline score"
	
save  "r_final_data.xls" , replace	
		
		
	/// run regressions
		
		reg m_theta_mle2 treat m_theta_mle1, robust
		outreg2 using "tables/table2.xls", label less(1) replace noaster

		reg h_theta_mle2 treat h_theta_mle1, robust
		outreg2 using "tables/table2.xls", label less(1) append noaster
		
		xtreg m_theta_mle2 treat m_theta_mle1, robust  i(strata) fe
		outreg2 using "tables/table2.xls", label less(1) append noaster
		
		xtreg h_theta_mle2 treat h_theta_mle1, robust i(strata) fe
		outreg2 using "tables/table2.xls", label less(1) append noaster
		
		
		
		

		
		
		
		
		
		