stage-1
# Use Node.js as base image
FROM node:14 as builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install npm dependencies
RUN npm install

# Copy the entire Angular project to the working directory
COPY . .

# Build the Angular application
RUN npm run build --prod

# Use Nginx as base image for serving the Angular app
FROM nginx:alpine

# Copy built Angular files to Nginx default public directory
COPY --from=builder /app/dist/<your-angular-app-name> /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
stage-2
# Use Maven as base image
FROM maven:3.8.4-openjdk-17-slim AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the entire backend project to the working directory
COPY . .

# Build the Spring Boot application
RUN mvn clean package -DskipTests

# Use OpenJDK as base image for running the Spring Boot app
FROM openjdk:17-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the builder stage to the current directory
COPY --from=builder /app/target/<your-spring-boot-app>.jar ./app.jar

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the Spring Boot application
CMD ["java", "-jar", "app.jar"]
