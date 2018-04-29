# memory_check
SE Exercise | scripting using BASH 

Usage example:
mem-check (-c|--critical) char (-w|--warning) char (-e|--email) char
Options:
-c or --critical char: Threshold. Required.
-w or --warning char: Threshold. Required.
-e or --email char: Email. Required.

Note: If you want to test if it is working. kindly lower the value of the threshold on the script to the current memory usage of your machine

"if [[ "$used" -gt XXX || "$used" -eq XXX ]]; then ###90% or 100% of 1024"

This script by default will send notification to my email which is defined on the script.

###declared mail variables
subject="Memory check - Critical"
from="edmundnavarrojr@gmail.com"
to="edmundnavarrojr@ymail.com"
also_to="edmundnavarrojr@ymail.com"


# You also need to have mailx and append the below configuration
# sudo vim /etc/mail.rc

set smtp-use-starttls
set ssl-verify=ignore
set smtp-auth=login
set smtp=smtp://smtp.gmail.com:587 #<gmail smtp host and port>
set smtp-auth-user=edmundnavarrojr@gmail.com #<gmail acount user email>
set smtp-auth-password= xxxxxxxx #<your gmail PW>
set ssl-verify=ignore
set nss-config-dir=~/.certs edmundnavarrojr@ymail.com #<recipient>


# Make sure you have google cert imported

# If you dont have mailx - install it
yum install mailx -y
 
# Creating folder for certificates and downloading Google cert inside
mkdir ~/.certs
certutil -N -d ~/.certs
echo -n | openssl s_client -connect smtp.gmail.com:465 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ~/.certs/gmail.crt
certutil -A -n "Google Internet Authority" -t "C,," -d ~/.certs -i ~/.certs/gmail.crt
 
# Sending od test email
echo -e "Sadrzaj emaila" | mailx -v -s "Email subject" -S smtp-use-starttls -S ssl-verify=ignore -S smtp-auth=login -S smtp=smtp://smtp.gmail.com:587 -S from="tvoj-email@gmail.com(Ime Prezime)" -S smtp-auth-user=tvoj-email@gmail.com -S smtp-auth-password=lozinka-za-gmail -S ssl-verify=ignore -S nss-config-dir=~/.certs tvoj-drugi-neki-nalog@gdegod.com
 
# Creating a alias for easier email sending
vi ~/.bash_profile
# Put this two lines on bottom of .bash_profile
alias mailx='mailx -S smtp-use-starttls -S ssl-verify=ignore -S smtp-auth=login -S smtp=smtp://smtp.gmail.com:587 -S from="tvoj-email@gmail.com(Ime Prezime)" -S smtp-auth-user=tvoj-email@gmail.com -S smtp-auth-password=lozinka-za-gmail -S ssl-verify=ignore -S nss-config-dir=~/.certs'
alias mail=mailx
# Make alias permanent
. ~/.bash_profile
 
# Testing of email send with simplified command
echo "Tekst poruke" | mail -s "Test email" tvoj-drugi-neki-nalog@gdegod.com

Reff:

https://kompjuteras.com/en/how-to-send-email-with-mailx-and-external-google-smtp-server-from-centos-linux/
