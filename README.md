# One It Once Technical Assignment
The Shell script part of the assignment is based in shell_script, while the Docker assignment is in webservice/

## Shell Script
Getting the two services (php-fpm and nginx) was a particular challenge, but the Docker documentation helped alot.

This container simply displays phpinfo() within index.php, and has no real structure to the project.

### Highlights
* The script will handle persistent re-runs with different versions of PHP, it will remove the old version then install the new one.
* I got to learn how php-fpm worked for the next section
* The Makefile has a run, stop, and export (simply curls localhost, but feel free to navigate with your browser as well)
  * This also has a clean, but I've commented out in case you use it out of habit, I'm doing a system prune since I don't use Docker regularly.

### Blockers
The biggest blocker here was that I couldn't get the version number parameterized in the dockerfile, so there are a few areas we need to visit to change the php version
  * entrypoint.sh requires the full name, and I wasn't able to get a symlink to work (eg: needs php8.0-fpm and a symlink to php-fpm was failing)
  * Dockerfile has two on lines 8, and 9

Next an issue I ran into was trying to move off of the root-user, as I couldn't run su noninteractively to run nginx as well as php-fpm. This should be quite solvable but time is running short so I'm making this report to state progress.

## Docker (webservice)
This was my first time using docker compose, as well as an introduction to using PHP so the bulk of my work went into this section. Still, most fun I've had in months!

The index.php of this webservice has links to all of the requested pages (latency checks, php-fpm status, phpinfo, etc..) so just load up index.php and have a look.

### Note
The Assignment asks for a single Nginx server that was probably supposed to have php-fpm running on it (as per the shell script part of the assignment) but to me, from a security standpoint keeping our front-end boxe separate from our back-end helps reduce attack surfaces as well as segregate workloads for a more practical defense-in-depth approach. However, as shown in the shell script portion of the assignment I was able to make a container with both services so if requirements demanded they be merged the work is done in the above task.

### Highlights
* Makefile handles docker compose, rebuild gives you the output for faster debugging, otherwise make up and make stop are as above.
* Container hardening is quite new for me, but multiple staged builds made it much easier to run alpine minimal builds. Other basic work like non-root running containers was also interesting to learn.

### Blockers
The biggest hurdle was working with the DOCKER-USER chain, as apparently it does not exist in my running containers, only in my host machine. quick googling mentioned a bug in a prior version of Docker (from 2019) that removed this chain by accident. It's posted as resolved but working this problem burnt up the rest of my allotted time.

This also prevented me from spending much time on IPTables, though I did spend some time going through a refresher in my old linux textbooks.


