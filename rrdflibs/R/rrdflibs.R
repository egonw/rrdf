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

.onLoad <- function(lib, pkg) {
    dlp<-Sys.getenv("DYLD_LIBRARY_PATH")
    if (dlp!="") { # for Mac OS X we need to remove X11 from lib-path
        Sys.setenv("DYLD_LIBRARY_PATH"=sub("/usr/X11R6/lib","",dlp))
    }

	jenaJars = c(
		"commons-codec-1.6.jar", "httpclient-4.2.3.jar", "httpcore-4.2.2.jar",
		"jcl-over-slf4j-1.6.4.jar", "jena-arq-2.10.1.jar", "jena-core-2.10.1.jar",
		"jena-iri-0.9.6.jar", "jena-tdb-0.10.1.jar",
		"log4j-1.2.16.jar", "slf4j-api-1.6.4.jar",
		"slf4j-log4j12-1.6.4.jar", "xercesImpl-2.11.0.jar",
		"xml-apis-1.4.01.jar"
	)
	.jpackage(pkg, jars=jenaJars)
}
