## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

(Diagrams/Azure Network Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the ansible file may be used to install only certain pieces of it, such as Filebeat.

  (Ansible/elk.yml)

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- Load balancing protects against DDoS attacks by distributing the load on the network to a web of vm's instead of a singular one.
- The jump box allows all access into an internal network to be controlled by one vm therefore making it easier to lock down an entire network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system traffic.
- Filebeat watches for logs and file changes in designated sections of the computer
- Metricbeat records a bunch of metrics about the underlying computer as well as services running on the computer

The configuration details of each machine may be found below.

| Name     | Function        | Ip Address | Operating System     |
|----------|-----------------|------------|----------------------|
| Jump-Box | Gateway/Ansible | 10.1.0.4   | Linux (Ubuntu 20.04) |
| Web-1    | DVWA            | 10.1.0.5   | Linux (Ubuntu 20.04) |
| Web-2    | DVWA            | 10.1.0.6   | Linux (Ubuntu 20.04) |
| Elk      | Elk             | 10.3.0.4   | Linux (Ubuntu 20.04) |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 99.225.110.201

Machines within the network can only be accessed by Jump-Box.
- 10.1.0.4

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | No                  | 99.225.110.201       |
| Web-1    | No                  | 10.1.0.4             |
| Web-2    | No                  | 10.1.0.4             |
| Elk      | No                  | 10.1.0.4             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- Replciation of this setup has been made incredibly easy and allows us to deploy it on multiple systems or networks with one command.

The playbook implements the following tasks:
- Install docker.io
- Install python3-pip
- Install the docker pip module
- Increase the virtual memory allowed
- Download and run the elk docker container
- Enable the docker service on start

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

(Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.1.0.5, 10.1.0.6

We have installed the following Beats on these machines:
- Filebeat and Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat will collect log files and monitor changes in them while metricbeat collects metrics from the computer and services

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-config.yml file to /etc/ansible/
- Update the filebeat-config.yml file to include the ip of the elk server in the elasticsearch and kibana section
- Run the playbook, and navigate to the elk server to check that the installation worked as expected.

Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?
- The playbook is called filebeat-playbook.yml and you copy it to your /etc/ansible/ folder
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- You need to update the hosts file which is in /etc/ansible/hosts, Here you place all the computers that you want to install filebeat onto in the [webserver] section and make a new section called [elk] with the ip of the vm you want elk installed on.
- _Which URL do you navigate to in order to check that the ELK server is running?
- You go to the public IP of the ELK server adding a :5601 to the end. In my case it is http://52.137.127.28:5601/

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._


- ssh RedAdmin@JumpBox(PrivateIP)
- sudo docker container list -a (locate your ansible container)
- sudo docker start container (name of the container)
- sudo docker attach container (name of the container)
- cd /etc/ansible/
- ansible-playbook elk.yml (configures Elk-Server and starts the Elk container on the Elk-Server) wait a couple minutes for the implementation of the Elk-Server
- cd /etc/ansible/roles/
- ansible-playbook filebeat-playbook.yml (installs Filebeat and Metricbeat)
- open a new web browser (Elk-Server PublicIP:5601) This will bring up the Kibana Web Portal

