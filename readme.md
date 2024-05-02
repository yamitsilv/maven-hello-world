#  Java Application - Hello World

## Overview
This repository contains a Java application along with GitHub Actions workflow and Helm chart files for deployment.

## Java Application
The Java application is a simple hello world, details from origin repo are in the end of this document.

## GitHub Actions
The repository includes GitHub Actions workflows for automating building, testing, and deploying the Java application which is run on every commit and PR.

### Workflows
- **maven**: This workflow builds the Java application using Maven, runs tests on the Java application, builds a docker image, pushes it to dockerhub, downloads it and runs it using Dockerfile file.
- **docker-image**: This workflow also builds the Java application but inside the docker container without running tests, using Dockerfile2 file.

## Helm Charts
The Helm chart files are used for deploying the Java application to Kubernetes clusters as a job.

### Files
- `Chart.yaml`: Contains metadata about the Helm chart.
- `values.yaml`: Contains default values for the Helm chart.
- `templates/job.yaml`: Defines a Kubernetes Job for running the Java application.

### Usage
1. Install Helm on your local machine if you haven't already.
2. Customize the Helm chart values in the `values.yaml` file if needed.
3. Deploy the Java application using Helm:

   ```bash
   helm install myappjob ./helm
   ```
   
4. You can view the creted job using the command

   ```bash
   kubectl get jobs
   ```
   
## Future improvements suggestions
1. Semantic versioning functionality instead of fixed version including updating the pom file and docker tag accordingly.
2. Setting up egress and adjusting the aplication to deliver the message to outer space using the appropriate method (possibly to the mothership api or to external device for radio transmission etc).
3. Setting workflow to exclude irrelevant paths such as this readme file.
4. Adding Steps to the CI pipeline scanning the code for vulnerability and licencing.


## Java application details

To create the files in this git repo we've already run `mvn archetype:generate` from http://maven.apache.org/guides/getting-started/maven-in-five-minutes.html
    
    mvn archetype:generate -DgroupId=com.myapp.app -DartifactId=myapp -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false

Now, to print "Hello World!", type either...

    cd myapp
    mvn compile
    java -cp target/classes com.myapp.app.App

or...

    cd myapp
    mvn package
    java -cp target/myapp-1.0-SNAPSHOT.jar com.myapp.app.App

Running `mvn clean` will get us back to only the source Java and the `pom.xml`:

    murphy:myapp pdurbin$ mvn clean --quiet
    murphy:myapp pdurbin$ ack -a -f
    pom.xml
    src/main/java/com/myapp/app/App.java
    src/test/java/com/myapp/app/AppTest.java

Running `mvn compile` produces a class file:

    murphy:myapp pdurbin$ mvn compile --quiet
    murphy:myapp pdurbin$ ack -a -f
    pom.xml
    src/main/java/com/myapp/app/App.java
    src/test/java/com/myapp/app/AppTest.java
    target/classes/com/myapp/app/App.class
    murphy:myapp pdurbin$ 
    murphy:myapp pdurbin$ java -cp target/classes com.myapp.app.App
    Hello World!

Running `mvn package` does a compile and creates the target directory, including a jar:

    murphy:myapp pdurbin$ mvn clean --quiet
    murphy:myapp pdurbin$ mvn package > /dev/null
    murphy:myapp pdurbin$ ack -a -f
    pom.xml
    src/main/java/com/myapp/app/App.java
    src/test/java/com/myapp/app/AppTest.java
    target/classes/com/myapp/app/App.class
    target/maven-archiver/pom.properties
    target/myapp-1.0-SNAPSHOT.jar
    target/surefire-reports/com.myapp.app.AppTest.txt
    target/surefire-reports/TEST-com.myapp.app.AppTest.xml
    target/test-classes/com/myapp/app/AppTest.class
    murphy:myapp pdurbin$ 
    murphy:myapp pdurbin$ java -cp target/myapp-1.0-SNAPSHOT.jar com.myapp.app.App
    Hello World!

Running `mvn clean compile exec:java` requires http://mojo.codehaus.org/exec-maven-plugin/

Running `java -jar target/myapp-1.0-SNAPSHOT.jar` requires http://maven.apache.org/plugins/maven-shade-plugin/

# Runnable Jar:
JAR Plugin
The Maven’s jar plugin will create jar file and we need to define the main class that will get executed when we run the jar file.
```
<plugin>
  <artifactId>maven-jar-plugin</artifactId>
  <version>3.0.2</version>
  <configuration>
    <archive>
      <manifest>
        <addClasspath>true</addClasspath>
        <mainClass>com.myapp.App</mainClass>
      </manifest>
    </archive>
  </configuration>
</plugin>
```


# Folder tree before package:
```
├── pom.xml
└── src
    ├── main
    │   └── java
    │       └── com
    │           └── myapp
    │               └── app
    │                   └── App.java
    └── test
        └── java
            └── com
                └── myapp
                    └── app
                        └── AppTest.java

```
# Folder tree after package:
```

.
├── pom.xml
├── src
│   ├── main
│   │   └── java
│   │       └── com
│   │           └── myapp
│   │               └── app
│   │                   └── App.java
│   └── test
│       └── java
│           └── com
│               └── myapp
│                   └── app
│                       └── AppTest.java
└── target
    ├── classes
    │   └── com
    │       └── myapp
    │           └── app
    │               └── App.class
    ├── generated-sources
    │   └── annotations
    ├── generated-test-sources
    │   └── test-annotations
    ├── maven-archiver
    │   └── pom.properties
    ├── maven-status
    │   └── maven-compiler-plugin
    │       ├── compile
    │       │   └── default-compile
    │       │       ├── createdFiles.lst
    │       │       └── inputFiles.lst
    │       └── testCompile
    │           └── default-testCompile
    │               ├── createdFiles.lst
    │               └── inputFiles.lst
    ├── myapp-1.0-SNAPSHOT.jar
    ├── surefire-reports
    │   ├── com.myapp.app.AppTest.txt
    │   └── TEST-com.myapp.app.AppTest.xml
    └── test-classes
        └── com
            └── myapp
                └── app
                    └── AppTest.class
```
