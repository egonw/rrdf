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

