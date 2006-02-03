Return-Path: <Marc.Bodmer@securiton.ch>
Received: from mrp.swissptt.ch (outmail2.swisscom.com [138.190.3.29])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "outmail2.swisscom.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44A8568A1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 23:56:49 +1100 (EST)
Received: from stnzolav1.securiton.int ([10.101.10.36])
	by mrp.swissptt.ch with ESMTP id k13Cuhrp024898
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Feb 2006 13:56:43 +0100 (MET)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C628C1.47D94C7F"
Subject: AW: How to cross-build OpenSSL shared library
Date: Fri, 3 Feb 2006 13:56:42 +0100
Message-ID: <5DDC68DD3569BB4D92D660326A9C095301728953@stnzolex1.securiton.int>
From: <Marc.Bodmer@securiton.ch>
To: <guilherme.mazzela@asga.com.br>, <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C628C1.47D94C7F
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Hi, thanks for your answer.
=0D
Thats almost what I actually did. Here is my ./Configure call:
=0D
./Configure linux-ppc shared zlib-dynamic compiler:${CROSS_COMPILE}gcc=
 --openssldir=3D$openssl_distdir --prefix=3D$openssl_bindir
=0D
I've tried what you proposed here and it works :-)
I made the mistake to give the compiler to the Configure script instead=
 just at make time...
=0D
I did not use the "no-asm" option. Is this needed for PPC or is there=
 mpc8xx asm available?
=0D
regards
Marc
=0D

-----Urspr=FCngliche Nachricht-----
Von: Guilherme Mazzela [mailto:guilherme.mazzela@asga.com.br]
Gesendet: Freitag, 3. Februar 2006 12:19
An: Bodmer Marc, Securiton, ESS
Betreff: RE: How to cross-build OpenSSL shared library



try this

./Configure
./Configure linux-ppc --prefix=3D/usr --openssldir=3D/etc shared no-asm
make clean
make CC=3Dppc-linux-gcc

after that you have to strip the libcrypto.so.X.X.X


-----Original Message-----
From:   Marc.Bodmer@securiton.ch [ mailto:Marc.Bodmer@securiton.ch]
Sent:   Fri 2/3/2006 7:45 AM
To:     linuxppc-embedded@ozlabs.org
Cc:   =0D
Subject:        How to cross-build OpenSSL shared library

Hello


I have a problem with cross compiling the OpenSSL library for PPC (mpc885)=
 as a
shared library (Host x86, Linux).


I give the option "shared" to the "Configure" script delivered with=
 OpenSSL. But it
always only builds me static libraries. After Configuration it shows me the=
 text:


>You gave the option 'shared'. Normally, that would give you shared=
 libraries.
>Unfortunately, the OpenSSL configuration doesn't include shared library=
 support
>for this platform yet, so it will pretend you gave the option 'no-shared'


I am using ELDK (3.1.1) and there is a built OpenSSL as shared library
available.
Does anybody know about how they managed to build this shared library?


Thanks for any help
Marc














































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
------_=_NextPart_001_01C628C1.47D94C7F
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3DWindows-1252">
<TITLE>RE: How to cross-build OpenSSL shared library</TITLE>

<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=
=3D040403511-03022006>Hi,=0D
thanks for your answer.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=0D
class=3D040403511-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=
=3D040403511-03022006>Thats=0D
almost what I actually did. Here is my ./Configure=
 call:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=0D
class=3D040403511-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=0D
class=3D040403511-03022006>./Configure=
 linux-ppc&nbsp;shared&nbsp;zlib-dynamic=0D
compiler:${CROSS_COMPILE}gcc --openssldir=3D$openssl_distdir=0D
--prefix=3D$openssl_bindir</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=0D
class=3D040403511-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=
=3D040403511-03022006>I've=0D
tried what you proposed here and it works :-)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=
=3D040403511-03022006>I made=0D
the mistake to give the compiler to the Configure script instead just at=
 make=0D
