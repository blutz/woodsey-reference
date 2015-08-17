# Woodsey Reference BETA

## Installation
### Requirements
Your system must be able to run docker.

### Instructions
Make sure you have docker, docker-machine, and docker-compose installed. If you're on a Mac or PC, I recommend installing [Docker Toolbox](https://www.docker.com/toolbox).

Run `docker-compose build` to build the two images. You'll only need to re-run this if the Gemfile or Dockerfile change.

Run the apps with `docker-container up`. To sync the database, run `docker-container run web db:create`.

## Running
To start the app, simply run `docker-container up`. Rails will be running on port 3000.

If you are using Docker Machine, run `docker-machine [MACHINE NAME] ip` to get the IP address of the machine it's running on.

## Contact
Woodsey Reference is made by Byron Lutz. You can contact him at byronlutz@gmail.com
