Return-Path: <Cedric_Hombourger@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 943C11A0D48
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Nov 2015 02:25:02 +1100 (AEDT)
Received: from nat-ies.mentorg.com ([192.94.31.2]
 helo=SVR-IES-FEM-05.mgc.mentorg.com)
 by relay1.mentorg.com with esmtp
 id 1Zuig5-0004Yg-BV from Cedric_Hombourger@mentor.com
 for linuxppc-dev@lists.ozlabs.org; Fri, 06 Nov 2015 07:11:45 -0800
From: "Hombourger, Cedric" <Cedric_Hombourger@mentor.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/module: avoid memmove() in dedotify()
Date: Fri, 6 Nov 2015 15:11:44 +0000
Message-ID: <53FDD47F-8AB7-45C9-91DE-9A39F5055151@mentor.com>
Content-Type: multipart/mixed;
 boundary="_002_53FDD47F8AB745C991DE9A39F5055151mentorcom_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_002_53FDD47F8AB745C991DE9A39F5055151mentorcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D412FF631C0534BA49A11738967BB3D@mentor.com>
Content-Transfer-Encoding: base64

DQoNCg==

--_002_53FDD47F8AB745C991DE9A39F5055151mentorcom_
Content-Type: application/octet-stream;
	name="0001-powerpc-module-avoid-memmove-in-dedotify.patch"
Content-Description: 0001-powerpc-module-avoid-memmove-in-dedotify.patch
Content-Disposition: attachment;
	filename="0001-powerpc-module-avoid-memmove-in-dedotify.patch"; size=1318;
	creation-date="Fri, 06 Nov 2015 15:11:44 GMT";
	modification-date="Fri, 06 Nov 2015 15:11:44 GMT"
Content-ID: <F553090AA1A9BA46AED30A9F206FBEF1@mentor.com>
Content-Transfer-Encoding: base64

RnJvbSA1ZTcyNzU3YmQ2MTljZDZmOTQyMmI2YjM0MmY1MmZmOGJkM2ZmYjIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDZWRyaWMgSG9tYm91cmdlciA8Q2VkcmljX0hvbWJvdXJnZXJA
bWVudG9yLmNvbT4KRGF0ZTogRnJpLCA2IE5vdiAyMDE1IDE1OjUwOjQ2ICswMTAwClN1YmplY3Q6
IFtQQVRDSF0gcG93ZXJwYy9tb2R1bGU6IGF2b2lkIG1lbW1vdmUoKSBpbiBkZWRvdGlmeSgpCgpt
ZW1tb3ZlKCkgaXMgZXNzZW50aWFsbHkgYSBtZW1jcHkoKSBvbiBwb3dlcnBjNjQuIGRlZG90aWZ5
KCkgZG9lcwphIG1lbW1vdmUoKSB0byByZW1vdmUgdGhlIGxlYWRpbmcgZG90IGZyb20gdW5kZWZp
bmVkIHN5bWJvbCBuYW1lcwppdCBpcyBzaW1wbHkgbW9yZSBlZmZpY2llbnQgdG8gb2Zmc2V0IHN0
X25hbWUgYW5kIGFyZ3VhYmx5IG1vcmUKY29ycmVjdCAob3RoZXIgRUxGIG9iamVjdHMgY291bGQg
YmUgcG9pbnRpbmcgdG8gdGhpcyBzdHJpbmcpLiBBdApzb21lIHBvaW50LCBhIGNvcnJlY3QgbWVt
bW92ZSgpIGltcGxlbWVudGF0aW9uIGlzIG5lZWRlZCBmb3IgcG93ZXIKKGVzcGVjaWFsbHkgZm9y
IGNhc2VzIGxpa2UgdGhpcyB3aGVyZSB0aGUgc291cmNlIGFuZCBkZXN0aW5hdGlvbgpvdmVybGFw
KS4gVGhlcmUgYXJlIGluZGVlZCBvdGhlciBtZW1tb3ZlKCkgY2FsbHMgaW4gdGhlIGtlcm5lbC4u
LgoKU2lnbmVkLW9mZi1ieTogQ2VkcmljIEhvbWJvdXJnZXIgPENlZHJpY19Ib21ib3VyZ2VyQG1l
bnRvci5jb20+Ci0tLQogYXJjaC9wb3dlcnBjL2tlcm5lbC9tb2R1bGVfNjQuYyB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2FyY2gvcG93ZXJwYy9rZXJuZWwvbW9kdWxlXzY0LmMgYi9hcmNoL3Bvd2VycGMva2VybmVsL21v
ZHVsZV82NC5jCmluZGV4IDY4Mzg0NTEuLmU3N2RiYWUgMTAwNjQ0Ci0tLSBhL2FyY2gvcG93ZXJw
Yy9rZXJuZWwvbW9kdWxlXzY0LmMKKysrIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9tb2R1bGVfNjQu
YwpAQCAtMzM1LDcgKzMzNSw3IEBAIHN0YXRpYyB2b2lkIGRlZG90aWZ5KEVsZjY0X1N5bSAqc3lt
cywgdW5zaWduZWQgaW50IG51bXN5bXMsIGNoYXIgKnN0cnRhYikKIAkJaWYgKHN5bXNbaV0uc3Rf
c2huZHggPT0gU0hOX1VOREVGKSB7CiAJCQljaGFyICpuYW1lID0gc3RydGFiICsgc3ltc1tpXS5z
dF9uYW1lOwogCQkJaWYgKG5hbWVbMF0gPT0gJy4nKQotCQkJCW1lbW1vdmUobmFtZSwgbmFtZSsx
LCBzdHJsZW4obmFtZSkpOworCQkJCXN5bXNbaV0uc3RfbmFtZSsrOwogCQl9CiAJfQogfQotLSAK
MS45LjEKCg==

--_002_53FDD47F8AB745C991DE9A39F5055151mentorcom_--
