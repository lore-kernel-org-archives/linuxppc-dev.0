Date: Tue, 4 Jul 2000 23:08:22 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] atyfb ppc asm removal... (fwd)
Message-ID: <Pine.LNX.4.10.10007042308130.930-200000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-741392083-1165795656-962590193=:21027"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---741392083-1165795656-962590193=:21027
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.10.10007042308132.930@cassiopeia.home>

---------- Forwarded message ----------
Date: Sun, 2 Jul 2000 19:09:53 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: geert@linux-m68k.org
Subject: [PATCH] atyfb ppc asm removal...



Hi Geert,

The attatched patch removes the ppc load/store asm from the inlines.  I
guess these were used back before we had a nice asm/io.h.  I don't see why
we can't just use readl/writel.  Patch is against 2.4.0-test3-2's atyfb.


ani

---741392083-1165795656-962590193=:21027
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="atyfb.diff"
Content-ID: <Pine.LNX.4.10.10007021909530.21027@shell.unixbox.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="atyfb.diff"
Content-Transfer-Encoding: BASE64

LS0tIGF0eWZiLmMub3JpZwlTdW4gSnVsICAyIDIxOjI0OjMxIDIwMDANCisr
KyBhdHlmYi5jCVN1biBKdWwgIDIgMjE6MjU6MjUgMjAwMA0KQEAgLTU3MCwx
NCArNTcwLDcgQEANCiBzdGF0aWMgaW5saW5lIHUzMiBhdHlfbGRfbGUzMih1
bnNpZ25lZCBpbnQgcmVnaW5kZXgsDQogCQkJICAgICAgY29uc3Qgc3RydWN0
IGZiX2luZm9fYXR5ICppbmZvKQ0KIHsNCi0jaWYgZGVmaW5lZChfX3Bvd2Vy
cGNfXykNCi0gICAgdW5zaWduZWQgbG9uZyB0ZW1wOw0KLSAgICB1MzIgdmFs
Ow0KLQ0KLSAgICB0ZW1wID0gaW5mby0+YXRpX3JlZ2Jhc2U7DQotICAgIGFz
bSB2b2xhdGlsZSgibHdicnggJTAsJTEsJTI7ZWllaW8iIDogIj1yIih2YWwp
IDogImIiIChyZWdpbmRleCksICJyIiAodGVtcCkpOw0KLSAgICByZXR1cm4g
dmFsOw0KLSNlbGlmIGRlZmluZWQoX19tYzY4MDAwX18pDQorI2lmIGRlZmlu
ZWQoX19tYzY4MDAwX18pDQogICAgIHJldHVybiBsZTMyX3RvX2NwdSgqKCh2
b2xhdGlsZSB1MzIgKikoaW5mby0+YXRpX3JlZ2Jhc2UrcmVnaW5kZXgpKSk7
DQogI2Vsc2UNCiAgICAgcmV0dXJuIHJlYWRsIChpbmZvLT5hdGlfcmVnYmFz
ZSArIHJlZ2luZGV4KTsNCkBAIC01ODcsMTMgKzU4MCw3IEBADQogc3RhdGlj
IGlubGluZSB2b2lkIGF0eV9zdF9sZTMyKHVuc2lnbmVkIGludCByZWdpbmRl
eCwgdTMyIHZhbCwNCiAJCQkgICAgICAgY29uc3Qgc3RydWN0IGZiX2luZm9f
YXR5ICppbmZvKQ0KIHsNCi0jaWYgZGVmaW5lZChfX3Bvd2VycGNfXykNCi0g
ICAgdW5zaWduZWQgbG9uZyB0ZW1wOw0KLQ0KLSAgICB0ZW1wID0gaW5mby0+
YXRpX3JlZ2Jhc2U7DQotICAgIGFzbSB2b2xhdGlsZSgic3R3YnJ4ICUwLCUx
LCUyO2VpZWlvIiA6IDogInIiICh2YWwpLCAiYiIgKHJlZ2luZGV4KSwgInIi
ICh0ZW1wKSA6DQotCSJtZW1vcnkiKTsNCi0jZWxpZiBkZWZpbmVkKF9fbWM2
ODAwMF9fKQ0KKyNpZiBkZWZpbmVkKF9fbWM2ODAwMF9fKQ0KICAgICAqKCh2
b2xhdGlsZSB1MzIgKikoaW5mby0+YXRpX3JlZ2Jhc2UrcmVnaW5kZXgpKSA9
IGNwdV90b19sZTMyKHZhbCk7DQogI2Vsc2UNCiAgICAgd3JpdGVsICh2YWws
IGluZm8tPmF0aV9yZWdiYXNlICsgcmVnaW5kZXgpOw0K
---741392083-1165795656-962590193=:21027--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
