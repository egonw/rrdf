\name{save.rdf}
\alias{save.rdf}
\title{
Save RDF content
}
\description{
Saves triples to a RDF serialization.
}
\usage{
save.rdf(store, filename, format = "RDF/XML")
}
\arguments{
  \item{store}{
A triple store, for example create with new.rdf().
}
  \item{filename}{
Name of the file to read the triples from.
}
  \item{format}{
Format of the RDF file, e.g. RDF/XML.
}
}
\value{
A Java Model object containing the triples loaded from the file.
}
\author{
Egon Willighagen
}
\examples{
store = new.rdf()
\dontrun{save.rdf(store, "someFile.xml", "N3")}
}
\keyword{ RDF }
\keyword{ triple }
