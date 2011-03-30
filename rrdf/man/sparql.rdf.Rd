\name{sparql.rdf}
\alias{sparql.rdf}
\title{
Run a SPARQL query on a Java Model.
}
\description{
Runs a query on the triples in a Java Model using the SPARQL
language.
}
\usage{
sparql.rdf(model, sparql)
}
\arguments{
  \item{model}{
A Java Model object.
}
  \item{sparql}{
The SPARQL query.
}
}
\value{
A matrix object containing the results of the query.
}
\author{
Egon Willighagen
}
\examples{
store = new.rdf()
sparql.rdf(store, paste(
  "SELECT ?subject ?predicate ?object {",
  "  ?subject ?predicate ?object",
  "} LIMIT 5"
))
}
\keyword{ RDF }
\keyword{ triple }
