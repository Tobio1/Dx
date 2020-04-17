#Dataloader is to load and organize diagnostic test data to make it ready for easy processing
# Load libraries --------
library(readxl)
library(DTComPair) #Library for diagnostic comparison
library(plotROC)
library(eulerr)
library(colorfulVennPlot)

# Import ------------------------------------------------------------------
#Import file manually using standard import function of Rstudio
r<- read_excel("~/Google Drive/13_Publications/190600_FujiLAM_HIVneg/DATA/200125_LAM_Merged_data_PP_MSD_MSDconc_Cohorts1_RITJATA_Compared2AZ_HIVall.xlsx", 
                                                                                         na = "NaN")
rd <- subset(r, r$AHIVneg==1)


# locate and standardize diagnostic data based on column headers --------------------------
upid<-rd$UPID...1
mrs<-rd$MRS_STRICT           #main reference standard
crs<-rd$CRS           #alternative reference standard
index<-rd$FujiRIT_FC  #index test for main analysis
comp1<-rd$AlereRIT_FC #comparator test for main analysis
comp2<-rd$HSMSDC_PredictionConcCorr_bin #Wrong, need to produce this YYY
sex<-rd$SEX 
age<-rd$AGE
cd4<-rd$CD4CNT
sp1xp<-rd$SP1_XP
sp2xp<-rd$SP2_XP
sp3xp<-rd$SP3_XP
spxpany<-rd$SP_XP_ANY
sp1ssm<-rd$SP1_FM_RES
sp1ssm[sp1ssm=='Positive'] <- 1
sp1ssm[sp1ssm=='Negative'] <- 0
sp1ssm<-strtoi(sp1ssm, base = 0L)

d = data.frame(upid, mrs, crs, index, comp1, 
               comp2, sex, age, sp1xp, cd4,sp1xp,sp2xp,sp3xp,spxpany,
               sp1ssm
               )
# Compare Diagnostic accuracy -----------------------------------------------------
tab<-tab.paired(d$mrs, d$index, d$comp1)
acc<-acc.paired(tab) 
pval<-sesp.mcnemar(tab) #mcnemar p-values

P.indextab <- tab.1test(d$mrs, d$index , ,'FujiLAM')
P.index <- acc.1test(P.indextab)
P.comptab <- tab.1test(d$mrs, d$comp1 , ,'AlereLAM')
P.comp<-acc.1test(P.comptab)
print(a2)

# ROC curve -----
# cont=d$comp2
# cont[is.na(cont)] <- 0
# calculate_roc(cont, d$MRS, ci = FALSE, alpha = 0.05)


# Eulerr ---- seems to give the wrong numbers, also comp2 needs right cut-off
dpos<- subset(d, d$mrs==1)
mat <- cbind(dpos$index, dpos$comp1,  dpos$sp1xp)
mat[is.na(mat)] <- 0
fit2 <- euler(mat)
plot(fit2 ,quantities = TRUE)

# Venn ------ Seems only 3 variables are possible thus useless
x=data.frame(dpos$index, dpos$comp1, dpos$sp1xp, dpos$comp2)
x[is.na(x)] <- 0
vennData<-createVennData(x, Cols = NULL, Splits = c(0.5, 0.5, 0.5, 0.5), Labels = NULL,
               type = c("count"), ToSkip = "000")
plotVenn3d(vennData$x, vennData$labels)

# Write results to .csv file ----------------------

write.table(mat, file = "x.csv", append = FALSE, quote = TRUE, sep = ";",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")
