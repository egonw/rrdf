\name{fromString.rdf}
\alias{fromString.rdf}
\title{
Load RDF content from a string
}
\description{
Loads triples from a string with RDF serialization.
}
\usage{
fromString.rdf(rdfContent, format = "RDF/XML", appendTo=NULL)
}
\arguments{
  \item{rdfContent}{
RDF serialization content.
}
  \item{format}{
Format of the RDF content, e.g. RDF/XML.
}
  \item{appendTo}{
Optional Java Model object to which read statements are added.
}
}
\value{
A Java Model object containing the triples loaded from the RDF string.
}
\author{
Egon Willighagen
}
\keyword{ RDF }
\keyword{ triple }
