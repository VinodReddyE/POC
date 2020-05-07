## How to configure SonarCloud Scan to build workflow

Using this GitHub Action, scan your code with SonarCloud to detects bugs, vulnerabilities and code smells.
WorkFlow Step:

```
- name: SonarCloud Scan
      run: mvn -B clean verify -Psonar -Dsonar.login=${{steps.secrets.outputs.sonartoken}}
      env:
          GITHUB_TOKEN: ${{steps.secrets.outputs.token}}

```
         
update sonar properties in maven pom.xml

```
 <properties>
    <sonar.sources>.</sonar.sources>
    <sonar.inclusions>src/main/java/**,src/main/resources/**</sonar.inclusions>
    <sonar.exclusions>${code.coverage.exclusions}</sonar.exclusions>
    <sonar.projectKey>projectKey</sonar.projectKey>
    <sonar.organization>Organization Key</sonar.organization>
    <sonar.host.url>https://sonarcloud.io</sonar.host.url>
   </properties>
  
 ```
   
   
 #Sonar Project Key and Organization Key not updated yet. waiting to enable to sonarcloud to gitHub repositories


Add maven sonar profile to project pom.xml to run sonar profile.

```
<profile>
   <id>sonar</id>
   <properties>
    <sonar.sources>.</sonar.sources>
    <sonar.inclusions>src/main/java/**,src/main/resources/**</sonar.inclusions>
    <sonar.exclusions>${code.coverage.exclusions}</sonar.exclusions>
    <sonar.projectKey>xxxxx</sonar.projectKey>
    <sonar.organization>xxxx</sonar.organization>
    <sonar.host.url>https://sonarcloud.io</sonar.host.url>
   </properties>
   <activation>
    <activeByDefault>false</activeByDefault>
   </activation>
   <build>
    <plugins>
     <plugin>
      <groupId>org.sonarsource.scanner.maven</groupId>
      <artifactId>sonar-maven-plugin</artifactId>
      <version>3.7.0.1746</version>
      <executions>
       <execution>
        <phase>verify</phase>
        <goals>
         <goal>sonar</goal>
        </goals>
       </execution>
      </executions>
     </plugin>
    </plugins>
   </build>
  </profile>

```

maven CLI command to run sonar:

```
mvn -B clean verify -Psonar -Dsonar.login=${{ secrets.SONAR_TOKEN }}

```
More Info refer the [sonarcloud](https://github.com/SonarSource/sonarcloud-github-action) documentation.
