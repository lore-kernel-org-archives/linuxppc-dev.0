MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C2177E.03EADEFC"
Subject: set_multicast_list function of ppc enet driver
Date: Wed, 19 Jun 2002 12:42:31 +0200
Message-ID: <C287DEEDF2D4C1409FDE10D8253BD7000D4C33@eurobird.dt.net>
From: "Ludszuweit, Axel" <Axel.Ludszuweit@datentechnik.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------_=_NextPart_001_01C2177E.03EADEFC
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I have a question about the powerquicc ethernet
drivers, especcially to the set_multicast_list=20
routine.
In this routine, only one multicast address
is used, to evaluate the appropriate hash value.
I dont know, how the dmi structure works, but I have=20
took a look to other drivers.=20
In my opinion, dev->dmi is the start point=20
of dev->mc_count chained dmi structures,=20
which contains all multicast addresses.
I have attached a patch of the 8260 version of
enet.c, which will take this in account.
I dont have tested the patch.
Have someone experience with the multicast feature
and can give me some feedback?

Thanks




--------------------------------------------

Datentechnik Intercom GmbH
Axel Ludszuweit
Frankenring 14
D-30855 Langenhagen

Telefon: +49(0)511 978197-630=20
Telefax: +49 511 / 978197-670
mailto:axel.ludszuweit@datentechnik.com
http://www.datentechnik.com

------_=_NextPart_001_01C2177E.03EADEFC
Content-Type: application/octet-stream;
	name="patch_enet.c"
Content-Transfer-Encoding: base64
Content-Description: patch_enet.c
Content-Disposition: attachment;
	filename="patch_enet.c"

LS0tIGxpbnV4LTIuNC4xOC9hcmNoL3BwYy84MjYwX2lvL2VuZXQuYy5PUklHCVdlZCBKdW4gMTkg
MTA6NDQ6MTYgMjAwMgorKysgbGludXgtMi40LjE4L2FyY2gvcHBjLzgyNjBfaW8vZW5ldC5jCVdl
ZCBKdW4gMTkgMTE6MDM6MzggMjAwMgpAQCAtNTc3LDkgKzU3NywxMCBAQAogCQkJZXAtPnNlbl9n
YWRkcjMgPSAwOwogCQkJZXAtPnNlbl9nYWRkcjQgPSAwOwogCi0JCQlkbWkgPSBkZXYtPm1jX2xp
c3Q7CiAKLQkJCWZvciAoaT0wOyBpPGRldi0+bWNfY291bnQ7IGkrKykgeworCQkJZm9yIChpPTAs
IGRtaSA9IGRldi0+bWNfbGlzdDsgCisJCQkgICAgIGkgPCBkZXYtPm1jX2NvdW50ICYmIChkbWkg
IT0gIChzdHJ1Y3QgZGV2X21jX2xpc3QgKikgTlVMTCk7IAorCQkJICAgICBpKyssIGRtaSA9IGRt
aS0+bmV4dCkgewogCQkJCQogCQkJCS8qIE9ubHkgc3VwcG9ydCBncm91cCBtdWx0aWNhc3QgZm9y
IG5vdy4KIAkJCQkqLwo=

------_=_NextPart_001_01C2177E.03EADEFC--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
