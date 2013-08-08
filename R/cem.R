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
                       var.exogen = NULL, # Must be added to VAR function call when fixed in vars package
                       var.lag.max = NULL,
                       var.ic = NULL,
                       rvar.method = "ser",
                       rvar.thresh = 2.0,
                       rvar.resmat = NULL,
                       bvar.p = NULL,
                       bvar.z = NULL,
                       bvar.l0 = 0.1,
                       bvar.l1 = 0.1,
                       bvar.l3 = 0.1,
                       bvar.l4 = 0.5,
                       bvar.l5 = 0.5,
                       bvar.m5 = 0,
                       bvar.m6 = 0,
                       bvar.qm = 4,
                       bvar.prior = 0,
                       bvar.posterior.fit = FALSE,
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
  model.sem <- systemfit(sem.formulas, method = sem.method, inst = sem.inst, data = sem.data, restrict.matrix = sem.restrict.matrix, restrict.rhs = sem.restrict.rhs, restrict.regMat = sem.restrict.regMat, pooled = sem.pooled)
   
  # VAR
  require("vars")
  model.var <- VAR(x.ts, p = var.p, type = var.type, season = var.season, lag.max = var.lag.max, ic = var.ic)
  
  # RVAR
  if(class(model.var) == "varest") {
    model.rvar <- restrict(model.var, method = rvar.method, thresh = rvar.thresh, resmat = rvar.resmat)
  } else {
    model.rvar <- NULL
    warning("Base VAR model was not available. RVAR model estimation set to NULL.")
  }
     
  # BVAR
  warning("BVAR model not yet fully implemented.")
  require("MSBVAR")
  if(is.null(bvar.p)) {
    if(is.null(var.lag.max)) {
      bvar.p = 30
    } else {
      bvar.p = var.lag.max
    }
  }
  model.bvar <- szbvar(x.ts, p = bvar.p, z = bvar.z, lambda0 = bvar.l0, lambda1 = bvar.l1, lambda3 = bvar.l3, lambda4 = bvar.l4, lambda5 = bvar.l5, mu5 = bvar.m5, mu6 = bvar.m6, nu = ncol(x) + 1, qm = bvar.qm, prior = bvar.prior, posterior.fit = bvar.posterior.fit)
     
  # GARCH
  model.garch <- NULL
  warning("GARCH model not yet implemented.")
     
  result <- list(SEM = model.sem, VAR = model.var, RVAR = model.rvar, BVAR = model.bvar, GARCH = model.garch, call = match.call())
  class(result) <- "cem"
  return(result)
}
