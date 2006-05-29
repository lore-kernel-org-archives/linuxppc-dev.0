Return-Path: <hoffman@marvell.com>
Received: from il.marvell.com (shoshil.marvell.com [199.203.130.250])
	by ozlabs.org (Postfix) with ESMTP id BC77C67A44
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 May 2006 22:37:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6831C.B4FC0F35"
Subject: RE: Setting I&D cache enable in the same mtspr instruction
Date: Mon, 29 May 2006 15:37:54 +0300
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41A62B87@msilexch01.marvell.com>
From: "Assaf Hoffman" <hoffman@marvell.com>
To: "Roger Larsson" <roger.larsson@norran.net>, <linuxppc-embedded@ozlabs.org>
Cc: Ronen Shitrit <rshitrit@marvell.com>
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

------_=_NextPart_001_01C6831C.B4FC0F35
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
Attached...

-----Original Message-----
From: linuxppc-embedded-bounces+hoffman=3Dmarvell.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+hoffman=3Dmarvell.com@ozlabs.org] On
Behalf Of Roger Larsson
Sent: Monday, May 29, 2006 3:15 PM
To: linuxppc-embedded@ozlabs.org
Subject: Re: Setting I&D cache enable in the same mtspr instruction
Importance: Low

Is the patch reversed?

diff -Naur old new > patch

And what about comments, are they all still valid?
"enable and invalidate caches" is now only Data cache...

In cases when I am writing code like this I try to
include the reason why it is not "optimized" together
in one write... (or soon someone will do that optimization).

/RogerL
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

------_=_NextPart_001_01C6831C.B4FC0F35
Content-Type: application/octet-stream;
	name="cpu_setup_6xx.patch"
Content-Transfer-Encoding: base64
Content-Description: cpu_setup_6xx.patch
Content-Disposition: attachment;
	filename="cpu_setup_6xx.patch"

LS0tIC4uL2Rvd25sb2Fkcy9rZXJuZWxzL2xpbnV4LTIuNi4xMi42L2FyY2gvcHBjL2tlcm5lbC9j
cHVfc2V0dXBfNnh4X3BhdGNoLlMJMjAwNi0wNS0yOSAxNTozMToyNC4wMDAwMDAwMDAgKzAzMDAK
KysrIC4uL2Rvd25sb2Fkcy9rZXJuZWxzL2xpbnV4LTIuNi4xMi42L2FyY2gvcHBjL2tlcm5lbC9j
cHVfc2V0dXBfNnh4LlMJMjAwNS0wOC0yOSAxOTo1NToyNy4wMDAwMDAwMDAgKzAzMDAKQEAgLTc3
LDI5ICs3NywxOSBAQAogCWJscgogCiAvKiBFbmFibGUgY2FjaGVzIGZvciA2MDMncywgNjA0LCA3
NTAgJiA3NDAwICovCi0KLS8qIAotICogSElEMFtJQ0ZJXSBhbmQgSElEMFtEQ0ZJXSBtdXN0IE5P
VCBib3RoIGJlIHNldCB3aXRoIHRoZSBzYW1lIG10c3ByIAotICogaW5zdHJ1Y3Rpb24sIGR1ZSB0
byB0aGUgc3luY2hyb25pemF0aW9uIHJlcXVpcmVtZW50cyAKLSAqLwotCiBzZXR1cF9jb21tb25f
Y2FjaGVzOgogCW1mc3ByCXIxMSxTUFJOX0hJRDAKLQlvcmkJcjgscjExLEhJRDBfRENFCiAJYW5k
aS4JcjAscjExLEhJRDBfRENFCisJb3JpCXIxMSxyMTEsSElEMF9JQ0V8SElEMF9EQ0UKKwlvcmkJ
cjgscjExLEhJRDBfSUNGSQogCWJuZQkxZgkJCS8qIGRvbid0IGludmFsaWRhdGUgdGhlIEQtY2Fj
aGUgKi8KIAlvcmkJcjgscjgsSElEMF9EQ0kJCS8qIHVubGVzcyBpdCB3YXNuJ3QgZW5hYmxlZCAq
LwogMToJc3luYwogCW10c3ByCVNQUk5fSElEMCxyOAkJLyogZW5hYmxlIGFuZCBpbnZhbGlkYXRl
IGNhY2hlcyAqLwotCXN5bmMJCQkJCi0Jb3JpCXI4LHIxMSxISUQwX0lDRXxISUQwX0RDRXxISUQw
X0lDRkkKLQlpc3luYwkJCQkvKiBBbiBpc3luYyBtdXN0IHByZWNlZGUgdGhlIHNldHRpbmcgIAkq
LwotCQkJCQkvKiBvZiB0aGUgSElEMFtJQ0ZJXSBpbiBvcmRlciBmb3IgdGhlIAkqLyAKLQkJCQkJ
Lyogc2V0dGluZyB0byB0YWtlIGVmZmVjdC4JCSovCiAJc3luYwotCW10c3ByCVNQUk5fSElEMCxy
OAkJLyogZW5hYmxlIGFuZCBpbnZhbGlkYXRlIEluc3RydWN0aW9uIGNhY2hlICovCisJbXRzcHIJ
U1BSTl9ISUQwLHIxMQkJLyogZW5hYmxlIGNhY2hlcyAqLwogCXN5bmMKLQkJCisJaXN5bmMKIAli
bHIKIAogLyogNjA0LCA2MDRlLCA2MDRldiwgLi4uCg==

------_=_NextPart_001_01C6831C.B4FC0F35--
