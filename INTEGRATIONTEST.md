### How to configure Integration tests in build work flow.

We need to add maven profiles in pom.xml to run integration tests

```
  <profile>
   <id>integration-test</id>
   <build>
    <plugins>
     <plugin>
      <groupId>org.codehaus.mojo</groupId>
      <artifactId>build-helper-maven-plugin</artifactId>
      <version>3.1.0</version>
      <executions>
       <execution>
        <id>add-integration-test-sources</id>
        <phase>generate-test-sources</phase>
        <goals>
         <goal>add-test-source</goal>
        </goals>
        <configuration>
         <sources>
          <source>src/test/java</source>
         </sources>
        </configuration>
       </execution>
       <execution>
        <id>add-integration-test-resources</id>
        <phase>generate-test-resources</phase>
        <goals>
         <goal>add-test-resource</goal>
        </goals>
        <configuration>
         <resources>
          <resource>
           <directory>src/test/resources</directory>
          </resource>
         </resources>
        </configuration>
       </execution>
      </executions>
     </plugin>
     <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-failsafe-plugin</artifactId>
      <version>2.22.2</version>
      <executions>
       <execution>
        <id>failsafe-integration-tests</id>
        <phase>integration-test</phase>
        <goals>
         <goal>integration-test</goal>
         <goal>verify</goal>
        </goals>
        <configuration>
         <skipTests>false</skipTests>
        </configuration>
       </execution>
      </executions>
     </plugin>
    </plugins>
   </build>
  </profile>
```
Configure workflow setp as below.

```
      - name: Integration test
        run: mvn -B clean verify -Pintegration-test

```

Maven CLI command to run integration tests 

```
 mvn -B clean verify -Pintegration-test

```
