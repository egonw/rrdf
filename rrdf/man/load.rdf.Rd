\name{load.rdf}
\alias{load.rdf}
\title{
Load RDF content
}
\description{
Loads triples from a RDF serialization.
}
\usage{
load.rdf(filename, format = "RDF/XML", appendTo=NULL)
}
\arguments{
  \item{filename}{
Name of the file to read the triples from.
}
  \item{format}{
Format of the RDF file, e.g. RDF/XML.
}
  \item{appendTo}{
Optional Java Model object to which read statements are added.
}
}
\value{
A Java Model object containing the triples loaded from the file.
}
\author{
Egon Willighagen
}
\examples{
\dontrun{model = load.rdf("someFile.xml", "RDF/XML")}
\dontrun{model = new.rdf(ontology=FALSE)}
\dontrun{load.rdf("someFile.xml", "RDF/XML", model)}
}
\keyword{ RDF }
\keyword{ triple }
