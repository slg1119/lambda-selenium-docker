FROM public.ecr.aws/lambda/python:3.13 as stage

RUN yum install -y -q sudo unzip

# Install Chromium
COPY install-browser.sh /tmp/
RUN /usr/bin/bash /tmp/install-browser.sh

FROM public.ecr.aws/lambda/python:3.13 as base

COPY chrome-deps.txt /tmp/
RUN yum install -y $(cat /tmp/chrome-deps.txt)

# Install Python dependencies for function
COPY requirements.txt /tmp/
RUN python3 -m pip install --upgrade pip -q
RUN python3 -m pip install -r /tmp/requirements.txt -q

COPY --from=stage /opt/chrome /opt/chrome
COPY --from=stage /opt/chromedriver /opt/chromedriver

# copy main.py
COPY main.py /var/task/


WORKDIR /var/task

CMD [ "main.handler" ]
