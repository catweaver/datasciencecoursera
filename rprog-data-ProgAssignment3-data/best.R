best <- function(state, outcome) {
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        ## Check that state and outcome are valid
        if (!state %in% unique(data[, 7])) {
                stop("invalid state")
        }
        if (!outcome %in% list("heart attack","heart failure","pneumonia")) {
                stop("invalid outcome")
        }

        data[,11]<-as.numeric(data[,11]) ##heart attack
        data[,17]<-as.numeric(data[,17]) ##heartfailure
        data[,23]<-as.numeric(data[,23]) ##pneumonia
        ## Return hospital name in that state with lowest 30-day death
        ## rate
        
        if (outcome=="heart attack"){filtered<-data[, c(2,7,11)]}
        if (outcome=="heart failure"){filtered<-data[, c(2,7,17)]}
        if (outcome=="pneumonia"){filtered<-data[, c(2,7,23)]}
        df<-subset(filtered, State==state)
        # sort by outcome then hospital, return first row's hospital
        ## Return hospital name in that state with lowest 30-day death rate
        return((df[ order(df[,3], df[,1]), ])[1, 1])
        
}