Return-Path: <j.glisse@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id 83FEE2BF0E
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jan 2005 02:40:58 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 36so178007wra
	for <linuxppc-dev@ozlabs.org>; Sun, 09 Jan 2005 07:40:56 -0800 (PST)
Message-ID: <4240b916050109074053e328b1@mail.gmail.com>
Date: Sun, 9 Jan 2005 16:40:56 +0100
From: Jerome Glisse <j.glisse@gmail.com>
To: trini@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	linuxppc64-dev@ozlabs.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1544_31757278.1105285256542"
Subject: Classic PPC specific ASM (CONFIG_6XX)
Reply-To: Jerome Glisse <j.glisse@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_1544_31757278.1105285256542
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

With 2.6.10 i get a compilation error with disable_6xx_mmu
i guess this is linked with the patch you supplied in december
in arch/ppc/boot/common/util.S

Patch which comment disable_6xx_mmu if flags CONFIG_6XX
not defined. The problem arise in arch/ppc/boot/simple/misc-prep.c
where there is no conditional compilation for this function.

Attached is a patch that use the flags CONFIG_6XX to comment
out call to this function if flags not set.

By the way there is many compilation warning related to PPC with 2.6.10
anyone looking to correct them ?

Signed-off-by: Jerome Glisse <j.glisse@gmail.com>

best,
Jerome Glisse

------=_Part_1544_31757278.1105285256542
Content-Type: application/octet-stream; name="disable_6xx-patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="disable_6xx-patch"

ZGlmZiAtTnJ1IGxpbnV4L2FyY2gvcHBjL2Jvb3Qvc2ltcGxlL21pc2MtcHJlcC5jIGxpbnV4LTIu
Ni4xMC9hcmNoL3BwYy9ib290L3NpbXBsZS9taXNjLXByZXAuYwotLS0gbGludXgvYXJjaC9wcGMv
Ym9vdC9zaW1wbGUvbWlzYy1wcmVwLmMJMjAwNC0xMi0yNCAyMjozMzo1MS4wMDAwMDAwMDAgKzAx
MDAKKysrIGxpbnV4LTIuNi4xMC9hcmNoL3BwYy9ib290L3NpbXBsZS9taXNjLXByZXAuYwkyMDA1
LTAxLTA5IDE2OjMwOjU5LjkzODc2NjQ0OCArMDEwMApAQCAtMzQsNyArMzQsOSBAQAogZXh0ZXJu
IHZvaWQgc2VyaWFsX2ZpeHVwcyh2b2lkKTsKIGV4dGVybiBzdHJ1Y3QgYmlfcmVjb3JkICpkZWNv
bXByZXNzX2tlcm5lbCh1bnNpZ25lZCBsb25nIGxvYWRfYWRkciwKIAkJaW50IG51bV93b3Jkcywg
dW5zaWduZWQgbG9uZyBja3N1bSk7CisjaWZkZWYgQ09ORklHXzZYWAogZXh0ZXJuIHZvaWQgZGlz
YWJsZV82eHhfbW11KHZvaWQpOworI2VuZGlmCiBleHRlcm4gdW5zaWduZWQgbG9uZyBtcGMxMHhf
Z2V0X21lbV9zaXplKHZvaWQpOwogCiBzdGF0aWMgdm9pZApAQCAtMTUyLDkgKzE1NCwxMSBAQAog
CQlob2xkX3Jlc2lkdWFsLT5WaXRhbFByb2R1Y3REYXRhLlJlc2VydmVkNSA9IDB4ZGVhZGJlZWY7
CiAJfQogCisJI2lmZGVmIENPTkZJR182WFgKIAkvKiBOb3cgZ28gYW5kIGNsZWFyIG91dCB0aGUg
QkFUcyBhbmQgZW5zdXJlIHRoYXQgb3VyIE1TUiBpcwogCSAqIGNvcnJlY3QgLiovCiAJZGlzYWJs
ZV82eHhfbW11KCk7CisJI2VuZGlmCiAKIAkvKiBNYWtlIHIzIGJlIGEgcG9pbnRlciB0byB0aGUg
cmVzaWR1YWwgZGF0YS4gKi8KIAlyZXR1cm4gKHVuc2lnbmVkIGxvbmcpaG9sZF9yZXNpZHVhbDsK

------=_Part_1544_31757278.1105285256542--
