Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2731C67A64
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Apr 2005 23:57:29 +1000 (EST)
Message-ID: <425147C4.10906@gmx.net>
Date: Mon, 04 Apr 2005 15:57:24 +0200
From: Christian <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <423B788F.7040705@kegel.com> <42509DB9.4090609@gmx.net>
In-Reply-To: <42509DB9.4090609@gmx.net>
Content-Type: multipart/mixed; boundary="------------080309090200000708060400"
Cc: Dan Kegel <dank@kegel.com>
Subject: Re: gcc4 compile fixes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080309090200000708060400
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

replying to myself:

Christian wrote:
> now it [1] fails with:
> 
> In file included from arch/ppc/kernel/time.c:68:
> include/asm/time.h:61: warning: type qualifiers ignored on function return
> type
[...]

..and there were other error messages too. not knowing a *bit* of C, i was
able to do minor alterations which i deduced from gcc's error messages.
now compiling for ppc604 (PReP) with gcc4 succeeds.

thank you for your concern,
Christian.
- --
BOFH excuse #403:

Sysadmin didn't hear pager go off due to loud music from bar-room speakers.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCUUfEC/PVm5+NVoYRAiMYAKCVru912jky9ctrnAhBe+ukymReQgCg9z6Y
YSNKwksGyXiDKgxpvGhO1wM=
=WSll
-----END PGP SIGNATURE-----

--------------080309090200000708060400
Content-Type: text/plain;
 name="2.6.11.6.gcc4_compile_fixes-take2.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline; filename="2.6.11.6.gcc4_compile_fixes-take2.diff"

LS0tIGxpbnV4LTIuNi9hcmNoL3BwYy9zeXNsaWIvb3Blbl9waWNfZGVmcy5oLm9yaWcJMjAw
NS0wNC0wNCAxNTowMTozOS41ODE4MjQ1MzggKzAyMDAKKysrIGxpbnV4LTIuNi9hcmNoL3Bw
Yy9zeXNsaWIvb3Blbl9waWNfZGVmcy5oCTIwMDUtMDQtMDQgMTU6MDE6NTIuNjc5Njk2OTcy
ICswMjAwCkBAIC0xNzIsNyArMTcyLDcgQEAKICAgICBPcGVuUElDX1Byb2Nlc3NvciBQcm9j
ZXNzb3JbT1BFTlBJQ19NQVhfUFJPQ0VTU09SU107CiB9OwogCi1leHRlcm4gdm9sYXRpbGUg
c3RydWN0IE9wZW5QSUMgX19pb21lbSAqT3BlblBJQzsKK3N0YXRpYyB2b2xhdGlsZSBzdHJ1
Y3QgT3BlblBJQyBfX2lvbWVtICpPcGVuUElDOwogCiAKICAgICAvKgotLS0gbGludXgtMi42
L2FyY2gvcHBjL2tlcm5lbC90aW1lLmMub3JpZwkyMDA1LTA0LTA0IDE1OjEyOjQxLjk2Mzgw
MTU3NSArMDIwMAorKysgbGludXgtMi42L2FyY2gvcHBjL2tlcm5lbC90aW1lLmMJMjAwNS0w
NC0wNCAxNToxMjo1Ni4zOTA1NTk2MDggKzAyMDAKQEAgLTg5LDcgKzg5LDcgQEAKIAogZXh0
ZXJuIHVuc2lnbmVkIGxvbmcgd2FsbF9qaWZmaWVzOwogCi1zdGF0aWMgbG9uZyB0aW1lX29m
ZnNldDsKK2V4dGVybiBsb25nIHRpbWVfb2Zmc2V0OwogCiBERUZJTkVfU1BJTkxPQ0socnRj
X2xvY2spOwogCi0tLSBsaW51eC0yLjYvaW5jbHVkZS9hc20tcHBjL3RpbWUuaC5vcmlnCTIw
MDUtMDQtMDQgMTQ6NDc6NTUuNTI2NzY1NTY5ICswMjAwCisrKyBsaW51eC0yLjYvaW5jbHVk
ZS9hc20tcHBjL3RpbWUuaAkyMDA1LTA0LTA0IDE0OjQ5OjU5LjA3NTEyOTU3MSArMDIwMApA
QCAtNTgsNyArNTgsNyBAQAogLyogQWNjZXNzb3IgZnVuY3Rpb25zIGZvciB0aGUgdGltZWJh
c2UgKFJUQyBvbiA2MDEpIHJlZ2lzdGVycy4gKi8KIC8qIElmIG9uZSBkYXkgQ09ORklHX1BP
V0VSIGlzIGFkZGVkIGp1c3QgZGVmaW5lIF9fVVNFX1JUQyBhcyAxICovCiAjaWZkZWYgQ09O
RklHXzZ4eAotZXh0ZXJuIF9faW5saW5lX18gaW50IGNvbnN0IF9fVVNFX1JUQyh2b2lkKSB7
CitzdGF0aWMgX19pbmxpbmVfXyBpbnQgY29uc3QgX19VU0VfUlRDKHZvaWQpIHsKIAlyZXR1
cm4gKG1mc3ByKFNQUk5fUFZSKT4+MTYpID09IDE7CiB9CiAjZWxzZQpAQCAtOTIsNyArOTIs
NyBAQAogCW10c3ByKFNQUk5fVEJXTCwgbG93ZXIpOwogfQogCi1leHRlcm4gX19pbmxpbmVf
XyB1bnNpZ25lZCBsb25nIGdldF9ydGNsKHZvaWQpIHsKK3N0YXRpYyBfX2lubGluZV9fIHVu
c2lnbmVkIGxvbmcgZ2V0X3J0Y2wodm9pZCkgewogCXVuc2lnbmVkIGxvbmcgcnRjbDsKIAlh
c20gdm9sYXRpbGUoIm1mcnRjbCAlMCIgOiAiPXIiIChydGNsKSk7CiAJcmV0dXJuIHJ0Y2w7
Ci0tLSBsaW51eC0yLjYvaW5jbHVkZS9hc20tcHBjL3Byb20uaC5vcmlnCTIwMDUtMDQtMDQg
MTQ6NTY6NTAuMDE0NzUyNzEwICswMjAwCisrKyBsaW51eC0yLjYvaW5jbHVkZS9hc20tcHBj
L3Byb20uaAkyMDA1LTA0LTA0IDE0OjU5OjU5LjgwNTQxNDA2MyArMDIwMApAQCAtMTMsOCAr
MTMsOCBAQAogdHlwZWRlZiB2b2lkICpwaGFuZGxlOwogdHlwZWRlZiB2b2lkICppaGFuZGxl
OwogCi1leHRlcm4gY2hhciAqcHJvbV9kaXNwbGF5X3BhdGhzW107Ci1leHRlcm4gdW5zaWdu
ZWQgaW50IHByb21fbnVtX2Rpc3BsYXlzOworc3RhdGljIGNoYXIgKnByb21fZGlzcGxheV9w
YXRoc1tdOworc3RhdGljIHVuc2lnbmVkIGludCBwcm9tX251bV9kaXNwbGF5czsKIAogc3Ry
dWN0IGFkZHJlc3NfcmFuZ2UgewogCXVuc2lnbmVkIGludCBzcGFjZTsK
--------------080309090200000708060400--
