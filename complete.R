complete <- function(directory, id = 1:332) {
        
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        poldata<-data.frame() #creates an empty data frame
        for (i in id) {
                #loops through the files rbinding them together
                nobs<-sum(complete.cases(read.csv(directory[i])))
                id<-unique(read.csv(directory[i])[4])
                poldata<-rbind(poldata,cbind(id,nobs))
        }  
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
        poldata
}

