# nginx-site-manager
Simple bash script to manage NGINX virtual hosts

# Usage
Script must be placed in same folder as /sites-available/ and /sites-enabled/, usually /etc/nginx/.
```
mngx ls|enable <file>|disable <file>|help
```
 **ls** - List the available sites and mark if they are enabled.  
 **enable *\<file>*** - Enable the specified site  
 **disable *\<file>*** - Disable the specified site  
 **help** - Get usage information
