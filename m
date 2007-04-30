Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 9D380DDF92
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 18:22:49 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so929244ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 01:22:46 -0700 (PDT)
Message-ID: <528646bc0704300122r29747b36q648fcde3da755a36@mail.gmail.com>
Date: Mon, 30 Apr 2007 02:22:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Subject: Re: I always encouter this simple error message compiling 2.6 for
	ML403 UART 16550
In-Reply-To: <528646bc0704300032r394d6510mfb0ba38fa0be791b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_49113_22241385.1177921366447"
References: <BAY115-W11DBD14D233C8E1FE8CAD3B24C0@phx.gbl>
	<528646bc0704300032r394d6510mfb0ba38fa0be791b@mail.gmail.com>
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_49113_22241385.1177921366447
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 4/30/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 4/30/07, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
> >
> > Well
> >
> > Don't know if any change should occure in the source files but when I compile any version of 2.6 kernel for ml403/405 with UART 16550 support , I encounter this error message :
>
> Hmm, yes.  That looks busted.  Try the attached patch and see if it
> works for you.

Oops; that patch won't work.  Try this one instead.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

------=_Part_49113_22241385.1177921366447
Content-Type: application/x-patch; name="0001-POWERPC-Fix-gen550-early-serial-support-on-Xilinx.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-POWERPC-Fix-gen550-early-serial-support-on-Xilinx.patch"
X-Attachment-Id: f_f14nyh8t

