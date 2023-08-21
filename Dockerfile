FROM nginx
RUN apt update -y
RUN apt install ansible -y
RUN apt install git vim -y

