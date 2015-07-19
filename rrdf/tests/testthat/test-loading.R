library(rrdf)
context("File loading")

test_that("data can be loaded from a file", {
  store = new.rdf(ontology=FALSE)
  expect_equal(0, tripleCount(store))
  load.rdf("testData.ttl", "N-TRIPLES", store)
  expect_equal(1, tripleCount(store))
})

test_that("data can be loaded from a file", {
  store = new.rdf(ontology=FALSE)
  expect_equal(0, tripleCount(store))
  expect_error(
    load.rdf("doesNotExist.ttl", "N-TRIPLES", store),
    "*No such file or directory*"
  )
})
