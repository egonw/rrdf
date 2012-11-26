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

new.rdf <- function(ontology=TRUE) {
    if (ontology) {
		model <- .jcall(
			"com/github/egonw/rrdf/RJenaHelper",
			"Lcom/hp/hpl/jena/rdf/model/Model;",
			"newOntoRdf"
		)
	} else {
		model <- .jcall(
			"com/github/egonw/rrdf/RJenaHelper",
			"Lcom/hp/hpl/jena/rdf/model/Model;",
			"newRdf"
		)
	}
	return(model)
}

load.rdf <- function(filename, format="RDF/XML", appendTo=NULL) {
	formats = c("RDF/XML", "TURTLE", "N-TRIPLES", "N3")
	if (!(format %in% formats))
		stop("Formats must be one in: ", formats)
	if (is.null(appendTo)) {
	    model <- .jcall(
    	    "com/github/egonw/rrdf/RJenaHelper",
       		"Lcom/hp/hpl/jena/rdf/model/Model;",
       		"loadRdf", filename, format
    	)
        return(model)
    } else {
	    model <- .jcall(
    	    "com/github/egonw/rrdf/RJenaHelper",
       		"Lcom/hp/hpl/jena/rdf/model/Model;",
       		"loadRdf", filename, format, appendTo
    	)
    }
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

sparql.rdf <- function(model, sparql, rowvarname=NULL) {
    stringMat <- .jcall(
        "com/github/egonw/rrdf/RJenaHelper",
        "Lcom/github/egonw/rrdf/StringMatrix;", "sparql", model, sparql
    )
    exception <- .jgetEx(clear = TRUE)
    if (!is.null(exception)) {
        stop(exception)
    }
    return(.stringMatrix.to.matrix(stringMat, rowvarname))
}

sparql.remote <- function(endpoint, sparql, rowvarname=NULL, user=NA, password=NA, jena=TRUE) {
    method = "sparqlRemoteNoJena";
    if (jena) method = "sparqlRemote";

    stringMat = NULL
    if (is.na(user)) {
     	tryCatch(
	    	stringMat <- .jcall(
			    "com/github/egonw/rrdf/RJenaHelper",
			    "Lcom/github/egonw/rrdf/StringMatrix;", method, endpoint, sparql
		    ),
	        Exception = function(e) {
	            warning(e)
	        }
	    )
	} else {
     	tryCatch(
		    stringMat <- .jcall(
			    "com/github/egonw/rrdf/RJenaHelper",
    			"Lcom/github/egonw/rrdf/StringMatrix;", method, endpoint, sparql,
		    	user, password
		    ),
	        Exception = function(e) {
	            warning(e)
	        }
    	)
    }
	if (!is.null(stringMat)) {
	    return(.stringMatrix.to.matrix(stringMat, rowvarname))
	} else {
		return(matrix(,0,0))
	}
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
}

add.data.triple <- function(store,
		subject="http://example.org/Subject",
		predicate="http://example.org/Predicate",
		data="Value",
		type=NULL) {
	if (is.null(type)) {
		.jcall(
			"com/github/egonw/rrdf/RJenaHelper",
			"V",
			"addDataProperty", store,
			subject, predicate, data
		)
	} else {
		.jcall(
			"com/github/egonw/rrdf/RJenaHelper",
			"V",
			"addDataProperty", store,
			subject, predicate, data,
			type
		)
	}
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

construct.remote <- function(endpoint, sparql) {
    newModel = NULL
	tryCatch(
	    newModel <- .jcall(
			"com/github/egonw/rrdf/RJenaHelper",
			"Lcom/hp/hpl/jena/rdf/model/Model;",
			"constructRemote", endpoint, sparql
	    ),
	    Exception = function(e) {
	        warning(e)
	    }
	)
	if (!is.null(newModel)) {
        return(newModel)
	} else {
		return(new.rdf())
	}
}

add.prefix <- function(store=NULL, prefix=NULL, namespace=NULL) {
    if (is.null(store)) stop("A store must be given.")
    if (is.null(prefix)) stop("A prefix must be given.")
    if (is.null(namespace)) stop("A namespace must be given.")

	.jcall(
		"com/github/egonw/rrdf/RJenaHelper",
		"V",
		"addPrefix", store, prefix, namespace
	)
	exception <- .jgetEx(clear = TRUE)
	if (!is.null(exception)) {
		stop(exception)
	}
}

.stringMatrix.to.matrix <- function(stringMatrix, rowvarname=NULL) {
    nrows <- .jcall(stringMatrix, "I", "getRowCount")
    ncols <- .jcall(stringMatrix, "I", "getColumnCount")
    if (ncols == 0 || nrows == 0) {
      matrix = matrix(,0,0)
    } else {
      matrix = matrix(,nrows,ncols)
      colNames = c()
      rowNames = c()
      for (col in 1:ncols) {
        colName = .jcall(stringMatrix, "S", "getColumnName", col)
        colNames = c(colNames, colName)
        if (ncols == 1 || # refuse to create row names if there is only one row 
            is.null(rowvarname) ||
            rowvarname != colName) {
          for (row in 1:nrows) {
            value = .jcall(stringMatrix, "S", "get", row, col)
            matrix[row,col] = .rdf.to.native(value)
          }
        } else {
          # ok, we're gonna use this column as row names
          for (row in 1:nrows) {
            rowName = .jcall(stringMatrix, "S", "get", row, col)
   	        c = strsplit(rowName, "\\^\\^")[[1]]
		    if (length(c) == 2) {
		      rowName = c[1]
		    }
            rowNames = c(rowNames, rowName)
          }
        }
      }
      colnames(matrix) <- colNames
      if (length(rowNames) > 0 ) {
        rownames(matrix) <- rowNames
        if (length(colNames) == 2) {
          # ok, need to make I do not end up with a vector
          matrix = as.matrix(matrix[,-which(colNames %in% c(rowvarname))], ncol=1)
          # and restore the column name (there must be a better way...)
          colnames(matrix) <- colNames[-which(colNames %in% c(rowvarname))]
        } else {
          matrix = matrix[,-which(colNames %in% c(rowvarname))]
        }
      }
    }
    matrix
}

.rdf.to.native <- function(string) {
	result = string
	if (is.null(string)) {
		result = NA;
	} else if (is.na(string)) {
		# just return NA
	} else {
		c = strsplit(string, "\\^\\^")[[1]]
		if (length(c) == 2) {
			# possibly a RDF data type
			datatype = c[2]
			if (datatype == "http://www.w3.org/2001/XMLSchema#double") {
				result = as.numeric(c[1])
			} else if (datatype == "http://www.w3.org/2001/XMLSchema#float") {
				result = as.numeric(c[1])
			} else if (datatype == "http://www.w3.org/2001/XMLSchema#integer") {
				result = as.numeric(c[1])
			} else if (datatype == "http://www.w3.org/2001/XMLSchema#string") {
				result = c[1]
			}
		}
	}
	result
}
