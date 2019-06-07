# Overview

## Developer Information

The microservice-template is built into a Docker image by means of the 
[Dockerfile](Dockerfile).

You can create the Docker image on your local computer and run it:

```shell
docker build -t "microservice-template" .
docker run -p 8080:8080 -it --rm --name "microservice-template" microservice-template
```

### Google Cloud Build

Every push to the **master** branch on GitHub triggers a Google
Cloud Build. This will compile the Docker image and store it in the
[Google Cloud Container Registry](https://console.cloud.google.com/gcr/images/). 
Google Cloud Build is configured in [cloudbuild.yaml](cloudbuild.yaml)

Run the latest image on your local computer:

```shell
export PROJECT=$(gcloud config get-value project)
docker run -p 8080:8080 -it --rm --name "microservice-template" eu.gcr.io/${PROJECT}/microservice-template:latest
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
