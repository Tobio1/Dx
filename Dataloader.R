#Dataloader is to load and organize diagnostic test data to make it ready for easy processing


# Load libraries --------
library(readxl)
library(DTComPair) #Library for diagnostic comparison

# Import ------------------------------------------------------------------
#Import file manually using standard import function of Rstudio
r<- read_excel("~/Google Drive/13_Publications/190600_FujiLAM_HIVneg/DATA/200125_LAM_Merged_data_PP_MSD_MSDconc_Cohorts1_RITJATA_Compared2AZ_HIVall.xlsx", 
                                                                                         na = "NaN")
rd <- subset(r, r$AHIVneg==1)


# locate and standardize diagnostic data based on column headers --------------------------
upid<-rd$UPID...1
mrs<-rd$MRS           #main reference standard
crs<-rd$CRS           #alternative reference standard
index<-rd$FujiRIT_FC  #index test for main analysis
comp1<-rd$AlereRIT_FC #comparator test for main analysis
sex<-rd$SEX 
age<-rd$AGE
cd4<-rd$CD4CNT
sp1xp<-rd$SP1_XP
sp2xp<-rd$SP2_XP
sp3xp<-rd$SP3_XP
spxpany<-rd$SP_XP_ANY

d = data.frame(upid,mrs, crs, cd4, index, comp1, sex, age, sp1xp)


# Compare Diagnostic accuracy -----------------------------------------------------
tab<-tab.paired(d$mrs, d$index, d$comp1)
acc<-acc.paired(tab) 
pval<-sesp.mcnemar(tab) #mcnemar p-values

# Write results to .csv file ----------------------
write.table("data/results.csv", output_file)