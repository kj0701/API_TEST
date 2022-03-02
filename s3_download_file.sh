#!/bin/sh

./idpass.txt

dateValue=`date -R`
outputFile="s3test.txt"
amzFile="test.txt"
bucket="kj0701-test1"
resource="/${bucket}/${amzFile}"
contentType="application/x-compressed-tar"
stringToSign="GET\n\n${contentType}\n${dateValue}\n${resource}"

signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`

curl -X GET \
     -H "Host: ${bucket}.s3.amazonaws.com" \
     -H "Date:  ${dateValue}" \
	  -H "Content-Type: ${contentType}" \
	  -H "Authorization : AWS ${s3Key} : ${signature}" \
	   https://${bucket}.s3.amazonaws.com/${amzFile} -o $outputFile
