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

combine.rdf <- function(model1, model2) {
    if (attr(model2, "jclass") != "Lcom/hp/hpl/jena/rdf/model/Model") {
        model2 <- .jcast(model2, "com/hp/hpl/jena/rdf/model/Model")
    }

    .jcall(
        model1, "Lcom/hp/hpl/jena/rdf/model/Model;", 
        "add", model2
    )
}
