Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <75DF04AC5ED4D511A9810090273CB41661519B@ROKONET-E>
From: Eli Brin <elib@rokonet.co.il>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: openssl
Date: Wed, 12 Mar 2003 18:11:54 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

We are working with ELDK 2.0.2, target - TQM860L

We are trying to work with openssl, and we have the following problems:

1.  Trying to create a certificate using the CA script gives us the
following error:
>sh-2.05$ ./CA -newca
>CA certificate filename (or enter to create)

>Making CA certificate ...
>Using configuration from /usr/share/ssl/openssl.cnf
>unable to load 'random state'
>This means that the random number generator has not been seeded
>with much random data.
>Generating a 1024 bit RSA private key
>403:error:24064064:random number generator:SSLEAY_RAND_BYTES:PRNG not
seeded:md_
>rand.c:492:You need to read the OpenSSL FAQ,
http://www.openssl.org/support/faq.

We don't have the /dev/random and /dev/urandom. How do we create them -
mknod?


2.  Using pem files created on a Redhat Linux machine gives us an error on
the function:
ssl_ctx_use_certificate_chain_file.

Should we create the pem files on our target or those created with Redhat
are OK?


Our application works OK with openssl on RH8.0 and RH7.3.

Has anyone worked successfully with openssl on  ppc_8xx?

Thank you,
Eli Brin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
