Return-Path: <daniel.schnell@marel.com>
Received: from mail.marel.com (mail.marel.com [213.213.131.31])
	by ozlabs.org (Postfix) with ESMTP id CCE0F67B56
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 02:31:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E707.B592B6E4"
Subject: Disable data cache on mpc5200
Date: Tue, 3 Oct 2006 16:19:31 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB012DEDD2@is-hdq-exchange.marel.net>
From: "Daniel Schnell" <daniel.schnell@marel.com>
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

------_=_NextPart_001_01C6E707.B592B6E4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
we have troubles with our 256 MBytes DDR SDRAM on our mpc5200B custom
board.
=20
On this processor we have four chips, 64 MBytes each connected via
chipselects CS0 & CS1.
When running a specific memory test under u-boot the CS1 connected RAM
seems also to work fine (memcpy, memcmp, etc.). But U-Boot disables the
data cache as it partly boot-strapped from there. So it will not use the
DDR burst mode.
=20
Now when booting our 2.4.25 Denx originated Linux Kernel (which we
fetched via git a few weeks ago) the data cache is on and we get into
trouble when booting Linux (either signal 11 or signal 4 at different
places, highly timing dependant). If we setup only the RAM connected via
CS0, we don't have any troubles. So I do not suspect Linux to be the
cause of the trouble.
=20
It would be helpful to see if this trouble is related to the DDR burst
mode. Is there any possibility to modify the Linux Kernel not to use the
data cache of the mpc5200 or to disable it, so we do not use the burst
mode ?
=20
A maybe stupid question: the CS1 can be at the same time a GPIO,
depending on the mpc5200B setup. Could there be the possibility that the
Linux kernel sets it up differently inside some driver initialization
routine, so the setup which has been done inside U-Boot will be altered
afterwards ?
=20
=20
Best regards,
=20
Daniel.

------_=_NextPart_001_01C6E707.B592B6E4
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial =
size=3D2>we&nbsp;have=20
troubles with&nbsp;our 256 MBytes DDR SDRAM on&nbsp;our mpc5200B custom=20
board.</FONT></SPAN></DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial size=3D2>On =
this processor we=20
have four&nbsp;chips, 64 MBytes each connected via chipselects CS0 &amp; =

CS1.</FONT></SPAN></DIV>
<DIV><SPAN class=3D081535315-03102006></SPAN><SPAN =
class=3D081535315-03102006><FONT=20
face=3DArial size=3D2>When running a specific memory test under u-boot =
the CS1=20
connected RAM seems also to work fine (memcpy, memcmp, etc.). But U-Boot =

disables the data cache as it partly boot-strapped from there. So it =
will not=20
use the DDR burst mode.</FONT></SPAN></DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial size=3D2>Now =
when booting our=20
2.4.25 Denx originated Linux Kernel (which we fetched via git a few =
weeks ago)=20
the data cache is on and we get into trouble when booting Linux (either =
signal=20
11 or signal 4&nbsp;at different places, highly timing dependant). =
If&nbsp;we=20
setup only the RAM connected via CS0, we don't have any troubles. So I =
do not=20
suspect Linux to be the cause of the trouble.</FONT></SPAN></DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial size=3D2>It =
would be helpful=20
to see if this trouble is related to the DDR burst mode. Is there any=20
possibility to modify the Linux Kernel not to use the data cache of the =
mpc5200=20
or to&nbsp;disable it, so we do not use the burst=20
mode&nbsp;?</FONT></SPAN></DIV>
<DIV><SPAN class=3D081535315-03102006></SPAN><SPAN =
class=3D081535315-03102006><FONT=20
face=3DArial size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial size=3D2>A =
maybe stupid=20
question: the CS1 can be at the same time a GPIO, depending on the =
mpc5200B=20
setup. Could there be the possibility that the Linux kernel sets it up=20
differently inside&nbsp;some driver initialization routine, so the setup =
which=20
has been done inside U-Boot will be altered afterwards =
?</FONT></SPAN></DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial size=3D2>Best=20
regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D081535315-03102006><FONT face=3DArial=20
size=3D2>Daniel.</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C6E707.B592B6E4--
