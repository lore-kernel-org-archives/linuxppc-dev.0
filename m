Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3641DDEFE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 01:14:03 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l39FDvk4023228
	for <linuxppc-embedded@ozlabs.org>; Mon, 9 Apr 2007 08:13:58 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l39FDvQO013724
	for <linuxppc-embedded@ozlabs.org>; Mon, 9 Apr 2007 10:13:57 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Powerpc newbie help
Date: Mon, 9 Apr 2007 08:13:56 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302C56221@az33exm25.fsl.freescale.net>
In-Reply-To: <E1FC5EDA57236147B397280C5E6C130032FDBA@MC4EXCH04.mcdata.com>
References: <E1FC5EDA57236147B397280C5E6C130032FDBA@MC4EXCH04.mcdata.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Gary Schumacher" <gschumac@brocade.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Right now documentation on the flat device tree is pretty
fragemented.  The concepts are based on the IEEE-1275=20
spec of which a relatively small portion is actually=20
relevant.  Other device types and properties come from
other 'binding' documents.

Here is a list of the documents I know about:

1275 spec:
http://playground.sun.com/pub/1275/coredoc/1275-1994/1275.ps.gz

PowerPC processor binding:
http://playground.sun.com/1275/bindings/ppc/release/ppc-2_1.html

booting-without-of.txt (kernel source code: Documentation/powerpc)
-Describes the flat device tree as it is used in the Linux=20
 kernel.

Device Trees Everywhere-- paper by David Gibson and
Ben Herrenschmidt-- an overview of the concept
http://ozlabs.org/~dgibson/home/papers/dtc-paper.pdf

PCI Bus binding:
http://playground.sun.com/1275/bindings/pci/pci2_1.pdf

USB Bus binding:
http://playground.sun.com/1275/bindings/usb/usb-1_0.ps

CHRP Binding:
http://playground.sun.com/1275/bindings/chrp/chrp1_8a.ps
(I think some things we may use like interrupt controller
device types came from here)

64-bit extension:
http://playground.sun.com/1275/bindings/64bitx/12756d5.ps

interrupt mappings (** very important **):
http://playground.sun.com/1275/practice/imap/imap0_9d.html

misc device types (network, RTC, sound, etc)
http://playground.sun.com/1275/practice/devicex/dse1_0a.html
=20
Regards,
Stuart Yoder
PowerPC Software Architecture
Freescale

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+b08248=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+b08248=3Dfreescale.com@ozlabs.
org] On Behalf Of Gary Schumacher
> Sent: Friday, April 06, 2007 8:34 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Powerpc newbie help
>=20
>=20
> =20
>=20
> I am in the process of upgrading a Linux kernel from 2.4,20=20
> to 2.6.20 on
> a proprietary board that uses the PPC 750Fx (without Open=20
> Firmware) and
> am having the following problems:
>=20
> =20
> 1.  Is there more information on Device Trees so I can construct one
> myself?  I have been reading "Device trees everywhere" and
> "booting-without-of".  Also, there are a number of *.dts files in
> /arch/powerpc/boot/dts that I have been looking at but more
> examples/HowTo information would be helpful.
>=20
> 2.  I have downloaded dtc-2006419.tar and was wondering if there is a
> newer version or do I need patches for this and if so where would I
> look?
>=20
> 3.  Where do I find glr_parser which is required to build dtc?
>=20
> Thanks
> =20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
