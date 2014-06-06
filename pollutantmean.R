pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        
        directory<-list.files("specdata", full.names="true") #creates a list of files
        poldata<-data.frame() #creates an empty data frame
        for (i in id) {
                #loops through the files rbinding them together
                poldata<-rbind(poldata,read.csv(directory[i]))    
        } 
        polsubset<-poldata[,pollutant]
        #subsets the columns that match the pollution subset
        
        mean(polsubset,na.rm=TRUE)
}

