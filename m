Message-ID: <D73A25AA6E54D511AD74009027B1110F3C05F1@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: nitesh_ppc@lycos.com, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Howto install bootloader using jtag?
Date: Thu, 30 Jan 2003 08:52:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The first thing you do is create an appropriate config file for the debugger
and board.  If you go to ftp://ftp.denx.de/pub/BDI2000/ you can get Abatron
BDI config files for the ep405 board.  You run this script then download the
pcl____.ep file that is on the documentation CD.  This file executes at
location 0x100000 and will burn the bootloader into flash.

It is important to note that the JTAG/COP connector on the ep405 ships with
the COP enabled, not the JTAG.  There is very little difference between JTAG
and COP but this can mess people up under certain circumstances.  I have
used the Abatron BDI 2000, Macraigor RAVEN, Macraigor OCDemon and the IBM
RiscWatch.

-----Original Message-----
From: Michael Washburn [mailto:mwashburn@citlink.net]
Sent: Wednesday, January 29, 2003 10:51 PM
To: nitesh_ppc@lycos.com; linuxppc-embedded@lists.linuxppc.org
Subject: Re: Howto install bootloader using jtag?



Depending on what JTAG debugger you're using, there should be a way to
download and execute the S-Rec file (usually a .mot file). The bootloader
file provided by Emdedded Planet is actually an executable that contains the
boot loader image. You should be able to download and execute it in one
simple step.

Mike Washburn
----- Original Message -----
From: "Nitesh Goyal" <nitesh_ppc@lycos.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, January 29, 2003 9:45 PM
Subject: Howto install bootloader using jtag?


>
> Hi,
> I'm using a IBM PPC 405GP board(from embeddedplanet) I accidently
> deleted the bootloader.
>
> I have the bootloader srecord image on my host, but I do not know how to
> burn it on board using JTAG ?
>
> Is there a utility available that I can use on host to download the
> bootloader image to tbe board ?
>
> Thanks,
> NItesh
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
