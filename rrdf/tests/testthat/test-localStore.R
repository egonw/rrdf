library(rrdf)
context("Local store")

test_that("a store can be created", {
  expect_false(is.null(new.rdf()))
  expect_false(is.null(new.rdf(ontology=TRUE)))
  expect_false(is.null(new.rdf(ontology=FALSE)))
})

test_that("a data triple can be added", {
  store = new.rdf(ontology=FALSE)
  expect_equal(0, tripleCount(store))
  add.data.triple(store,
    subject="http://example.org/Subject",
    predicate="http://example.org/Predicate",
    data="Value")
  expect_equal(1, tripleCount(store))
})

test_that("a warning is thrown in invalid input", {
  store = new.rdf(ontology=FALSE)
  expect_equal(0, tripleCount(store))
  expect_error(
    add.data.triple(store,
      subject="http://example.org/Subject",
      predicate="http://example.org/Predicate",
      data="Value",
      lang="en", type="xsd:string"
    )
  )
})

test_that("a triple can be added", {
  store = new.rdf(ontology=FALSE)
  expect_equal(0, tripleCount(store))
  add.triple(store,
    subject="http://example.org/Subject",
    predicate="http://example.org/Predicate",
    object="http://example.org/Object")
  expect_equal(1, tripleCount(store))
})

test_that("a store can be summarized", {
  store = new.rdf(ontology=FALSE)
  expect_equal("Number of triples: 0", summarize.rdf(store))
  add.triple(store,
    subject="http://example.org/Subject",
    predicate="http://example.org/Predicate",
    object="http://example.org/Object")
  expect_equal("Number of triples: 1", summarize.rdf(store))
})

test_that("stores can be serialized", {
  store = new.rdf(ontology=FALSE)
  add.triple(store,
    subject="http://example.org/Subject",
    predicate="http://example.org/Predicate",
    object="http://example.org/Object")
  turtle = asString.rdf(store, format="TURTLE")
  expect_true(0 < nchar(turtle))
  expect_equal(1, grep("<http://example.org/Subject>", turtle))
  ntriples= asString.rdf(store, format="N-TRIPLES")
  expect_true(0 < nchar(ntriples))
  expect_equal(1, grep("<http://example.org/Subject>", ntriples))
  n3 = asString.rdf(store, format="N3")
  expect_true(0 < nchar(n3))
  expect_equal(1, grep("<http://example.org/Subject>", n3))
  rdfxml = asString.rdf(store, format="RDF/XML")
  expect_true(0 < nchar(rdfxml))
  expect_equal(1, grep("<rdf:RDF", rdfxml))
})

test_that("the serialization format is checked", {
  store = new.rdf(ontology=FALSE)
  add.triple(store,
    subject="http://example.org/Subject",
    predicate="http://example.org/Predicate",
    object="http://example.org/Object")
  expect_error(asString.rdf(store, format="DOESNOTEXIST"))
})

test_that("stores can be serialized with a prefix", {
  store = new.rdf(ontology=FALSE)
  add.triple(store,
    subject="http://example.org/Subject",
    predicate="http://example.org/Predicate",
    object="http://example.org/Object")
  add.prefix(store, "ex", "http://example.org/")
  turtle = asString.rdf(store, format="TURTLE")
  expect_true(0 < nchar(turtle))
  expect_equal(0, length(grep("<http://example.org/Subject>", turtle)))
  expect_equal(1, grep("ex:Subject", turtle))
  n3 = asString.rdf(store, format="N3")
  expect_true(0 < nchar(n3))
  expect_equal(0, length(grep("<http://example.org/Subject>", n3)))
  expect_equal(1, grep("ex:Subject", n3))
})
