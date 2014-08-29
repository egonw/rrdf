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

save.rdf <- function(store, filename, format="RDF/XML") {
	formats = c("RDF/XML", "RDF/XML-ABBREV", "N3", "TURTLE", "N-TRIPLE")
	if (!(format %in% formats))
		stop("Formats must be one in: ", paste(formats, collapse=", "))
	if (format == "RDF/XML") format <- "RDF/XML-ABBREV";
	.jcall(
			"com/github/egonw/rrdf/RJenaHelper",
			"V",
			"saveRdf", store, filename, format
	)
        filename
}
