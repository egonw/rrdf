\name{add.prefix}
\alias{add.prefix}
\title{
Define an prefix for a namespace.
}
\description{
Adds an prefix for a namespace to the model.
}
\usage{
add.prefix(store, prefix, namespace)
}
\arguments{
  \item{store}{
A triple store, for example create with new.rdf().
}
  \item{prefix}{
String to be used as prefix.
}
  \item{namespace}{
URI of the namespace.
}
}
\author{
Egon Willighagen
}
\examples{
store = new.rdf()
add.prefix(store,
  prefix="dc",
  namespace="http://purl.org/dc/terms/"
)
}
\keyword{ rdf }
\keyword{ prefix }
\keyword{ namespace }
