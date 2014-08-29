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

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import com.hp.hpl.jena.datatypes.xsd.XSDDatatype;
import com.hp.hpl.jena.query.Query;
import com.hp.hpl.jena.query.QueryExecution;
import com.hp.hpl.jena.query.QueryExecutionFactory;
import com.hp.hpl.jena.query.QueryFactory;
import com.hp.hpl.jena.query.QuerySolution;
import com.hp.hpl.jena.query.ResultSet;
import com.hp.hpl.jena.query.ResultSetFactory;
import com.hp.hpl.jena.rdf.model.Literal;
import com.hp.hpl.jena.rdf.model.Model;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.rdf.model.Property;
import com.hp.hpl.jena.rdf.model.RDFNode;
import com.hp.hpl.jena.rdf.model.Resource;
import com.hp.hpl.jena.rdf.model.SimpleSelector;
import com.hp.hpl.jena.rdf.model.Statement;
import com.hp.hpl.jena.rdf.model.StmtIterator;
import com.hp.hpl.jena.shared.PrefixMapping;
import com.hp.hpl.jena.sparql.engine.http.QueryEngineHTTP;

public class RJenaHelper {

  public static Model newOntoRdf() throws Exception {
    return ModelFactory.createOntologyModel();
  }

  public static Model newRdf() throws Exception {
	    return ModelFactory.createDefaultModel();
	  }

  public static Model loadRdf(String filename, String format) throws Exception {
    return loadRdf(filename, format, ModelFactory.createOntologyModel());
  }

  public static Model loadRdf(String filename, String format, Model appendTo) throws Exception {
	  File file = new File(filename);
          InputStream stream = new FileInputStream(file);
	  appendTo.read(stream, "", format);
	  return appendTo;
  }

  public static Model fromString(String rdfContent, String format) throws Exception {
          return fromString(rdfContent, format, newRdf());
  }

  public static Model fromString(String rdfContent, String format, Model appendTo) throws Exception {
          InputStream stream = new ByteArrayInputStream(rdfContent.getBytes());
          appendTo.read(stream, "", format);
          return appendTo;
  }

  public static String toString(Model model, String format) throws Exception {
	  ByteArrayOutputStream output = new ByteArrayOutputStream();
	  model.write(output, format);
	  output.close();
	  String result = new String(output.toByteArray());
	  return result;
  }

