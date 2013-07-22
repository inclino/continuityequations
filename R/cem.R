"ce.model" <- function(x, type = c("SEM", "VAR", "RVAR", "BVAR", "GARCH"), ...) {
  
  result <- NULL
  
  if(type == SEM) {
  } else if(type == VAR) {
  } else if(type == RVAR) {
  } else if(type == BVAR) {
  } else if(type == GARCH) {
  } else {
    print("ERROR: No built-in model was selected. Please provide a model to continue...")
    
  }
  
  class(result) <- "cem"
  return(result)
}
