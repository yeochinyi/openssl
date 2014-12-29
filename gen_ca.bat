set OPENSSL_CONF=%CD%\openssl.cfg

rem system ("$REQ -new -keyout "${CATOP}/private/$CAKEY -out ${CATOP}/$CAREQ");
rem system ("$CA -create_serial -out ${CATOP}/$CACERT $CADAYS -batch -keyfile ${CATOP}/private/$CAKEY -selfsign -extensions v3_ca -infiles ${CATOP}/$CAREQ ");

rm -Rf %1CA

mkdir %1CA\certs
mkdir %1CA\crl
mkdir %1CA\newcerts
mkdir %1CA\private
touch %1CA\index.txt
echo "01\n" >  %1CA\crlnumber
		
openssl req -new -keyout %1CA\private\cakey.pem -out %1CA\careq.pem -subj /commonName=%1.m-daq.com
openssl ca -create_serial -out %1CA\cacert.pem -batch -keyfile %1CA\private\cakey.pem -selfsign -extensions v3_ca -infiles %1CA\careq.pem 

mkdir target\%1

openssl x509 -outform der -in %1CA\cacert.pem -out target\%1\%1.cacert.cer