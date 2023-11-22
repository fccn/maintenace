# Temporary maintenance page

This repository allows you to configure any maintenance page for any server.

By default it has configuration for any domain that ends with `nau.edu.pt` or `fccn.pt`.

Add the certificates to the certs folder, with the key of the certificate needs to have a `.key` suffix:
- certificate 1: `www.pem`
- key for certificate 1: `www.pem.key`

## Test commands

```bash
curl -v --resolve www.nau.edu.pt:443:127.0.0.1 --resolve nau.edu.pt:443:127.0.0.1 --resolve lms.nau.edu.pt:443:127.0.0.1 https://lms.nau.edu.pt/AA
```

```bash
curl -v --resolve educast.fccn.pt:80:127.0.0.1 http://educast.fccn.pt/AA
```

## Troubleshooting

Sometimes the HAProxy doesn't load the new configuration right away if you have changed the files.
On that occasion just restart it again.
