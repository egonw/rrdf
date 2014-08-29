\name{remove.triple}
\alias{remove.triple}
\title{
Removes an object property from the model.
}
\description{
Removes an object property from the model.
}
\usage{
remove.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  object="http://example.org/Object")
}
\arguments{
  \item{store}{
A triple store, for example created with new.rdf().
}
  \item{subject}{
URI of the subject.
}
  \item{predicate}{
URI of the predicate.
}
  \item{object}{
URI of the object.
}
}
\value{
The updated Java Model object no longer the provided triple.
}
\author{
Egon Willighagen
}
\examples{
store = new.rdf()
add.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  object="http://example.org/Object")
cat(asString.rdf(store))
remove.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  object="http://example.org/Object")
cat(asString.rdf(store))
}
\keyword{ object }
\keyword{ predicate }
\keyword{ triple }
