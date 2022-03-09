# Create PFX File from SSL Certificate

## Use openssl Commands

```bash
openssl pkcs12 -export -out domain.name.pfx -inkey domain.name.key -in domain.name.crt

# If you have a root CA and intermediate certs, then include them as well using multiple -in parameters.
openssl pkcs12 -export -out domain.name.pfx -inkey domain.name.key -in domain.name.crt -in intermediate.crt -in rootca.crt

# Convert .CRT file to Base64 encoded equivalent.
openssl x509 -inform der -in MYCERT.cer -out MYCERT.pem

####

# Working example as follows.
openssl pkcs12 -export -out test.mydomain.com.pfx -inkey test.mydomain.com.key -in test.mydomain.com.crt -in MyCertificateCAIntermediateCertificate.crt -in MyCertificateCARootCertificate.crt

openssl pkcs12 -export -out test.mydomain.com.pfx -inkey test.mydomain.com.key -in test.mydomain.com.cer -in MyCertificateCAIntermediateCertificate.crt -in MyCertificateCARootCertificate.cer -in MyCertificateCAIntermediateCertificate.cer

openssl pkcs12 -export -out test.mydomain.com.pfx -inkey test.mydomain.com.key -in test.mydomain.com.v2.crt -in intermedca.cer -in rootca.cer

openssl pkcs12 -export -out test.mydomain.com.pfx -inkey test.mydomain.com.key -in test.mydomain.com.crt -in qvsslq3.pem -in MyCertificateCARootCertificate.crt
```

----

Sources:

- <https://remotehub.blogspot.com/2021/02/how-to-create-pfx-certificate-with.html>
- <https://elgwhoppo.com/2013/04/18/combine-crt-and-key-files-into-a-pfx-with-openssl/>
- <https://antmedia.io/ssl-for-azure-app-gateway-for-scaling-azure-ant-media/>
