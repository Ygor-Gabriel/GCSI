FROM python:3.11-alpine

WORKDIR /usr/src/app

COPY ./requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ./app .

ENV FLASK_APP=app.py
# watch app' files
ENV FLASK_DEBUG=true
ENV FLASK_ENV=development

# running Flask as a module
CMD ["sh", "-c", "sleep 5 \ 
    # ! run init only the first time you launch the stack and when the migrations folder do not exist yet
    && flask db init \ 
    # ! To set the revision in the database to the head, without performing any migrations. You can change head to the required change you want.
    # && flask db stamp head \
    && flask db migrate \
    && flask db upgrade \ 
    && flask run --host=0.0.0.0"]