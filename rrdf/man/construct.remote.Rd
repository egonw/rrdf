\name{construct.remote}
\alias{construct.remote}
\title{
Run a SPARQL CONSTRUCT query on a SPARQL end point and construct a new model with the results.
}
\description{
Runs a query against a SPARQL end point and construct a new model with the results.
}
\usage{
construct.remote(endpoint, sparql)
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
A Jena model object containing the results of the query.
}
\author{
Egon Willighagen
}
\examples{
\dontrun{store = construct.remote("http://rdf.farmbio.uu.se/chembl/sparql",
  paste(
    "CONSTRUCT { ?instance a <http://example.org/Article> } ",
    "WHERE { ?instance a <http://purl.org/ontology/bibo/Article> }",
    "LIMIT 5"
  ))}
}
\keyword{ RDF }
\keyword{ triple }
