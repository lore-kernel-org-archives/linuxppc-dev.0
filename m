Message-Id: <5.1.0.14.2.20020613160339.02e4cbd0@pop.prodigy.net>
Date: Thu, 13 Jun 2002 16:07:15 -0700
To: Dan Malek <dan@embeddededge.com>
From: Eugene Surovegin <ebs@innocent.com>
Subject: [PATCH] pci_alloc_consistent in an interrupt context, part 2
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3D0912F4.4020300@embeddededge.com>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com>
 <20020613205824.GX13541@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_277061203==_"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=====================_277061203==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

Hi!

Here is an addition to my first patch.

Instead of using gfp which was passed to consistent_alloc,
I use a modified version with masked out zone modifiers (like __GFP_DMA).

Thanks,

Eugene
--=====================_277061203==_
Content-Type: application/octet-stream; name="consistent_alloc_2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="consistent_alloc_2.patch"

PT09PT0gY2FjaGVtYXAuYyAxLjE0IHZzIDEuMTUgPT09PT0KLS0tIDEuMTQvYXJjaC9wcGMvbW0v
Y2FjaGVtYXAuYwlUaHUgSnVuIDEzIDExOjQ3OjQxIDIwMDIKKysrIDEuMTUvYXJjaC9wcGMvbW0v
Y2FjaGVtYXAuYwlUaHUgSnVuIDEzIDE2OjAwOjE1IDIwMDIKQEAgLTg4LDggKzg4LDEwIEBACiAJ
aW52YWxpZGF0ZV9kY2FjaGVfcmFuZ2UocGFnZSwgcGFnZSArIHNpemUpOwogCiAJLyogQWxsb2Nh
dGUgc29tZSBjb21tb24gdmlydHVhbCBzcGFjZSB0byBtYXAgdGhlIG5ldyBwYWdlcy4KKwkgICBN
YXNrIG91dCB6b25lIG1vZGlmaWVycyBmcm9tIGdmcDsgd2UgZG9uJ3Qgd2FudCAKKwkgICB0byBy
ZXN0cmljdCB2bV9zdHJ1Y3QgYWxsb2NhdGlvbiB0byBETUEgb3IgaGlnaCBtZW1vcnkgcG9vbCBv
bmx5CiAJKi8KLQlhcmVhID0gZ2V0X3ZtX2FyZWEoc2l6ZSwgVk1fQUxMT0MsIEdGUF9BVE9NSUMp
OworCWFyZWEgPSBnZXRfdm1fYXJlYShzaXplLCBWTV9BTExPQywgZ2ZwICYgfihfX0dGUF9ETUEg
fCBfX0dGUF9ISUdITUVNKSk7CiAJaWYgKGFyZWEgPT0gMCkgewogCQlmcmVlX3BhZ2VzKHBhZ2Us
IG9yZGVyKTsKIAkJcmV0dXJuIE5VTEw7Cg==
--=====================_277061203==_--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
