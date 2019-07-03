# Overview

## Usage

In order to derive a new project from this template, execute the bash script

```shell
cd /path/to/projects
kdb-stationservice/create-project-from-template.sh My-Fancy-Project
```

Replace "My-Fancy-Project" with your desired project name. Use "-" symbols instead
of spaces.

The script will clone this microservice-template, rename all files, directories and
file contents to "My-Fancy-Project" (considering case) and initialize a git repository.
While doing so it will establish a branch named microservice-template-master and
link it to the source repository. The source repository will have the git remote name
"template".

After the script has finished, you can [publish your new project on GitHub](https://github.com).
When creating the project, you can activate the [Google Cloud Build](https://cloud.google.com/cloud-build/)
checkbox (see below for details). As instructed by GitHub, push your fresh project:

```shell
cd my-fancy-project
git remote add origin git@github.com:<userid>/<repository>
git push -u origin master
```

Now this will trigger a [Google Cloud Build (Console)](https://console.cloud.google.com/cloud-build/builds) already.
The build should be successful.

If you have connected [Travis-CI.org](https://travis-ci.org) to GitHub, then you can enable the
project in your [Travis CI Repository Settings](https://travis-ci.org/account/repositories). This
will launch a first build.

## Developer Information

The kdb-stationservice is built into a Docker image by means of the 
[Dockerfile](Dockerfile).

You can create the Docker image on your local computer and run it:

```shell
docker build -t "kdb-stationservice" .
docker run -p 8080:8080 -it --rm --name "kdb-stationservice" kdb-stationservice
```

### Google Cloud Build

Every push to the **master** branch on GitHub triggers a Google
Cloud Build. This will compile the Docker image and store it in the
[Google Cloud Container Registry](https://console.cloud.google.com/gcr/images/). 
Google Cloud Build is configured in [cloudbuild.yaml](cloudbuild.yaml)

Run the latest image on your local computer:

```shell
export PROJECT=$(gcloud config get-value project)
docker run -p 8080:8080 -it --rm --name "kdb-stationservice" eu.gcr.io/${PROJECT}/kdb-stationservice:latest
```

#### Running a Google Cloud Build Manually

You can invoke the Google Cloud Build API from the command line:

```shell
gcloud builds submit --config cloudbuild.yaml
```

#### References

* Google LLC: [Cloud Build Documentation](https://cloud.google.com/cloud-build/docs/), last visited on June 7, 2019.

## Endpoints

The following generic endpoints are available:

* Swagger UI - http://localhost:8080/swagger-ui.html
* API documentation (Swagger File) - http://localhost:9001/v2/api-docs
