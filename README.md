# discord-c2
Using Discord and curl for bidirectional c2 communication

A describtion on my blog:
https://pawelbruski.com/posts/2022-03-27---Discord-as-C2-server-with-a-Batch-beacon/

## Features
- Easy to use
- Using Discord as Command and Control server
- Bidirectional communication with C2
- Persistance using Schleuded tasks



## Defense
``` Kusto 
union DeviceNetworkEvents, DeviceProcessEvents 
| where RemoteUrl == "https://discord.com" or ProcessCommandLine contains "http://discord.com/api/webhooks"
| where InitiatingProcessVersionInfoOriginalFileName == "curl.exe" or ProcessVersionInfoOriginalFileName == "curl.exe" or InitiatingProcessCommandLine == "powershell.exe"
| sort by Timestamp desc
```
