# Copyright (C) 2011  Egon Willighagen <egon.willighagen@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details. 
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

new.rdf <- function() {
	model <- .jcall(
			"com/github/egonw/rrdf/RJenaHelper",
			"Lcom/hp/hpl/jena/rdf/model/Model;",
			"newRdf"
	)
	return(model)
}

load.rdf <- function(filename, format="RDF/XML") {
	formats = c("RDF/XML", "TURTLE", "N-TRIPLES", "N3")
	if (!(format %in% formats))
		stop("Formats must be one in: ", formats)
    model <- .jcall(
        "com/github/egonw/rrdf/RJenaHelper",
        "Lcom/hp/hpl/jena/rdf/model/Model;",
        "loadRdf", filename, format
    )
    return(model)
}

save.rdf <- function(store, filename, format="RDF/XML") {
	formats = c("RDF/XML", "RDF/XML-ABBREV", "N3")
	if (!(format %in% formats))
		stop("Formats must be one in: ", formats)
	if (format == "RDF/XML") format <- "RDF/XML-ABBREV";
	.jcall(
			"com/github/egonw/rrdf/RJenaHelper",
			"V",
			"saveRdf", store, filename, format
	)
	return(store)
}

combine.rdf <- function(model1, model2) {
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

sparql.remote <- function(endpoint, sparql) {
	stringMat <- .jcall(
			"com/github/egonw/rrdf/RJenaHelper",
			"Lcom/github/egonw/rrdf/StringMatrix;", "sparqlRemote", endpoint, sparql
	)
	exception <- .jgetEx(clear = TRUE)
	if (!is.null(exception)) {
		stop(exception)
	}
	return(.stringMatrix.to.matrix(stringMat))
}

add.triple <- function(store,
	subject="http://example.org/Subject",
	predicate="http://example.org/Predicate",
	object="http://example.org/Object") {
	.jcall(
		"com/github/egonw/rrdf/RJenaHelper",
		"V",
		"addObjectProperty", store,
		subject, predicate, object
	)
	store
}

add.data.triple <- function(store,
		subject="http://example.org/Subject",
		predicate="http://example.org/Predicate",
		data="Value") {
	.jcall(
		"com/github/egonw/rrdf/RJenaHelper",
		"V",
		"addDataProperty", store,
		subject, predicate, data
	)
	store
}

construct.rdf <- function(model, sparql) {
	newModel <- .jcall(
		"com/github/egonw/rrdf/RJenaHelper",
		"Lcom/hp/hpl/jena/rdf/model/Model;",
		"construct", model, sparql
	)
	exception <- .jgetEx(clear = TRUE)
	if (!is.null(exception)) {
		stop(exception)
	}
	return(newModel)
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
