package com.github.egonw.rrdf;

import com.hp.hpl.jena.rdf.model.*;
import com.hp.hpl.jena.ontology.*;

public class RJenaHelper {

  public Model loadRdf(String file, String format) {
    Model model = ModelFactory.createOntologyModel();
    return model;
  }

}