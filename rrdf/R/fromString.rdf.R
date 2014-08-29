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

fromString.rdf <- function(rdfContent, format="RDF/XML", appendTo=NULL) {
	formats = c("RDF/XML", "TURTLE", "N-TRIPLES", "N3")
	if (!(format %in% formats))
		stop("Formats must be one in: ", paste(formats, collapse=", "))
	if (is.null(appendTo)) {
	    model <- .jcall(
    	    "com/github/egonw/rrdf/RJenaHelper",
       		"Lcom/hp/hpl/jena/rdf/model/Model;",
       		"fromString", rdfContent, format
    	)
        return(model)
    } else {
	    model <- .jcall(
    	    "com/github/egonw/rrdf/RJenaHelper",
       		"Lcom/hp/hpl/jena/rdf/model/Model;",
       		"fromString", rdfContent, format, appendTo
    	)
    }
}
