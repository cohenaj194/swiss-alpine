FROM alpine:3.7

RUN apk -v --update add \
      util-linux \
      jq \
      curl \
      python \
      py-pip \
      groff \
      less \
      mailcap \
      tzdata \
      && \
      pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic && \
      apk -v --purge del && \
      rm /var/cache/apk/*
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.1/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
RUN pip install yq
