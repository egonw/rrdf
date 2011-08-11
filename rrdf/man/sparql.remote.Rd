\name{sparql.remote}
\alias{sparql.remote}
\title{
Run a SPARQL query on a remote SPARQL end point.
}
\description{
Runs a query against a SPARQL end point.
}
\usage{
sparql.remote(endpoint, sparql, rowvarname)
}
\arguments{
  \item{endpoint}{
The SPARQL end point.
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
sparql.remote("http://rdf.farmbio.uu.se/chembl/sparql",
  paste(
    "SELECT DISTINCT ?instance",
    "WHERE { ?instance a <http://purl.org/ontology/bibo/Article> }",
    "LIMIT 5"
  ))
}
\keyword{ RDF }
\keyword{ triple }
