Date: Thu, 26 Feb 2004 11:12:40 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Sound dependency on I2C missing
Message-ID: <Pine.LNX.4.58.0402261106470.1950@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-638110681-1077811960=:1950"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-638110681-1077811960=:1950
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello!

I was compiling Linux 2.6.3-bk7 and encountered error messages like those
already posted to this list:
http://lists.linuxppc.org/linuxppc-dev/200402/msg00042.html

The fix is to make CONFIG_SND_POWERMAC depend on CONFIG_I2C.  The patch is
attached.  No additional I2C drivers are needed to make the kernel compile
and support sound.

--
Regards,
Pavel Roskin
--8323328-638110681-1077811960=:1950
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="i2cdep.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0402261112400.1950@marabou.research.att.com>
Content-Description: 
Content-Disposition: attachment; filename="i2cdep.diff"

LS0tIGxpbnV4Lm9yaWcvc291bmQvcHBjL0tjb25maWcNCisrKyBsaW51eC9z
b3VuZC9wcGMvS2NvbmZpZw0KQEAgLTUsNyArNSw3IEBADQogDQogY29uZmln
IFNORF9QT1dFUk1BQw0KIAl0cmlzdGF0ZSAiUG93ZXJNYWMgKEFXQUNTLCBE
QUNBLCBCdXJndW5keSwgVHVtYmxlciwgS2V5d2VzdCkiDQotCWRlcGVuZHMg
b24gU05EDQorCWRlcGVuZHMgb24gU05EICYmIEkyQw0KIA0KIGVuZG1lbnUN
CiANCg==

--8323328-638110681-1077811960=:1950--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
