Date: Wed, 10 Oct 2001 21:15:42 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: <benh@kernel.crashing.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: I swear I'm stupid...
Message-ID: <Pine.LNX.4.33.0110102114040.30572-200000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1842346852-1766615134-1002770142=:30572"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1842346852-1766615134-1002770142=:30572
Content-Type: TEXT/PLAIN; charset=US-ASCII

Only tested with files that were under the "magic" 13 characters before -
didn't know that the offset value ended up always being 26! Now I've fixed
it so that longer names (greater than 13 characters) will get translated
correctly as well. Sorry for the bad patch.

/me LARTs self...

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN

--1842346852-1766615134-1002770142=:30572
Content-Type: TEXT/plain; name="vfat-lfn-fix-v2.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0110102115420.30572@andromeda.dsdk12.net>
Content-Description: 
Content-Disposition: attachment; filename="vfat-lfn-fix-v2.diff"

LS0tIG9yaWdzL2xpbnV4LTIuNC1iZW5oLmRpc3QvZnMvZmF0L2Rpci5jCVdl
ZCBPY3QgMTAgMDc6MTE6MzIgMjAwMQ0KKysrIGxpbnV4L2ZzL2ZhdC9kaXIu
YwlXZWQgT2N0IDEwIDIxOjA3OjA0IDIwMDENCkBAIC0yMzIsNiArMjMyLDEw
IEBADQogCQkJCW1lbWNweSgmdW5pY29kZVtvZmZzZXRdLCBkcy0+bmFtZTBf
NCwgMTApOw0KIAkJCQltZW1jcHkoJnVuaWNvZGVbb2Zmc2V0KzEwXSwgZHMt
Pm5hbWU1XzEwLCAxMik7DQogCQkJCW1lbWNweSgmdW5pY29kZVtvZmZzZXQr
MjJdLCBkcy0+bmFtZTExXzEyLCA0KTsNCisNCisJCQkJZm9yKGkgPSBvZmZz
ZXQ7IGkgPCBvZmZzZXQgKyAyNjsgaSArPSAyKQ0KKwkJCQkJX19sZTE2X3Rv
X2NwdXMoKHdjaGFyX3QgKikmdW5pY29kZVtpXSk7DQorDQogCQkJCW9mZnNl
dCArPSAyNjsNCiANCiAJCQkJaWYgKGRzLT5pZCAmIDB4NDApIHsNCkBAIC00
MzAsNiArNDM1LDEwIEBADQogCQkJbWVtY3B5KCZ1bmljb2RlW29mZnNldF0s
IGRzLT5uYW1lMF80LCAxMCk7DQogCQkJbWVtY3B5KCZ1bmljb2RlW29mZnNl
dCsxMF0sIGRzLT5uYW1lNV8xMCwgMTIpOw0KIAkJCW1lbWNweSgmdW5pY29k
ZVtvZmZzZXQrMjJdLCBkcy0+bmFtZTExXzEyLCA0KTsNCisNCisJCQlmb3Io
aSA9IG9mZnNldDsgaSA8IG9mZnNldCArIDI2OyBpICs9IDIpDQorCQkJCV9f
bGUxNl90b19jcHVzKCh3Y2hhcl90ICopJnVuaWNvZGVbaV0pOw0KKw0KIAkJ
CW9mZnNldCArPSAyNjsNCiANCiAJCQlpZiAoZHMtPmlkICYgMHg0MCkgew0K

--1842346852-1766615134-1002770142=:30572--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
