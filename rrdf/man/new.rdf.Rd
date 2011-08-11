\name{new.rdf}
\alias{new.rdf}
\title{
Create a new RDF triple store object
}
\description{
Create a new RDF triple store object.
}
\usage{
new.rdf(ontology=TRUE)
}
\arguments{
  \item{ontology}{
Indicates if the model should be an ontological model (the default).
}
}
\value{
A Java Model object containing the triples loaded from the file.
}
\author{
Egon Willighagen
}
\examples{
store = new.rdf()
store = new.rdf(ontology=FALSE)
}
\keyword{ RDF }
\keyword{ triple }
