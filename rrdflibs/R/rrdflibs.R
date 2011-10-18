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

	jenaJars = c(
		"arq-2.8.7.jar", "icu4j-3.4.4.jar", "iri-0.8.jar",
		"jena-2.6.4.jar", "log4j-1.2.13.jar", "lucene-core-2.3.1.jar",
		"slf4j-api-1.5.8.jar", "slf4j-log4j12-1.5.8.jar",
		"wstx-asl-3.2.9.jar", "xercesImpl-2.7.1.jar",
		"commons-codec-1.4.jar", "commons-logging-1.1.1.jar",
        "httpclient-4.1.2.jar", "httpclient-cache-4.1.2.jar",
        "httpcore-4.1.2.jar", "httpmime-4.1.2.jar"
		
	)
	.jpackage(pkg, jars=jenaJars)
}
