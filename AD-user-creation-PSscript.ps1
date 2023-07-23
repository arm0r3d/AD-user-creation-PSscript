# This powershell script is a part of SoftUni Windows System Administration - june 2023 Module-7 Homework Task-1.
# Author: Panayot Petrov
# This script create AD user and user folder in C:\Shared\ and was done with Do-Until construction. 
# Nested if-else and do-unitl constructions was used for better interaction.
# The script file can be executed from any folder.
# GitHub repo : https://github.com/arm0r3d/AD-user-creation-PSscript.git
# WARNING!
# If you use different than WSA.LAB AD Domain: line 31 of script need to be comment/disabled and line 36 and 37 need to be enabled/uncomment.
#
# Begin of root Do-Until construction
#
Do {
#
# Creating/Reseting variable for next script interactions
#
$continue = $false
#
# Input AD User Credentials
#
$FirstName = Read-Host -Prompt "Please enter your First Name"
$LastName = Read-Host -Prompt "Please enter your Last Name"
$Password = Read-Host -Prompt "Please enter your Password"
#
# Convert Name inputs to lower case letters
#
$FirstNameLow = ("$FirstName").ToLower() 
$LastNameLow = ("$LastName").ToLower() 
#
# Creating AD user 
#
New-ADUser "$FirstName.$LastName" -GivenName "$FirstName" -Surname "$LastName" -SamAccountName "$FirstNameLow.$LastNameLow" -UserPrincipalName "$FirstNameLow.$LastNameLow@wsa.lab" -AccountPassword (ConvertTo-SecureString -AsPlainText "$Password" -Force) -Enabled $true
#
# WARNING!
# Next 2 line of script to be used only in differrent AD Domain /NOT IN WSA.LAB/. Line 31 of script need to be comment/disabled. Line 36 and 37 need to be enabled/uncomment.
#
# $MyDomain = Read-Host -Prompt "Please enter your AD Domain"
# New-ADUser "$FirstName.$LastName" -GivenName "$FirstName" -Surname "$LastName" -SamAccountName "$FirstNameLow.$LastNameLow" -UserPrincipalName "$FirstNameLow.$LastNameLow@$MyDomain" -AccountPassword (ConvertTo-SecureString -AsPlainText "$Password" -Force) -Enabled $true
#
Write-Host " "
Write-Host "-------------------------------------------"
Write-Host "AD user $FirstNameLow.$LastNameLow was created..."
Write-Host "-------------------------------------------"
Write-Host " "
#
# Creating user folder in C:\Shared
#
New-Item -Path "C:\Shared\$FirstNameLow.$LastNameLow" -Type Directory -ErrorAction SilentlyContinue
Write-Host " "
Write-Host "-------------------------------------------"
Write-Host "Folder with name $FirstNameLow.$LastNameLow was created..."
Write-Host "-------------------------------------------"
Write-Host " "
#
# Promting for another AD user creation
#
Do {
Write-Host " "
#
# Check for proper promt (Y or N) input
#
$AnotherCreation = Read-Host -Prompt "Do you want to create another AD user or no (Y/N)?"
#
# If input promt was proper script continue next interaction
#
if (($AnotherCreation -EQ "Y") -or ($AnotherCreation -EQ "N")){
$continue = $true
}
#
# If input promt was NOT proper script ask for another Y or N input.
#
else {
Write-Host " "
Write-Host "--------------------------------"
Write-Host "Wrong input! Please try again..."
Write-Host "--------------------------------"
Write-Host " "
}
}
#
# End of nested Do-Until Construction 
#
until ($continue)
#
# Beginning next interaction if answer was Y
#
if ($AnotherCreation -EQ "Y"){
Write-Host " "
Write-Host "-------------------------------------------"
Write-Host "Starting another AD user creation..."
Write-Host "-------------------------------------------"
Write-Host " "
}
#
# Ending interaction if answer was N
#
else {
Write-Host " "
Write-Host "-------------------"
Write-Host "All tasks was done!"
Write-Host "-------------------"
}
}
#
# End of root Do-Until Construction
#
Until ($AnotherCreation -EQ "N")
#
# End of script