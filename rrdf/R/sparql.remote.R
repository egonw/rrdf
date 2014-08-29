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

sparql.remote <- function(endpoint, sparql, rowvarname=NULL, user=NA, password=NA, jena=FALSE) {
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
