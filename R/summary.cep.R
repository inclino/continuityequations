"summary.cep" <- function(cep, type = c("simple", "fancy"), ...) {
  
  if(class(cep) != "cep") {
    stop("Provided models were not in the expected format. Please use models of \'cep\' class.")
  }
  
  if(missing(type)) type <- "simple"
  
  if(type == "simple") {
    for (prediction in pred.simple) {
      print(summary(prediction))
    }
  } else if(type == "fancy") { # Simple is not really helpful
    stop("Function not implemented yet.")
  } else {
    stop("Type not supported. Choose \"simple\" or \"fancy\".")
  }
}
