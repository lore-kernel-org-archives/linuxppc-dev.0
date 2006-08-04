Return-Path: <jonandia@aotek.es>
Received: from smtp1.sarenet.es (smtp1.sarenet.es [194.30.0.4])
	by ozlabs.org (Postfix) with ESMTP id 9C3B6679FD
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 17:30:24 +1000 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by smtp1.sarenet.es (Postfix) with ESMTP id 6E43F114E4
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 09:11:35 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6B795.1A05AE12"
Subject: RE: MTD Flash Howto ?
Date: Fri, 4 Aug 2006 09:10:44 +0200
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F38747BE@correo.fagorautomation.net>
From: "Josu Onandia" <jonandia@aotek.es>
To: <dhlii@comcast.net>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6B795.1A05AE12
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
Even if you dont't use U-Boot as bootloader, I'm sure that the =
documentation in http://www.denx.de/wiki/DULG/Manual will interest you.
=20
Best regards
=20
Josu Onandia

-----Mensaje original-----
De: linuxppc-embedded-bounces+jonandia=3Daotek.es@ozlabs.org =
[mailto:linuxppc-embedded-bounces+jonandia=3Daotek.es@ozlabs.org]En =
nombre de David H. Lynch Jr.
Enviado el: viernes, 04 de agosto de 2006 6:04
Para: linuxppc-embedded
Asunto: MTD Flash Howto ?



    I need to put together a filesystem driver for the flash in the Pico =
E-12.
    I think I have a pretty good grasp of what I need of the FileSystem =
end of things.

    But I am less certain of the peices needed to get from the flash to =
the block driver that I assume underly's the FileSystem.
    I have enabled MTD, and configured a starting address and size.
    I got a signon banner. How can I tell if it has really found my =
flash and if it actually knows the type of flash it found - in my=20
    instance Spansion S29GL512N.

    I have found some documentation covering details, I think I am more =
interested in something that gives a more zoomed out view.

    Is anyone aware of a relevant howto ? Maybe some web pages on the =
end-end process of going from flash devices to filesystems over flash ?


--=20

Dave Lynch 					  	    DLA Systems

Software Development:  				         Embedded Linux

717.627.3770 	        dhlii@dlasys.net 	   http://www.dlasys.net

fax: 1.253.369.9244 			           Cell: 1.717.587.7774

Over 25 years' experience in platforms, languages, and technologies too =
numerous to list.



"Any intelligent fool can make things bigger and more complex... It =
takes a touch of genius - and a lot of courage to move in the opposite =
direction."

Albert Einstein


------_=_NextPart_001_01C6B795.1A05AE12
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<META content=3D"MSHTML 6.00.2900.2627" name=3DGENERATOR></HEAD>
<BODY text=3D#000000 bgColor=3D#ffffff>
<DIV><SPAN class=3D057010307-04082006><FONT face=3DArial color=3D#0000ff =

size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D057010307-04082006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D057010307-04082006><FONT face=3DArial color=3D#0000ff =
size=3D2>Even=20
if you dont't use U-Boot as bootloader, I'm sure&nbsp;that the =
documentation in=20
<A=20
href=3D"http://www.denx.de/wiki/DULG/Manual">http://www.denx.de/wiki/DULG=
/Manual</A>&nbsp;will=20
interest you.</FONT></SPAN></DIV>
<DIV><SPAN class=3D057010307-04082006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D057010307-04082006><FONT face=3DArial color=3D#0000ff =
size=3D2>Best=20
regards</FONT></SPAN></DIV>
<DIV><SPAN class=3D057010307-04082006><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D057010307-04082006><FONT face=3DArial color=3D#0000ff =
size=3D2>Josu=20
Onandia</FONT></SPAN></DIV>
<BLOCKQUOTE dir=3Dltr style=3D"MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Mensaje original-----<BR><B>De:</B>=20
  linuxppc-embedded-bounces+jonandia=3Daotek.es@ozlabs.org=20
  [mailto:linuxppc-embedded-bounces+jonandia=3Daotek.es@ozlabs.org]<B>En =
nombre de=20
  </B>David H. Lynch Jr.<BR><B>Enviado el:</B> viernes, 04 de agosto de =
2006=20
  6:04<BR><B>Para:</B> linuxppc-embedded<BR><B>Asunto:</B> MTD Flash =
Howto=20
  ?<BR><BR></FONT></DIV><FONT face=3DArial><BR>&nbsp;&nbsp;&nbsp; I need =
to put=20
  together a filesystem driver for the flash in the Pico=20
  E-12.<BR>&nbsp;&nbsp;&nbsp; I think I have a pretty good grasp of what =
I need=20
  of the FileSystem end of things.<BR><BR>&nbsp;&nbsp;&nbsp; But I am =
less=20
  certain of the peices needed to get from the flash to the block driver =
that I=20
  assume underly's the FileSystem.<BR>&nbsp;&nbsp;&nbsp; I have enabled =
MTD, and=20
  configured a starting address and size.<BR>&nbsp;&nbsp;&nbsp; I got a =
signon=20
  banner. How can I tell if it has really found my flash and if it =
actually=20
  knows the type of flash it found - in my <BR>&nbsp;&nbsp;&nbsp; =
instance=20
  Spansion S29GL512N.<BR><BR>&nbsp;&nbsp;&nbsp; I have found some =
documentation=20
  covering details, I think I am more interested in something that gives =
a more=20
  zoomed out view.<BR><BR>&nbsp;&nbsp;&nbsp; Is anyone aware of a =
relevant howto=20
  ? Maybe some web pages on the end-end process of going from flash =
devices to=20
  filesystems over flash ?<BR><BR></FONT><PRE class=3Dmoz-signature =
cols=3D"72">--=20
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <A class=3Dmoz-txt-link-abbreviated =
href=3D"mailto:dhlii@dlasys.net">dhlii@dlasys.net</A> 	  <A =
class=3Dmoz-txt-link-freetext =
href=3D"http://www.dlasys.net">http://www.dlasys.net</A>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too =
numerous to list.

"Any intelligent fool can make things bigger and more complex... It =
takes a touch of genius - and a lot of courage to move in the opposite =
direction."
Albert Einstein
</PRE></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C6B795.1A05AE12--
