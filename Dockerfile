# Base image with JRE 17
FROM eclipse-temurin:17-jre

# Set working directory inside the container
WORKDIR /app

# Copy JAR file into the container
COPY myapp/target/*.jar myapp.jar

# Command to run the application
CMD ["java", "-jar", "myapp.jar"]
