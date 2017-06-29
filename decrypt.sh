#!/bin/bash
echo "decrypted backup $1 to $2 with pass $3"
openssl aes-256-cbc -d -in $1 -out $2 -k $3
if [ ! -f $2 ]; then
  echo "decrypted failed"
else
  echo "decrypted successful save @ $2"
fi
