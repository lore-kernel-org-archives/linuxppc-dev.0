Return-Path: <reyems@telkomsa.net>
Received: from ctb-mesg7.saix.net (ctb-mesg7.saix.net [196.25.240.77])
	by ozlabs.org (Postfix) with ESMTP id 18F7567A67
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 21:46:04 +1000 (EST)
Received: from stefanlaptop (dsl-165-249-230.telkomadsl.co.za
	[165.165.249.230])
	by ctb-mesg7.saix.net (Postfix) with SMTP id 78FB03867
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 12:30:30 +0200 (SAST)
Message-ID: <002301c65d52$fd7c6fd0$1100a8c0@stefanlaptop>
From: "Stefan Meyer" <reyems@telkomsa.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux kernel for MPC834X platform
Date: Tue, 11 Apr 2006 12:30:32 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0020_01C65D63.B98DA0D0"
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

------=_NextPart_000_0020_01C65D63.B98DA0D0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi All
Pardon the intrusion if this is not the correct way to get the relevant =
information, but I am relatively new to kernel hacking.
Anyway here goes my question:
I am getting a Freescale MPC8343 based board up and running and have =
been using the BSP (with patched 2.6.11 kernel) release by Freescale =
with great success.
However when I tried to use the USB ISO transactions it seems to be non =
functional. I have connected a known good working codec (tested on my =
PC's usb) and tried to access it via the low level sound driver =
(/dev/dsp) but it only creates garbled noise.=20
In the meanwhile, I have noticed that the official kernel release 2.6.17 =
also start supporting the MPC834X platform and would rather like to =
persue that avenue to get my problems addressed (hopefully).=20
I have downloaded the latest 2.6.17 kernel and got it going  with the =
configuration for MPC834x_sys, with relation to booting and ethernet =
comms.=20
However there are clearly no provision in the USB driver for setting up =
the usb clocks and ports (which is of course MPC834x specific).=20
I have tried to hack it by inserting approriate code form the 2.6.11 =
freescale kernel but with very little success.=20
On inspection of the 2.6.11 kernel from Freescale I have also noticed =
that the USB core drivers were heavily modified around DMA buffer =
management, although the 2.6.17 had no such hacks in place.   =20
My question simply relates to the status of the MPC834x implementation =
on the 2.6.17 kernel in so far that it is operational and being tested =
on hardware platforms. Could you please direct me to the persons(s) who =
have experience with this platform ?

Regards
Stefan


------=_NextPart_000_0020_01C65D63.B98DA0D0
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dwindows-1252">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi All</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Pardon the intrusion if this is not the =
correct way=20
to get the relevant information, but&nbsp;I am relatively new to kernel=20
hacking.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Anyway here goes my =
question:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I am getting a Freescale MPC8343 based =
board up and=20
running and have been using the BSP (with patched 2.6.11 =
kernel)&nbsp;release by=20
Freescale with great success.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>However when I tried to use the USB ISO =

transactions it seems to be non functional.&nbsp;I have connected a =
known good=20
working codec (tested on my PC's usb) and tried to access it via the low =
level=20
sound driver (/dev/dsp) but it only creates garbled =
noise.&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>In the meanwhile, I have noticed that =
the official=20
kernel release 2.6.17 also start supporting the MPC834X platform and =
would=20
rather like to persue that avenue to get my problems addressed =
(hopefully).=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I have downloaded the latest 2.6.17 =
kernel and got=20
it going&nbsp;&nbsp;with the configuration for MPC834x_sys, with =
relation to=20
booting and ethernet comms. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>However there are clearly no provision =
in the USB=20
driver for setting up the usb clocks and ports (which is of course =
MPC834x=20
specific). </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I have tried to hack it by inserting =
approriate=20
code form the 2.6.11 freescale kernel but with very little success.=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>On inspection of the 2.6.11 kernel from =
Freescale=20
I&nbsp;have&nbsp;also noticed that the USB core drivers were heavily =
modified=20
around DMA buffer management, although the 2.6.17 had no such hacks in =
place.=20
&nbsp;&nbsp;</FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>My question simply relates to the =
status of the=20
MPC834x implementation on the 2.6.17 kernel in so far that it is =
operational and=20
being tested on&nbsp;hardware platforms. Could you please direct me to =
the=20
persons(s) who have experience with this platform ?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Stefan</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0020_01C65D63.B98DA0D0--
