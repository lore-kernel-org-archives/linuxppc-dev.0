Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id DAAB267A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Feb 2005 10:26:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C51611.3C83E889"
Date: Fri, 18 Feb 2005 17:26:13 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8592BE@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Philip Van-Houtte" <jvan_1@students.concordia.ca>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: oops in process_backlog : kernel 2.6.9
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

------_=_NextPart_001_01C51611.3C83E889
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Try this patch.
It makes sure the IP stack is intialized before accepting packets.

------_=_NextPart_001_01C51611.3C83E889
Content-Type: application/octet-stream;
	name="ip_stack_init_26.patch"
Content-Transfer-Encoding: base64
Content-Description: ip_stack_init_26.patch
Content-Disposition: attachment;
	filename="ip_stack_init_26.patch"

LS0tIGxpbnV4LTIuNS9uZXQvaXB2NC9pcF9vdXRwdXQuYyAgICAgIDIwMDUtMDEtMTIgMDg6NTk6
MTEuMDAwMDAwMDAwIC0wNjAwDQorKysgbGludXgtaW5uc3lzL25ldC9pcHY0L2lwX291dHB1dC5j
ICAgMjAwNS0wMi0xOCAxNzoyMjo1MC4yNTA3NzY0NzMgLTA2MDANCkBAIC0xMzM5LDExICsxMzM1
LDExIEBAIHN0YXRpYyBzdHJ1Y3QgcGFja2V0X3R5cGUgaXBfcGFja2V0X3R5cGUNCg0KIHZvaWQg
X19pbml0IGlwX2luaXQodm9pZCkNCiB7DQotICAgICAgIGRldl9hZGRfcGFjaygmaXBfcGFja2V0
X3R5cGUpOw0KLQ0KICAgICAgICBpcF9ydF9pbml0KCk7DQogICAgICAgIGluZXRfaW5pdHBlZXJz
KCk7DQoNCisgICAgICAgZGV2X2FkZF9wYWNrKCZpcF9wYWNrZXRfdHlwZSk7DQorDQogI2lmIGRl
ZmluZWQoQ09ORklHX0lQX01VTFRJQ0FTVCkgJiYgZGVmaW5lZChDT05GSUdfUFJPQ19GUykNCiAg
ICAgICAgaWdtcF9tY19wcm9jX2luaXQoKTsNCiAjZW5kaWYNCg==

------_=_NextPart_001_01C51611.3C83E889--
