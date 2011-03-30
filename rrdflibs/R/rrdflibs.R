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

.packageName <- "rrdflibs"

require(rJava, quietly=TRUE)

.First.lib <- function(lib, pkg) {
    dlp<-Sys.getenv("DYLD_LIBRARY_PATH")
    if (dlp!="") { # for Mac OS X we need to remove X11 from lib-path
        Sys.setenv("DYLD_LIBRARY_PATH"=sub("/usr/X11R6/lib","",dlp))
    }

    .jinit(classpath=c(
        paste(lib,pkg,"java","arq-2.8.7.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"java","icu4j-3.4.4.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"java","iri-0.8.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"java","jena-2.6.4.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"java","log4j-1.2.13.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"java","lucene-core-2.3.1.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"java","slf4j-api-1.5.8.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"java","slf4j-log4j12-1.5.8.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"java","stax-api-1.0.1.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"java","wstx-asl-3.2.9.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"java","xercesImpl-2.7.1.jar",sep=.Platform$file.sep)
    ))
}
