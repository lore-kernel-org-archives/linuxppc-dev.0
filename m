Message-Id: <199905241630.SAA25266@dv.ba.dlr.de>
Date: Mon, 24 May 1999 18:15:55 +0000
Subject: semaphores in 2.3.3
From: "Oliver Neukum" <Oliver.Neukum@lrz.uni-muenchen.de>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: multipart/mixed; boundary="MS_Mac_OE_3010414555_90469_MIME_Part"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> DIESE NACHRICHT IST IN MIME-FORMAT. Da Ihr Mailreader dieses Format nicht
untersttzt, knnte diese Nachricht ganz oder teilweise unlesbar sein.

--MS_Mac_OE_3010414555_90469_MIME_Part
Content-type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

as you may have noticed linux-2.3.3  doesn't compile on powerpc due to
changes in semaphores and waitqueues. This means that ppc is again at a
disadvantage.
I hope for ppc to become one of the stable ports.
I've attached a patch that ports the basic change from i386 to ppc.
As yet, the kernel will not compile. It needs to include semaphore.h at a
few places. In addition i've found ide-pmac.c and adbmouse.c to be broken.

People, this can't be that hard.

Regards

Oliver Neukum

PS: It assumes the changes needed to compile 2.2.8 have been made.

PPS:What is the reason IrDA isn't there for ppc ?

--MS_Mac_OE_3010414555_90469_MIME_Part
Content-type: application/octet-stream; name="ppc233patch";
 x-mac-creator="3F3F3F3F";
 x-mac-type="3F3F3F3F"
Content-disposition: attachment
Content-Transfer-Encoding: base64

LS0tIGluY2x1ZGUvYXNtLXBwYy9zZW1hcGhvcmUuaC5hbHQJTW9uIE1heSAyNCAxNToxNjow
MyAxOTk5CisrKyBpbmNsdWRlL2FzbS1wcGMvc2VtYXBob3JlLmgJTW9uIE1heSAyNCAxNzox
NjowOCAxOTk5CkBAIC05LDYgKzksNyBAQAogICovCiAKICNpbmNsdWRlIDxhc20vYXRvbWlj
Lmg+CisjaW5jbHVkZSA8bGludXgvd2FpdC5oPgogCiBzdHJ1Y3Qgc2VtYXBob3JlIHsKIAlh
dG9taWNfdCBjb3VudDsKQEAgLTE2LDE3ICsxNyw0MiBAQAogCXdhaXRfcXVldWVfaGVhZF90
IHdhaXQ7CiB9OwogCi0jZGVmaW5lIHNlbWFfaW5pdChzZW0sIHZhbCkJYXRvbWljX3NldCgm
KChzZW0pLT5jb3VudCksICh2YWwpKQotCi0jZGVmaW5lIE1VVEVYCQkoKHN0cnVjdCBzZW1h
cGhvcmUpIFwKLQkJCSB7IEFUT01JQ19JTklUKDEpLCBBVE9NSUNfSU5JVCgwKSwgTlVMTCB9
KQotI2RlZmluZSBNVVRFWF9MT0NLRUQJKChzdHJ1Y3Qgc2VtYXBob3JlKSBcCi0JCQkgeyBB
VE9NSUNfSU5JVCgwKSwgQVRPTUlDX0lOSVQoMCksIE5VTEwgfSkKKyNkZWZpbmUgX19TRU1f
REVCVUdfSU5JVChuYW1lKQogCiBleHRlcm4gdm9pZCBfX2Rvd24oc3RydWN0IHNlbWFwaG9y
ZSAqIHNlbSk7CiBleHRlcm4gaW50ICBfX2Rvd25faW50ZXJydXB0aWJsZShzdHJ1Y3Qgc2Vt
YXBob3JlICogc2VtKTsKIGV4dGVybiBpbnQgIF9fZG93bl90cnlsb2NrKHN0cnVjdCBzZW1h
cGhvcmUgKiBzZW0pOwogZXh0ZXJuIHZvaWQgX191cChzdHJ1Y3Qgc2VtYXBob3JlICogc2Vt
KTsKKworI2RlZmluZSBfX1NFTUFQSE9SRV9JTklUSUFMSVpFUihuYW1lLGNvdW50KSBcCit7
IEFUT01JQ19JTklUKGNvdW50KSwgMCxfX1dBSVRRVUVVRV9IRUFEX0lOSVRJQUxJWkVSKChu
YW1lKS53YWl0KSBcCisJX19TRU1fREVCVUdfSU5JVChuYW1lKSB9CisKKyNkZWZpbmUgX19N
VVRFWF9JTklUSUFMSVpFUihuYW1lKSBcCisJX19TRU1BUEhPUkVfSU5JVElBTElaRVIobmFt
ZSwxKQorCisjZGVmaW5lIF9fREVDTEFSRV9TRU1BUEhPUkVfR0VORVJJQyhuYW1lLGNvdW50
KSBcCisJc3RydWN0IHNlbWFwaG9yZSBuYW1lID0gX19TRU1BUEhPUkVfSU5JVElBTElaRVIo
bmFtZSxjb3VudCkKKworI2RlZmluZSBERUNMQVJFX01VVEVYKG5hbWUpIF9fREVDTEFSRV9T
RU1BUEhPUkVfR0VORVJJQyhuYW1lLDEpCisjZGVmaW5lIERFQ0xBUkVfTVVURVhfTE9DS0VE
KG5hbWUpIF9fREVDTEFSRV9TRU1BUEhPUkVfR0VORVJJQyhuYW1lLDApCisKK2V4dGVybiBp
bmxpbmUgdm9pZCBzZW1hX2luaXQgKHN0cnVjdCBzZW1hcGhvcmUgKnNlbSwgaW50IHZhbCkK
K3sKK2F0b21pY19zZXQoJnNlbS0+Y291bnQsIHZhbCk7CithdG9taWNfc2V0KCZzZW0tPndh
a2luZywgMCk7Citpbml0X3dhaXRxdWV1ZV9oZWFkKCZzZW0tPndhaXQpOworfQorCitzdGF0
aWMgaW5saW5lIHZvaWQgaW5pdF9NVVRFWCAoc3RydWN0IHNlbWFwaG9yZSAqc2VtKQorewor
CXNlbWFfaW5pdChzZW0sIDEpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgaW5pdF9NVVRF
WF9MT0NLRUQgKHN0cnVjdCBzZW1hcGhvcmUgKnNlbSkKK3sKKwlzZW1hX2luaXQoc2VtLCAw
KTsKK30KIAogZXh0ZXJuIGlubGluZSB2b2lkIGRvd24oc3RydWN0IHNlbWFwaG9yZSAqIHNl
bSkKIHsKLS0tIGtlcm5lbC9mb3JrLmMuYWx0CU1vbiBNYXkgMjQgMTU6MDE6MjYgMTk5OQor
Kysga2VybmVsL2ZvcmsuYwlNb24gTWF5IDI0IDE3OjEwOjQ3IDE5OTkKQEAgLTIxLDYgKzIx
LDcgQEAKICNpbmNsdWRlIDxhc20vcGd0YWJsZS5oPgogI2luY2x1ZGUgPGFzbS9tbXVfY29u
dGV4dC5oPgogI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+CisjaW5jbHVkZSA8YXNtL3NlbWFw
aG9yZS5oPgogCiAvKiBUaGUgaWRsZSB0YXNrcyBkbyBub3QgY291bnQuLiAqLwogaW50IG5y
X3Rhc2tzPTA7Cg==
--MS_Mac_OE_3010414555_90469_MIME_Part--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
