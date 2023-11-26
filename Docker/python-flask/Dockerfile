FROM python:3.8 AS build
WORKDIR /app
COPY . /app
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
FROM python:3.8-slim
WORKDIR /app
COPY --from=build /app .
EXPOSE 3000
CMD ["python3", "flask.py"]
