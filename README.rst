================
BSON for Jackson
================

This library adds support for `BSON <http://bsonspec.org>`_ to the
`Jackson JSON processor <http://jackson.codehaus.org/>`_.

BSON is a binary representation of `JSON <http://json.org/>`_. It has
gained prominence by its usage as the main exchange and persistence
format of the document-oriented database management system `MongoDB
<http://www.mongodb.com>`_.

Usage
-----

The bson4jackson library integrates completely into Jackson. Please have
a look at the `Jackson wiki <http://wiki.fasterxml.com/JacksonDocumentation>`_
for a complete description. For more information you may also have a
look at the `bson4jackson tutorial <http://www.michel-kraemer.com/binary-json-with-bson4jackson>`_.

The BSON specification defines some additional types not available in
the original JSON specification. These types are mapped to simple
wrapper objects.

Download
--------

bson4jackson binaries are available from the
`GitHub Download page <https://github.com/michel-kraemer/bson4jackson/downloads>`_.

You may also use `Maven <http://maven.apache.org/>`_ to download bson4jackson::

  <dependencies>
    <dependency>
      <groupId>de.undercouch</groupId>
      <artifactId>bson4jackson</artifactId>
      <version>2.0.0</version>
    </dependency>
  </dependencies>

If you're using `sbt <http://code.google.com/p/simple-build-tool/>`_,
you may add the following line to your project::

  val bson4jackson = "de.undercouch" % "bson4jackson" % "2.0.0"

For `buildr <http://buildr.apache.org/>`_ use the following snippet::

  compile.with 'de.undercouch:bson4jackson:jar:2.0.0'

Compatibility
-------------

bson4jackson 2.x is compatible to Jackson 2.0 and higher.

If you're looking for a version compatible to Jackson 1.x, please use
bson4jackson 1.3.0. It's the last version for the 1.x branch.
bson4jackson 1.3.0 is compatible to Jackson 1.7 up to 1.9.

License
-------

bson4jackson is licensed under the
`Apache License, Version 2.0 <http://www.apache.org/licenses/LICENSE-2.0>`_.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Compiling
---------

.. image:: https://secure.travis-ci.org/michel-kraemer/bson4jackson.png?branch=master
   :alt: Build Status
   :target: http://travis-ci.org/michel-kraemer/bson4jackson

You need buildr in order to compile the bson4jackson library. Please follow
the `instructions on the buildr website <http://buildr.apache.org/installing.html>`_.

Execute the following command to compile the library and to run the
unit tests::

  buildr compile test

If everything runs successfully, you may create a .jar library::

  buildr clean package

The library will be located under the ``target`` directory.

Eclipse
.......

buildr includes a task that creates the files required to develop
bson4jackson in Eclipse. Run the following command::

  buildr eclipse

Then import the project into your workspace. If Eclipse complains about
your classpath, make sure the variable ``M2_REPO`` is set to your local
Maven repository. You can change that variable under
"Window/Preferences/Java/Build Path/Classpath Variables".
