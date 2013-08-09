"summary.cem" <- function(cem, type = c("simple", "fancy"), ...) {
  
  if(class(cem) != "cem") {
    stop("Provided models were not in the expected format. Please use models of \'cem\' class.")
  }
  
  if(missing(type)) type <- "simple"
  
  if(type == "simple") {
    for (model in cem) {
      summary(model)
    }
  } else if(type == "fancy") { # Simple is not really helpful
    stop("Function not implemented yet.")
  } else {
    stop("Type not supported. Choose \"simple\" or \"fancy\".")
  }
}