RnJvbSA1ODZhYjEzYjgxOWQ1MDNkMjlkNjBlZmVhZmZlOGQ1MTFkMzVmMGFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHcmFudCBMaWtlbHkgPGdyYW50Lmxpa2VseUBzZWNyZXRsYWIu
Y2E+CkRhdGU6IE1vbiwgMzAgQXByIDIwMDcgMDE6NDc6MTUgLTA2MDAKU3ViamVjdDogW1BBVENI
XSBbUE9XRVJQQ10gRml4IGdlbjU1MCBlYXJseSBzZXJpYWwgc3VwcG9ydCBvbiBYaWxpbnggVmly
dGV4CgpSU19UQUJMRV9TSVpFIGFuZCBTRVJJQUxfUE9SVF9ERk5TIHdlcmUgbm90IGdldHRpbmcg
ZGVmaW5lZCBmb3IgdGhlClhpbGlueCBWaXJ0ZXggcGxhdGZvcm0uICBJbiB0aGlzIGNhc2UsIHdl
IGV4cGxpY2l0bHkgZG8gKm5vdCogYWRkIGEKdXNlIHRoZXNlIGRlZmluaXRpb25zIGluc3RlYWQg
b2YgdGhlIGRhdGEgaW4gdGhlIHBsYXRmb3JtIGRldmljZQpyZWdpc3RyYXRpb24gYmVjYXVzZSBk
cml2ZXJzL3NlcmlhbC84MjUwLmMgd2lsbCB0cnkgdG8gdXNlIHRoZW0KaW5zdGVhZCBvZiB0aGUg
ZGF0YSBpbiB0aGUgcGxhdGZvcm0gZGV2aWNlLiAgT25seSBzeXNsaWIvZ2VuNTUwLmMgYW5kCmJv
b3QvY29tbW9uL25zMTY1NTAuYyB3YW50IHRvIHVzZSB0aGVzZSBkZWZpbmVzOyBzbyBpbmNsdWRl
IHhwYXJhbWV0ZXJzCmRpcmVjdGx5IGZyb20gdGhlcmUuCgpTaWduZWQtb2ZmLWJ5OiBHcmFudCBM
aWtlbHkgPGdyYW50Lmxpa2VseUBzZWNyZXRsYWIuY2E+Ci0tLQogYXJjaC9wcGMvcGxhdGZvcm1z
LzR4eC94cGFyYW1ldGVycy94cGFyYW1ldGVycy5oIHwgICAgNyArKysrKystCiBhcmNoL3BwYy9z
eXNsaWIvZ2VuNTUwX2RiZy5jICAgICAgICAgICAgICAgICAgICAgfCAgICAzICsrKwogYXJjaC9w
cGMvc3lzbGliL3ZpcnRleF9kZXZpY2VzLmMgICAgICAgICAgICAgICAgIHwgICAgMyArKysKIDMg
ZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9hcmNoL3BwYy9wbGF0Zm9ybXMvNHh4L3hwYXJhbWV0ZXJzL3hwYXJhbWV0ZXJzLmggYi9h
cmNoL3BwYy9wbGF0Zm9ybXMvNHh4L3hwYXJhbWV0ZXJzL3hwYXJhbWV0ZXJzLmgKaW5kZXggMGFm
OTRiMC4uOTE3Y2M4MSAxMDA2NDQKLS0tIGEvYXJjaC9wcGMvcGxhdGZvcm1zLzR4eC94cGFyYW1l
dGVycy94cGFyYW1ldGVycy5oCisrKyBiL2FyY2gvcHBjL3BsYXRmb3Jtcy80eHgveHBhcmFtZXRl
cnMveHBhcmFtZXRlcnMuaApAQCAtMjcsNyArMjcsOCBAQAogI2VuZGlmCiAKICNpZm5kZWYgU0VS
SUFMX1BPUlRfREZOUwotICAvKiB6SW1hZ2Ugc2VyaWFsIHBvcnQgZGVmaW5pdGlvbnMgKi8KKyNp
ZiBkZWZpbmVkKFhQQVJfVUFSVE5TNTUwXzBfQkFTRUFERFIpCisgIC8qIHpJbWFnZS9nZW41NTAg
c2VyaWFsIHBvcnQgZGVmaW5pdGlvbnM7IG9ubHkgcG9ydCAxIHN1cHBvcnRlZCBBVE0gKi8KICAg
I2RlZmluZSBSU19UQUJMRV9TSVpFIDEKICAgI2RlZmluZSBTRVJJQUxfUE9SVF9ERk5TIHsJCQkJ
CQlcCiAJLmJhdWRfYmFzZQkgPSBYUEFSX1VBUlROUzU1MF8wX0NMT0NLX0ZSRVFfSFovMTYsCQlc
CkBAIC0zNyw2ICszOCwxMCBAQAogCS5pb21lbV9yZWdfc2hpZnQgPSAyLAkJCQkJCVwKIAkuaW9f
dHlwZQkgPSBTRVJJQUxfSU9fTUVNLAkJCQlcCiAgIH0sCisjZWxzZQorICAjZGVmaW5lIFJTX1RB
QkxFX1NJWkUgMAorICAjZGVmaW5lIFNFUklBTF9QT1JUX0RGTlMKKyNlbmRpZgogI2VuZGlmCiAK
IC8qCmRpZmYgLS1naXQgYS9hcmNoL3BwYy9zeXNsaWIvZ2VuNTUwX2RiZy5jIGIvYXJjaC9wcGMv
c3lzbGliL2dlbjU1MF9kYmcuYwppbmRleCA5MjkzZjVjLi4yNjdkNmRiIDEwMDY0NAotLS0gYS9h
cmNoL3BwYy9zeXNsaWIvZ2VuNTUwX2RiZy5jCisrKyBiL2FyY2gvcHBjL3N5c2xpYi9nZW41NTBf
ZGJnLmMKQEAgLTIzLDYgKzIzLDkgQEAKICNpbmNsdWRlIDxhc20vbWFjaGRlcC5oPgogI2luY2x1
ZGUgPGFzbS9zZXJpYWwuaD4KICNpbmNsdWRlIDxhc20vaW8uaD4KKyNpZiBkZWZpbmVkKENPTkZJ
R19YSUxJTlhfVklSVEVYKQorI2luY2x1ZGUgPHBsYXRmb3Jtcy80eHgveHBhcmFtZXRlcnMveHBh
cmFtZXRlcnMuaD4KKyNlbmRpZgogCiAjZGVmaW5lIFNFUklBTF9CQVVECTk2MDAKIApkaWZmIC0t
Z2l0IGEvYXJjaC9wcGMvc3lzbGliL3ZpcnRleF9kZXZpY2VzLmMgYi9hcmNoL3BwYy9zeXNsaWIv
dmlydGV4X2RldmljZXMuYwppbmRleCBjMTcyNTFhLi45NTNmNjIyIDEwMDY0NAotLS0gYS9hcmNo
L3BwYy9zeXNsaWIvdmlydGV4X2RldmljZXMuYworKysgYi9hcmNoL3BwYy9zeXNsaWIvdmlydGV4
X2RldmljZXMuYwpAQCAtMzEyLDYgKzMxMiw5IEBAIHZpcnRleF9lYXJseV9zZXJpYWxfaW5pdChp
bnQgbnVtLCBzdHJ1Y3QgcGxhdF9zZXJpYWw4MjUwX3BvcnQgKnBkYXRhKQogI2lmIGRlZmluZWQo
Q09ORklHX1NFUklBTF9URVhUX0RFQlVHKSB8fCBkZWZpbmVkKENPTkZJR19LR0RCKQogCXN0cnVj
dCB1YXJ0X3BvcnQgc2VyaWFsX3JlcTsKIAorCWlmIChudW0gPj0gUlNfVEFCTEVfU0laRSkKKwkJ
cmV0dXJuOworCiAJbWVtc2V0KCZzZXJpYWxfcmVxLCAwLCBzaXplb2Yoc2VyaWFsX3JlcSkpOwog
CXNlcmlhbF9yZXEubWFwYmFzZQk9IHBkYXRhLT5tYXBiYXNlOwogCXNlcmlhbF9yZXEubWVtYmFz
ZQk9IHBkYXRhLT5tZW1iYXNlOwotLSAKMS41LjEKCg==
------=_Part_49113_22241385.1177921366447--
