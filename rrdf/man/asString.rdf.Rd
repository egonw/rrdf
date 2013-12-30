\name{asString.rdf}
\alias{asString.rdf}
\title{
Converts a RDF store to a string
}
\description{
Converts a RDF store to a string in the given serialization format.
}
\usage{
asString.rdf(model, format = "N3")
}
\arguments{
  \item{model}{
RDF store to serialize.
}
  \item{format}{
Format of the RDF serialization, e.g. N3 or RDF/XML.
}
}
\value{
A String serialization of the RDF store.
}
\author{
Egon Willighagen
}
\keyword{ RDF }
\keyword{ triple }
