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
# Rewrite URLs with query parameters but skip those already routed through Thumbor

RUN perl -pe 's#(?<!thumbor\.alteox\.app/unsafe/)(http[s]?://[^ ?\"'"'"']+\.(jpg|jpeg|png|webp|gif|svg|tif|tiff|apng|avif))\?([^ \"'"'"']+)#https://thumbor.alteox.app/unsafe/\1%3F\3#g' -i guide.xml
# Rewrite plain URLs without query params (also skip if already rewritten)
RUN sed -i -E '/thumbor\.alteox\.app\/unsafe/!s#(http[s]?://[^ ?\"'"'"']+\.(jpg|jpeg|png|webp|gif|svg|tif|tiff|apng|avif))#https://thumbor.alteox.app/unsafe/\1#g' guide.xml

RUN perl -pe 's#(?<!thumbor\.alteox\.app/unsafe/)(http[s]?://images\.media-press\.cloud[^ ?\"'"'"']+)\?([^ \"'"'"']+)#https://thumbor.alteox.app/unsafe/\1%3F\2#g' -i guide.xml
# Rewrite plain URLs without query params (also skip if already rewritten)
RUN perl -pe 's#(?<!thumbor\.alteox\.app/unsafe/)(https?://images\.media-press\.cloud[^ \"'"'"']+)#https://thumbor.alteox.app/unsafe/\1#g' -i guide.xml


RUN echo "*/10 * * * * /app/cron.sh" > /tmp/cron-file

# Apply cron job
RUN crontab /tmp/cron-file

# Expose the port
EXPOSE 3000

# Run the application 
CMD cron && npx serve
