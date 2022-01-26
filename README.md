### Nextcloud (with cron inside) + Traefik 2 (LetsEncrypt ACMEv2) + Jellyfin + OnlyOffice + Redis + BitwardenRS (Docker Compose Setup guide)

READ EVERYTHING BEFORE INSTALL

### 1. OS requirements

This setup requires the latest Docker and Docker-compose versions (I am running on 19.03.5)

<https://www.howtoforge.com/tutorial/how-to-upgrade-kernel-in-centos-7-server/>

### 2. Domain provider requirements

Any provider that is supported by ACME can be used:

<https://docs.traefik.io/v2.0/https/acme/#providers>

This setup also uses wildcard certificate, so only one certificate is used for all your domain. Your provider must support DNS-01 challenge to use wildcard certificates.

You will need to get the API access keys before the install, and set the environment variables accordingly.

### 3. Setup

Just complete the docker-compose.yml and traefik.yml with the data (Domains, passwords and provider API keys)

Then bring everything up with:

```
sudo docker-compose up -d
```

And give it some time until everything starts, and the certificate is requested

### 4. After setup

Go to Nextcloud, create your user, enter to the main files pages, and then go to the server shell and get inside the container using:

```
sudo docker exec -it -u www-data nextcloud bash
nano config/config.php
```

Add the following (inside the config PHP array):

```
'overwriteprotocol' => 'https',
```

So the resources can be loaded correctly.

Also, check that the background jobs, in nextcloud configuration (webpage, not files) is checked to cron

The files acme.json and access.log that are created on the folder are the LetsEncrypt cert, and the Traefik access logs.

### 5. What is installed

* Nextcloud with cron inside (Thats because is doing a custom build of the nextcloud image)
* Traefik 2 using a secure dashboard, accesible via user and password defined in the basic-auth middleware, with the subdomain traefik
* Redis for Nextcloud
* Jellyfin, with the volume of Nextcloud (Read only)
* OnlyOffice DocumentServer protected with jwt-secret password (environment variable)
* BitwardenRS

### 6. Security features

* Gets A+ on Nextcloud security test
* Gets A+ on ssllabs.com
* HTTPS redirect
* Security headers
* Secure traefik dashboard access
* Perfect Forward Secrecy
* STS preload
