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
      ruby \
      ruby-bundler \
      make \
      gcc \
      ruby-dev \
      libc-dev \
      libffi-dev \
      bash \
      ansible \
      sshpass \
      openssh-client \
      terraform \
      docker \
      openrc \
      && \
      pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic && \
      apk -v --purge del && \
      rm /var/cache/apk/*
      
# add kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.1/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

# add yq
RUN pip install yq

# add aws-iam-authenticator
RUN curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x ./aws-iam-authenticator
RUN cp ./aws-iam-authenticator usr/bin/aws-iam-authenticator
RUN mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
RUN echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

# upgrade terraform to 0.12.21
RUN wget https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
RUN unzip terraform_0.12.21_linux_amd64.zip && rm terraform_0.12.21_linux_amd64.zip
RUN mv terraform /usr/bin/terraform

# add docker
RUN rc-update add docker boot
