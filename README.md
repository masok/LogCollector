# LogCollector
**A Windows/Unix script to collect specific logs**

For work, I usually have to collect logs from a client
Asking the client to do this, usually ends up on logs missing, wrong logs being sent, etc. So I have to either tell them again what they need to send me, or just go in and grab it myself.
All of this is time that could be used to actually investigate the issue.

So I created a script for both Windows and Unix that grabs those logs in an easy way.

Note: Whoever uses these scripts will have to modify them to grab the desired logs, and I will be putting XXX instead of the name of the software I'm working with (just so that I don't get in trouble here)

Note: To better understand the options on the scripts, it would be good to point out that the software I'm working with has several components, a Desktop application, a Web application, Mobile application, and a statistics application as well.

## Windows script
(Run as Administrator)
When running the script, first we get to choose in which volume the software is installed.
After, we get a menu with the following options:

- 1 - Collects the Desktop logs, and also a file which has the installation history, to check what hotfixes have been applied
- 2 - Collects statistics logs
- 3 - Collects Web logs
- 4 - Collects Mobile logs
- 5 - Collects system information (OS, CPU, memory, installed programs, Windows hotfixes applied)
- 6 - Collects Windows Event Viewer (Application and System), filtered by error and warning messages, and saves it as a text file
- 7 - Collects all logs at once
- 8 - Exits the script


## Unix script
(Make sure you have the permission to run it, chmod 777 if you have any doubts)
When running the script, we get a menu with the following options:
- 1 - Collects the Desktop logs, and also a file which has the installation history, to check what hotfixes have been applied
- 2 - Collects statistics logs
- 3 - Collects system information (hostname, kernel, CPU info, memory)
- 4 - Runs a locate command to find the Web logs
- 5 - Runs a locate command to find the Mobile logs
- 6 - Collects information messages from the system (dmesg, messages, yum.log)
- 7 - Collects all logs at once
- 8 - Zips all the logs into a TechSuppLogs.zip file and exits the script


This was made just to make my work easier, but I'm sharing it just in case someone has a similar tasks and wants to make the job a little easier


masok
