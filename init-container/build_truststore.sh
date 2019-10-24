#!/bin/bash

set -euo pipefail

function insert_cert {
    echo "${1}" | keytool -noprompt \
        -import \
        -trustcacerts \
        -alias "${2}" \
        -keystore $trust_store_file \
        -storepass changeit
}

COUNTER=1; OLDIFS=$IFS; IFS=';' blocks=$(sed -n '/-----BEGIN /,/-----END/ {/-----BEGIN / s/^/\;/; p}'  /etc/ssl/certs/ca-certificates.crt);
for block in ${blocks#;}; do
    insert_cert "$(echo $block)" "os-$COUNTER"
    COUNTER=$((COUNTER +1))
done; IFS=$OLDIFS

for cert in $uaa_ca_certs/*; do
    test -f "$cert" || continue
    insert_cert "$(cat $cert)" "$(basename $cert)"
done

chmod 0755 $trust_store_file
