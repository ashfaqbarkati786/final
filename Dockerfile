FROM python:3.9

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN pip install mysql-connector-python gunicorn

COPY . .

CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80"]
