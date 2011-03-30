\name{summarize.rdf}
\alias{summarize.rdf}
\title{
Summarized the content of a Java Model.
}
\description{
Summarized the content of a Java Model, including the number
of triples.
}
\usage{
summarize.rdf(model)
}
\arguments{
  \item{model}{
A Java Model object.
}
}
\value{
Results are returned to the console.
}
\author{
Egon Willighagen
}
\examples{
store = new.rdf()
summarize.rdf(store)
}
\keyword{ RDF }
\keyword{ triple }
