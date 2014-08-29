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
