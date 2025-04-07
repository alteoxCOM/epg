# Build Stage
FROM node:20-alpine 

# Set the working directory inside the front folder
WORKDIR /app

# Copy the application files
COPY . .

# Install dependencies
RUN npm install

# Build the application
RUN npx pm2 start npm --no-autorestart --cron-restart="0 0,12 * * *" -- run grab --- --channels=channels.xml

# Expose the port
EXPOSE 3000

# Run the application 
CMD ["npx", "serve"]
