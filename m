Return-Path: <gorcunov@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id C97E2DDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 16:43:05 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3715501wag
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 21:43:04 -0800 (PST)
Message-ID: <aa79d98a0711222143r746d8789r1bff0cb7b7cd88a5@mail.gmail.com>
Date: Fri, 23 Nov 2007 08:43:04 +0300
From: "Cyrill Gorcunov" <gorcunov@gmail.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] PPC: CHRP - fix possible NULL pointer dereference
In-Reply-To: <20071123101646.63550945.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_19488_23666844.1195796584724"
References: <20071122195423.GA9877@cvg>
	<20071123101646.63550945.sfr@canb.auug.org.au>
Cc: Olof Johansson <olof@lixom.net>, PPCML <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_19488_23666844.1195796584724
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is updated version
---
From: Cyrill Gorcunov <gorcunov@gmail.com>

This patch does fix possible NULL pointer dereference
inside of strncmp() if of_get_property() failed.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---

------=_Part_19488_23666844.1195796584724
Content-Type: text/plain; name=ppc-chrs-null-fix.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9cadwlc
Content-Disposition: attachment; filename=ppc-chrs-null-fix.diff

IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvY2hycC9zZXR1cC5jIHwgICAxMyArKysrKysrKystLS0t
CiAxIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL2NocnAvc2V0dXAuYyBiL2FyY2gvcG93ZXJw
Yy9wbGF0Zm9ybXMvY2hycC9zZXR1cC5jCmluZGV4IDU5MzA2MjYuLmRhNGU0NWUgMTAwNjQ0Ci0t
LSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvY2hycC9zZXR1cC5jCisrKyBiL2FyY2gvcG93ZXJw
Yy9wbGF0Zm9ybXMvY2hycC9zZXR1cC5jCkBAIC0xMTUsNyArMTE1LDcgQEAgdm9pZCBjaHJwX3No
b3dfY3B1aW5mbyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0pCiAJc2VxX3ByaW50ZihtLCAibWFjaGluZVx0
XHQ6IENIUlAgJXNcbiIsIG1vZGVsKTsKIAogCS8qIGxvbmd0cmFpbCAoZ29sZGVuZ2F0ZSkgc3R1
ZmYgKi8KLQlpZiAoIXN0cm5jbXAobW9kZWwsICJJQk0sTG9uZ1RyYWlsIiwgMTMpKSB7CisJaWYg
KG1vZGVsICYmICFzdHJuY21wKG1vZGVsLCAiSUJNLExvbmdUcmFpbCIsIDEzKSkgewogCQkvKiBW
TFNJIFZBUzk2MDExLzEyIGBHb2xkZW4gR2F0ZSAyJyAqLwogCQkvKiBNZW1vcnkgYmFua3MgKi8K
IAkJc2RyYW1lbiA9IChpbl9sZTMyKGdnMl9wY2lfY29uZmlnX2Jhc2UgKyBHRzJfUENJX0RSQU1f
Q1RSTCkKQEAgLTIwMywxNSArMjAzLDIwIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzaW9fZml4dXBf
aXJxKGNvbnN0IGNoYXIgKm5hbWUsIHU4IGRldmljZSwgdTggbGV2ZWwsCiBzdGF0aWMgdm9pZCBf
X2luaXQgc2lvX2luaXQodm9pZCkKIHsKIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKnJvb3Q7CisJY29u
c3QgY2hhciAqbW9kZWw7CiAKLQlpZiAoKHJvb3QgPSBvZl9maW5kX25vZGVfYnlfcGF0aCgiLyIp
KSAmJgotCSAgICAhc3RybmNtcChvZl9nZXRfcHJvcGVydHkocm9vdCwgIm1vZGVsIiwgTlVMTCks
Ci0JCQkiSUJNLExvbmdUcmFpbCIsIDEzKSkgeworCXJvb3QgPSBvZl9maW5kX25vZGVfYnlfcGF0
aCgiLyIpOworCWlmICghcm9vdCkKKwkJcmV0dXJuOworCisJbW9kZWwgPSBvZl9nZXRfcHJvcGVy
dHkocm9vdCwgIm1vZGVsIiwgTlVMTCk7CisJaWYgKG1vZGVsICYmICFzdHJuY21wKG1vZGVsLCJJ
Qk0sTG9uZ1RyYWlsIiwgMTMpKSB7CiAJCS8qIGxvZ2ljYWwgZGV2aWNlIDAgKEtCQy9LZXlib2Fy
ZCkgKi8KIAkJc2lvX2ZpeHVwX2lycSgia2V5Ym9hcmQiLCAwLCAxLCAyKTsKIAkJLyogc2VsZWN0
IGxvZ2ljYWwgZGV2aWNlIDEgKEtCQy9Nb3VzZSkgKi8KIAkJc2lvX2ZpeHVwX2lycSgibW91c2Ui
LCAxLCAxMiwgMik7CiAJfQorCiAJb2Zfbm9kZV9wdXQocm9vdCk7CiB9CiAK
------=_Part_19488_23666844.1195796584724--
