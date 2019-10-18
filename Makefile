gcp-bootstrap:
	(cd gcp-account && terraform init)
	(cd gcp-account && terraform apply)
	@(cd gcp-account && terraform output private_key_file | base64 -D | gpg --batch --pinentry-mode loopback --command-fd 0 --passphrase ${PASSPHRASE} -d -- | base64 -D > ../packer-builder.json)

setup:
	mkdir -p workspace
	echo ${GCLOUD_SERVICE_KEY} > workspace/packer-builder.json

build:
	cd packer && packer build desktop.json

unit:
	go test ./test/unit/... -v

test: clean
	(cd vagrant && vagrant up)

clean:
	(cd vagrant && vagrant destroy --force)