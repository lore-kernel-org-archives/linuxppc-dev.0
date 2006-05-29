Return-Path: <hoffman@marvell.com>
Received: from il.marvell.com (shoshil.marvell.com [199.203.130.250])
	by ozlabs.org (Postfix) with ESMTP id 10C2867A3D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 May 2006 20:59:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6830E.EC60A583"
Subject: RE: Setting I&D cache enable in the same mtspr instruction
Date: Mon, 29 May 2006 13:59:14 +0300
Message-ID: <B9FFC3F97441D04093A504CEA31B7C41A62B2F@msilexch01.marvell.com>
From: "Assaf Hoffman" <hoffman@marvell.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Ronen Shitrit <rshitrit@marvell.com>, Rita Shtern <rita@marvell.com>,
	linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C6830E.EC60A583
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
Attached...

-----Original Message-----
From: Mark A. Greer [mailto:mgreer@mvista.com]=20
Sent: Wednesday, May 24, 2006 1:35 AM
To: Assaf Hoffman
Cc: Mark A. Greer; linuxppc-embedded@ozlabs.org; Rita Shtern; Ronen
Shitrit
Subject: Re: Setting I&D cache enable in the same mtspr instruction

On Tue, May 23, 2006 at 12:55:46PM +0300, Assaf Hoffman wrote:
> Attached.
> Thanks.

Er, how about a *patch* place inline (as in, not as an attachment).

Thanks,

Mark

------_=_NextPart_001_01C6830E.EC60A583
Content-Type: application/octet-stream;
	name="cpu_setup_6xx.patch"
Content-Transfer-Encoding: base64
Content-Description: cpu_setup_6xx.patch
Content-Disposition: attachment;
	filename="cpu_setup_6xx.patch"

LS0tIC4uL2Rvd25sb2Fkcy9rZXJuZWxzL2xpbnV4LTIuNi4xMi42L2FyY2gvcHBjL2tlcm5lbC9j
cHVfc2V0dXBfNnh4X3BhdGNoLlMJMjAwNi0wNS0yOSAxMzo1MzowNy4wMDAwMDAwMDAgKzAzMDAK
KysrIC4uL2Rvd25sb2Fkcy9rZXJuZWxzL2xpbnV4LTIuNi4xMi42L2FyY2gvcHBjL2tlcm5lbC9j
cHVfc2V0dXBfNnh4LlMJMjAwNS0wOC0yOSAxOTo1NToyNy4wMDAwMDAwMDAgKzAzMDAKQEAgLTc5
LDE5ICs3OSwxNyBAQAogLyogRW5hYmxlIGNhY2hlcyBmb3IgNjAzJ3MsIDYwNCwgNzUwICYgNzQw
MCAqLwogc2V0dXBfY29tbW9uX2NhY2hlczoKIAltZnNwcglyMTEsU1BSTl9ISUQwCi0Jb3JpCXI4
LHIxMSxISUQwX0RDRQogCWFuZGkuCXIwLHIxMSxISUQwX0RDRQorCW9yaQlyMTEscjExLEhJRDBf
SUNFfEhJRDBfRENFCisJb3JpCXI4LHIxMSxISUQwX0lDRkkKIAlibmUJMWYJCQkvKiBkb24ndCBp
bnZhbGlkYXRlIHRoZSBELWNhY2hlICovCiAJb3JpCXI4LHI4LEhJRDBfRENJCQkvKiB1bmxlc3Mg
aXQgd2Fzbid0IGVuYWJsZWQgKi8KIDE6CXN5bmMKIAltdHNwcglTUFJOX0hJRDAscjgJCS8qIGVu
YWJsZSBhbmQgaW52YWxpZGF0ZSBjYWNoZXMgKi8KIAlzeW5jCi0Jb3JpCXI4LHIxMSxISUQwX0lD
RXxISUQwX0RDRXxISUQwX0lDRkkKLQlpc3luYwotCXN5bmMKLQltdHNwcglTUFJOX0hJRDAscjgJ
CS8qIGVuYWJsZSBhbmQgaW52YWxpZGF0ZSBJbnN0cnVjdGlvbiBjYWNoZSAqLworCW10c3ByCVNQ
Uk5fSElEMCxyMTEJCS8qIGVuYWJsZSBjYWNoZXMgKi8KIAlzeW5jCi0JCQorCWlzeW5jCiAJYmxy
CiAKIC8qIDYwNCwgNjA0ZSwgNjA0ZXYsIC4uLgo=

------_=_NextPart_001_01C6830E.EC60A583--
