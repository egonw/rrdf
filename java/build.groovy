def ant = new AntBuilder()

ant.mkdir(dir:"bin")
ant.javac(
  srcdir:"src", destdir:"bin",
  includes:"**/*.java",
  fork:"true") {
    classpath {
      fileset dir: "../rdf/inst/cont", {
      include name: "*.jar"
    }
  }
}

ant.jar(
  destfile:"rrdf.jar",
  basedir:"bin",
  includes:"**/*.class"
)
