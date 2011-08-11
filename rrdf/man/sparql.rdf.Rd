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
sparql.rdf(model, sparql, rowvarname)
}
\arguments{
  \item{model}{
A Java Model object.
}
  \item{sparql}{
The SPARQL query.
}
  \item{rowvarname}{
Optional SPARQL variable name (without the ?) for which the values
will be used as row names of the result matrix.
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
sparql.rdf(store, paste(
  "SELECT ?subject ?predicate ?object {",
  "  ?subject ?predicate ?object",
  "} LIMIT 5"),
  rowvarname="subject"
)
}
\keyword{ RDF }
\keyword{ triple }
