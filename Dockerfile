FROM tomcat:0.1
# Take the war and copy to webapps of tomcat
COPY target/spring-boot-deployment.war /Home/dockeransible.war
