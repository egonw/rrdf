\name{add.triple}
\alias{add.triple}
\title{
Add an object property to the model.
}
\description{
Adds an object property to the model.
}
\usage{
add.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  object="http://example.org/Object")
}
\arguments{
  \item{store}{
A triple store, for example create with new.rdf().
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
The update Java Model object containing the existing and new triples.
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
}
\keyword{ object }
\keyword{ predicate }
\keyword{ triple }
