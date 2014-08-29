
# About

Package to bring RDF and SPARQL functionality to R, using the Jena libraries.

    java/ -> Helper classes for the R rdf package.
    rdf/ -> R package for dealing with RDF, using Jena.
    rrdflibs/ -> Jena libraries

Installable packages are available from the CRAN archive:

    http://cran.r-project.org/src/contrib/Archive/rrdf/

# Copyright / License

Copyright (C) 2011-2014  Egon Willighagen and contributors

Licensed AGPL v3 for the package. Jena is copyright and licensed differently.
See the LICENSE file for details, or at https://jena.apache.org/.

Contributions from:

Carl Boettiger
Ryan Kohl

(See: https://github.com/egonw/rrdf/graphs/contributors)

# Install from R

This is likely currently not working, as CRAN made it much harder to have Java-based packages.

    > install.packages(pkgs=c("rrdflibs", "rrdf"))

# Compile from source

    $ cd rrdf/java
    $ groovy build.groovy
    $ cd ../..
    $ R CMD check rrdflibs
    $ R CMD build rrdflibs
    $ R CMD check rrdf
    $ R CMD build rrdf
    $ tar xvf rrdf_2.0.3.tar.gz rrdf/inst/doc/tutorial.pdf
    $ R CMD check rrdf
    $ R CMD build rrdf

The second round of checking is needed to ensure to vignette inst/doc check succeeds then.


