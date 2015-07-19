library(rrdf)
context("Null parameters")

test_that("a data triple can be added", {
  store = new.rdf(ontology=FALSE)
  expect_error(add.prefix(NULL, "ex", "http://example.org/"))
  expect_error(add.prefix(store, NULL, "http://example.org/"))
  expect_error(add.prefix(store, "ex", NULL))
})
