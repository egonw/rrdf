\name{remove.data.triple}
\alias{remove.data.triple}
\title{
Remove a data property from the model.
}
\description{
Removes a add property from the model.
}
\usage{
remove.data.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  data="Value",
  type=NULL)
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
  \item{data}{
A data value.
}
  \item{type}{
Optional parameter for the data value type. Can be "string", "float",
"double", or any other XML Schema Data Type.
}
}
\value{
The updated Java Model object without the provided triple.
}
\author{
Egon Willighagen
}
\examples{
store = new.rdf()
# untyped literal
add.data.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  data="1")
cat(asString.rdf(store))
remove.data.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  data="1")
cat(asString.rdf(store))

# typed literal
add.data.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  data="1", type="integer")
cat(asString.rdf(store))
remove.data.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  data="1", type="integer")
cat(asString.rdf(store))
}
\keyword{ data }
\keyword{ predicate }
\keyword{ triple }
