# katsdp-ansible-nomad-jobs
Ansible role to deploy Nomad jobs

This role is associated with https://github.com/ska-sa/katsdp-ansible-collection

## Installation

Initially install by checking out the source and using make.
``
git clone https://github.com/ska-sa/katsdp-ansible-nomad-jobs.git
cd katsdp-ansible-nomad-jobs
make install
``

Also, see [requirements.yml|examples/requirements.yml].

## Usage

See [playbook.yml|examples/playbook.yml].
The role is only applied once per execution, if multiple Ansible targets are given it will only be run on the first suitable target.

### Variables
The following variables control the deployment. Job Sets have variables that can be set, see vars.yml in job set folders.

* nomad_server_enabled: This variable control if the job can run on a system. Default to false.
* *nomad_cluster_jobs_present: List of Job Sets to add to the cluster. Default to [].
* **nomad_job_deployment_path: Temporary working directory on server. Default to '/opt/nomad/deploy'.
* datacenter_name: The name of the Nomad datacenter. This field is used in the Nomad job specifications.

## Job Set
A job set is the configuration files to deploy jobs to Nomad.
A Job set consists out of different categories of files.
Each Job Set is a directory in the templates directory of this repository.

### Nomad Job Set files
Nomad job definition files as Ansible templates. These can be either HCL or JSON files.
The file must have the following pattern "nomad.****.hcl.j2" or "nomad.*.json.j2".
Each of these files will be loaded into Nomad. The command `nomad job run <filename>` will be called on each file.
Typically there will be one Nomad template per Job Set.

### Job Set variables file
Each Job Set can have a vars.yml, the variables in this file will be loaded by the Ansible role and be available to templates.
All the variables from the vars.yml file will be keys in a 'job_vars' object.

### Consul Key-Value store records
Files to be loaded into Consul Key-Value store. The value of the files will be available to Nomad jobs via Nomad-Consul templates or Nomad artefact requests.
Files with the pattern `consul.*` are copied to a Job Set path in Consul Key-Value store. The consul prefix is stripped from the filename.
Files with the pattern `consul.*.j2` are copied to a Job Set path in Consul Key-Value store after the file has been processed by Ansible template. The 'consul.' prefix and '.j2' suffix is stripped from the filename.

## Requirements
Nomad and Consul has to be installed and configured on the target server. At present the nomad and consul commands need to be in the PATH.
