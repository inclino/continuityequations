"ce.model" <- function(x,
                sem.method = "OLS",
                sem.inst = NULL,
                sem.data = NULL,
                sem.restrict.matrix = NULL,
                sem.restrict.rhs = NULL,
                sem.restrict.regMat = NULL,
                sem.pooled = FALSE,
                var.p = 1,
                var.type = "const",
                var.season = NULL,
                var.exogen = NULL,
                var.lag.max = NULL,
                var.ic = NULL,
                ...) {
  
  # Sanity checks
  if(any(is.na(x))) {
    stop("\nNAs in data. Please remove the NAs and run again.\n")
  }
   
   
  ##  Models
  # SEM
  require("systemfit")
  sem.formulas <- as.list(NULL)
  for (col in seq(ncol(x))) {
    sem.formula = paste("x$",dimnames(x)[[2]][col], " ~ ", paste(paste("x$", dimnames(x)[[2]]), collapse= "+"))
    sem.formulas = c(sem.formulas, as.formula(sem.formula))
  }
  model.sem <- systemfit(sem.formulas, method = sem.method, inst = sem.inst, data = sem.data, restrict.matrix = sem.restrict.matrix, restrict.rhs = sem.restrict.rhs, restrict.regMat = sem.restrict.regMat, pooled = sem.pooled)
   
  # VAR
  require("vars")
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
