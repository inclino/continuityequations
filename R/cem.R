"ce.model" <- function(x, 
                var.p = 1,
                var.type = "const",
                var.season = NULL,
                var.exogen = NULL,
                var.lag.max = NULL,
                var.ic = NULL,
                ...) {
  
  x <- as.matrix(x)
  
  # Sanity checks
  if(any(is.na(x))) {
    stop("\nNAs in data. Please remove the NAs and run again.\n")
  }
   
   
  ##  Models
  # SEM
  model.sem <- NULL
   
  # VAR
  x.ts <- as.ts(x)
  model.var <- VAR(x.ts, p = var.p, type = var.type, season = var.season, exogen = var.exogen, lag.max = var.lag.max, ic = var.ic)
  
  # RVAR
  model.rvar <- NULL
     
  # BVAR
  model.bvar <- NULL  
     
  # GARCH
  model.garch <- NULL  
     
  result <- list(SEM = model.sem, VAR = model.var, RVAR = model.rvar, BVAR = model.bvar, GARCH = model.garch)
  class(result) <- "cem"
  return(result)
}
