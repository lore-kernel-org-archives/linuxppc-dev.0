Date: Sat, 12 Aug 2000 08:48:19 -0700 (PDT)
From: Keith Clayton <kclayton@jps.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Small fixes for 2.4.0test5, bk, thurs nite
Message-ID: <Pine.LNX.4.10.10008120843310.7199-300000@yoda.keith.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="98048-1165152143-966095299=:7199"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--98048-1165152143-966095299=:7199
Content-Type: TEXT/PLAIN; charset=US-ASCII

Ran into some minor probs with 2.4.0test5 rsync'd from bk thurs night.  I
apologize if they've already been fixed . . just getting around to
compiling the source this morning.

I've attached two patches, first against pmac_time.c which fixes a problem
when CONGIG_ADB_PMU is not set (in my case)

The second fixes a few bad defs in adbhid.c



<><><><><><><><><><><><>
Keith Clayton
kclayton@jps.net

*************************************************************************
*                      Have GPG?  Use it!                               *
*                                                                       *
* Why encrypt?  See my rant at http://www.jps.net/kclayton/encrypt.html *
*                                                                       *
* Public key: http://www.jps.net/kclayton/keith_public_key.html         *
* Or pull it from: http://www.keyserver.net                             *
*                                                                       *
* Key fingerprint = 0C47 F1A1 0434 588C 9457  D53F D86A 5449 43F6 09A0  *
*************************************************************************


--98048-1165152143-966095299=:7199
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="adbhid.patch"
Content-ID: <Pine.LNX.4.10.10008120848190.7199@yoda.keith.net>
Content-Description: 
Content-Disposition: attachment; filename="adbhid.patch"
Content-Transfer-Encoding: BASE64

LS0tIGFkYmhpZC5jLm9yaWcJU2F0IEF1ZyAxMiAwODowOTowNCAyMDAwDQor
KysgYWRiaGlkLmMJU2F0IEF1ZyAxMiAwODoxOToyOSAyMDAwDQpAQCAtMTI5
LDkgKzEyOSw5IEBADQogCWlmIChuYiAhPSAzIHx8IChkYXRhWzBdICYgMykg
IT0gS0VZQl9LRVlSRUcpDQogCQlyZXR1cm47CQkvKiBpZ25vcmUgaXQgKi8N
CiAJa2JkX3B0X3JlZ3MgPSByZWdzOw0KLQlpbnB1dF9rZXljb2RlKGlkLCBk
YXRhWzFdLCAwKTsNCisJYWRiaGlkX2lucHV0X2tleWNvZGUoaWQsIGRhdGFb
MV0sIDApOw0KIAlpZiAoIShkYXRhWzJdID09IDB4ZmYgfHwgKGRhdGFbMl0g
PT0gMHg3ZiAmJiBkYXRhWzFdID09IDB4N2YpKSkNCi0JCWlucHV0X2tleWNv
ZGUoaWQsIGRhdGFbMl0sIDApOw0KKwkJYWRiaGlkX2lucHV0X2tleWNvZGUo
aWQsIGRhdGFbMl0sIDApOw0KIH0NCiANCiBzdGF0aWMgdm9pZA0K
--98048-1165152143-966095299=:7199
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pmac_time.patch"
Content-ID: <Pine.LNX.4.10.10008120848191.7199@yoda.keith.net>
Content-Description: 
Content-Disposition: attachment; filename="pmac_time.patch"
Content-Transfer-Encoding: BASE64

LS0tIHBtYWNfdGltZS5jLm9yaWcJU2F0IEF1ZyAxMiAwNzo1OToxOSAyMDAw
DQorKysgcG1hY190aW1lLmMJU2F0IEF1ZyAxMiAwODowMTowNSAyMDAwDQpA
QCAtMTMzLDYgKzEzMyw3IEBADQogCQkJcHJpbnRrKEtFUk5fRVJSICJwbWFj
X3NldF9ydGNfdGltZTogZ290ICVkIGJ5dGUgcmVwbHlcbiIsDQogCQkJICAg
ICAgIHJlcS5yZXBseV9sZW4pOw0KIAkJcmV0dXJuIDE7DQorI2lmZGVmIENP
TkZJR19BREJfUE1VDQogCWNhc2UgU1lTX0NUUkxFUl9QTVU6DQogCQlpZiAo
cG11X3JlcXVlc3QoJnJlcSwgTlVMTCwgNSwgUE1VX1NFVF9SVEMsDQogCQkJ
CW5vd3RpbWUgPj4gMjQsIG5vd3RpbWUgPj4gMTYsIG5vd3RpbWUgPj4gOCwg
bm93dGltZSkgPCAwKQ0KQEAgLTE0Myw2ICsxNDQsNyBAQA0KIAkJCXByaW50
ayhLRVJOX0VSUiAicG1hY19zZXRfcnRjX3RpbWU6IGdvdCAlZCBieXRlIHJl
cGx5XG4iLA0KIAkJCSAgICAgICByZXEucmVwbHlfbGVuKTsNCiAJCXJldHVy
biAxOw0KKyNlbmRpZiAvKkNPTkZJR19BREJfUE1VICovDQogCWRlZmF1bHQ6
DQogCQlyZXR1cm4gMDsNCiAJfQ0K
--98048-1165152143-966095299=:7199--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
