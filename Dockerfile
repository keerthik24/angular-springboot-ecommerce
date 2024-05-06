# Stage-1: Angular Frontend
FROM node:14 as builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build --prod

FROM nginx:alpine

COPY --from=builder /app/dist/<your-angular-app-name> /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# Stage-2: Spring Boot Backend
FROM maven:3.8.4-openjdk-17-slim AS builder

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

FROM openjdk:17-slim

WORKDIR /app

COPY --from=builder /app/target/<your-spring-boot-app>.jar ./app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
