Date: Wed, 24 Jan 2001 11:11:12 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: linuxppc-users@lists.linuxppc.org
cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Matrox and XFree86 4.0.2 update
Message-ID: <Pine.BSF.4.21.0101241035480.289-200000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-970582926-980361434=:289"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-970582926-980361434=:289
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.BSF.4.21.0101241037271.289@shell.unixbox.com>


I recently ran into an issue with the matroxfb driver and XFree86 4.0.2's
matrox driver.  Sometime in the past someone decided to use BE
register access in matroxfb for BE machines, while this is probably The
Right Way, it produces problems in X.  I can use BE register access
macro's in X but it was causing problems with the engine, perhaps some DMA
issue although the dma BE bits are on.

Anyhow, the small attatched patch is necessary along with my XFree86 4.0.2
rsync tree located at linuxppc.org::xfree86-pmac.

The patch removes the turning on of the BE PCI option register, and lets
matroxfb use LE register access for powerpc.


ani

--0-970582926-980361434=:289
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="matroxfb-x.patch"
Content-ID: <Pine.BSF.4.21.0101241037140.289@shell.unixbox.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="matroxfb-x.patch"
Content-Transfer-Encoding: BASE64

LS0tIG1hdHJveGZiLmMub3JpZwlXZWQgSmFuIDI0IDExOjUwOjQxIDIwMDEN
CisrKyBtYXRyb3hmYi5jCVdlZCBKYW4gMjQgMTE6NTU6MzQgMjAwMQ0KQEAg
LTE4MSw3ICsxODEsNyBAQA0KICNlbmRpZiANCiAjZW5kaWYNCiANCi0jaWYg
ZGVmaW5lZChfX2FscGhhX18pIHx8IGRlZmluZWQoX19tNjhrX18pDQorI2lm
IGRlZmluZWQoX19hbHBoYV9fKSB8fCBkZWZpbmVkKF9fbTY4a19fKSB8fCBk
ZWZpbmVkKF9fcG93ZXJwY19fKQ0KICNkZWZpbmUgUkVBRHhfV09SS1MNCiAj
ZGVmaW5lIE1FTUNQWVRPSU9fV09SS1MNCiAjZWxzZQ0KQEAgLTEwNDIsNyAr
MTA0MiwxMSBAQA0KICNkZWZpbmUgTV9PUE1PREVfMzJCUFAJKE1fT1BNT0RF
X0RNQV9MRSB8IE1fT1BNT0RFX0RJUl9MRSB8IE1fT1BNT0RFX0RNQV9CTElU
KQ0KICNlbHNlDQogI2lmZGVmIF9fQklHX0VORElBTg0KKyNpZiBkZWZpbmVk
IChfX3Bvd2VycGNfXykNCisjZGVmaW5lIE1YX09QVElPTl9CU1dBUAkJMHgw
MDAwMDAwMA0KKyNlbHNlDQogI2RlZmluZSBNWF9PUFRJT05fQlNXQVAJCTB4
ODAwMDAwMDANCisjZW5kaWYNCiANCiAjZGVmaW5lIE1fT1BNT0RFXzRCUFAJ
KE1fT1BNT0RFX0RNQV9MRSB8IE1fT1BNT0RFX0RJUl9MRSB8IE1fT1BNT0RF
X0RNQV9CTElUKQkvKiBUT0RPICovDQogI2RlZmluZSBNX09QTU9ERV84QlBQ
CShNX09QTU9ERV9ETUFfQkVfOEJQUCAgfCBNX09QTU9ERV9ESVJfQkVfOEJQ
UCAgfCBNX09QTU9ERV9ETUFfQkxJVCkNCg==
--0-970582926-980361434=:289--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
