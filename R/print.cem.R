"print.cem" <- function(cem, type = c("simple", "fancy"), ...) {
  
  if(class(cem) != "cem") {
    stop("Provided models were not in the expected format. Please use models of \'cem\' class.")
  }
  
  if(missing(type)) type <- "simple"
  
  if(type == "simple") {
    ##  Models
    # SEM
    if(class(cem$SEM) == "systemfit") {
      require("systemfit")
      print(cem$SEM)
    } else {
      warning("SEM model missing.")
    }
    
    # VAR
    if(class(cem$VAR) == "varest") {
      require("vars")
      print(cem$VAR)
    } else {
      warning("VAR model missing.")
    }
    
    # RVAR
    if(class(cem$RVAR) == "varest") {
      require("vars")
      print(cem$RVAR)
    } else {
      warning("RVAR model missing.")
    }
    
    # BVAR
    if(class(cem$BVAR) == "BVAR") {
      require("MSBVAR")
      print(cem$BVAR)
    } else {
      warning("BVAR model missing.")
    }
    
    # GARCH
    if(class(cem$GARCH) == "GARCH") {
      require("tseries")
      print(cem$GARCH)
    } else {
      warning("GARCH model missing.")
    }
  } else if(type == "fancy") { # Simple is not really helpful
    stop("Function not implemented yet.")
  } else {
    stop("Type not supported. Choose \"simple\" or \"fancy\".")
  }
}
