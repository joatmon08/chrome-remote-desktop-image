gcp-bootstrap:
	(cd gcp-account && terraform init)
	(cd gcp-account && terraform apply)
	@(cd gcp-account && terraform output private_key_file | base64 -D | gpg --batch --pinentry-mode loopback --command-fd 0 --passphrase ${PASSPHRASE} -d -- | base64 -D > ../packer-builder.json)

packer-build:
	cd packer && packer build -var commit_hash=${COMMIT_HASH} desktop.json

unit:
	go test ./test/unit/... -v

test: clean
	(cd vagrant && vagrant up)

clean:
	(cd vagrant && vagrant destroy --force)