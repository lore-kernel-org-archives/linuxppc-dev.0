Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 0AF8D67A46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 03:38:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C51445.F25CD43F"
Date: Wed, 16 Feb 2005 10:38:30 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8592B6@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>,
	"Tom Rini" <trini@kernel.crashing.org>
Subject: [PATCH] Fixup of previous PCI9 patch
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

------_=_NextPart_001_01C51445.F25CD43F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Previous PCI9 patch had a #endif placed wrong for some unknown reason
(was correct in local tree)
This fixes it.
Signed-off-by: Rune Torgersen <runet@innovsys.com>

Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com

------_=_NextPart_001_01C51445.F25CD43F
Content-Type: application/octet-stream;
	name="patch_pci9patch_fixup"
Content-Transfer-Encoding: base64
Content-Description: patch_pci9patch_fixup
Content-Disposition: attachment;
	filename="patch_pci9patch_fixup"

LS0tIGxpbnV4LTIuNS9pbmNsdWRlL2FzbS1wcGMvaW8uaAkyMDA1LTAyLTE2IDEwOjEzOjA3Ljg0
NjExNjMyMCAtMDYwMAorKysgbGludXgtaW5uc3lzLTIuNi45L2luY2x1ZGUvYXNtLXBwYy9pby5o
CTIwMDUtMDItMTYgMTA6MzI6MDcuMDAwMDAwMDAwIC0wNjAwCkBAIC0zNjAsNiArMzYwLDcgQEAg
c3RhdGljIGlubGluZSB2b2lkIG1lbWNweV90b2lvKHZvbGF0aWxlIAogewogCW1lbWNweSgodm9p
ZCBfX2ZvcmNlICopIGRzdCwgc3JjLCBjb3VudCk7CiB9CisjZW5kaWYKIAogI2RlZmluZSBldGhf
aW9fY29weV9hbmRfc3VtKGEsYixjLGQpCQlldGhfY29weV9hbmRfc3VtKChhKSwodm9pZCBfX2Zv
cmNlICopKHZvaWQgX19pb21lbSAqKShiKSwoYyksKGQpKQogCkBAIC00MDgsNyArNDA5LDcgQEAg
ZXh0ZXJuIGlubGluZSB2b2lkICogYnVzX3RvX3ZpcnQodW5zaWduZQogCXJldHVybiAodm9pZCop
IG1tX3B0b3YgKGFkZHJlc3MpOwogI2VuZGlmCiB9Ci0jZW5kaWYKKwogLyoKICAqIENoYW5nZSB2
aXJ0dWFsIGFkZHJlc3NlcyB0byBwaHlzaWNhbCBhZGRyZXNzZXMgYW5kIHZ2LCBmb3IKICAqIGFk
ZHJlc3NlcyBpbiB0aGUgYXJlYSB3aGVyZSB0aGUga2VybmVsIGhhcyB0aGUgUkFNIG1hcHBlZC4K

------_=_NextPart_001_01C51445.F25CD43F--
