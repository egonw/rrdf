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

remove.data.triple <- function(store,
		subject="http://example.org/Subject",
		predicate="http://example.org/Predicate",
		data="Value", type=NULL) {
	if (is.null(type)) {
		.jcall(
			"com/github/egonw/rrdf/RJenaHelper",
			"V",
			"removeDataProperty", store,
			subject, predicate, data
		)
	} else {
		.jcall(
			"com/github/egonw/rrdf/RJenaHelper",
			"V",
			"removeDataProperty", store,
			subject, predicate, data,
			type
		)
	}
}
