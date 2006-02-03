Return-Path: <Marc.Bodmer@securiton.ch>
Received: from mrz.swissptt.ch (outmail3.swisscom.com [138.190.3.30])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "outmail3.swisscom.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A876D689F9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 21:29:31 +1100 (EST)
Received: from stnzolav1.securiton.int ([10.101.10.36])
	by mrz.swissptt.ch with ESMTP id k139jjbv022654
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Feb 2006 10:45:45 +0100 (MET)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C628A6.9A8DE3B7"
Subject: How to cross-build OpenSSL shared library
Date: Fri, 3 Feb 2006 10:45:44 +0100
Message-ID: <5DDC68DD3569BB4D92D660326A9C095301728952@stnzolex1.securiton.int>
From: <Marc.Bodmer@securiton.ch>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C628A6.9A8DE3B7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello
=0D
I have a problem with cross compiling the OpenSSL library for PPC (mpc885)=
 as a
shared library (Host x86, Linux).
=0D
I give the option "shared" to the "Configure" script delivered with=
 OpenSSL. But it
always only builds me static libraries. After Configuration it shows me the=
 text:
=0D
>You gave the option 'shared'. Normally, that would give you shared=
 libraries.
>Unfortunately, the OpenSSL configuration doesn't include shared library=
 support
>for this platform yet, so it will pretend you gave the option 'no-shared'
=0D
I am using ELDK (3.1.1) and there is a built OpenSSL as shared library
available.
Does anybody know about how they managed to build this shared library?
=0D
Thanks for any help
Marc
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D
=0D


<html>
<body>
<font face =3D "arial" size =3D "1">
---------------------------------------------------------------------------=
------------------------------
This e-mail is confidential and may contain privileged information.
It is intended only for the addressees. If you have received this
e-mail in error, kindly notify us immediately by telephone or e-mail
and delete the message from your system.
---------------------------------------------------------------------------=
------------------------------
</font>
</body>
</html>
------_=_NextPart_001_01C628A6.9A8DE3B7
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Diso-8859-1">


<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006>Hello</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D657553709-03022006>I have a=
 problem=0D
with cross compiling the OpenSSL library for&nbsp;PPC (mpc885)&nbsp;as=0D
a</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D657553709-03022006>shared=
 library (Host=0D
x86, Linux).</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D657553709-03022006>I give=
 the option=0D
"shared" to the "Configure" script delivered with OpenSSL. But=0D
it</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D657553709-03022006>always=
 only builds=0D
me static libraries. After Configuration it shows me the=0D
text:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D657553709-03022006>&gt;You=
 gave the=0D
option 'shared'. Normally, that would give you shared=0D
libraries.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=
=3D657553709-03022006>&gt;Unfortunately,=0D
the OpenSSL configuration doesn't include shared library=0D
support</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D657553709-03022006>&gt;for=
 this=0D
platform yet, so it will pretend you gave the option=0D
'no-shared'</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D657553709-03022006>I am=
 using ELDK=0D
(3.1.1)&nbsp;and there is a built&nbsp;OpenSSL as shared=0D
library</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006>available.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D657553709-03022006>Does=
 anybody know=0D
about how they managed to build this shared library?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D657553709-03022006>Thanks=
 for any=0D
help</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006>Marc</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=0D
class=3D657553709-03022006></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><html><br>
<body><br>
<font face =3D "arial" size =3D "1"><br>
---------------------------------------------------------------------------=
------------------------------<br>
This e-mail is confidential and may contain privileged information.<br>
It is intended only for the addressees. If you have received this<br>
e-mail in error, kindly notify us immediately by telephone or e-mail<br>
and delete the message from your system.<br>
---------------------------------------------------------------------------=
------------------------------<br>
</font><br>
</body><br>
</html><br>
</font></td></tr></table>
------_=_NextPart_001_01C628A6.9A8DE3B7--
