\name{combine.rdf}
\alias{combine.rdf}
\title{
Merge to Java Model objects.
}
\description{
Returns a new Java Model object containing all unique triples from both merged models.
}
\usage{
combine.rdf(model1, model2)
}
\arguments{
  \item{model1}{
The first Java Model to get triples from.
}
  \item{model2}{
The second Java Model to get triples from.
}
}
\value{
A new Java Model object containing the triples from both models.
}
\author{
Egon Willighagen
}
\examples{
model1 = new.rdf()
model2 = new.rdf()
\dontrun{model3 = combine.rdf(model1, model2)}
}
\keyword{ RDF }
\keyword{ triple }
