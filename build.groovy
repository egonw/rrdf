def ant = new AntBuilder()

ant.mkdir(dir:"bin")
ant.javac(
  srcdir:"src", destdir:"bin",
  includes:"**/*.java",
  fork:"true"
)
ant.jar(
  destfile:"rrdf.jar",
  basedir:"bin",
  includes:"**/*.class"
)
