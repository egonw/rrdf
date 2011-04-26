
# About

java/ -> Helper classes for the R rdf package.
rdf/ -> R package for dealing with RDF, using Jena.

# Copyright / License

Copyright (C) 2011  Egon Willighagen

Licensed AGPL v3. See the LICENSE file.

# Install from R

> install.packages(pkgs=c("rrdflibs", "rrdf"))

# Compile from source

$ cd java
$ groovy build.groovy
$ cd ..
$ R CMD check rrdflibs
$ R CMD build rrdflibs
$ R CMD check rrdf
$ R CMD build rrdf


