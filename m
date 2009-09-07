Return-Path: <d.dusha@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CF732B7B63
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Sep 2009 10:37:57 +1000 (EST)
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 3075BDDD0B
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Sep 2009 10:37:55 +1000 (EST)
Received: by yxe8 with SMTP id 8so3001563yxe.17
	for <linuxppc-dev@ozlabs.org>; Sun, 06 Sep 2009 17:37:54 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 7 Sep 2009 10:06:01 +1000
Message-ID: <c788c1220909061706i3c1c2c52rc1284e0ad416cb7@mail.gmail.com>
Subject: [PATCH] mpc512x: Reset module
From: Damien Dusha <d.dusha@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary=0016e646a3267fa8630472f19dd6
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e646a3267fa8630472f19dd6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,

I have written a small patch to get the software reset working on the
mpc5121.=A0 It is similar to the reset driver found in
arch/powerpc/platforms/83xx/misc.c except it has been modified to look
for the reset node in the device tree before writing to the reset
module.

Comments are welcome.  It's my first patch to the mailing list, so
I'll apologise in advance for any problems with the submission
procedure.

Damien.

--0016e646a3267fa8630472f19dd6
Content-Type: text/x-patch; charset=US-ASCII; name="mpc512x_restart.patch"
Content-Disposition: attachment; filename="mpc512x_restart.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fzag90wq0

ZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvNTEyeC9tcGM1MTIxX2Fkcy5jIGIv
YXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy81MTJ4L21wYzUxMjFfYWRzLmMKaW5kZXggYTg5NzZiNC4u
MTZjYTI1MCAxMDA2NDQKLS0tIGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy81MTJ4L21wYzUxMjFf
YWRzLmMKKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy81MTJ4L21wYzUxMjFfYWRzLmMKQEAg
LTcwLDQgKzcwLDUgQEAgZGVmaW5lX21hY2hpbmUobXBjNTEyMV9hZHMpIHsKIAkuaW5pdF9JUlEJ
CT0gbXBjNTEyMV9hZHNfaW5pdF9JUlEsCiAJLmdldF9pcnEJCT0gaXBpY19nZXRfaXJxLAogCS5j
YWxpYnJhdGVfZGVjcgkJPSBnZW5lcmljX2NhbGlicmF0ZV9kZWNyLAorICAgIC5yZXN0YXJ0ICAg
ICAgICA9IG1wYzUxMnhfcmVzdGFydCwKIH07CmRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvcGxh
dGZvcm1zLzUxMngvbXBjNTEyeC5oIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy81MTJ4L21wYzUx
MnguaAppbmRleCBmNGRiOGE3Li5kNzdmMGFiIDEwMDY0NAotLS0gYS9hcmNoL3Bvd2VycGMvcGxh
dGZvcm1zLzUxMngvbXBjNTEyeC5oCisrKyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvNTEyeC9t
cGM1MTJ4LmgKQEAgLTE0LDUgKzE0LDYgQEAKIGV4dGVybiB1bnNpZ25lZCBsb25nIG1wYzUxMnhf
ZmluZF9pcHNfZnJlcShzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUpOwogZXh0ZXJuIHZvaWQgX19p
bml0IG1wYzUxMnhfaW5pdF9JUlEodm9pZCk7CiBleHRlcm4gdm9pZCBfX2luaXQgbXBjNTEyeF9p
bml0X2kyYyh2b2lkKTsKK2V4dGVybiB2b2lkIG1wYzUxMnhfcmVzdGFydChjaGFyICpjbWQpOwog
dm9pZCBfX2luaXQgbXBjNTEyeF9kZWNsYXJlX29mX3BsYXRmb3JtX2RldmljZXModm9pZCk7CiAj
ZW5kaWYJCQkJLyogX19NUEM1MTJYX0hfXyAqLwpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy81MTJ4L21wYzUxMnhfc2hhcmVkLmMgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzUx
MngvbXBjNTEyeF9zaGFyZWQuYwppbmRleCAxMzVmZDZiLi5kZWRkYWZjIDEwMDY0NAotLS0gYS9h
cmNoL3Bvd2VycGMvcGxhdGZvcm1zLzUxMngvbXBjNTEyeF9zaGFyZWQuYworKysgYi9hcmNoL3Bv
d2VycGMvcGxhdGZvcm1zLzUxMngvbXBjNTEyeF9zaGFyZWQuYwpAQCAtMjIsNiArMjIsNyBAQAog
I2luY2x1ZGUgPGFzbS9wcm9tLmg+CiAjaW5jbHVkZSA8YXNtL3RpbWUuaD4KIAorI2luY2x1ZGUg
PGFzbS9tcGM1MTJ4Lmg+CiAjaW5jbHVkZSAibXBjNTEyeC5oIgogCiB1bnNpZ25lZCBsb25nCkBA
IC04OSw2ICs5MCwzMyBAQCB2b2lkIF9faW5pdCBtcGM1MTJ4X2luaXRfaTJjKHZvaWQpCiAJfQog
fQogCit2b2lkIG1wYzUxMnhfcmVzdGFydChjaGFyICpjbWQpCit7CisgICAgc3RydWN0IGRldmlj
ZV9ub2RlICpucDsKKyAgICBzdHJ1Y3QgbXBjNTEyeF9yZXNldF9tb2R1bGUgKnJtOworCisgICAg
bG9jYWxfaXJxX2Rpc2FibGUoKTsKKworCW5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVM
TCwgTlVMTCwgImZzbCxtcGM1MTIxLXJlc2V0Iik7CisKKwlpZiAobnApIHsKKworICAgICAgICBy
bSA9IG9mX2lvbWFwKG5wLCAwKTsKKwkJaWYgKHJtKSB7CisKKyAgICAgICAgICAgIC8qIEVuYWJs
ZSBzb2Z0d2FyZSByZXNldCAiUlNURSIgKGluIGhleCkgKi8KKyAgICAgICAgICAgIG91dF9iZTMy
KCAmKHJtLT5ycHIpICwgMHg1MjUzNTQ0NSk7CisKKyAgICAgICAgICAgIC8qIFNldCB0aGUgc29m
dHdhcmUgaGFyZCByZXNldCAqLworICAgICAgICAgICAgb3V0X2JlMzIoICYocm0tPnJjciksIDB4
Mik7CisgICAgICAgIH0KKwl9CisKKyAgICBwcmludGsgKEtFUk5fRU1FUkcgIkVycm9yOiBVbmFi
bGUgdG8gbWFwIHJlc2V0IG1vZHVsZSwgc3Bpbm5pbmcgZm9yZXZlciFcbiIpOworICAgIGZvcig7
Oyk7Cit9CisKKwogLyoKICAqIE5vZGVzIHRvIGRvIGJ1cyBwcm9iZSBvbiwgc29jIGFuZCBsb2Nh
bGJ1cwogICovCg==
--0016e646a3267fa8630472f19dd6--
