
# About

Package to bring RDF and SPARQL functionality to R, using the Jena libraries.

    java/ -> Helper classes for the R rdf package.
    rdf/ -> R package for dealing with RDF, using Jena.
    rrdflibs/ -> Jena libraries

# User mailing list

    https://groups.google.com/forum/#!forum/rrdf-user

# Copyright / License

## rrdflibs package

Copyright (C) 2011-2014  Egon Willighagen and contributors

Apache License 2.0 for for the rrdflibs package files.

Copyright for Jena is described in the LICENSE and java/NOTICE
files. Please also visit https://jena.apache.org/.

## rrdf package

Copyright (C) 2011-2014  Egon Willighagen and contributors

License AGPL v3 for the rrdf package.

## Authors / Contributors

Authors:

Egon Willighagen

Contributions from:

Carl Boettiger,
Ryan Kohl

(See: https://github.com/egonw/rrdf/graphs/contributors)

# Install from R

Previously, the packages were available from CRAN, but this is no longer the case.

If you have the devtools package installed, you can do:

    > install.packages("rJava") # if not present already
    > install.packages("devtools") # if not present already
    > library(devtools)
    > install_github("rrdf", "egonw", subdir="rrdflibs")
    > install_github("rrdf", "egonw", subdir="rrdf")

# Compile from source

    $ cd rrdf/java
    $ groovy build.groovy
    $ cd ../..
    $ R CMD build rrdflibs
    $ R CMD check --as-cran rrdflibs_1.3.2.tar.gz
    $ R CMD build rrdf
    $ tar xvf rrdf_2.0.4.tar.gz rrdf/inst/doc/tutorial.pdf
    $ R CMD check --as-cran rrdf_2.0.4.tar.gz
