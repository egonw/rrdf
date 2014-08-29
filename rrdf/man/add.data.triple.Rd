\name{add.data.triple}
\alias{add.data.triple}
\title{
Add an data property to the model.
}
\description{
Adds an add property to the model. The type and lang parameters cannot be combined together.
}
\usage{
add.data.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  data="Value",
  type=NULL, lang=NULL)
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
"double", or any other XML Schema Data Type. It cannot be used at the same
time as lang.
}
  \item{lang}{
Optional parameter with the two-letter code for the language of the literal
content, for example "en". It cannot be used at the same
time as lang.
}
}
\value{
The updated Java Model object containing the existing and new triple.
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
add.data.triple(store,
  subject="http://example.org/Subject",
  predicate="http://example.org/Predicate",
  data="benzeen", lang="nl")
}
\keyword{ data }
\keyword{ predicate }
\keyword{ triple }
