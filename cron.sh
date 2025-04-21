#!/bin/bash
cd /app 
npm run grab --- --channels=channels.xml 
#perl -pe 's#(?<!thumbor\.alteox\.app/unsafe/)(http[s]?://[^ ?\"'"'"']+\.(jpg|jpeg|png|webp|gif|svg|tif|tiff|apng|avif))\?([^ \"'"'"']+)#https://thumbor.alteox.app/unsafe/\1%3F\3#g' -i guide.xml 
#sed -i -E '/thumbor\.alteox\.app\/unsafe/!s#(http[s]?://[^ ?\"'"'"']+\.(jpg|jpeg|png|webp|gif|svg|tif|tiff|apng|avif))#https://thumbor.alteox.app/unsafe/\1#g' guide.xml 
#perl -pe 's#(?<!thumbor\.alteox\.app/unsafe/)(http[s]?://images\.media-press\.cloud[^ ?\"'"'"']+)\?([^ \"'"'"']+)#https://thumbor.alteox.app/unsafe/\1%3F\2#g' -i guide.xml 
#perl -pe 's#(?<!thumbor\.alteox\.app/unsafe/)(https?://images\.media-press\.cloud[^ \"'"'"']+)#https://thumbor.alteox.app/unsafe/\1#g' -i guide.xml

