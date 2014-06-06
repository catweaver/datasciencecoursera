rankhospital<- function(state, outcome, num) {
        data<- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        if (!state %in% unique(data[, 7])) {
                stop("invalid state")
        }
        if (!outcome %in% list("heart attack","heart failure","pneumonia")) {
                stop("invalid outcome")
        }
        data[, 11] <- as.numeric(data[,11]) ##heartattack
        data[, 17] <- as.numeric(data[,17]) ##heartfailure
        data[, 23] <- as.numeric(data[,23]) ##pneumonia
        
        if (outcome=="heart attack") {filtered<-data[,c(2,7,11)]}
        if (outcome=="heart failure") {filtered<-data[,c(2,7,17)]}
        if (outcome=="pneumonia") {filtered<-data[,c(2,7,23)]}
        
        statef<-filtered[which(data$State==state),]
        orderf<-statef[order(statef[,3],statef[,1]),]
        endorder<-na.omit(orderf)
        worstcase<-tail(endorder,n=1L)
        
        if (num=="best") {
                orderf[1,1]
        }
        else if (num=="worst"){
                worstcase[1,1]}
        else {orderf[num,1]}
}
