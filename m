Message-ID: <32932.80.7.99.14.1073672878.squirrel@www.solinno.co.uk>
Date: Fri, 9 Jan 2004 18:27:58 -0000 (GMT)
Subject: [PATCH][TRIVIAL] Update comment in arch/ppc/kernel/head.S
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040109182758_83559"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


------=_20040109182758_83559
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Please, apply.

diff -urNX /home/leigh/.diffex linux-2.6.1-lbb-prev/arch/ppc/kernel/head.S
linux-2.6.1-lbb/arch/ppc/kernel/head.S
--- linux-2.6.1-lbb-prev/arch/ppc/kernel/head.S	Fri Jan  9 18:22:36 2004
+++ linux-2.6.1-lbb/arch/ppc/kernel/head.S	Fri Jan  9 18:23:39 2004
@@ -117,10 +117,10 @@
  * to its proper place in memory by the boot loader.  The expected layout
  * of the regs is:
  *   r3: ptr to residual data
- *   r4: initrd_start or if no initrd then 0
- *   r5: initrd_end - unused if r4 is 0
- *   r6: Start of command line string
- *   r7: End of command line string
+ *   r4: unused
+ *   r5: unused
+ *   r6: unused
+ *   r7: unused
  *
  * This just gets a minimal mmu environment setup so we can call
  * start_here() to do the real work.

------=_20040109182758_83559
Content-Type: application/octet-stream; name="head-prep-comment.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="head-prep-comment.diff"

ZGlmZiAtdXJOWCAvaG9tZS9sZWlnaC8uZGlmZmV4IGxpbnV4LTIuNi4xLWxiYi1wcmV2L2FyY2gv
cHBjL2tlcm5lbC9oZWFkLlMgbGludXgtMi42LjEtbGJiL2FyY2gvcHBjL2tlcm5lbC9oZWFkLlMK
LS0tIGxpbnV4LTIuNi4xLWxiYi1wcmV2L2FyY2gvcHBjL2tlcm5lbC9oZWFkLlMJRnJpIEphbiAg
OSAxODoyMjozNiAyMDA0CisrKyBsaW51eC0yLjYuMS1sYmIvYXJjaC9wcGMva2VybmVsL2hlYWQu
UwlGcmkgSmFuICA5IDE4OjIzOjM5IDIwMDQKQEAgLTExNywxMCArMTE3LDEwIEBACiAgKiB0byBp
dHMgcHJvcGVyIHBsYWNlIGluIG1lbW9yeSBieSB0aGUgYm9vdCBsb2FkZXIuICBUaGUgZXhwZWN0
ZWQgbGF5b3V0CiAgKiBvZiB0aGUgcmVncyBpczoKICAqICAgcjM6IHB0ciB0byByZXNpZHVhbCBk
YXRhCi0gKiAgIHI0OiBpbml0cmRfc3RhcnQgb3IgaWYgbm8gaW5pdHJkIHRoZW4gMAotICogICBy
NTogaW5pdHJkX2VuZCAtIHVudXNlZCBpZiByNCBpcyAwCi0gKiAgIHI2OiBTdGFydCBvZiBjb21t
YW5kIGxpbmUgc3RyaW5nCi0gKiAgIHI3OiBFbmQgb2YgY29tbWFuZCBsaW5lIHN0cmluZworICog
ICByNDogdW51c2VkCisgKiAgIHI1OiB1bnVzZWQKKyAqICAgcjY6IHVudXNlZAorICogICByNzog
dW51c2VkCiAgKgogICogVGhpcyBqdXN0IGdldHMgYSBtaW5pbWFsIG1tdSBlbnZpcm9ubWVudCBz
ZXR1cCBzbyB3ZSBjYW4gY2FsbAogICogc3RhcnRfaGVyZSgpIHRvIGRvIHRoZSByZWFsIHdvcmsu
Cg==
------=_20040109182758_83559--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
