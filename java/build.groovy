def ant = new AntBuilder()

ant.mkdir(dir:"bin")
ant.javac(
  srcdir:"src", destdir:"bin",
  includes:"**/*.java",
  fork:"true") {
  classpath {
    fileset dir: "../rrdf/inst/java", {
      include name: "*.jar"
    }
    fileset dir: "../rrdflibs/inst/java", {
      include name: "*.jar"
    }
  }
}

ant.jar(
  destfile:"../rrdf/inst/java/rrdf.jar",
  basedir:"bin",
  includes:"**/*.class"
)
