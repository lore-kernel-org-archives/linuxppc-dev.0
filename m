Return-Path: <Rajan.Rai@ingenient.com>
Received: from mail.ingenient.com (unknown [63.87.52.245])
	by ozlabs.org (Postfix) with ESMTP id 822E067B6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 19:18:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6BD26.AF0945B9"
Subject: RE: PCI driver on EB8347
Date: Fri, 11 Aug 2006 04:15:26 -0500
Message-ID: <4DA89577C33E194ABEBC978921E858541B8E3B@exchange.ingenient.net>
References: <995B09A8299C2C44B59866F6391D2635018CA7@zch01exm21.fsl.freescale.net>
From: "rajan rai" <Rajan.Rai@ingenient.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>,
	"Gala Kumar K.-galak" <kumar.gala@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C6BD26.AF0945B9
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=20
                      I'm using polling mechanism and not interrupts in =
my driver. Although I'm not using polling I see strange behavior When I =
do lspci -v I don't see any interrupts being allocated to PCI device =
behind PCI bridge !!!! But when I use same card directly on primary bus =
I do see interrupt being allocated to PCI device. Any advise why IRQ's =
being not allocated in case its attached to PCI bridge ?
=20
                              Do I need to take care of any extra =
configuration in case of PCI card is attached to PCI bridge ?
=20
Yaa you are correct I shouldn't use CONFIG_85xx_PCI2
=20
Thanks,
-Rajan

________________________________

From: Liu Dave-r63238 [mailto:DaveLiu@freescale.com]
Sent: Thu 8/10/2006 10:40 PM
To: rajan rai; Gala Kumar K.-galak
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: PCI driver on EB8347




Rajan>        I have written PCI driver which works fine along with
MPC8347 and two PCI
Rajan> card connected in a single PCI bus. When I try to communicate
same PCI card
Rajan> using PCI bridge ( PCI2050B ), Linux does detect PCI card on
Secondary bus
Rajan> but same driver doesn't work !!!!

PCI interrupt for secondary bus set up properly?
    =20
Rajan>        Do I need to enable support for second PCI host controller
at kernel level to
Rajan>make it work? Or I need to do something else ? I tried compiling
PPC-linux kernel
Rajan> after enabling CONFIG_85xx_PCI2 kernel doesn't compile it gives
me error while
Rajan>compiling "arch/ppc/syslib/ppc83xx_setup.c" Kernel version I'm
using is 2.6.13.

Why you enable CONFIG_85xx_PCI2 in kernel? It is for 85xx, but you are
using 8347 processor.

<snip>

Dave




------_=_NextPart_001_01C6BD26.AF0945B9
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">=0A=
<TITLE>RE: PCI driver on EB8347</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText35068 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
I'm using polling mechanism and not interrupts in my =
driver.&nbsp;Although I'm =0A=
not using polling I see strange behavior When I do lspci -v&nbsp;I don't =
see any =0A=
interrupts being allocated to PCI device behind PCI bridge !!!! But when =
I use =0A=
same card directly on primary bus I do see interrupt being allocated to =
PCI =0A=
device.&nbsp;Any advise why&nbsp;IRQ's being not allocated in case its =
attached =0A=
to PCI bridge ?</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
Do I need to take care of any extra configuration in case of PCI card is =0A=
attached to PCI bridge ?</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Yaa you are =
correct I =0A=
shouldn't use CONFIG_85xx_PCI2</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>-Rajan</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> Liu Dave-r63238 =0A=
[mailto:DaveLiu@freescale.com]<BR><B>Sent:</B> Thu 8/10/2006 10:40 =0A=
PM<BR><B>To:</B> rajan rai; Gala Kumar K.-galak<BR><B>Cc:</B> =0A=
linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> RE: PCI driver on =0A=
EB8347<BR></FONT><BR></DIV>=0A=
<DIV><BR>=0A=
<P><FONT size=3D2>Rajan&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I =
have =0A=
written PCI driver which works fine along with<BR>MPC8347 and two =0A=
PCI<BR>Rajan&gt; card connected in a single PCI bus. When I try to =0A=
communicate<BR>same PCI card<BR>Rajan&gt; using PCI bridge ( PCI2050B ), =
Linux =0A=
does detect PCI card on<BR>Secondary bus<BR>Rajan&gt; but same driver =
doesn't =0A=
work !!!!<BR><BR>PCI interrupt for secondary bus set up =0A=
properly?<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>Rajan&gt;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
Do I need to enable support for second PCI host controller<BR>at kernel =
level =0A=
to<BR>Rajan&gt;make it work? Or I need to do something else ? I tried =0A=
compiling<BR>PPC-linux kernel<BR>Rajan&gt; after enabling =
CONFIG_85xx_PCI2 =0A=
kernel doesn't compile it gives<BR>me error while<BR>Rajan&gt;compiling =0A=
"arch/ppc/syslib/ppc83xx_setup.c" Kernel version I'm<BR>using is =0A=
2.6.13.<BR><BR>Why you enable CONFIG_85xx_PCI2 in kernel? It is for =
85xx, but =0A=
you are<BR>using 8347 =0A=
processor.<BR><BR>&lt;snip&gt;<BR><BR>Dave<BR><BR></FONT></P></DIV>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C6BD26.AF0945B9--
