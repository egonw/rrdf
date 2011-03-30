/* Copyright (C) 2011  Egon Willighagen <egon.willighagen@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details. 
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.github.egonw.rrdf;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.hp.hpl.jena.query.Query;
import com.hp.hpl.jena.query.QueryExecution;
import com.hp.hpl.jena.query.QueryExecutionFactory;
import com.hp.hpl.jena.query.QueryFactory;
import com.hp.hpl.jena.query.QuerySolution;
import com.hp.hpl.jena.query.ResultSet;
import com.hp.hpl.jena.rdf.model.Model;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.rdf.model.RDFNode;
import com.hp.hpl.jena.rdf.model.Resource;
import com.hp.hpl.jena.rdf.model.Statement;
import com.hp.hpl.jena.rdf.model.StmtIterator;
import com.hp.hpl.jena.shared.PrefixMapping;

public class RJenaHelper {

  public static Model newRdf() throws Exception {
    return ModelFactory.createOntologyModel();
  }

  public static Model loadRdf(String filename, String format) throws Exception {
    Model model = ModelFactory.createOntologyModel();
    File file = new File(filename);
    InputStream stream = new FileInputStream(file);
    model.read(stream, "", format);
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

  public static int tripleCount(Model model) {
    return (int)model.size();
  }

  public static StringMatrix sparql(Model model, String queryString) throws Exception {
      StringMatrix table = null;
      Query query = QueryFactory.create(queryString);
      PrefixMapping prefixMap = query.getPrefixMapping();
      QueryExecution qexec = QueryExecutionFactory.create(query, model);
      try {
          ResultSet results = qexec.execSelect();
          table = convertIntoTable(prefixMap, results);
      } finally {
          qexec.close();
      }
      return table;
  }

  private static StringMatrix convertIntoTable(
          PrefixMapping prefixMap, ResultSet results) {
      StringMatrix table = new StringMatrix();
      int rowCount = 0;
      int colCount = 0;
      while (results.hasNext()) {
              colCount = 0;
              rowCount++;
          QuerySolution soln = results.nextSolution();
          Iterator<String> varNames = soln.varNames();
          while (varNames.hasNext()) {
              colCount++;
              String varName = varNames.next();
              table.setColumnName(colCount, varName);
              RDFNode node = soln.get(varName);
              if (node != null) {
                  String nodeStr = node.toString();
                  if (node.isResource()) {
                      Resource resource = (Resource)node;
                      // the resource.getLocalName() is not accurate, so I
                      // use some custom code
                      String[] uriLocalSplit = split(prefixMap, resource);
                      if (uriLocalSplit[0] == null) {
                              if (resource.getURI() != null) {
                                      table.set(rowCount, colCount, resource.getURI());
                              } else {
                                      // anonymous node
                                      table.set(rowCount, colCount, "" + resource.hashCode());
                              }
                      } else {
                              table.set(rowCount, colCount,
                              uriLocalSplit[0] + ":" + uriLocalSplit[1]
                          );
                      }
                  } else {
                      if (nodeStr.endsWith("@en"))
                              nodeStr = nodeStr.substring(
                                      0, nodeStr.lastIndexOf('@')
                              );
                      table.set(rowCount, colCount, nodeStr);
                  }
              }
          }
      }
      return table;
  }

  public static String[] split(PrefixMapping prefixMap, Resource resource) {
      String uri = resource.getURI();
      if (uri == null) {
          return new String[] {null, null};
      }
      Map<String,String> prefixMapMap = prefixMap.getNsPrefixMap();
      Set<String> prefixes = prefixMapMap.keySet();
      String[] split = { null, null };
      for (String key : prefixes){
          String ns = prefixMapMap.get(key);
          if (uri.startsWith(ns)) {
              split[0] = key;
              split[1] = uri.substring(ns.length());
              return split;
          }
      }
      split[1] = uri;
      return split;
  }
}