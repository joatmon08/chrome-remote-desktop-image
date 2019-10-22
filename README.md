# chrome-remote-desktop-image

Image pipeline to bake a remote desktop environment
on Debian, uses Chrome Remote Desktop.

## Pre-Requisites

- Vagrant
- Packer
- `make gcp-bootstrap`: This command creates a GCP Service
  Account for image baking.

## Usage

For testing locally, run `make test`.