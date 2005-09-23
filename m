Return-Path: <det.nicolas@free.fr>
Received: from smtp6.wanadoo.fr (smtp6.wanadoo.fr [193.252.22.25])
	by ozlabs.org (Postfix) with ESMTP id B3ABE68373
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Sep 2005 01:22:46 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0609.wanadoo.fr (SMTP Server) with ESMTP id D5A4024000C6
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2005 17:22:43 +0200 (CEST)
From: Nicolas DET <det.nicolas@free.fr>
To: linuxppc-dev@ozlabs.org
Date: 23 Sep 2005 17:22:45 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="--==bound213431d8165----"
Message-Id: <20050923152242.BE6F62400135@mwinf0609.wanadoo.fr>
Cc: Andrew Morton <akpm@osdl.org>, Sven Luther <sl@bplan-gmbh.de>,
	David Holm <dholm@gentoo.org>
Subject: Tiny patch for cputable.c -> 750CXe support
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

----==bound213431d8165----

Hello,

You can find enclosed or at 
http://arrakin.homedns.org/~nicolas/cputable_750CXe_2.6.14.rc1.diff

A tiny patch which alow to correctly recognized every (let's hope) 750CXe
cpus.
Tested on my system (750 CXe rev 3.1, PVR: 0008 3311).

Feel free to comment and review it.

By the way, a nice 750CXe PVR summary can be found there:
http://www-306.ibm.com/chips/techlib/techlib.nsf/techdocs/291C8D0EF3EAEC1687256B72005C745C#C1

Regards,
-- 
Nicolas DET
MorphOS & Linux developer
----==bound213431d8165----
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=cputable_750CXe_2.6.14.rc1.diff
Content-transfer-encoding: base64

LS0tIGxpbnV4LTIuNi4xNC1yYzEvYXJjaC9wcGMva2VybmVsL2NwdXRhYmxlLmMJMjAwNS0wOS0x
NCAwODoxNDo0My42NzIyMTk1NjAgKzAyMDAKKysrIGxpbnV4LTIuNi4xNC1yYzFfbmljby9hcmNo
L3BwYy9rZXJuZWwvY3B1dGFibGUuYwkyMDA1LTA5LTIzIDE3OjAxOjQwLjM1NTAwMzAwMCArMDIw
MApAQCAtMTk4LDYgKzE5OCw3IEBACiAJCS5udW1fcG1jcwkJPSA0LAogCQkuY3B1X3NldHVwCQk9
IF9fc2V0dXBfY3B1Xzc1MAogCX0sCisJLy8gRm9yIHRoZSA3NTBDWCBmYW1pbGx5IHNlZTogIGh0
dHA6Ly93d3ctMzA2LmlibS5jb20vY2hpcHMvdGVjaGxpYi90ZWNobGliLm5zZi90ZWNoZG9jcy8y
OTFDOEQwRUYzRUFFQzE2ODcyNTZCNzIwMDVDNzQ1QyNDMQogCXsJLyogNzUwQ1ggKDgwMTAwIGFu
ZCA4MDEweD8pICovCiAJCS5wdnJfbWFzawkJPSAweGZmZmZmZmYwLAogCQkucHZyX3ZhbHVlCQk9
IDB4MDAwODAxMDAsCkBAIC0yMTIsMTAgKzIxMywxMCBAQAogCQkubnVtX3BtY3MJCT0gNCwKIAkJ
LmNwdV9zZXR1cAkJPSBfX3NldHVwX2NwdV83NTBjeAogCX0sCi0JewkvKiA3NTBDWCAoODIyMDEg
YW5kIDgyMjAyKSAqLwotCQkucHZyX21hc2sJCT0gMHhmZmZmZmZmMCwKLQkJLnB2cl92YWx1ZQkJ
PSAweDAwMDgyMjAwLAotCQkuY3B1X25hbWUJCT0gIjc1MENYIiwKKwl7CS8qIDc1MENYZSAoODIy
MDIpICovCisJCS5wdnJfbWFzawkJPSAweGZmZmZmZmZmLAorCQkucHZyX3ZhbHVlCQk9IDB4MDAw
ODIyMDIsCisJCS5jcHVfbmFtZQkJPSAiNzUwQ1hlIHJldiAyLjIiLAogCQkuY3B1X2ZlYXR1cmVz
CQk9IENQVV9GVFJfQ09NTU9OIHwKIAkJCUNQVV9GVFJfU1BMSVRfSURfQ0FDSEUgfCBDUFVfRlRS
X01BWUJFX0NBTl9ET1pFIHwKIAkJCUNQVV9GVFJfVVNFX1RCIHwgQ1BVX0ZUUl9MMkNSIHwgQ1BV
X0ZUUl9UQVUgfApAQCAtMjI2LDEwICsyMjcsMjQgQEAKIAkJLm51bV9wbWNzCQk9IDQsCiAJCS5j
cHVfc2V0dXAJCT0gX19zZXR1cF9jcHVfNzUwY3gKIAl9LAotCXsJLyogNzUwQ1hlICg4MjIxNCkg
Ki8KLQkJLnB2cl9tYXNrCQk9IDB4ZmZmZmZmZjAsCi0JCS5wdnJfdmFsdWUJCT0gMHgwMDA4MjIx
MCwKLQkJLmNwdV9uYW1lCQk9ICI3NTBDWGUiLAorCXsJLyogNzUwQ1hlICg4MjIxNCAmIDgyMzE0
KSAqLworCQkucHZyX21hc2sJCT0gMHhmZmZmZjBmZiwKKwkJLnB2cl92YWx1ZQkJPSAweDAwMDgy
MjE0LAorCQkuY3B1X25hbWUJCT0gIjc1MENYZSByZXYgMi40IiwKKwkJLmNwdV9mZWF0dXJlcwkJ
PSBDUFVfRlRSX0NPTU1PTiB8CisJCQlDUFVfRlRSX1NQTElUX0lEX0NBQ0hFIHwgQ1BVX0ZUUl9N
QVlCRV9DQU5fRE9aRSB8CisJCQlDUFVfRlRSX1VTRV9UQiB8IENQVV9GVFJfTDJDUiB8IENQVV9G
VFJfVEFVIHwKKwkJCUNQVV9GVFJfSFBURV9UQUJMRSB8IENQVV9GVFJfTUFZQkVfQ0FOX05BUCwK
KwkJLmNwdV91c2VyX2ZlYXR1cmVzCT0gQ09NTU9OX1BQQywKKwkJLmljYWNoZV9ic2l6ZQkJPSAz
MiwKKwkJLmRjYWNoZV9ic2l6ZQkJPSAzMiwKKwkJLm51bV9wbWNzCQk9IDQsCisJCS5jcHVfc2V0
dXAJCT0gX19zZXR1cF9jcHVfNzUwY3gKKwl9LAorCXsJLyogNzUwQ1hlICgwMDA4MjMxMSBvciAw
MDA4MzMxMSkgcmV2aXNpb24gMy4xIC8gMy4xIHByZV9HQSAqLworCQkucHZyX21hc2sJCT0gMHhm
ZmZmMGZmZiwKKwkJLnB2cl92YWx1ZQkJPSAweDAwMDgwMzExLAorCQkuY3B1X25hbWUJCT0gIjc1
MENYZSByZXYgMy4xIiwKIAkJLmNwdV9mZWF0dXJlcwkJPSBDUFVfRlRSX0NPTU1PTiB8CiAJCQlD
UFVfRlRSX1NQTElUX0lEX0NBQ0hFIHwgQ1BVX0ZUUl9NQVlCRV9DQU5fRE9aRSB8CiAJCQlDUFVf
RlRSX1VTRV9UQiB8IENQVV9GVFJfTDJDUiB8IENQVV9GVFJfVEFVIHwKQEAgLTI0Myw3ICsyNTgs
MjEgQEAKIAl7CS8qIDc1MENYZSAiR2Vra28iICg4MzIxNCkgKi8KIAkJLnB2cl9tYXNrCQk9IDB4
ZmZmZmZmZmYsCiAJCS5wdnJfdmFsdWUJCT0gMHgwMDA4MzIxNCwKLQkJLmNwdV9uYW1lCQk9ICI3
NTBDWGUiLAorCQkuY3B1X25hbWUJCT0gIjc1MENYZSAnR2Vra28nIiwKKwkJLmNwdV9mZWF0dXJl
cwkJPSBDUFVfRlRSX0NPTU1PTiB8CisJCQlDUFVfRlRSX1NQTElUX0lEX0NBQ0hFIHwgQ1BVX0ZU
Ul9NQVlCRV9DQU5fRE9aRSB8CisJCQlDUFVfRlRSX1VTRV9UQiB8IENQVV9GVFJfTDJDUiB8IENQ
VV9GVFJfVEFVIHwKKwkJCUNQVV9GVFJfSFBURV9UQUJMRSB8IENQVV9GVFJfTUFZQkVfQ0FOX05B
UCwKKwkJLmNwdV91c2VyX2ZlYXR1cmVzCT0gQ09NTU9OX1BQQywKKwkJLmljYWNoZV9ic2l6ZQkJ
PSAzMiwKKwkJLmRjYWNoZV9ic2l6ZQkJPSAzMiwKKwkJLm51bV9wbWNzCQk9IDQsCisJCS5jcHVf
c2V0dXAJCT0gX19zZXR1cF9jcHVfNzUwY3gKKwl9LAorCXsJLyogNzUwQ1ggKDgyMjAxIGFuZCA4
MjIwMikgKi8KKwkJLnB2cl9tYXNrCQk9IDB4ZmZmZmZmZjAsCisJCS5wdnJfdmFsdWUJCT0gMHgw
MDA4MjIwMCwKKwkJLmNwdV9uYW1lCQk9ICI3NTBDWCIsCiAJCS5jcHVfZmVhdHVyZXMJCT0gQ1BV
X0ZUUl9DT01NT04gfAogCQkJQ1BVX0ZUUl9TUExJVF9JRF9DQUNIRSB8IENQVV9GVFJfTUFZQkVf
Q0FOX0RPWkUgfAogCQkJQ1BVX0ZUUl9VU0VfVEIgfCBDUFVfRlRSX0wyQ1IgfCBDUFVfRlRSX1RB
VSB8Cg==

----==bound213431d8165------
