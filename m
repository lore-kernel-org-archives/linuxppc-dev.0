Message-ID: <39B0D6D7.DE13ABA9@pop.agri.ch>
Date: Sat, 02 Sep 2000 12:30:47 +0200
From: Andreas Tobler <toa@pop.agri.ch>
MIME-Version: 1.0
To: Bernhard Reiter <bernhard@intevation.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: pppd modem problem (2.4.0-test7 lombard)
References: <20000902121218.B16589@cheops.usf.Uni-Osnabrueck.DE>
Content-Type: multipart/mixed;
 boundary="------------ACD0761308EAF45213621C65"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------ACD0761308EAF45213621C65
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bernhard Reiter wrote:

> I am using pppd 2.3.10 and

[snip]

> I also have the problem that after that sometimes, the ttS0 port cannot
> be opened anymore.
>
> Am I missing something obvious here?

May an update to pppd-2.4.0 would be an idea. I run here almost the latest dev
kernels on my wallstreet and I have no problems using pppd with ttyS0.

The pkg you'll find here: ftp://linuxcare.com.au/pub/ppp/
It is a tar.gz, if you prefer an rpm then I attach the spec file. With this spec
file and the source you can build your own rpm with rpm -ba file.spec (-ba
stands for binary, all. The binary rpm and the src.rpm will be built. This has
to be done in the appropriate place)

If the spec is ok?? Don't know for me it works.

Good luck

Andreas
--------------ACD0761308EAF45213621C65
Content-Type: application/x-gzip;
 name="ppp.spec.gz"
Content-Disposition: inline;
 filename="ppp.spec.gz"
Content-Transfer-Encoding: base64

H4sICHSljjkAA3BwcC5zcGVjAHVSyW7bMBC98yvmUN0aqS16CAz04A2G0HiBnORq0ORYJkyR
LJe2adF/71BeEMTOgaDmzZt5bzhap67j/mUAzjmQHDtrwHFx4C3CznrQyqTfbME77CnsGX1Q
1gzgS/m1/MQa1MgD5T5zNrbuxat2HwcgVYhebVPkW41s5m1yA1hg/GX9QZm2mvRCga1t8oKq
exXBPZbCdiVPg8qlbUV6+dwVf1fD8ffhbLp5njbrern4V0buy/YPGyWlZWMtSVax69mMFRKD
8MpF8ske9wir1eo82p4bqTFAJFhi5EoHsDsIGCP5guSA93QydABlhE6ScCas2ak2+czJpeY4
CjEi+h0XCNQXHH1b351JuY/B1kbFs5VQsjqCxx9JeXJw1JFe/URPffqKA3qD+iOgosgDvYVT
GmVO51VYLlEynms7K5PGkoZ1Hh0raADyzoptfhBWVmfDyDp+QKIpEyLXug/hFMCoXkzq5tuH
ZjXfjJ7qh8mmWS4fqxR8FbYkOh++m++4genj+FYaozgtYkfuA+3DCmimw8l8errKft9w3FKA
1cPTrF6s2UW4Ense2Vknn/seKu9fcUhCvuFk6C2HJo3hmtfDV/1S5260JJSYhVQeLsMVxxe+
ANmfuwsoPJLcVdb2f+ONhHtV9R/6XwiWjAMAAA==
--------------ACD0761308EAF45213621C65--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
