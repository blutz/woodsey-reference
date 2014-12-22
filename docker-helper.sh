#! /bin/bash
if [ $1 ] ; then
    if [ $1 = "bash" ]
    then
        docker run -v /Users/byron/unicamp/woodsey-reference/code:/woodsey -p 0.0.0.0:8000:8000 -it blutz/django-postgres /bin/bash
    elif [ $1 = "inspect" ]
    then
        docker exec -it $2 /bin/bash
    elif [ $1 = "port-forward" ]
    then
        boot2docker ssh -Nf -L 8000:0.0.0.0:8000 &
    elif [ $1 = "runserver" ]
    then
        docker run -v /Users/byron/unicamp/woodsey-reference/code:/woodsey -p 0.0.0.0:8000:8000 blutz/django-postgres python /woodsey/manage.py runserver 0.0.0.0:8000
    elif [ $1 = "h" ] || [ $1 = "help" ]
    then
        echo -e "\c"
    else
        echo "ERROR: That's not a command. h for help"
    fi
fi

if [ !$1 ] || [ $1 = "h" ] || [ $1 = "help" ]
then
    echo 'This is a utility to help run some basic docker commands. They are:'
    echo -e '\th(0) or help(0) - this help message'
    echo -e '\tbash(0) - run container with bash'
    echo -e '\tinspect(1) - connect to container with bash'
    echo -e '\tport-forward(0) - forward 8000 in background'
    echo -e '\trunserver(0) - run server in background'
fi

