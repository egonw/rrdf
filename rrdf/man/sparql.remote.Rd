\name{sparql.remote}
\alias{sparql.remote}
\title{
Run a SPARQL query on a remote SPARQL end point.
}
\description{
Runs a query against a SPARQL end point.
}
\usage{
sparql.remote(endpoint, sparql)
}
\arguments{
  \item{endpoint}{
The SPARQL end point.
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
sparql.remote("http://rdf.farmbio.uu.se/chembl/sparql",
  paste(
    "SELECT DISTINCT ?instance",
    "WHERE { ?instance a <http://purl.org/ontology/bibo/Article> }",
    "LIMIT 5"
  ))
}
\keyword{ RDF }
\keyword{ triple }
