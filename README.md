# One It Once Technical Assignment
The Shell script part of the Assignment is  in shell_script/, while the Docker portion is in web services/

## Shell Script
Getting the two services (php-fpm and nginx) was a challenge, but the Docker documentation helped.

This container displays phpinfo() within index.php and has no real structure to the project.

### Highlights
* The script will handle constant re-runs with different versions of PHP. It will remove the old version then install the new one.
* I got to learn how php-fpm worked for the next section
* The Makefile has a run, stop, and export (curls localhost, but feel free to navigate with your browser as well)
  * This also has a clean, but I've commented it out if you use it out of habit. I'm doing a system prune since I don't use Docker regularly.

### Blockers
The biggest blocker here was that I couldn't get the version number parameterized in the dockerfile, so there are a few areas we need to visit to change the php version.
  * entrypoint.sh requires the full name, and I wasn't able to get a symlink to work (e.g., needs php8.0-fpm and a symlink to php-fpm was failing)
  * Dockerfile has two on lines 8 and 9

Next, an issue I ran into was trying to move off of the root-user, as I couldn't run su noninteractively to run nginx as well as php-fpm. This block should be pretty solvable, but time is running short, so I'm making this report to state progress.

## Docker (webservice)
This project was my first time using Docker compose and an introduction to using PHP, so the bulk of my work went into this section. Still, the most fun I've had in months!

The index.php of this webservice has links to all of the requested pages (latency checks, php-fpm status, phpinfo, etc.), so load up index.php and have a look.

### Note
The Assignment asks for a single Nginx server that was probably supposed to have php-fpm running on it (as per the shell script part of the Assignment) but to me, from a security standpoint keeping our front-end box separate from our back-end helps reduce attack surfaces as well as segregate workloads for a more practical defence-in-depth approach. However, as shown in the shell script portion of the Assignment, I was able to make a container with both services, so if other requirements necessitate they be within the same container, the work is already complete.

### Highlights
* Makefile handles Docker compose, rebuild gives you the output for faster debugging, otherwise 'make up' and 'make stop' are as above.
* Container hardening is entirely new for me, but multiple staged builds made it much easier to run minimal alpine builds. Other essential work like non-root running containers was also interesting to learn.

### Blockers
The biggest hurdle was working with the DOCKER-USER chain, as apparently it does not exist in my running containers, only in my host machine. Quick googling mentioned a bug in a prior version of Docker (from 2019) that removed this chain by accident. This blocker burnt up the rest of my allotted time and is why there is next to no work done on IPTables so far.
