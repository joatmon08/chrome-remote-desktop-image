packer-test:
	(cd packer && vagrant up)

gcp-bootstrap:
	(cd gcp && terraform init -backend-config backend.conf)
	(cd gcp && terraform apply)
	@(cd gcp && terraform output private_key_file | base64 -D | gpg --batch --pinentry-mode loopback --command-fd 0 --passphrase ${PASSPHRASE} -d -- | base64 -D > ../packer-builder.json)

clean:
	(cd packer && vagrant destroy --force)