corr <- function(directory, threshold = 0) {
        directory<-list.files("specdata", full.names="true") #creates a list of files
        complete.cases
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        for i in ##list of files with complete cases>threshold
        cor(read.csv(directory[1])[3],read.csv(directory[1])[2])
}
?cor
cor(read.csv(directory[1])[3],read.csv(directory[1])[2],use="complete.obs")

one<-data.frame(read.csv(directory[1]))
one[complete.cases(one),]

cor()
##subset taking only files with a minimum number of complete cases then create correlation

ccases<-complete("specdata")

ccases[1]

cone<-data.frame(ccases[1])
cone>200

