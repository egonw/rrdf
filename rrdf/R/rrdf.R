.packageName <- "rrdf"

require(rJava, quietly=TRUE)

.First.lib <- function(lib, pkg) {
    dlp<-Sys.getenv("DYLD_LIBRARY_PATH")
    if (dlp!="") { # for Mac OS X we need to remove X11 from lib-path
        Sys.setenv("DYLD_LIBRARY_PATH"=sub("/usr/X11R6/lib","",dlp))
    }

    .jinit(classpath=c(
        paste(lib,pkg,"cont","rrdf.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"cont","arq-2.8.7.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"cont","icu4j-3.4.4.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"cont","iri-0.8.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"cont","jena-2.6.4.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"cont","log4j-1.2.13.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"cont","lucene-core-2.3.1.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"cont","slf4j-api-1.5.8.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"cont","slf4j-log4j12-1.5.8.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"cont","stax-api-1.0.1.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"cont","wstx-asl-3.2.9.jar",sep=.Platform$file.sep),
        paste(lib,pkg,"cont","xercesImpl-2.7.1.jar",sep=.Platform$file.sep)
    ))
}
