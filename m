Date: Sun, 9 Jul 2000 01:09:49 -0700 (PDT)
From: Forwarded SuSE Mail <suse@linux-ide.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Michel Lanners <mlan@cpu.lu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Crash in IDE code
In-Reply-To: <Pine.LNX.4.10.10007081406230.833-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10007090108570.2423-200000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1019260510-1237063275-963130189=:2423"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1019260510-1237063275-963130189=:2423
Content-Type: text/plain; charset=us-ascii


Apply this against any 2.4.0-test3 and it should go.

If this fails then holler.

Cheers,

Andre Hedrick
The Linux ATA/IDE guy


---1019260510-1237063275-963130189=:2423
Content-Type: text/plain; charset=us-ascii; name="altstatus.diff"
Content-ID: <Pine.LNX.4.10.10007090109490.2423@master.linux-ide.org>
Content-Description: 
Content-Disposition: attachment; filename="altstatus.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtdXJOIGxpbnV4LTIuNC4wLXQzLTYvZHJpdmVycy9pZGUvaWRlLmMg
bGludXgtMi40LjAtdDMtNi4xL2RyaXZlcnMvaWRlL2lkZS5jDQotLS0gbGlu
dXgtMi40LjAtdDMtNi9kcml2ZXJzL2lkZS9pZGUuYwlTYXQgSnVsICA4IDAy
OjAxOjE4IDIwMDANCisrKyBsaW51eC0yLjQuMC10My02LjEvZHJpdmVycy9p
ZGUvaWRlLmMJU2F0IEp1bCAgOCAyMjo0MjowOSAyMDAwDQpAQCAtNDgxLDEz
ICs0ODEsMTkgQEANCiAgKi8NCiBzdGF0aWMgaW5saW5lIGludCBkcml2ZV9p
c19yZWFkeSAoaWRlX2RyaXZlX3QgKmRyaXZlKQ0KIHsNCisJYnl0ZSBzdGF0
ID0gMDsNCiAJaWYgKGRyaXZlLT53YWl0aW5nX2Zvcl9kbWEpDQogCQlyZXR1
cm4gSFdJRihkcml2ZSktPmRtYXByb2MoaWRlX2RtYV90ZXN0X2lycSwgZHJp
dmUpOw0KICNpZiAwDQogCXVkZWxheSgxKTsJLyogbmVlZCB0byBndWFyYW50
ZWUgNDAwbnMgc2luY2UgbGFzdCBjb21tYW5kIHdhcyBpc3N1ZWQgKi8NCiAj
ZW5kaWYNCi0vLwlpZiAoR0VUX1NUQVQoKSAmIEJVU1lfU1RBVCkJLyogTm90
ZTogdGhpcyBtYXkgY2xlYXIgYSBwZW5kaW5nIElSUSEhICovDQotCWlmIChJ
Tl9CWVRFKElERV9BTFRTVEFUVVNfUkVHKSAmIEJVU1lfU1RBVCkNCisNCisJ
aWYgKElERV9DT05UUk9MX1JFRykNCisJCXN0YXQgPSBHRVRfQUxUU1RBVCgp
Ow0KKwllbHNlDQorCQlzdGF0ID0gR0VUX1NUQVQoKTsJLyogTm90ZTogdGhp
cyBtYXkgY2xlYXIgYSBwZW5kaW5nIElSUSEhICovDQorDQorCWlmIChzdGF0
ICYgQlVTWV9TVEFUKQ0KIAkJcmV0dXJuIDA7CS8qIGRyaXZlIGJ1c3k6ICBk
ZWZpbml0ZWx5IG5vdCBpbnRlcnJ1cHRpbmcgKi8NCiAJcmV0dXJuIDE7CQkv
KiBkcml2ZSByZWFkeTogKm1pZ2h0KiBiZSBpbnRlcnJ1cHRpbmcgKi8NCiB9
DQpkaWZmIC11ck4gbGludXgtMi40LjAtdDMtNi9pbmNsdWRlL2xpbnV4L2lk
ZS5oIGxpbnV4LTIuNC4wLXQzLTYuMS9pbmNsdWRlL2xpbnV4L2lkZS5oDQot
LS0gbGludXgtMi40LjAtdDMtNi9pbmNsdWRlL2xpbnV4L2lkZS5oCVNhdCBK
dWwgIDggMDI6MDE6MjkgMjAwMA0KKysrIGxpbnV4LTIuNC4wLXQzLTYuMS9p
bmNsdWRlL2xpbnV4L2lkZS5oCVNhdCBKdWwgIDggMjI6NTM6MDQgMjAwMA0K
QEAgLTE2Miw2ICsxNjIsNyBAQA0KIA0KICNkZWZpbmUgR0VUX0VSUigpCQlJ
Tl9CWVRFKElERV9FUlJPUl9SRUcpDQogI2RlZmluZSBHRVRfU1RBVCgpCQlJ
Tl9CWVRFKElERV9TVEFUVVNfUkVHKQ0KKyNkZWZpbmUgR0VUX0FMVFNUQVQo
KQkJSU5fQllURShJREVfQ09OVFJPTF9SRUcpDQogI2RlZmluZSBPS19TVEFU
KHN0YXQsZ29vZCxiYWQpCSgoKHN0YXQpJigoZ29vZCl8KGJhZCkpKT09KGdv
b2QpKQ0KICNkZWZpbmUgQkFEX1JfU1RBVAkJKEJVU1lfU1RBVCAgIHwgRVJS
X1NUQVQpDQogI2RlZmluZSBCQURfV19TVEFUCQkoQkFEX1JfU1RBVCAgfCBX
UkVSUl9TVEFUKQ0K
---1019260510-1237063275-963130189=:2423--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
