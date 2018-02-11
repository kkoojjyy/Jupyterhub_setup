#!/bin/bash

# Revoke the previous SSL cert
# check https://certbot.eff.org/docs/using.html#revoking-certificates
certbot revoke --cert-path /etc/letsencrypt/uicquant.com/CERTNAME/cert.pem
certbot delete --cert-name uicquant.com

#Regenerate SSL cert in new server
sudo certbot certonly --standalone -d uicquant.com -d www.uicquant.com

#Test for SSL renew
sudo certbot renew --dry-run

#SSL renew
certbot renew

# Jupyter config
#c.JupyterHub.ssl_cert = '/etc/letsencrypt/live/url/fullchain.pem'
#c.JupyterHub.ssl_key = '/etc/letsencrypt/live/url/privkey.pem'
#c.JupyterHub.port = 443
/etc/letsencrypt/live/uicquant.com/fullchain.pem
/etc/letsencrypt/live/uicquant.com/privkey.pem
certbot certonly --standalone -d uicquant.com -d www.uicquant.com