  public static void saveRdf(Model model, String filename, String format) throws Exception {
	  File file = new File(filename);
	  OutputStream stream = new FileOutputStream(file);
      model.write(stream, format);
      stream.close();
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

  public static StringMatrix sparqlRemote(String endpoint, String queryString)
  throws Exception {
	  return sparqlRemote(endpoint, queryString, null, null);
  }

  public static StringMatrix sparqlRemoteNoJena(String endpoint, String queryString)
  throws Exception {
	  return sparqlRemoteNoJena(endpoint, queryString, null, null);
  }

  public static StringMatrix sparqlRemoteNoJena(String endpoint, String queryString, String user, String password)
  throws Exception {
      StringMatrix table = null;

      // use Apache for doing the SPARQL query
      DefaultHttpClient httpclient = new DefaultHttpClient();

      // Set credentials on the client
      if (user != null) {
    	  URL endpointURL = new URL(endpoint);
    	  CredentialsProvider credsProvider = new BasicCredentialsProvider();
    	  credsProvider.setCredentials(
            new AuthScope(endpointURL.getHost(), AuthScope.ANY_PORT), 
            new UsernamePasswordCredentials(user, password)
          );
    	  httpclient.setCredentialsProvider(credsProvider);
      }
         
      List<NameValuePair> formparams = new ArrayList<NameValuePair>();
      formparams.add(new BasicNameValuePair("query", queryString));
      UrlEncodedFormEntity entity = new UrlEncodedFormEntity(formparams, "UTF-8");
      HttpPost httppost = new HttpPost(endpoint);
      httppost.setEntity(entity);
      HttpResponse response = httpclient.execute(httppost);
      HttpEntity responseEntity = response.getEntity();
      InputStream in = responseEntity.getContent();

      // now the Jena part
      ResultSet results = ResultSetFactory.fromXML(in);
      // also use Jena for getting the prefixes...
      Query query = QueryFactory.create(queryString);
      PrefixMapping prefixMap = query.getPrefixMapping();
      table = convertIntoTable(prefixMap, results);

      in.close();
      return table;
  }

  public static StringMatrix sparqlRemote(String endpoint, String queryString, String user, String password)
  throws Exception {
      StringMatrix table = null;
      Query query = QueryFactory.create(queryString);
      QueryEngineHTTP qexec = (QueryEngineHTTP)QueryExecutionFactory.sparqlService(endpoint, query);
      if (user != null) {
          qexec.setBasicAuthentication("" + user, ("" + password).toCharArray());
      }
      PrefixMapping prefixMap = query.getPrefixMapping();

      try {
          ResultSet results = qexec.execSelect();
          table = convertIntoTable(prefixMap, results);
      } finally {
          qexec.close();
      }
      return table;
  }

  public static Model construct(Model model, String queryString) throws Exception {
	  Model result= null;
	  Query query= QueryFactory.create(queryString);
	  QueryExecution qexec= QueryExecutionFactory.create(query, model);
	  try {
		  result= qexec.execConstruct();
	  } finally {
		  qexec.close();
	  }
	  return result;
  }

  public static Model constructRemote(String endpoint, String queryString) throws Exception {
      Model result= null;
	  Query query= QueryFactory.create(queryString);
      QueryEngineHTTP qexec = (QueryEngineHTTP)QueryExecutionFactory.sparqlService(endpoint, query);
	  try {
		  result= qexec.execConstruct();
	  } finally {
		  qexec.close();
	  }
	  return result;
  }

  private static StringMatrix convertIntoTable(
          PrefixMapping prefixMap, ResultSet results) {
      StringMatrix table = new StringMatrix();
      int rowCount = 0;
      List<String> resultVarNames = results.getResultVars();
      while (results.hasNext()) {
              rowCount++;
          QuerySolution soln = results.nextSolution();
          Iterator<String> varNames = resultVarNames.iterator();
          while (varNames.hasNext()) {
              String varName = varNames.next();
              int colCount = -1;
              if (table.hasColumn(varName)) {
            	  colCount = table.getColumnNumber(varName);
              } else {
            	  colCount = table.getColumnCount() + 1;
                  table.setColumnName(colCount, varName);
              }
              RDFNode node = soln.get(varName);
              if (node != null) {
                  if (node.isResource()) {
                      Resource resource = (Resource)node;
                      // the resource.getLocalName() is not accurate, so I
                      // use some custom code
                      if (resource.isAnon()) {
                    	  table.set(rowCount, colCount,
                    	     "" + resource.getId()
                    	  );
                      } else {
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
                      }
                  } else if (node.isLiteral()) {
                      Literal literal = (Literal)node;
                      table.set(rowCount, colCount, literal.getString());
                  } else {
                      String nodeStr = node.toString();
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

  public static void addObjectProperty(Model model,
		  String subject, String property, String object)
  throws Exception {
	  Resource subjectRes = model.createResource(subject);
	  Property propertyRes = model.createProperty(property);
	  Resource objectRes = model.createResource(object);
	  model.add(subjectRes, propertyRes, objectRes);
  }

  public static void removeObjectProperty(Model model,
		  String subject, String property, String object)
  throws Exception {
	  Resource subjectRes = model.createResource(subject);
	  Property propertyRes = model.createProperty(property);
	  Resource objectRes = model.createResource(object);
	  model.remove(subjectRes, propertyRes, objectRes);
  }

  public static void addDataProperty(Model model, String subject,
		  String property, String value)
  throws Exception {
	  addDataProperty(model, subject, property, value, null);
  }

  public static void addDataProperty(Model model, String subject,
		  String property, String value, String dataType)
  throws Exception {
	  Resource subjectRes = model.createResource(subject);
	  Property propertyRes = model.createProperty(property);
	  
	  if (dataType == null) {
		  model.add(subjectRes, propertyRes, value);
	  } else {
		  model.add(subjectRes, propertyRes, value, new XSDDatatype(dataType));
	  }
  }

  public static void removeDataProperty(Model model, String subject,
		  String property, String value)
  throws Exception {
	  removeDataProperty(model, subject, property, value, null);
  }

  public static void removeDataProperty(Model model, String subject,
		  String property, String value, String dataType)
  throws Exception {
	  final Resource subjectRes = model.createResource(subject);
	  final Property propertyRes = model.createProperty(property);
	  
	  if (dataType == null) {
		  Literal valueLit = model.createLiteral(value);
		  model.remove(subjectRes, propertyRes, valueLit);
	  } else {
		  StmtIterator iter = model.listStatements(new SimpleSelector(subjectRes,propertyRes,(RDFNode)null));
		  Statement statementToRemove = null;
		  while (iter.hasNext() && statementToRemove == null) {
			  Statement statement = iter.nextStatement();
			  Literal match = statement.getLiteral();
			  if (match.getString().equals(value) &&
				  match.getDatatype().getURI().equals(new XSDDatatype(dataType).getURI())) {
				  statementToRemove = statement;
			  }
		  }
		  if (statementToRemove != null) {
			  model.remove(statementToRemove);
		  }
	  }
  }

  public static void addPrefix(Model model, String prefix, String namespace) {
	  model.setNsPrefix(prefix, namespace);
  }

}
