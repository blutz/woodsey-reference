#! /bin/bash
docker run -v /Users/byron/unicamp/woodsey-reference/code:/woodsey -p 0.0.0.0:8000:8000 -it blutz/django-postgres /bin/bash
