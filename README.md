# chrome-remote-desktop-image

Image pipeline to bake a remote desktop environment
on Debian, uses Chrome Remote Desktop.

## Pre-Requisites

- Vagrant
- Packer
- Google Cloud Service Account with Admin access to Compute Engine & IAM

## Usage

Add the following environment variables to the pipeline:

```shell
GOOGLE_PROJECT=<google project you want to use>
GCLOUD_SERVICE_KEY=<json formatted service account key>
TF_VAR_crd_user=<user for the desktop login>
```