# Blue Team: Summary of Operations

## Table of Contents
- Network Topology
- Description of Targets
- Monitoring the Targets
- Patterns of Traffic & Behavior
- Suggestions for Going Further

### Network Topology

The following machines were identified on the network:
- Kali
  - **Operating System**: Kali Linux
  - **Purpose**: Penetration Testing Machine
  - **IP Address**: 192.168.1.90
- ELK
  - **Operating System**:
  - **Purpose**: The ELK stack monitoring the targets
  - **IP Address**: 192.168.1.100
- Capstone
  - **Operating System**:
  - **Purpose**: Testing alerts
  - **IP Address**: 192.168.1.105
- Target 1
  - **Operating System**: Linux 3.2 - 4.9
  - **Purpose**: The first target to exploit
  - **IP Address**: 192.168.1.110
- Target 2
  - **Operating System**: Linux 3.2 - 4.9
  - **Purpose**: An optional target to exploit
  - **IP Address**: 192.168.1.115

### Description of Targets

The target of this attack was: `Target 1` (192.168.1.110).

Target 1 is an Apache web server and has SSH enabled, so ports 80 and 22 are possible ports of entry for attackers. As such, the following alerts have been implemented:

### Monitoring the Targets

Traffic to these services should be carefully monitored. To this end, we have implemented the alerts below:

#### Excessive HTTP Errors
`WHEN count() GROUPED OVER top 5 'http.response.status_code' IS ABOVE 400 FOR THE LAST 5 minutes`

Alert 1 is implemented as follows:
  - **Metric**: WHEN count() GROUPED OVER top 5 'http.response.status_code'
  - **Threshold**: IS ABOVE 400
  - **Vulnerability Mitigated**: Brute Force
  - **Reliability**: Since it only counts error responces it should never fire under normal circumstances unless there is an attack ongoing against the system making it a high reliability alert.

#### HTTP Request Size Monitor
`WHEN sum() of http.request.bytes OVER all documents IS ABOVE 3500 FOR THE LAST 1 minute`

Alert 2 is implemented as follows:
  - **Metric**: WHEN sum() of http.request.bytes OVER all documents
  - **Threshold**: IS ABOVE 3500
  - **Vulnerability Mitigated**: Prevents code injection being sent over HTTP header
  - **Reliability**: There could be a legitimate reason for the HTTP request header to be extra large althought it would be under rare circumstance so this is a medium reliability alert

#### CPU Usage Monitor
`WHEN max() OF system.process.cpu.total.pct OVER all documents IS ABOVE 0.5 FOR THE LAST 5 minutes`

Alert 3 is implemented as follows:
  - **Metric**: WHEN max() OF system.process.cpu.total.pct OVER all documents
  - **Threshold**: IS ABOVE 0.5
  - **Vulnerability Mitigated**: Any attack that targets overloading system resources
  - **Reliability**: This is a high reliability alert because even if it is triggered when there is no attack happening it should still be investigated

### Suggestions for Going Further (Optional)

- The logs and alerts generated during the assessment suggest that this network is susceptible to several active threats, identified by the alerts above. In addition to watching for occurrences of such threats, the network should be hardened against them. The Blue Team suggests that IT implement the fixes below to protect the network:

- Vulnerability 1: Excessive HTTP Errors
  - **Patch**: 
    - Disable pretty permalinks in Wordpress
    - Have users set a nickname for themselves that is different from their username
    - Enforce a password policy of minimum 12 characters and encourage the use of random passwords and password managers
  - **Why It Works**:
    - Pretty permalinks is how WPScan is able to find the usernames in it's enumeration scan so disabling it will make it harder for it to find usernames
    - When WPScan can't use permalinks it will scan for posts made by usernames but if you set a nickname for every account that is different from the username than WPScan can't find the proper usernames
    - If WPScan finds the usernames and is running a bruteforce attack against the system than ensuring that the passwords are not ones that are found on common password lists is imperative
- Vulnerability 2: HTTP Request Size Monitor
  - **Patch**:
    - Set a maximum length to certain HTTP tags in the header such as the length of a query
  - **Why It Works**:
    - Setting a max length will help to ensure that Cross Site Scripting isn't happening on your site
- Vulnerability 3: CPU Usage Monitor
  - **Patch**:
    - Disable XML RPC for Wordpress
    - Disable the REST API for Wordpress
    - Implementing a Wordpress security plugin such as Sucuri
  - **Why It Works**:
    - XML RPC allows 3rd party apps to interact with your Wordpress site and can be a vector for a DDOS attack
    - The REST API lets you interact with Wordpress data such as posting or deleting content on the site, this can also be used as a vector for a DDOS attack
    - Adding a security plugin such as Sucuri will allow you to add a website firewall to the Wordpress site