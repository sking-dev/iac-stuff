#!/bin/bash

# This script removes the password from a single .PFX file.
# TODO: Consider adapting it to work on multiple files (versus one file at a time)

echo "Starting bash script to remove the password from a .PFX file."

# Dynamic variables (supply the values for these)
YourPKCSFile=my-pfx-file.pfx
PASSWORD=MySuperStrongPassw0rd!

# Static variable (no need to change this)
TemporaryPassword=12345678912345

# Step 1 of 7 (public certificate)
openssl pkcs12 -clcerts -nokeys -in $YourPKCSFile -out certificate.crt -password pass:$PASSWORD -passin pass:$PASSWORD

# Step 2 of 7 (CA key)
openssl pkcs12 -cacerts -nokeys -in $YourPKCSFile -out ca-cert.ca -password pass:$PASSWORD -passin pass:$PASSWORD

# Step 3 of 7 (private key)
openssl pkcs12 -nocerts -in $YourPKCSFile -out private.key -password pass:$PASSWORD -passin pass:$PASSWORD -passout pass:$TemporaryPassword

# Step 4 of 7 (remove passphrase)
openssl rsa -in private.key -out "NewKeyFile.key" -passin pass:$TemporaryPassword

# Step 5 of 7 (put things together for new PKCS file)
cat "NewKeyFile.key" > PEM.pem
cat "certificate.crt" >> PEM.pem
cat "ca-cert.ca" >> PEM.pem

# Step 6 of 7 (create new .PFX file)
openssl pkcs12 -export -nodes -CAfile ca-cert.ca -in PEM.pem -out $YourPKCSFile".nopass.pfx"

# Step 7 of 7 (clean up temporary files)
rm NewKeyFile.key ca-cert.ca certificate.crt private.key PEM.pem

echo "Completed bash script."
