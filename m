Message-ID: <19990922012702.19730.rocketmail@web120.yahoomail.com>
Date: Tue, 21 Sep 1999 18:27:02 -0700 (PDT)
From: David Hay <hay_dave@yahoo.com>
Reply-To: hay@colorado.edu
Subject: Re: USB driver not detecting mouse? (lots of detail)
To: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Cc: linuxdev <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1804289383-937963622=:19382"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--0-1804289383-937963622=:19382
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've attached the patch for the changes I had to make to get the USB driver
compiled under 2.2.12.  If anyone sees anything funny looking, pls let me
know.  Thanks!

--- Ira K Weiny <iweiny@falcon.csc.calpoly.edu> wrote:
> > 
> > I got the 2.3 USB code from cvs.on.openprojects.net.  I had to update it
> a
> > bit to include the 2.2 spinlock.h since it seems to have moved in the 2.3
> > kernel.  If I think of it, I'll try to make some patches once I get
> home...
> 

===
------------------------------------------------------------
 David Hay                                     \|/ ____ \|/
 hay@colorado.edu                              ~@-/ oO \-@~
 http://home.earthlink.net/~dhay/              /_( \__/ )_\
 ~ Live well ~ Laugh often ~ Love much ~          \__U_/
--0-1804289383-937963622=:19382
Content-Type: application/x-unknown; name="usb.patch"
Content-Description: usb.patch
Content-Disposition: attachment; filename="usb.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtdSAvaG9tZS9kaGF5L2xpbnV4L2RyaXZlcnMvdXNiL2h1Yi5jIC91
c3Ivc3JjL2xpbnV4L2RyaXZlcnMvdXNiL2h1Yi5jCi0tLSAvaG9tZS9kaGF5
L2xpbnV4L2RyaXZlcnMvdXNiL2h1Yi5jCUZyaSBTZXAgMTAgMTg6NDQ6MTMg
MTk5OQorKysgL3Vzci9zcmMvbGludXgvZHJpdmVycy91c2IvaHViLmMJU2F0
IFNlcCAxMSAwMDoxOTowMSAxOTk5CkBAIC0xMiw3ICsxMiwxMSBAQAogI2lu
Y2x1ZGUgPGxpbnV4L21hbGxvYy5oPgogI2luY2x1ZGUgPGxpbnV4L3NtcF9s
b2NrLmg+CiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaWYgTElOVVhf
VkVSU0lPTl9DT0RFIDwgMHgwMjAzMDAKKyNpbmNsdWRlIDxhc20vc3Bpbmxv
Y2suaD4KKyNlbHNlCiAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4KKyNl
bmRpZgogCiAjaW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4KIApkaWZmIC11IC9o
b21lL2RoYXkvbGludXgvZHJpdmVycy91c2IvbW91c2UuYyAvdXNyL3NyYy9s
aW51eC9kcml2ZXJzL3VzYi9tb3VzZS5jCi0tLSAvaG9tZS9kaGF5L2xpbnV4
L2RyaXZlcnMvdXNiL21vdXNlLmMJRnJpIFNlcCAxMCAxODo0NDoxNyAxOTk5
CisrKyAvdXNyL3NyYy9saW51eC9kcml2ZXJzL3VzYi9tb3VzZS5jCVR1ZSBT
ZXAgMjEgMTk6MjE6NTMgMTk5OQpAQCAtNDAsNyArNDAsMTEgQEAKICNpbmNs
dWRlIDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8bGludXgvbWFsbG9jLmg+
CiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaWYgTElOVVhfVkVSU0lP
Tl9DT0RFIDwgMHgwMjAzMDAKKyNpbmNsdWRlIDxhc20vc3BpbmxvY2suaD4K
KyNlbHNlCiAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4KKyNlbmRpZgog
CiAjaW5jbHVkZSAidXNiLmgiCiAKZGlmZiAtdSAvaG9tZS9kaGF5L2xpbnV4
L2RyaXZlcnMvdXNiL29oY2kuYyAvdXNyL3NyYy9saW51eC9kcml2ZXJzL3Vz
Yi9vaGNpLmMKLS0tIC9ob21lL2RoYXkvbGludXgvZHJpdmVycy91c2Ivb2hj
aS5jCUZyaSBTZXAgMTAgMTg6NDQ6MjMgMTk5OQorKysgL3Vzci9zcmMvbGlu
dXgvZHJpdmVycy91c2Ivb2hjaS5jCVNhdCBTZXAgMTEgMDA6MTY6MDAgMTk5
OQpAQCAtMzcsNyArMzcsMTEgQEAKICNpbmNsdWRlIDxsaW51eC9tYWxsb2Mu
aD4KICNpbmNsdWRlIDxsaW51eC9zbXBfbG9jay5oPgogI2luY2x1ZGUgPGxp
bnV4L2Vycm5vLmg+CisjaWYgTElOVVhfVkVSU0lPTl9DT0RFIDwgMHgwMjAz
MDAKKyNpbmNsdWRlIDxhc20vc3BpbmxvY2suaD4KKyNlbHNlCiAjaW5jbHVk
ZSA8bGludXgvc3BpbmxvY2suaD4KKyNlbmRpZgogCiAjaW5jbHVkZSA8YXNt
L2lvLmg+CiAjaW5jbHVkZSA8YXNtL2lycS5oPgpAQCAtMjc0NywxNCArMjc1
MSwyMyBAQAogICovCiBzdGF0aWMgaW50IGluaXRfb2hjaShzdHJ1Y3QgcGNp
X2RldiAqZGV2KQogeworI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA8IDB4MDIw
MzAwCisJdW5zaWduZWQgbG9uZyBtZW1fYmFzZSA9IGRldi0+YmFzZV9hZGRy
ZXNzWzBdOworI2Vsc2UKIAl1bnNpZ25lZCBsb25nIG1lbV9iYXNlID0gZGV2
LT5yZXNvdXJjZVswXS5mbGFnczsKKyNlbmRpZgogCQogCS8qIElmIGl0cyBP
SENJLCBpdHMgbWVtb3J5ICovCiAJaWYgKG1lbV9iYXNlICYgUENJX0JBU0Vf
QUREUkVTU19TUEFDRV9JTykKIAkJcmV0dXJuIC1FTk9ERVY7CiAKIAkvKiBH
ZXQgdGhlIG1lbW9yeSBhZGRyZXNzIGFuZCBtYXAgaXQgZm9yIElPICovCisj
aWYgTElOVVhfVkVSU0lPTl9DT0RFIDwgMHgwMjAzMDAKKwltZW1fYmFzZSAm
PSBQQ0lfQkFTRV9BRERSRVNTX01FTV9NQVNLOworI2Vsc2UKIAltZW1fYmFz
ZSA9IGRldi0+cmVzb3VyY2VbMF0uc3RhcnQ7CisjZW5kaWYKKwogCiAJLyog
bm8gaW50ZXJydXB0IHdvbid0IHdvcmsuLi4gKi8KIAlpZiAoZGV2LT5pcnEg
PT0gMCkgewpkaWZmIC11IC9ob21lL2RoYXkvbGludXgvZHJpdmVycy91c2Iv
dXNiLmggL3Vzci9zcmMvbGludXgvZHJpdmVycy91c2IvdXNiLmgKLS0tIC9o
b21lL2RoYXkvbGludXgvZHJpdmVycy91c2IvdXNiLmgJRnJpIFNlcCAxMCAx
ODo0NDozMSAxOTk5CisrKyAvdXNyL3NyYy9saW51eC9kcml2ZXJzL3VzYi91
c2IuaAlTYXQgU2VwIDE4IDE0OjM2OjA5IDE5OTkKQEAgLTEsNiArMSwxNCBA
QAogI2lmbmRlZiBfX0xJTlVYX1VTQl9ICiAjZGVmaW5lIF9fTElOVVhfVVNC
X0gKIAorI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA8IDB4MDIwMzAwCisjZGVm
aW5lIERFQ0xBUkVfV0FJVF9RVUVVRV9IRUFEKHcpICAgICBzdHJ1Y3Qgd2Fp
dF9xdWV1ZSAqdyA9IE5VTEwKKyNkZWZpbmUgREVDTEFSRV9XQUlUUVVFVUUo
dyxjKSAgICAgICAgIHN0cnVjdCB3YWl0X3F1ZXVlIHcgPSB7KGMpLCBOVUxM
fQorI2RlZmluZSB3YWl0X3F1ZXVlX2hlYWRfdCAgICAgICAgICAgICAgc3Ry
dWN0IHdhaXRfcXVldWUgKgorI2RlZmluZSBpbml0X3dhaXRxdWV1ZV9oZWFk
KHcpICAgICAgICAgKih3KSA9IDAKKyNkZWZpbmUgREVDTEFSRV9NVVRFWF9M
T0NLRUQoc2VtKSAgICAgIHN0cnVjdCBzZW1hcGhvcmUgc2VtID0gTVVURVhf
TE9DS0VECisjZW5kaWYKKwogI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CiAj
aW5jbHVkZSA8bGludXgvaW9jdGwuaD4KIAo=

--0-1804289383-937963622=:19382--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
