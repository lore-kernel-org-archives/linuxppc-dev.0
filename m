Message-ID: <023EF71CB65AA949A2C510353690C86B027E7B@rokonet-e.rokonet.co.il>
From: Eli Brin <eli.brin@rokonet.co.il>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ELDK 3.0 krb-5
Date: Thu, 26 Feb 2004 15:08:22 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Dear Wolfgang, congratulations on the ELDK 3.0.

I recommend to install the krb5 lib directory in ppc_8xx/lib or
ppc_8xx/usr/lib and the krb5 include directory in the ppc_8xx/usr/include,
as openssl.

This will eliminate the use of: ld -rpath when building as application that
uses openssl.

Thank you,

Eli Brin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
