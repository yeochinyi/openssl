set OPENSSL_CONF=%CD%\openssl.cfg

set env=%1
set filename=target\%1\%1.%2
set password=%3

rem perl CA.pl -newreq
rem system ("$REQ -new -keyout newkey.pem -out newreq.pem $DAYS");

openssl req -new -keyout %filename%.key.pem -out %filename%.req.pem -passin pass:%password% -passout pass:%password% -subj /commonName=%filename%

rem perl CA.pl -sign
rem system ("$CA -policy policy_anything -out newcert.pem " . "-infiles newreq.pem");
openssl ca -policy policy_anything -out %filename%.cert.pem -infiles %filename%.req.pem

rem perl CA.pl -pkcs12
rem system ("$PKCS12 -in newcert.pem -inkey newkey.pem -certfile ${CATOP}/$CACERT -out newcert.p12 -export -name \"$cname\"");
openssl pkcs12 -in %filename%.cert.pem -inkey %filename%.key.pem -certfile %env%CA/cacert.pem -out %filename%.p12 -export -name \"%filename%\" -passin pass:%password% -passout pass:%password%

keytool -importkeystore -srckeystore %filename%.p12 -destkeystore %filename%.jks -srcstoretype PKCS12 -srcstorepass %password% -deststorepass %password% -v

keytool -list -v -keystore %filename%.jks -storepass %password%
