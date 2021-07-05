# Delete Old Downloads (DOD)

Delete Old Downloads, or DOD, is a script written in PowerShell to delete your old downloads after a pre-specified number of days. The default amount of days old a download must be to get deleted is 90 days, but it can be changed in the script to any number.

DOD also includes a feature that can send an email of what downloads were deleted in HTML format. You must edit the 'DOD.ps1' file to include a sending email address, the senders password, a receiving address, the SMTP server URL, and port number.

## Guides

[Windows 10: Setup DOD as a Scheduled Task](#Windows-10-Scheduled-Task-Setup)

### Windows 10 Scheduled Task Setup
![Opening task scheduler](../assets/test.png)

1. Find and launch the "Task Scheduler" program

![Selecting "Task Scheduler Library" folder](../assets/step2.png)

2. Select the "Task Scheduler Library" folder in the leftmost pane

![Creating a new subfolder for tasks](../assets/step3.png)

3. Select the "New Folder..." option in the rightmost pane and name the new folder whatever you would like

![Creating a new task](../assets/final.png)

4. Select "Create Task" in the rightmost pane. From here, follow [u/Martin9700's guide on creating a task](https://community.spiceworks.com/how_to/17736-run-powershell-scripts-from-task-scheduler)!