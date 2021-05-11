FROM openjdk:8
EXPOSE 8090

ARG VAR_PROFILE
ENV env_var_profile=${VAR_PROFILE}
ARG JAR_FILE=target/practica-devops-0.0.1-SNAPSHOT.jar
# ADD practica-devops.jar app.jar
ADD ${JAR_FILE} app.jar
CMD ["/bin/sh"]
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=${env_var_profile}", "/app.jar"]
