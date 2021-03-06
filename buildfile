require "buildr/bnd"

repositories.remote << 'http://repo1.maven.org/maven2'
repositories.remote << Buildr::Bnd.remote_repository

repositories.release_to = 'https://oss.sonatype.org/service/local/staging/deploy/maven2'

JACKSON = 'com.fasterxml.jackson.core:jackson-core:jar:2.0.0'
JACKSON_ANNOTATIONS = 'com.fasterxml.jackson.core:jackson-annotations:jar:2.0.0'
JACKSON_DATABIND = 'com.fasterxml.jackson.core:jackson-databind:jar:2.0.0'
MONGODB = 'org.mongodb:mongo-java-driver:jar:2.5.3'

define 'bson4jackson' do
  project.version = '2.0.0'
  project.group = 'de.undercouch'
  
  compile.with JACKSON, JACKSON_ANNOTATIONS, JACKSON_DATABIND
  test.with MONGODB
  
  package(:bundle).tap do |bnd|
    bnd['Import-Package'] = "*"
    bnd['Export-Package'] = "de.undercouch.*;version=#{version}"
    bnd['Bundle-Vendor'] = 'Michel Kraemer'
    bnd['Include-Resource'] = _('LICENSE.txt')
  end
  package(:bundle).pom.from create_pom(package(:bundle), compile.dependencies)
  package :sources
  package :javadoc
  
  # sign artifacts before uploading
  packages.each { |p| sign_artifact(p) }
  sign_artifact(package(:bundle).pom)
end

def create_pom(pkg, deps)
 file(_(:target, "pom.xml")) do |file|
   Dir.mkdir(_(:target)) unless FileTest.exists?(_(:target))
   File.open(file.to_s, 'w') do |f|
     xml = Builder::XmlMarkup.new(:target => f, :indent => 2)
     xml.instruct!
     xml.project do
       xml.modelVersion "4.0.0"
       xml.groupId pkg.group
       xml.artifactId pkg.id
       xml.packaging 'jar'
       xml.version pkg.version
       xml.name pkg.id
       xml.description 'A pluggable BSON generator and parser for Jackson JSON processor.'
       xml.url 'http://www.michel-kraemer.de'
       xml.licenses do
         xml.license do
           xml.name 'The Apache Software License, Version 2.0'
           xml.url 'http://www.apache.org/licenses/LICENSE-2.0.txt'
           xml.distribution 'repo'
         end
       end
       xml.scm do
         xml.connection 'scm:git:git://github.com/michel-kraemer/bson4jackson.git'
         xml.url 'scm:git:git://github.com/michel-kraemer/bson4jackson.git'
         xml.developerConnection 'scm:git:git://github.com/michel-kraemer/bson4jackson.git'
       end
       xml.developers do
         xml.developer do
           xml.id 'michel-kraemer'
           xml.name 'Michel Kraemer'
           xml.email 'michel@undercouch.de'
         end
       end
       xml.dependencies do
         deps.each do |artifact|
           xml.dependency do
             xml.groupId artifact.group
             xml.artifactId artifact.id
             xml.version artifact.version
             xml.scope 'compile'
           end
         end
       end
     end
   end
 end
end

def sign_artifact(p)
  artifact = Buildr.artifact(p.to_spec_hash.merge(:type => "#{p.type}.asc"))
  asc = file(p.to_s + '.asc') do
    sh %{gpg -ab "#{p.to_s}"}
  end
  artifact.from asc
  task(:upload).enhance [ artifact.upload_task ]
end
