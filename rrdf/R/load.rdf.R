load.rdf <- function(filename, format="RDF/XML") {
    model <- .jcall(
        "com/github/egonw/rrdf/RJenaHelper",
        "Lcom/hp/hpl/jena/rdf/model/Model;",
        "loadRdf"
    )
    return(model)
}

dump.rdf <- function(model) {
    output <- .jcall(
        "com/github/egonw/rrdf/RJenaHelper",
        "S", "dump", model
    )
    exception <- .jgetEx(clear = TRUE)
    if (!is.null(exception)) {
        stop(exception)
    }
    return(output)
}

merge.rdf <- function(model1, model2) {
    if (attr(model2, "jclass") != "Lcom/hp/hpl/jena/rdf/model/Model") {
        model2 <- .jcast(model2, "com/hp/hpl/jena/rdf/model/Model")
    }

    .jcall(
        model1, "Lcom/hp/hpl/jena/rdf/model/Model;", 
        "add", model2
    )

}
