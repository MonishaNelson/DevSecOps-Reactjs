# Use official Node.js image as base
FROM node:18-alpine AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the entire project directory into the container
COPY . .

# Copy package.json and package-lock.json (or yarn.lock) to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Build the React app
RUN npm run build

# Stage 2: Serve the Angular app using Nginx
FROM nginx:alpine

#RUN rm -rf /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built app from the previous stage to Nginx public directory
COPY --from=builder /app/build/ /usr/share/nginx/html/

# Expose port 3000 to the outside world
EXPOSE 80

# Command to run the application
CMD ["nginx", "-g", "daemon off;"]










