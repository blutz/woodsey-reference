#! /bin/bash
docker run -v /Users/byron/unicamp/woodsey-reference/code:/woodsey -p 0.0.0.0:8000:8000 blutz/django-postgres python /woodsey/manage.py runserver 0.0.0.0:8000
