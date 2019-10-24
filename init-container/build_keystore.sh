#!/bin/bash

set -euo pipefail
openssl pkcs12 -export -name uaa_ssl_cert -inkey $keyfile -in $crtfile -out $keystore_pkcs12 -password pass:$password
