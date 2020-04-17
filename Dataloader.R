#Dataloader is to load and organize diagnostic test data to make it ready for easy processing


# Load libraries --------
library(DTComPair) #Library for diagnostic comparison

# Import ------------------------------------------------------------------
#Import file manually using standard import function of Rstudio
data<-X200125_LAM_Merged_data_PP_MSD_MSDconc_Cohorts1_RITJATA_Compared2AZ_HIVall


# locate and standardize diagnostic data based on column headers --------------------------
mrs<-data$MRS
crs<-data$CRS
cd4<-data$CD4CNT
index<-data$FujiRIT_FC
comp1<-data$AlereRIT_FC

d = data.frame(mrs, crs, cd4, index, comp1)


# Diagnostic accuracy -----------------------------------------------------
tab<-tab.paired(d$mrs, d$index, d$comp1)
acc<-acc.paired(tab)


# Write results to .csv file --------------------
write.table("data/results.csv", output_file)