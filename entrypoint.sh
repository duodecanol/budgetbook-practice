#!/bin/bash
sleep 5
python manage.py makemigrations
python manage.py migrate
sleep 1
python manage.py collectstatic --noinput  # Collect static files
python manage.py loaddata budgetbook/models/fixtures/categories_fixture.json
python manage.py loaddata budgetbook/models/fixtures/currencies_fixture.json
sleep 1

# test admin
python manage.py shell < dummy_superuser.py

# # Prepare log files
touch /gunicorn/logs/access.log
touch /gunicorn/logs/error.log

# Start Gunicorn processes
echo Starting Gunicorn.
exec gunicorn simplebudgetbook.wsgi:application \
    --bind 0.0.0.0:8080 \
    --workers 2 \
    --log-level=info \
    --access-logfile=/gunicorn/logs/access.log \
    --error-logfile=/gunicorn/logs/error.log \
    --capture-output \
    "$@"