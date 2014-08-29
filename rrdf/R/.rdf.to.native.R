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
