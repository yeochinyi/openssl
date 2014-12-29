This project use openssl to generate self-signed CA and creates private key and certs for SSL authentication.

Openssl stores conf in the openssl.cfg and currently there is a limitation on the conf to dynamically set the environment.

When using / creating an environment you have to set the correct dir before running the scripts.

[ CA_default ]

#dir		= ./demoCA		# Where everything is kept
dir		= ./prdCA		# Where everything is kept
#dir		= ./uatCA		# Where everything is kept
#dir		= ./devCA		# Where everything is kept
#dir		= ./testCA		# Where everything is kept

There are 2 scripts:-

gen_ca.bat <env> -> generate a new ca i.e for dev, uat or prod

i.e gen_ca uat

gen_signed_keypairs.bat <env> <certname> <passphase> -> generate a new keypairs using the ca

i.e gen_signed_keypairs uat cert password

There is also an issue with dotnet clients with openssl generated server certs. Will need to add this.

# This is required for DotNet clients!!!
extendedKeyUsage = serverAuth


Setup
-------
1) install Openssl and add bin to the PATH
