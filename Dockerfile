# Stage 1: Build with Maven
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build the WAR file
RUN mvn clean package -DskipTests

# Stage 2: Run with Tomcat
FROM tomcat:9-jdk21

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy our WAR file as ROOT.war (so it runs at /)
COPY --from=build /app/target/CryptoLaunchpad.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
