Subject: RE: Problems bring up NFS mount on MPC8270 board
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C39D5A.58262262"
Date: Tue, 28 Oct 2003 08:49:44 -0500
Message-ID: <AB5AF73EAF23304EA1B932174137CED70E6F16@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "Joe Birch" <jbirch@mangrovesystems.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------_=_NextPart_001_01C39D5A.58262262
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


The 8270 has a new core revision (Hip7) which have a new PVR:

  Hip3: 0x0081xxxx
  Hip4: 0x8081xxxx
  Hip7: 0x8082xxxx

It is probably not recognized has a 603e core, but a generic PPC (which =
will not work).

May I suggest the patch in attachement (for =
'arch/ppc/kernel/cputable.c'). It will correctly recognize the three cpu =
revisions, and report the chosen one in '/proc/cpuinfo'.

Regards,

--------------------------------------------
 Jean-Denis Boyer, Eng.
 M5T Centre d'Excellence en T=E9l=E9com Inc.
 4283 Garlock Street
 Sherbrooke (Qu=E9bec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

------_=_NextPart_001_01C39D5A.58262262
Content-Type: application/octet-stream;
	name="cputable.patch"
Content-Transfer-Encoding: base64
Content-Description: cputable.patch
Content-Disposition: attachment;
	filename="cputable.patch"

LS0tIEtlcm5lbC5vcmlnL2FyY2gvcHBjL2tlcm5lbC9jcHV0YWJsZS5jCU1vbiBTZXAgMjIgMDQ6
MTI6MjAgMjAwMworKysgS2VybmVsL2FyY2gvcHBjL2tlcm5lbC9jcHV0YWJsZS5jCU1vbiBPY3Qg
MjcgMDk6NTU6MTUgMjAwMwpAQCAtMjk0LDcgKzI5NCwyMSBAQAogCV9fc2V0dXBfY3B1Xzc0NXgK
ICAgICB9LAogICAgIHsJLyogODJ4eCAoODI0MCwgODI0NSwgODI2MCBhcmUgYWxsIDYwM2UgY29y
ZXMpICovCi0JMHg3ZmZmMDAwMCwgMHgwMDgxMDAwMCwgIjgyeHgiLAorCTB4ZmZmZjAwMDAsIDB4
MDA4MTAwMDAsICI4Mnh4IChIaXAzKSIsCisJQ1BVX0ZUUl9TUExJVF9JRF9DQUNIRSB8IENQVV9G
VFJfQ0FOX0RPWkUgfCBDUFVfRlRSX1VTRV9UQiwKKwlDT01NT05fUFBDLAorCTMyLCAzMiwKKwlf
X3NldHVwX2NwdV82MDMKKyAgICB9LAorICAgIHsJLyogODJ4eCAoSGlwNCA2MDNlIGNvcmVzKSAq
LworCTB4ZmZmZjAwMDAsIDB4ODA4MTAwMDAsICI4Mnh4IChIaXA0KSIsCisJQ1BVX0ZUUl9TUExJ
VF9JRF9DQUNIRSB8IENQVV9GVFJfQ0FOX0RPWkUgfCBDUFVfRlRSX1VTRV9UQiwKKwlDT01NT05f
UFBDLAorCTMyLCAzMiwKKwlfX3NldHVwX2NwdV82MDMKKyAgICB9LAorICAgIHsgICAvKiA4Mnh4
IChIaXA3IDYwM2UgY29yZXMpICovCisJMHhmZmZmMDAwMCwgMHg4MDgyMDAwMCwgIjgyeHggKEhp
cDcpIiwKIAlDUFVfRlRSX1NQTElUX0lEX0NBQ0hFIHwgQ1BVX0ZUUl9DQU5fRE9aRSB8IENQVV9G
VFJfVVNFX1RCLAogCUNPTU1PTl9QUEMsCiAJMzIsIDMyLAo=

------_=_NextPart_001_01C39D5A.58262262--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
