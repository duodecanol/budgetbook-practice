FROM python:3.8

ENV PYTHONUNBUFFERED=1
RUN mkdir /simplebudgetbook
WORKDIR /simplebudgetbook

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt


COPY . .

EXPOSE 8080
COPY ./entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
