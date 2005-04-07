Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 5855067A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 05:22:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C53BA7.1C51A8E4"
Date: Thu, 7 Apr 2005 14:22:17 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859341@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] FCC Ethernet startup crash
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

------_=_NextPart_001_01C53BA7.1C51A8E4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch fizxes a race condition in the FCC ethernet driver, where the
ethernet driver starts to receive packets before the IP layer is
initialized.

This pathch is originally from Stefan Nickl <Stefan.Nickl@kontron.com>
for the linuxppc2.4 three, redone for 2.6 and tested.

Signed-off-by: Rune Torgersen <runet@innovsys.com>


Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com

------_=_NextPart_001_01C53BA7.1C51A8E4
Content-Type: application/octet-stream;
	name="fcc_enet_startup_crash.patch"
Content-Transfer-Encoding: base64
Content-Description: fcc_enet_startup_crash.patch
Content-Disposition: attachment;
	filename="fcc_enet_startup_crash.patch"

PT09PT0gYXJjaC9wcGMvODI2MF9pby9mY2NfZW5ldC5jIDEuMjQgdnMgZWRpdGVkID09PT09Ci0t
LSAxLjI0L2FyY2gvcHBjLzgyNjBfaW8vZmNjX2VuZXQuYwkyMDA1LTAzLTE4IDE0OjUxOjMxIC0w
NjowMAorKysgZWRpdGVkL2FyY2gvcHBjLzgyNjBfaW8vZmNjX2VuZXQuYwkyMDA1LTA0LTA3IDE0
OjEzOjMxIC0wNTowMApAQCAtMjE1OCwxNiArMjE1OCw2IEBACiAJKih2b2xhdGlsZSB1aW50ICop
KEJDU1JfQUREUiArIDEyKSAmPSB+QkNTUjNfRkVUSElFTjI7CiAJKih2b2xhdGlsZSB1aW50ICop
KEJDU1JfQUREUiArIDEyKSB8PSAgQkNTUjNfRkVUSDJfUlNUOwogI2VuZGlmCi0KLSNpZiBkZWZp
bmVkKENPTkZJR19VU0VfTURJTykgfHwgZGVmaW5lZChDT05GSUdfVFFNODI2MCkKLQkvKiBzdGFy
dCBpbiBmdWxsIGR1cGxleCBtb2RlLCBhbmQgbmVnb3RpYXRlIHNwZWVkCi0JICovCi0JZmNjX3Jl
c3RhcnQgKGRldiwgMSk7Ci0jZWxzZQotCS8qIHN0YXJ0IGluIGhhbGYgZHVwbGV4IG1vZGUKLQkg
Ki8KLQlmY2NfcmVzdGFydCAoZGV2LCAwKTsKLSNlbmRpZgogfQogCiAjaWZkZWYJQ09ORklHX1VT
RV9NRElPCkBAIC0yMzY3LDYgKzIzNTcsMTYgQEAKIGZjY19lbmV0X29wZW4oc3RydWN0IG5ldF9k
ZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3QgZmNjX2VuZXRfcHJpdmF0ZSAqZmVwID0gZGV2LT5wcml2
OworCisjaWYgZGVmaW5lZChDT05GSUdfVVNFX01ESU8pIHx8IGRlZmluZWQoQ09ORklHX1RRTTgy
NjApCisJLyogc3RhcnQgaW4gZnVsbCBkdXBsZXggbW9kZSwgYW5kIG5lZ290aWF0ZSBzcGVlZAor
CSAqLworCWZjY19yZXN0YXJ0IChkZXYsIDEpOworI2Vsc2UKKwkvKiBzdGFydCBpbiBoYWxmIGR1
cGxleCBtb2RlCisJICovCisJZmNjX3Jlc3RhcnQgKGRldiwgMCk7CisjZW5kaWYKIAogI2lmZGVm
CUNPTkZJR19VU0VfTURJTwogCWZlcC0+c2VxdWVuY2VfZG9uZSA9IDA7Cg==

------_=_NextPart_001_01C53BA7.1C51A8E4--
