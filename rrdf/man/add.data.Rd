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
  data="Value",
  type=NULL)
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
  \item{type}{
Optional parameter for the data value type. Can be "string", "float",
"double", or any other XML Schema Data Type.
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
add.data.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  data="1", type="integer")
}
\keyword{ data }
\keyword{ predicate }
\keyword{ triple }
