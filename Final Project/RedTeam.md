# Red Team: Summary of Operations

## Table of Contents
- Exposed Services
- Critical Vulnerabilities
- Exploitation

### Exposed Services

Nmap scan results for each machine reveal the below services and OS details:

![Initial Nmap Scan](Images/InitialNmapScan.png "Nmap Scan")

This scan identifies the services below as potential points of entry:
- Target 1
  - Port 22: OpenSSH
  - Port 80: Apache web server
  - Port 111: rpcbind
  - Port 139: Samba smbd
  - Port 445: Samba smbd

_TODO: Fill out the list below. Include severity, and CVE numbers, if possible._



The following vulnerabilities were identified on each target:
- Target 1
  - List of
  - Critical
  - Vulnerabilities

### Exploitation
_TODO: Fill out the details below. Include screenshots where possible._

The Red Team was able to penetrate `Target 1` and retrieve the following confidential data:
- Target 1
  - `flag1`: flag1{b9bbcb33e11b80be759c4e844862482d}
    - **Exploit Used**
      - Metasploit ssh_login module using the usernames acquired from wpscan and a general password list
      - Hidden in service.html at /var/www/html
	  - grep -nr 'flag1' .
  - `flag2`: flag2{fc3fd58dcdad9ab23faca6e9a36e581c}
    - **Exploit Used**
      - Metasploit ssh_login module using the usernames acquired from wpscan and a general password list
	  - Hidden in /var/www/flag2.txt
      - find / -iname '*flag*' -type f
  - `flag3`: flag3{afc01ab56b50591e7dccf93122770cd2}
    - **Exploit Used**
      - Found the MySQL password in wp-config.php
	  - Searched the posts in wp_posts for flag
      - select post_content from wp_posts where post_content like '%flag%';
  - `flag4`: flag4{715dea6c055b9fe3337544932f2941ce}
    - **Exploit Used**
      - Logged into Steven after cracking the password hash from mysql
	  - escalated to root using sudo python -c 'import pty; pty.spawn("/bin/sh")'
      - find / -iname '*flag*' -type f
	  
	  
	  
steven:pink84
michael:michael
mysql
	root:R@v3nSecurity
