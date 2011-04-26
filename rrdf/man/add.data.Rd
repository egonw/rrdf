\name{add.data.triple}
\alias{add.data.triple}
\title{
Add an data property to the model.
}
\description{
Adds an add property to the model.
}
\usage{
add.data.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  data="Value")
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
  \item{data}{
A data value.
}
}
\value{
The update Java Model object containing the existing and new triple.
}
\author{
Egon Willighagen
}
\examples{
store = new.rdf()
add.data.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  data="Value")
}
\keyword{ data }
\keyword{ predicate }
\keyword{ triple }
