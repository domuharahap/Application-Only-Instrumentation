From ubuntu
RUN apt-get update
RUN apt-get install wget nodejs npm unzip -y
copy ./app.js app.js

ARG DT_API_URL="https://xxx***.live.dynatrace.com/api"
ARG DT_API_TOKEN="xxx****-xxx******"
ARG DT_ONEAGENT_OPTIONS="flavor=default&include=nodejs"
ENV DT_HOME="/opt/dynatrace/oneagent"
RUN mkdir -p "$DT_HOME" && \
    wget -O "$DT_HOME/oneagent.zip" "$DT_API_URL/v1/deployment/installer/agent/unix/paas/latest?Api-Token=$DT_API_TOKEN&$DT_ONEAGENT_OPTIONS" && \
    unzip -d "$DT_HOME" "$DT_HOME/oneagent.zip" && \
    rm "$DT_HOME/oneagent.zip"
ENTRYPOINT [ "/opt/dynatrace/oneagent/dynatrace-agent64.sh" ]
CMD [ "node", "app.js" ]
