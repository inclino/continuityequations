"ce.model" <- function(x,
                       lag.max = 30,
                       t.thresh = 2.0,
                       ...) {
  
  # Sanity checks
  if(any(is.na(x))) {
    stop("\nNAs in data. Please remove the NAs and run again.\n")
  }
  
  # Create time series
  require("zoo")
  x.ts <- as.ts(x)
  x.zoo <- as.zoo(x)
     
  ##  Models
  # SEM
  require("systemfit")
  sem.formulas <- as.list(NULL)
  for (col in seq(ncol(x))) {
    sem.formula = paste("x$",dimnames(x)[[2]][col], " ~ ")
    for (col.minor in seq(ncol(x))) {
      if(col.minor != col){
        sem.formula <- paste(sem.formula, "+ x$", dimnames(x)[[2]][col.minor])
      }
    }
    sem.formulas = c(sem.formulas, as.formula(sem.formula))
  }
  model.sem <- systemfit(sem.formulas, method = "OLS")
   
  # VAR
  require("vars")
  model.var <- VAR(x.ts, type = "none", lag.max = lag.max)
  
  # RVAR
  if(class(model.var) == "varest") {
    model.rvar <- restrict(model.var, thresh = t.thresh)
  } else {
    model.rvar <- NULL
    warning("Base VAR model was not available. RVAR model estimation set to NULL.")
  }
     
  # BVAR
  model.bvar <- NULL
  warning("BVAR model not yet implemented.")
     
  # GARCH
  model.garch <- NULL
  warning("GARCH model not yet implemented.")
     
  result <- list(SEM = model.sem, VAR = model.var, RVAR = model.rvar, BVAR = model.bvar, GARCH = model.garch, call = match.call())
  class(result) <- "cem"
  return(result)
}
