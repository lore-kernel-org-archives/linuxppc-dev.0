Return-Path: <nd@bplan-gmbh.de>
Received: from smtp8.wanadoo.fr (smtp8.wanadoo.fr [193.252.22.23])
	by ozlabs.org (Postfix) with ESMTP id 1AA30679E1
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jun 2005 03:35:54 +1000 (EST)
Received: from smtp8.wanadoo.fr (mwinf0808 [172.22.139.38])
	by mwinf0810.wanadoo.fr (SMTP Server) with ESMTP id 51A211000570
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2005 19:16:01 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0808.wanadoo.fr (SMTP Server) with ESMTP id CC6261C00272
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2005 19:15:57 +0200 (CEST)
Received: from bplan-gmbh.de (ALyon-253-1-28-11.w83-205.abo.wanadoo.fr
	[83.205.155.11])
	by mwinf0808.wanadoo.fr (SMTP Server) with ESMTP id 9E86B1C00209
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2005 19:15:55 +0200 (CEST)
From: Nicolas DET <nd@bplan-gmbh.de>
To: linuxppc-dev@ozlabs.org
Date: 01 Jun 2005 19:14:13 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="--==bound210540b8135----"
Message-Id: <20050601171555.9E86B1C00209@mwinf0808.wanadoo.fr>
Subject: Tiny patch for arch/ppc/kernel/cputable.c to properly support the IBM
 PowerPC 750CXe rev 3.1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does not
support MIME. Some parts of this message will be readable as plain text.
To see the rest, you will need to upgrade your mail reader. Following are
some URLs where you can find MIME-capable mail programs for common
platforms:

  Amiga............: SimpleMail   http://simplemail.sourceforge.net/
  Unix.............: Metamail     ftp://ftp.bellcore.com/nsb/
  Windows/Macintosh: Eudora       http://www.qualcomm.com/

General info about MIME can be found at:

http://www.cis.ohio-state.edu/hypertext/faq/usenet/mail/mime-faq/top.html

----==bound210540b8135----

Hello,

You can find enclosed a small patch to properly support the 750 CXe rev
3.1. Indeed, the current kernel (2.6.11.11) only supports rev 2.1 and
ignores 3.1

It's a tiny patch: it only add an entry in the table with the correct PVR
and name. Others values has been copied from 750CXe rev 2.1.

I succesfully patched & compiled a vanila 2.6.11.11 from kernel.org.

Your sincerly,
-- 
Nicolas DET
MorphOS & Linux developer
----==bound210540b8135----
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=patch_750CXe_2.6.11
Content-transfer-encoding: base64

