# chrome-remote-desktop-automation

Some automation to spin up a remote desktop development environment
anywhere, any time. Using code, of course.

## Pre-Requisites

- Terraform
- Terraform Cloud
- Vagrant
- Packer

## Usage

1. Add variables to `local.env`.
   ```
   export TF_VAR_pgp_key=
   export TF_VAR_project=
   export TF_VAR_region=
   export PASSPHRASE=
   
   export GCLOUD_ZONE=

   export TF_VAR_crd_code=
   export TF_VAR_crd_pin=
   export TF_VAR_image=
   export TF_VAR_crd_user=
   export TF_VAR_public_key_file=
   ```

1. Create a `backend.conf` file with TF Cloud
   organization and workspace.
   ```
   organization = "my-tf-org"
   workspaces {
     name = "my-workspace"
   }
   ```

1. Create the service account user.
   ```shell
   source local.env
   make gcp-bootstrap
   ```

1. Build the image.
   ```shell
   source local.env
   make packer-build
   ```

1. Update the variable file (`local.env`) with zone & image name.

1. Get the OAuth token for the remote desktop setup.
   - `make code-retrieve`
   - Click through the browser, copy the URL with the `code=` in it.
   - `make URL='<returned url>' code-parse`
   - Copy the output and add it to `local.env` under `TF_VAR_crd_code`.

1. Deploy.
   ```shell
   source local.env
   make desktop-build
   ```