FROM tutum/apache-php:latest
MAINTAINER Matt Day

ADD index.php /app/index.php
ADD images/piealicious.png /app/piealicious.png
ADD images/banner-1.jpg /app/banner-1.jpg
ADD images/time.jpg /app/time.jpg
ADD js/image_slide.js /app/image_slide.js
ADD js/jquery.min.js /app/jquery.min.js
ADD css/style.css /app/style.css
ADD images/background.jpg /app/background.jpg
ADD images/transparent.png /app/transparent.png
ADD images/logo.png /app/logo.png
ADD images/AWS.png /app/AWS.png
ADD images/Metapod.png /app/Metapod.png

EXPOSE 80
WORKDIR /app
CMD ["/run.sh"]