time...</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=0D
class=3D040403511-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=
=3D040403511-03022006>I did=0D
not use the "no-asm" option. Is this needed for PPC or is there mpc8xx asm=
=0D
available?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=0D
class=3D040403511-03022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=0D
class=3D040403511-03022006>regards</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=0D
class=3D040403511-03022006>Marc</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=0D
class=3D040403511-03022006></SPAN></FONT>&nbsp;</DIV>
<BLOCKQUOTE dir=3Dltr style=3D"MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT face=
=3DTahoma=0D
  size=3D2>-----Urspr=FCngliche Nachricht-----<BR><B>Von:</B> Guilherme=
 Mazzela=0D
  [mailto:guilherme.mazzela@asga.com.br]<BR><B>Gesendet:</B> Freitag, 3.=
 Februar=0D
  2006 12:19<BR><B>An:</B> Bodmer Marc, Securiton, ESS<BR><B>Betreff:</B>=
 RE:=0D
  How to cross-build OpenSSL shared library<BR><BR></FONT></DIV><!--=
 Converted from text/plain format -->
  <P><FONT size=3D2>try this<BR><BR>./Configure<BR>./Configure linux-ppc=0D
  --prefix=3D/usr --openssldir=3D/etc shared no-asm<BR>make clean<BR>make=0D
  CC=3Dppc-linux-gcc<BR><BR>after that you have to strip the=0D
  libcrypto.so.X.X.X<BR><BR><BR>-----Original=
 Message-----<BR>From:&nbsp;&nbsp;=0D
  Marc.Bodmer@securiton.ch [<A=0D
  href=
=3D"mailto:Marc.Bodmer@securiton.ch">mailto:Marc.Bodmer@securiton.ch</A>]<B=
R>Sent:&nbsp;&nbsp;=0D
  Fri 2/3/2006 7:45 AM<BR>To:&nbsp;&nbsp;&nbsp;&nbsp;=0D
 =
 linuxppc-embedded@ozlabs.org<BR>Cc:&nbsp;&nbsp;&nbsp;&nbsp;<BR>Subject:&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0D
  How to cross-build OpenSSL shared library<BR><BR>Hello<BR><BR><BR>I have=
 a=0D
  problem with cross compiling the OpenSSL library for PPC (mpc885) as=0D
  a<BR>shared library (Host x86, Linux).<BR><BR><BR>I give the option=
 "shared"=0D
  to the "Configure" script delivered with OpenSSL. But it<BR>always only=
 builds=0D
  me static libraries. After Configuration it shows me the=0D
  text:<BR><BR><BR>&gt;You gave the option 'shared'. Normally, that would=
 give=0D
  you shared libraries.<BR>&gt;Unfortunately, the OpenSSL configuration=
 doesn't=0D
  include shared library support<BR>&gt;for this platform yet, so it will=0D
  pretend you gave the option 'no-shared'<BR><BR><BR>I am using ELDK=
 (3.1.1) and=0D
  there is a built OpenSSL as shared library<BR>available.<BR>Does anybody=
 know=0D
  about how they managed to build this shared library?<BR><BR><BR>Thanks=
 for any=0D
 =
 help<BR>Marc<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><B=
R><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><=
BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>&lt;html&gt;<BR>&lt;body=
&gt;<BR>&lt;font=0D
  face =3D "arial" size =3D=0D
 =
 "1"&gt;<BR>---------------------------------------------------------------=
------------------------------------------<BR>This=0D
  e-mail is confidential and may contain privileged information.<BR>It is=0D
  intended only for the addressees. If you have received this<BR>e-mail in=
=0D
  error, kindly notify us immediately by telephone or e-mail<BR>and delete=
 the=0D
  message from your=0D
 =
 system.<BR>---------------------------------------------------------------=
------------------------------------------<BR>&lt;/font&gt;<BR>&lt;/body&gt=
;<BR>&lt;/html&gt;<BR><BR></FONT></P></BLOCKQUOTE></BODY></HTML>

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
------_=_NextPart_001_01C628C1.47D94C7F--
