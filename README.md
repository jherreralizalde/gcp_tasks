# gcp_tasks
Info about RD GCP 4
Prerequisites:
Install gclod SDK
install a Linux WSL with gcloud
conect to your proyect in the case of use wsl
Install terraform

Code:
Its a Terraform script that made teh following steps:
1. select the project, zone and region to work on.
2. create a network named "new-network"
3. create a private subnet with the range 10.0.1.0/24, and a public subnet with the range 192.168.20.0/24.
4. Create a fw rule named test-firewall, allowing icmp, tco ports: 22, 80, 8080, 1000-2000 and the range 35.235.240.0/20
5. Create a ubuntu 20.04 instance named terraform-instance-ubuntu, type e2-standard-2 in the zone us-centrak1-a
6. run an startup script named startup.sh who update ubuntu, install aptitude anda apache 2

Goals:
Create and see a Ubuntu VM
Create a network and subnetwort for the instance
Can acces with ssh port 22 to the instance usince the fw rule
Check that the startuip script works

Limitations
Trial GCP account
the service account can only create VMs
