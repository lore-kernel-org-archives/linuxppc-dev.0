Date: Mon, 28 Dec 1998 18:15:09 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: cort@cs.nmt.edu, paulus@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org, linux-pmac@samba.anu.edu.au
Subject: 2.2.0 pre1 (Ack!)
Message-ID: <Pine.LNX.4.05.9812281811330.988-200000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811583-2046452598-914886909=:988"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811583-2046452598-914886909=:988
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello,
  Well, Linus has gone and released 2.2.0-pre1.  And it of course, doesn't
compile on ppc due to some new changes (tho I think alpha, sparc, et all
are whacked now too).  I've attached a patch I wrote vs 2.1.33-pre5 which
seemed to fix it, tho I have no idea of how correct it is.  Could any of
the knowledgable (or even the slightly less knowledgable) comment on it?
(And if it works, send it along, along w/ some more bits and pieces (bmac
update and mace hopefully really soon)).

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/

---1463811583-2046452598-914886909=:988
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pre-patch-2.1.133-5-ppc"
Content-ID: <Pine.LNX.4.05.9812281815090.988@pc.wackyland.com>
Content-Description: 
Content-Disposition: attachment; filename="pre-patch-2.1.133-5-ppc"
Content-Transfer-Encoding: BASE64

LS0tIGluY2x1ZGUvYXNtLXBwYy9pbml0LmgJRnJpIE1heSAgOCAwMzoxODoy
MyAxOTk4DQorKysgaW5jbHVkZS9hc20tcHBjL2luaXQuaAlNb24gRGVjIDI4
IDExOjE3OjIzIDE5OTgNCkBAIC0zMSw2ICszMSw5IEBADQogI2RlZmluZSBf
X0ZJTklUCS5wcmV2aW91cw0KICNkZWZpbmUgX19JTklUREFUQQkuc2VjdGlv
bgkiLmRhdGEuaW5pdCIsI2FsbG9jLCN3cml0ZQ0KIA0KKyNkZWZpbmUgX19j
YWNoZWxpbmVfYWxpZ25lZCBfX2F0dHJpYnV0ZV9fIFwNCisJCQkoKF9fc2Vj
dGlvbl9fICgiLmRhdGEuY2FjaGVsaW5lX2FsaWduZWQiKSkpDQorDQogI2Vs
c2UgLyogbm90IGVnY3MgKi8NCiANCiAjZGVmaW5lIF9faW5pdA0KQEAgLTUy
LDUgKzU1LDcgQEANCiAjZGVmaW5lIF9fb3BlbmZpcm13YXJlDQogI2RlZmlu
ZSBfX29wZW5maXJtd2FyZWRhdGENCiAjZGVmaW5lIF9fb3BlbmZpcm13YXJl
ZnVuYyh4KSB4DQorDQorI2RlZmluZSBfX2NhY2hlbGluZV9hbGlnbmVkDQog
I2VuZGlmIC8qIGVnY3MgKi8NCiAjZW5kaWYNCi0tLSBpbmNsdWRlL2FzbS1w
cGMvdGltZXguaAlNb24gRGVjIDI4IDExOjA5OjUxIDE5OTgNCisrKyBpbmNs
dWRlL2FzbS1wcGMvdGltZXguaAlNb24gRGVjIDI4IDExOjEyOjAyIDE5OTgN
CkBAIC0xMiw0ICsxMiwxOCBAQA0KIAkoMTAwMDAwMC9DTE9DS19USUNLX0ZB
Q1RPUikgLyAoQ0xPQ0tfVElDS19SQVRFL0NMT0NLX1RJQ0tfRkFDVE9SKSkg
XA0KIAkJPDwgKFNISUZUX1NDQUxFLVNISUZUX0haKSkgLyBIWikNCiANCit0
eXBlZGVmIHVuc2lnbmVkIGxvbmcgbG9uZyBjeWNsZXNfdDsNCisNCitleHRl
cm4gY3ljbGVzX3QgY2FjaGVmbHVzaF90aW1lOw0KKw0KK3N0YXRpYyBpbmxp
bmUgY3ljbGVzX3QgZ2V0X2N5Y2xlcyAodm9pZCkNCit7DQorCWN5Y2xlc190
IHZhbHVlOw0KKw0KKwlfX2FzbV9fKCJyZHRzYyINCisJCToiPWEiICgqKCgo
aW50ICopJnZhbHVlKSswKSksDQorCQkgIj1kIiAoKigoKGludCAqKSZ2YWx1
ZSkrMSkpKTsNCisJcmV0dXJuIHZhbHVlOw0KK30NCisNCiAjZW5kaWYNCg==
---1463811583-2046452598-914886909=:988--

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
