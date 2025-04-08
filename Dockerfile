# Build Stage
FROM ubuntu:22.04

RUN apt update && apt-get install -y curl cron
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs 

# Set the working directory inside the front folder
WORKDIR /app

# Copy the application files
COPY . .

# Install dependencies
RUN npm install

# Setup cron
RUN npm run grab --- --channels=channels.xml
RUN sed -i -E 's#(http[s]?://[^ \"]+(\.(jpg|jpeg|png|webp|gif|svg|tif|tiff|apng|avif)))#https://thumbor.alteox.app/\1#g' guide.xml
RUN echo "0 0,12 * * * cd /app && npm run grab --- --channels=channels.xml && sed -i -E 's#(http[s]?://[^ \"]+(\.(jpg|jpeg|png|webp|gif|svg|tif|tiff|apng|avif)))#https://thumbor.alteox.app/\\\1#g' guide.xml" > /tmp/grab-cron

# Apply cron job
RUN crontab /tmp/grab-cron

# Expose the port
EXPOSE 3000

# Run the application 
CMD cron && npx serve
