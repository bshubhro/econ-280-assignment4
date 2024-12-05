// ECON 280 | Part 4: Paper Extension //


/// Assignment submitted by: Shubhro Bhattacharya


/// Project title: Disrupting Education? Experimental Evidence on Technology-Aided Instruction in India

/// Authors: karthik muralidharan, abhijeet singh & alejandro ganimian 


/// Replication assignment: Provide an extension for the paper




			
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



cd "/Users/shubhro/Desktop/econ-280-assignment4/"
use "data/ms_blel_jpal_wide.dta",clear



* We will log in
capture log close 

log using "extension_$S_DATE.txt", replace text

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




/// Part-(A) Let us re-run the original result amd save the table 

/// Reference: table 2: intent-to-treat effects in a regression framework
		
			
	///	relabel vars
	
		lab var m_theta_mle1	"Baseline score"
		lab var h_theta_mle1	"Baseline score"
	
				
	/// run regressions
		
		reg m_theta_mle2 treat m_theta_mle1, robust
		outreg2 using "tables/table2.xls", label less(1) replace noaster

		reg h_theta_mle2 treat h_theta_mle1, robust
		outreg2 using "tables/table2.xls", label less(1) append noaster
		
		xtreg m_theta_mle2 treat m_theta_mle1, robust  i(strata) fe
		outreg2 using "tables/table2.xls", label less(1) append noaster
		
		xtreg h_theta_mle2 treat h_theta_mle1, robust i(strata) fe
		outreg2 using "tables/table2.xls", label less(1) append noaster
		
		
		

		

/// Part-(B) Extension

		
/// Check for the consistency of the stata "robust" command and use bootstrapped standard errors		
	
				
	/// run regressions
		
		reg m_theta_mle2 treat m_theta_mle1, robust
		bootstrap _b, reps(1000): reg m_theta_mle2 treat m_theta_mle1
        outreg2 using "tables/bstable.xls", label less(1) replace noaster

		reg h_theta_mle2 treat h_theta_mle1, robust
		bootstrap _b, reps(1000): reg h_theta_mle2 treat h_theta_mle1
		outreg2 using "tables/bstable.xls", label less(1) append noaster
		
		xtreg m_theta_mle2 treat m_theta_mle1, robust  i(strata) fe
		bootstrap _b, reps(1000): xtreg m_theta_mle2 treat m_theta_mle1, fe i(strata)
		outreg2 using "tables/bstable.xls", label less(1) append noaster
		
		xtreg h_theta_mle2 treat h_theta_mle1, robust i(strata) fe
		bootstrap, reps(1000) seed(1234): xtreg h_theta_mle2 treat h_theta_mle1, fe i(strata)
		outreg2 using "tables/bstable.xls", label less(1) append noaster
		
		

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		