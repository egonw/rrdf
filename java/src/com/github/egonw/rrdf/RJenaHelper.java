package com.github.egonw.rrdf;

import java.io.*;

import com.hp.hpl.jena.rdf.model.*;
import com.hp.hpl.jena.ontology.*;

public class RJenaHelper {

  public static Model loadRdf() {
    Model model = ModelFactory.createOntologyModel();
    /*File file = new File(filename);
    InputStream stream = new FileInputStream(file);
    model.read(stream, "", format);*/
    return model;
  }

  public static String dump(Model model) {
    StringBuffer dump = new StringBuffer();

    StmtIterator statements = model.listStatements();
    while (statements.hasNext()) {
      Statement statement = statements.nextStatement();
      RDFNode object = statement.getObject();
      dump.append(statement.getSubject().getLocalName())
          .append(' ')
          .append(statement.getPredicate().getLocalName())
          .append(' ')
          .append((object instanceof Resource ?
                   object.toString() : '"' + object.toString() + "\""))
          .append('\n');
    }
    return dump.toString();
  }

}