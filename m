Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id F01A267FBD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 06:18:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C5A81F.D7665E33"
Date: Tue, 23 Aug 2005 15:18:36 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859437@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix baseaddress for SMC 1 and 2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A81F.D7665E33
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Base addess register for SMC 1 and 2 are never initialized.=20
This means that they will not work unless a bootloader already
configured them.
The DPRAM already have space reserved, this patch just makes sure=20
the base addess register is updated correctly on initialization.

Signed-off-by: Rune Torgersen <runet@innovsys.com>


------_=_NextPart_001_01C5A81F.D7665E33
Content-Type: application/octet-stream;
	name="smc_baseparam.patch"
Content-Transfer-Encoding: base64
Content-Description: smc_baseparam.patch
Content-Disposition: attachment;
	filename="smc_baseparam.patch"

LS0tIGxpbnV4L2RyaXZlcnMvc2VyaWFsL2NwbV91YXJ0L2NwbV91YXJ0X2NwbTIuYwkyMDA1LTA4
LTIzIDA5OjAxOjM3LjAwMDAwMDAwMCAtMDUwMAorKysgbGludXgtaW5uc3lzL2RyaXZlcnMvc2Vy
aWFsL2NwbV91YXJ0L2NwbV91YXJ0X2NwbTIuYwkyMDA1LTA4LTIzIDE1OjExOjE0LjAwMDAwMDAw
MCAtMDUwMApAQCAtMjU3LDYgKzI1Nyw3IEBAIGludCBjcG1fdWFydF9pbml0X3BvcnRkZXNjKHZv
aWQpCiAJY3BtX3VhcnRfcG9ydHNbVUFSVF9TTUMxXS5zbWNwID0gKHNtY190ICopICYgY3BtMl9p
bW1yLT5pbV9zbWNbMF07CiAJY3BtX3VhcnRfcG9ydHNbVUFSVF9TTUMxXS5zbWN1cCA9CiAJICAg
IChzbWNfdWFydF90ICopICYgY3BtMl9pbW1yLT5pbV9kcHJhbWJhc2VbUFJPRkZfU01DMV07CisJ
Kih1c2hvcnQgKikoJmNwbTJfaW1tci0+aW1fZHByYW1iYXNlW1BST0ZGX1NNQzFfQkFTRV0pID0g
UFJPRkZfU01DMTsKIAljcG1fdWFydF9wb3J0c1tVQVJUX1NNQzFdLnBvcnQubWFwYmFzZSA9CiAJ
ICAgICh1bnNpZ25lZCBsb25nKSZjcG0yX2ltbXItPmltX3NtY1swXTsKIAljcG1fdWFydF9wb3J0
c1tVQVJUX1NNQzFdLnNtY3AtPnNtY19zbWNtIHw9IChTTUNNX1JYIHwgU01DTV9UWCk7CkBAIC0y
NjksNiArMjcwLDcgQEAgaW50IGNwbV91YXJ0X2luaXRfcG9ydGRlc2Modm9pZCkKIAljcG1fdWFy
dF9wb3J0c1tVQVJUX1NNQzJdLnNtY3AgPSAoc21jX3QgKikgJiBjcG0yX2ltbXItPmltX3NtY1sx
XTsKIAljcG1fdWFydF9wb3J0c1tVQVJUX1NNQzJdLnNtY3VwID0KIAkgICAgKHNtY191YXJ0X3Qg
KikgJiBjcG0yX2ltbXItPmltX2RwcmFtYmFzZVtQUk9GRl9TTUMyXTsKKwkqKHVzaG9ydCAqKSgm
Y3BtMl9pbW1yLT5pbV9kcHJhbWJhc2VbUFJPRkZfU01DMl9CQVNFXSkgPSBQUk9GRl9TTUMyOwog
CWNwbV91YXJ0X3BvcnRzW1VBUlRfU01DMl0ucG9ydC5tYXBiYXNlID0KIAkgICAgKHVuc2lnbmVk
IGxvbmcpJmNwbTJfaW1tci0+aW1fc21jWzFdOwogCWNwbV91YXJ0X3BvcnRzW1VBUlRfU01DMl0u
c21jcC0+c21jX3NtY20gfD0gKFNNQ01fUlggfCBTTUNNX1RYKTsK

------_=_NextPart_001_01C5A81F.D7665E33--
