# VPN

## Post-install:

The process is very simple linear. `ssh` into the machine, then:

### OpenVPN:

```bash
cd /etc/openvpn/easy-rsa/2.0/
cp openssl-1.0.0.cnf openssl.cnf
. /etc/openvpn/easy-rsa/2.0/vars
. /etc/openvpn/easy-rsa/2.0/clean-all
. /etc/openvpn/easy-rsa/2.0/build-ca
```

and complete the questions...

```bash
. /etc/openvpn/easy-rsa/2.0/build-key-server server
```

and complete the questions... (Challenge password and optional company can be left blank, acknowledge yes twice)

Now, for each client you wish to connect to the server (substitute <client_name>):

```bash
. /etc/openvpn/easy-rsa/2.0/build-key <client_name>
```

and complete the questions... (Challenge password and optional company can be left blank, acknowledge yes twice)

Now Generate Diffie-Hellman parameters:

```bash
. /etc/openvpn/easy-rsa/2.0/build-dh
```

And copy the files into place (1) on the server

```bash
cp /etc/openvpn/easy-rsa/2.0/keys/ca.crt /etc/openvpn
cp /etc/openvpn/easy-rsa/2.0/keys/ca.key /etc/openvpn
cp /etc/openvpn/easy-rsa/2.0/keys/dh1024.pem /etc/openvpn
cp /etc/openvpn/easy-rsa/2.0/keys/server.crt /etc/openvpn
cp /etc/openvpn/easy-rsa/2.0/keys/server.key /etc/openvpn
```

and (2) to the clients. For this: copy the client certificates (`ca.crt`, `<client_name>.crt` and `<client_name>.key`) from /etc/openvpn/easy-rsa/2.0/keys/ to the remote machines using scp or other means (substitute client_name)


### DnsMasq

Reconfigure resolvconf:

```bash
sudo dpkg-reconfigure resolvconf
```

and acknowledge yes twice

### Final

Now make sure that your `/etc/rc.local` file contains the following lines, so the vpn routing and dnsmasq are setup correctly upon reboot:

```bash
iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -s 10.8.0.0/24 -j ACCEPT
iptables -A FORWARD -j REJECT
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables -A INPUT -i tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -j ACCEPT
iptables -A INPUT -i tap+ -j ACCEPT
iptables -A FORWARD -i tap+ -j ACCEPT

/etc/init.d/dnsmasq restart
```

Finally: give both openvpn and dnsmasq a kick:

```bash
service openvpn restart
service dnsmasq restart
```


## Extra

### Creating an openvpn (.ovn) file to configure your iDevice

Below you can see the frame: Just fill in the required info

```bash
client

dev tun
proto udp
remote [TODO_server_ip] 1194

resolv-retry infinite
nobind

reneg-sec 3600

persist-key
persist-tun

verb 3

keepalive 10 1200
inactive 3600
comp-lzo

<ca>
-----BEGIN CERTIFICATE-----
...copy content from ca.crt...
-----END CERTIFICATE-----
</ca>
<cert>
-----BEGIN CERTIFICATE-----
...copy content from <client_name>.crt...
-----END CERTIFICATE-----
</cert>
<key>
-----BEGIN PRIVATE KEY-----
...copy content from <client_name>.key...
-----END PRIVATE KEY-----
</key>
```
