FROM node:12.2
ENV NODE_ENV=staging
ENV HOME=/home/app
RUN apt-get update && apt-get install htop
COPY package.json package-lock.json $HOME/node_docker/
WORKDIR $HOME/node_docker
RUN npm install --silent --progress=false
EXPOSE 2000
COPY . $HOME/node_docker
CMD ["npm", "start"]
