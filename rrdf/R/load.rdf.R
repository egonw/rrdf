load.rdf <- function(filename, format="RDF/XML") {
    model <- .jcall(
        "com/github/egonw/rrdf/RJenaHelper",
        "Lcom/hp/hpl/jena/rdf/model/Model;",
        "loadRdf", filename, format
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

summarize.rdf <- function(model) {
    count <- .jcall(
        "com/github/egonw/rrdf/RJenaHelper",
        "I", "tripleCount", model
    )
    exception <- .jgetEx(clear = TRUE)
    if (!is.null(exception)) {
        stop(exception)
    }
    print(paste("Number of triples:", count))
}

sparql.rdf <- function(model, sparql) {
    stringMat <- .jcall(
        "com/github/egonw/rrdf/RJenaHelper",
        "Lcom/github/egonw/rrdf/StringMatrix;", "sparql", model, sparql
    )
    exception <- .jgetEx(clear = TRUE)
    if (!is.null(exception)) {
        stop(exception)
    }
    return(.stringMatrix.to.matrix(stringMat))
}

.stringMatrix.to.matrix <- function(stringMatrix) {
    nrows <- .jcall(stringMatrix, "I", "getRowCount")
    ncols <- .jcall(stringMatrix, "I", "getColumnCount")
    matrix = matrix(,nrows,ncols)
    colNames = c()
    for (col in 1:ncols) {
      colNames = c(colNames, .jcall(stringMatrix, "S", "getColumnName", col))
      for (row in 1:nrows) {
        value = .jcall(stringMatrix, "S", "get", row, col)
        matrix[row,col] = value
      }
    }
    colnames(matrix) <- colNames
    matrix
}
