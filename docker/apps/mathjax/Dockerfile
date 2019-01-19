FROM alpine:latest

MAINTAINER https://github.com/nisnaker/webstack

WORKDIR /root

RUN apk -U add npm && npm install mathjax-node

COPY server.js /root

EXPOSE 9999

CMD ["node", "server.js"]
