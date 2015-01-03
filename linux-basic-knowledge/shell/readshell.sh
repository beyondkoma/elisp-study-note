#! /bin/bash
# read-secret: input a secret passphrase

if read -t 10 -sp "Enter secret passphrase >" ; then
               echo - e "\nSecret passphrase = '$secret_pass'"
else
               echo -e "\nInput timed out"
	       exit 1
fi
	       
