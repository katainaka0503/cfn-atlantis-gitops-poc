FROM runatlantis/atlantis:v0.8.2

RUN apk --update add python sudo

RUN curl "https://bootstrap.pypa.io/get-pip.py" | python && \
    pip install awscli==1.16.211

RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "/tmp/awscli-bundle.zip" && \
  unzip /tmp/awscli-bundle.zip && \
  sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws


COPY ./scripts/* /usr/local/cfn-utils/
RUN sudo chmod +x /usr/local/cfn-utils/*
ENV PATH $PATH:/usr/local/cfn-utils/