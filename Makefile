
devinstall:
	# Assume default Ansible Galaxy path
	mkdir -p ~/.ansible/roles/katsdp-ansible-nomad-jobs
	cp -ru * ~/.ansible/roles/katsdp-ansible-nomad-jobs/.

install:
	ansible-galaxy role install git+file://${PWD} --force
