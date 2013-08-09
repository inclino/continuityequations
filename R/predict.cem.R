"predict.cem" <- function(cem, n = 1, ci = 0.95,
                          sem.newdata = NULL,                          
                          ...) {
  if(class(cem) != "cem") {
    stop("\nProvided models were not in the expected format. Please use models of \'cem\' class.\n")
  }
  
  ##  Models
  # SEM
  if(class(cem$SEM) == "systemfit") {
    require("systemfit")
    warning("SEM model prediction not yet fully implemented.")
    pred.sem <- predict(cem$SEM, newdata = sem.newdata)
  } else {
    warning("SEM model missing. No predictions were calculated for this model.")
    pred.sem <- NULL
  }
  
  # VAR
  if(class(cem$VAR) == "varest") {
    require("vars")
    warning("VAR model prediction not yet fully implemented.")
    pred.var <- predict(cem$VAR, n.ahead = n, ci = ci)
  } else {
    warning("VAR model missing. No predictions were calculated for this model.")
    pred.var <- NULL
  }
  
  # RVAR
  if(class(cem$RVAR) == "varest") {
    warning("RVAR model prediction not yet fully implemented.")
    pred.rvar <- predict(cem$RVAR, n.ahead = n, ci = ci)
  } else {
    warning("RVAR model missing. No predictions were calculated for this model.")
    pred.rvar <- NULL
  }
  
  # BVAR
  if(class(cem$BVAR) == "BVAR") {
    #require("MSBVAR")
    warning("BVAR model prediction not yet fully implemented.")
    pred.bvar <- NULL
  } else {
    warning("BVAR model missing. No predictions were calculated for this model.")
    pred.bvar <- NULL
  }
  
  # GARCH
  if(class(cem$GARCH) == "GARCH") {
    warning("GARCH model prediction not yet fully implemented.")
    pred.garch <- NULL
  } else {
    warning("GARCH model missing. No predictions were calculated for this model.")
    pred.garch <- NULL
  }
  
  result <- list(SEM = pred.sem, VAR = pred.var, RVAR = pred.rvar, BVAR = pred.bvar, GARCH = pred.garch)
  
  class(result) <- "cep"
  return(result)
}
