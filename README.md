
# About

Package to bring RDF and SPARQL functionality to R, using the Jena libraries.

    java/ -> Helper classes for the R rdf package.
    rdf/ -> R package for dealing with RDF, using Jena.
    rrdflibs/ -> Jena libraries

Information about this package can be found in this preprint:

    Willighagen E. (2014) Accessing biological data in R with semantic web
    technologies. PeerJ PrePrints 2:e185v3

See https://dx.doi.org/10.7287/peerj.preprints.185v3

(Please cite this paper if you use this package.)

# User mailing list

    https://groups.google.com/forum/#!forum/rrdf-user

# Copyright / License

## rrdflibs package

Copyright (C) 2011-2015  Egon Willighagen and contributors

Apache License 2.0 for for the rrdflibs package files.

Copyright for Jena is described in the LICENSE and java/NOTICE
files. Please also visit https://jena.apache.org/.

## rrdf package

Copyright (C) 2011-2015  Egon Willighagen and contributors

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

Mind you, the below install_github() method will attempt to rebuild the vignette
and therefore at this moment require a LaTeX distribution with pdflatex and a few
packages installed. See also issue https://github.com/egonw/rrdf/issues/28 and
https://github.com/egonw/rrdf/issues/29.

    > install.packages("rJava") # if not present already
    > install.packages("devtools") # if not present already
    > library(devtools)
    > install_github("egonw/rrdf", subdir="rrdflibs")
    > install_github("egonw/rrdf", subdir="rrdf", build_vignettes = FALSE)

# Compile from source

    $ cd rrdf/java
    $ groovy build.groovy
    $ cd ../..
    $ R CMD build rrdflibs
    $ R CMD check --as-cran rrdflibs_1.4.0.tar.gz
    $ R CMD build rrdf
    $ tar xvf rrdf_2.0.4.tar.gz rrdf/inst/doc/tutorial.pdf
    $ R CMD check --as-cran rrdf_2.0.4.tar.gz

# Error Handling

In case of issues on Mac, follow the instructions below:

- check that the $JAVA_PATH variable is correctly set. If not:
 1. Run `touch ~/.bash_profile; open ~/.bash_profile` in a Terminal window.
 2. add the following lines to your .bash_profile and then save:
    export JAVA_HOME=$(/usr/libexec/java_home)
    export LD_LIBRARY_PATH=/Library/Java/JavaVirtualMachines/jdk1.8.0_31.jdk/Contents/Home/jre/lib/server 
    export PATH=$PATH:$JAVA_HOME/bin
 3. Run `source ~/.bash_profile` in a terminal window.

- check that that Java >=1.7 is installed in your system. If not, go to [https://java.com/it/download/](https://java.com/it/download/)
- check that R sees the latest Java version (`.jinit();.jcall("java/lang/System", "S", "getProperty", "java.runtime.version")`). If not [1,2]:
 1. Download and install Apple’s Java version 1.6 like you were asked to.
 2. Reconfigure your R installation by typing `sudo R CMD javareconf` in a Terminal window.
 3. Trigger a recompile by reinstalling rJava by typing `install.packages('rJava', type='source')`.
 4. Run `sudo ln -f -s $(/usr/libexec/java_home)/jre/lib/server/libjvm.dylib /usr/lib` in a Terminal window.
