FROM public.ecr.aws/lambda/python:3.13

ENV PYTHONUNBUFFERED=1
ENV DISPLAY=:99

RUN dnf install -y unzip wget

# Install Chromium
COPY install-browser.sh /tmp/
RUN /bin/sh /tmp/install-browser.sh

# Install Python dependencies for function
COPY requirements.txt /tmp/
RUN python3 -m pip install --upgrade pip -q
RUN python3 -m pip install -r /tmp/requirements.txt -q

# copy main.py
COPY main.py /var/task/


WORKDIR /var/task

CMD [ "main.handler" ]
