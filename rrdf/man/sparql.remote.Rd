\name{sparql.remote}
\alias{sparql.remote}
\title{
Run a SPARQL query on a remote SPARQL end point.
}
\description{
Runs a query against a SPARQL end point.
}
\usage{
sparql.remote(endpoint, sparql, rowvarname, user, password, jena)
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
  \item{user}{
Optional user name for HTTP authentication.
}
  \item{password}{
Optional password for HTTP authentication.
}
  \item{jena}{
Boolean to indicate if Jena should be used for the remote SPARQL querying,
or Apache's HttpClient.
}
}
\value{
A matrix object containing the results of the query.
}
\author{
Egon Willighagen
}
\examples{
\dontrun{sparql.remote("http://rdf.farmbio.uu.se/chembl/sparql",
  paste(
    "SELECT DISTINCT ?instance",
    "WHERE { ?instance a <http://purl.org/ontology/bibo/Article> }",
    "LIMIT 5"
  )
)}

# with authentication
\dontrun{sparql.remote("http://rdf.farmbio.uu.se/chembl/sparql",
  paste(
    "SELECT DISTINCT ?predicate",
    "WHERE { [] ?predicate [] }"
  ),
  user="user", password="password"
)}
}

\keyword{ RDF }
\keyword{ triple }
