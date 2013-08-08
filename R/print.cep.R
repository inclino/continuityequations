"print.cep" <- function(cep, type = c("simple", "fancy"), ...) {
  
  if(class(cep) != "cep") {
    stop("Provided models were not in the expected format. Please use models of \'cep\' class.")
  }
  
  if(missing(type)) type <- "simple"
  
  if(type == "simple") {
    ##  Models
    # SEM
    if(class(cep$SEM) == "data.frame") {
      require("systemfit")
      print(cep$SEM)
    } else {
      warning("SEM model missing.")
    }
    
    # VAR
    if(class(cep$VAR) == "varprd") {
      require("vars")
      print(cep$VAR)
    } else {
      warning("VAR model missing.")
    }
    
    # RVAR
    if(class(cep$RVAR) == "varprd") {
      require("vars")
      print(cep$RVAR)
    } else {
      warning("RVAR model missing.")
    }
    
    # BVAR
    if(class(cep$BVAR) == "BVAR") { # Class unknown yet
      require("MSBVAR")
      print(cep$BVAR)
    } else {
      warning("BVAR model missing.")
    }
    
    # GARCH
    if(class(cep$GARCH) == "GARCH") { # Class unknown yet
      require("tseries")
      print(cep$GARCH)
    } else {
      warning("GARCH model missing.")
    }
  } else if(type == "fancy") { # Simple is not really helpful
    stop("Function not implemented yet.")
  } else {
    stop("Type not supported. Choose \"simple\" or \"fancy\".")
  }
}
