Date: Wed, 10 Oct 2001 20:10:25 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: <benh@kernel.crashing.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Patch to kernel to make long names work on big-endian systems with
 VFAT
Message-ID: <Pine.LNX.4.33.0110102007560.29867-200000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1842346852-615257861-1002766225=:29867"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1842346852-615257861-1002766225=:29867
Content-Type: TEXT/PLAIN; charset=US-ASCII

Figured I'd send this to Ben and the LinuxPPC devel list, because I think
everyone will want to see this. I figured out the mods to make in the vfat
FS driver to reorder the (little-endian) wide-character data for the long
name entries so that big-endian systems (like PowerPC) can read and write
VFAT filesystems correctly - finally, no more filenames like
"????????????".

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN

--1842346852-615257861-1002766225=:29867
Content-Type: TEXT/plain; name="vfat-lfn-fix.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0110102010250.29867@andromeda.dsdk12.net>
Content-Description: 
Content-Disposition: attachment; filename="vfat-lfn-fix.diff"

LS0tIG9yaWdzL2xpbnV4LTIuNC1iZW5oLmRpc3QvZnMvZmF0L2Rpci5jCVdl
ZCBPY3QgMTAgMDc6MTE6MzIgMjAwMQ0KKysrIGxpbnV4L2ZzL2ZhdC9kaXIu
YwlXZWQgT2N0IDEwIDE5OjU5OjU3IDIwMDENCkBAIC0yNTAsNiArMjUwLDEw
IEBADQogCQkJCWlmIChkcy0+YWxpYXNfY2hlY2tzdW0gIT0gYWxpYXNfY2hl
Y2tzdW0pDQogCQkJCQlnb3RvIHBhcnNlX2xvbmc7DQogCQkJfQ0KKw0KKwkJ
CWZvcihpID0gMDsgaSA8IG9mZnNldDsgaSArPSAyKQ0KKwkJCQlfX2xlMTZf
dG9fY3B1cygod2NoYXJfdCAqKSZ1bmljb2RlW2ldKTsNCisNCiAJCQlpZiAo
ZGUtPm5hbWVbMF0gPT0gKF9fczgpIERFTEVURURfRkxBRykNCiAJCQkJY29u
dGludWU7DQogCQkJaWYgKGRlLT5hdHRyID09ICBBVFRSX0VYVCkNCkBAIC00
NDgsNiArNDUyLDEwIEBADQogCQkJaWYgKGRzLT5hbGlhc19jaGVja3N1bSAh
PSBhbGlhc19jaGVja3N1bSkNCiAJCQkJZ290byBQYXJzZUxvbmc7DQogCQl9
DQorDQorCQlmb3IoaSA9IDA7IGkgPCBvZmZzZXQ7IGkgKz0gMikNCisJCQlf
X2xlMTZfdG9fY3B1cygod2NoYXJfdCAqKSZ1bmljb2RlW2ldKTsNCisNCiAJ
CWlmIChkZS0+bmFtZVswXSA9PSAoX19zOCkgREVMRVRFRF9GTEFHKQ0KIAkJ
CWdvdG8gUmVjRW5kOw0KIAkJaWYgKGRlLT5hdHRyID09ICBBVFRSX0VYVCkN
Cg==
--1842346852-615257861-1002766225=:29867--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
