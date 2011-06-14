\name{construct.rdf}
\alias{construct.rdf}
\title{
Run a SPARQL query on a Java Model and construct a new model with the results.
}
\description{
Runs a query on the triples in a Java Model using the SPARQL
language and construct a new model with the results.
}
\usage{
construct.rdf(model, sparql)
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
A Jena model object containing the results of the query.
}
\author{
Ryan Kohl
}
\examples{
store = new.rdf()
add.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  object="http://example.org/Object")
results = construct.rdf(store, paste(
  "CONSTRUCT { ?instance a <http://example.org/AnotherObject> }",
  "WHERE { ?instance a <http://example.org/Object> }"
))
}
\keyword{ RDF }
\keyword{ triple }
