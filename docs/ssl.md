# SSL certificates

For all/most SSL certificates, you will be required to provide the following information:

```bash
Country Name (2 letter code) []:
State or Province Name (full name) [Some-State]:
Locality Name (eg, city) []:
Organization Name (eg, company) []:
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:
Email Address []:
```

The most important one is the common name; this should contain your domain name. If you want to use it as a wildcard, enter *.your.domain as common name.



## Self-signed wildcard


#### 1. Create the Server Key and Certificate Signing Request

First create a private key. You will be prompted to enter a keyphrase. Make sure to remember it, or you won't be able to access this certificate

```bash
sudo openssl genrsa -des3 -out server.key 2048
```

And proceed by creating a certificate signing request, providing the variables mentioned earlier.

```bash
sudo openssl req -new -key server.key -out server.csr
```

#### 2. Remove the password

Even though the passphrase positively enhances the security, keeping it may generate issues when you try to reload the webserver (it will prompt you to enter the passphrase, which is unwanted in case the webserver crashes, reboots, ..., before it goes back online).

```bash
sudo cp server.key server.key.org
sudo openssl rsa -in server.key.org -out server.key
```

#### 3. Sign the SSL certificate

Now let's sign it. The line below will make it expire after 3650 days (10 year). Adapt as you see fit.

```bash
sudo openssl x509 -req -days 3650 -in server.csr -signkey server.key -out server.crt
```

#### 4. Copy the certificates

In our case, you want them to be in roles/ssl/files/wildcard. You need the content of both the private key (server.key) and the certificate (server.crt). Easiest way:

```bash
cat server.crt
cat server.key
```

and copy-paste the contents to the respective files.
