Return-Path: <nlv11891@natlab.research.philips.com>
Message-ID: <002001c52aef$d29dbb70$9c9c9182@ddns.htc.nl.philips.com>
From: "S. van Beek" <nlv11891@natlab.research.philips.com>
To: <Linuxppc-embedded@ozlabs.org>
Date: Thu, 17 Mar 2005 13:49:56 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001D_01C52AF8.3453CB90"
Subject: Problems with MontaVista Linux on a Memec Virtex-II pro ff672 board
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

------=_NextPart_000_001D_01C52AF8.3453CB90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello there,

This is our first post on this list, hi all!
We're two Dutch students working with a Virtex-II pro ff672 board from =
Memec with the Communications 2 module. We've compiled a simple kernel =
wich comes with MontaVista Linux 3.1 (2.4.20) with ethernet and a serial =
port. It mounts its root filesystem over NFS and everything seems to =
work nicely. The next step we wanted to make was adding support for the =
Flash on the com board. We added the IP to the hardware and loaded the =
new bitstream in the FPGA. Next thing, we enabled support for MTD =
devices in the kernel. After that, the kernel did not seem to boot =
anymore. It stopped at the message 'Now booting the kernel'. So we read =
some documentation about debugging. We recompiled this kernel with the =
-g -ggdb options and removed the -O (optimalization) flag. Then we did =
not even see the ppc boot loader messages anymore when trying to boot. =
So we tried to compile the first kernel (with only serial and ethernet =
support) -wich worked fine before- with debugging and it gave us the =
same result.. no output at all.=20
Can anyone give us some hints on what we can try more to find out what =
is going wrong?=20

Regards,
Sander van Beek
Daniel van Os
------=_NextPart_000_001D_01C52AF8.3453CB90
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1491" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello there,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>This is our first post on this list, hi =

all!</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>We're two Dutch students working with a =
Virtex-II=20
pro ff672 board from Memec with the Communications 2 module. We've =
compiled a=20
simple kernel wich comes with MontaVista Linux&nbsp;3.1 (2.4.20) with =
ethernet=20
and a serial port. It mounts its root filesystem over NFS and everything =
seems=20
to work nicely. The next step we wanted to make was adding&nbsp;support =
for the=20
Flash&nbsp;on the com board. We added the IP to the hardware and loaded =
the new=20
bitstream in the FPGA. Next thing, we enabled support for MTD devices in =
the=20
kernel. After that, the kernel did not seem to boot anymore. It stopped =
at the=20
message 'Now booting the kernel'. So we read some documentation about =
debugging.=20
We recompiled this kernel with the -g -ggdb options and removed the -O=20
(optimalization) flag. Then we did not even see the ppc boot loader =
messages=20
anymore when trying to boot. So we tried to compile the first kernel =
(with only=20
serial and ethernet support) -wich worked fine before-&nbsp;with =
debugging and=20
it gave us the same result.. no output at all. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Can anyone give us some hints on what =
we can try=20
more to find out what is going wrong? </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Sander van Beek</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Daniel van =
Os</FONT></DIV></BODY></HTML>

------=_NextPart_000_001D_01C52AF8.3453CB90--
