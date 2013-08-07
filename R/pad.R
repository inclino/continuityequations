"pad" <- function(x, with = NA, start = NULL, end = NULL, ...) {
  
  if(is.null(start)) {
    start = as.Date(head(sort(x[,1]), 1))
  } else {
    start = as.Date(start)
  }
  
  if(is.null(end)) {
    end = as.Date(tail(sort(x[,1]), 1))
  } else {
    end = as.Date(end)
  }
  
  data.empty <- data.frame( Date=seq.Date( from=start, to=end, 1) ), by="1 day") )
  data.merged <- merge( data.empty, x, by = c("Date"), all.x=TRUE, all.y=FALSE )
  data.merged[ is.na(data.merged) ] <- with
    
  result <- data.merged
  
  return(result)
}