LS0tIGxpbnV4LTIuNi4xMS5vcmlnL2FyY2gvcHBjL2tlcm5lbC9jcHV0YWJsZS5jCTIwMDUtMDMt
MDIgMDg6Mzg6MDkuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjYuMTFfbmljby9hcmNoL3Bw
Yy9rZXJuZWwvY3B1dGFibGUuYwkyMDA1LTAzLTA0IDE1OjM5OjExLjAzMjk3NTA4OCArMDEwMApA
QCAtMTk4LDIwICsxOTgsNiBAQAogCQkubnVtX3BtY3MJCT0gNCwKIAkJLmNwdV9zZXR1cAkJPSBf
X3NldHVwX2NwdV83NTAKIAl9LAotCXsJLyogNzQ1Lzc1NSAqLwotCQkucHZyX21hc2sJCT0gMHhm
ZmZmZjAwMCwKLQkJLnB2cl92YWx1ZQkJPSAweDAwMDgzMDAwLAotCQkuY3B1X25hbWUJCT0gIjc0
NS83NTUiLAotCQkuY3B1X2ZlYXR1cmVzCQk9IENQVV9GVFJfQ09NTU9OIHwKLQkJCUNQVV9GVFJf
U1BMSVRfSURfQ0FDSEUgfCBDUFVfRlRSX01BWUJFX0NBTl9ET1pFIHwKLQkJCUNQVV9GVFJfVVNF
X1RCIHwgQ1BVX0ZUUl9MMkNSIHwgQ1BVX0ZUUl9UQVUgfAotCQkJQ1BVX0ZUUl9IUFRFX1RBQkxF
IHwgQ1BVX0ZUUl9NQVlCRV9DQU5fTkFQLAotCQkuY3B1X3VzZXJfZmVhdHVyZXMJPSBDT01NT05f
UFBDLAotCQkuaWNhY2hlX2JzaXplCQk9IDMyLAotCQkuZGNhY2hlX2JzaXplCQk9IDMyLAotCQku
bnVtX3BtY3MJCT0gNCwKLQkJLmNwdV9zZXR1cAkJPSBfX3NldHVwX2NwdV83NTAKLQl9LAogCXsJ
LyogNzUwQ1ggKDgwMTAwIGFuZCA4MDEweD8pICovCiAJCS5wdnJfbWFzawkJPSAweGZmZmZmZmYw
LAogCQkucHZyX3ZhbHVlCQk9IDB4MDAwODAxMDAsCkBAIC0yNTQsNiArMjQwLDM0IEBACiAJCS5u
dW1fcG1jcwkJPSA0LAogCQkuY3B1X3NldHVwCQk9IF9fc2V0dXBfY3B1Xzc1MGN4CiAJfSwKKwl7
CS8qIDc1MENYZSAoMDAwODIzMTEgb3IgMDAwODMzMTEpIHJldmlzaW9uIDMuMSAvIDMuMSBwcmVf
R0EgKi8KKwkJLnB2cl9tYXNrCQk9IDB4ZmZmZjBmZmYsCisJCS5wdnJfdmFsdWUJCT0gMHgwMDA4
MDMxMSwKKwkJLmNwdV9uYW1lCQk9ICI3NTBDWGUgcmV2IDMuMSIsCisJCS5jcHVfZmVhdHVyZXMJ
CT0gQ1BVX0ZUUl9DT01NT04gfAorCQkJQ1BVX0ZUUl9TUExJVF9JRF9DQUNIRSB8IENQVV9GVFJf
TUFZQkVfQ0FOX0RPWkUgfAorCQkJQ1BVX0ZUUl9VU0VfVEIgfCBDUFVfRlRSX0wyQ1IgfCBDUFVf
RlRSX1RBVSB8CisJCQlDUFVfRlRSX0hQVEVfVEFCTEUgfCBDUFVfRlRSX01BWUJFX0NBTl9OQVAs
CisJCS5jcHVfdXNlcl9mZWF0dXJlcwk9IENPTU1PTl9QUEMsCisJCS5pY2FjaGVfYnNpemUJCT0g
MzIsCisJCS5kY2FjaGVfYnNpemUJCT0gMzIsCisJCS5udW1fcG1jcwkJPSA0LAorCQkuY3B1X3Nl
dHVwCQk9IF9fc2V0dXBfY3B1Xzc1MGN4CisJfSwKKwl7CS8qIDc0NS83NTUgKi8KKwkJLnB2cl9t
YXNrCQk9IDB4ZmZmZmYwMDAsCisJCS5wdnJfdmFsdWUJCT0gMHgwMDA4MzAwMCwKKwkJLmNwdV9u
YW1lCQk9ICI3NDUvNzU1IiwKKwkJLmNwdV9mZWF0dXJlcwkJPSBDUFVfRlRSX0NPTU1PTiB8CisJ
CQlDUFVfRlRSX1NQTElUX0lEX0NBQ0hFIHwgQ1BVX0ZUUl9NQVlCRV9DQU5fRE9aRSB8CisJCQlD
UFVfRlRSX1VTRV9UQiB8IENQVV9GVFJfTDJDUiB8IENQVV9GVFJfVEFVIHwKKwkJCUNQVV9GVFJf
SFBURV9UQUJMRSB8IENQVV9GVFJfTUFZQkVfQ0FOX05BUCwKKwkJLmNwdV91c2VyX2ZlYXR1cmVz
CT0gQ09NTU9OX1BQQywKKwkJLmljYWNoZV9ic2l6ZQkJPSAzMiwKKwkJLmRjYWNoZV9ic2l6ZQkJ
PSAzMiwKKwkJLm51bV9wbWNzCQk9IDQsCisJCS5jcHVfc2V0dXAJCT0gX19zZXR1cF9jcHVfNzUw
CisJfSwKIAl7CS8qIDc1MEZYIHJldiAxLnggKi8KIAkJLnB2cl9tYXNrCQk9IDB4ZmZmZmZmMDAs
CiAJCS5wdnJfdmFsdWUJCT0gMHg3MDAwMDEwMCwK

----==bound210540b8135------
