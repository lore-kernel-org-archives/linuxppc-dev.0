Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 08B79B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 21:34:45 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74C56DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 21:34:42 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n76BYLtO019355
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 04:34:32 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n76BYn4q004885
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 06:34:50 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH][powerpc/85xx] P2020RDB Platform Support Added
Date: Thu, 6 Aug 2009 17:04:18 +0530
Message-ID: <1BD5CFC378ED0946B688E0C9BA2EF0951931A6@zin33exm24.fsl.freescale.net>
In-Reply-To: <4A7A7C45.4040800@embedded-sol.com>
References: <1249532639-20070-1-git-send-email-poonam.aggrwal@freescale.com>	<4A7A776D.7080400@embedded-sol.com><1BD5CFC378ED0946B688E0C9BA2EF09519312F@zin33exm24.fsl.freescale.net>
	<4A7A7C45.4040800@embedded-sol.com>
From: "Aggrwal Poonam-B10812" <Poonam.Aggrwal@freescale.com>
To: "Felix Radensky" <felix@embedded-sol.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-release@webnode01-prod1.am.freescale.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs
> .org=20
> [mailto:linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@list
s.ozlabs.org] On Behalf Of Felix Radensky
> Sent: Thursday, August 06, 2009 12:16 PM
> To: Aggrwal Poonam-B10812
> Cc: linuxppc-dev@ozlabs.org;=20
> linuxppc-release@webnode01-prod1.am.freescale.net
> Subject: Re: [PATCH][powerpc/85xx] P2020RDB Platform Support Added
>=20
> Aggrwal Poonam-B10812 wrote:
> > =20
> >
> >  =20
> >> -----Original Message-----
> >> From: Felix Radensky [mailto:felix@embedded-sol.com]
> >> Sent: Thursday, August 06, 2009 11:56 AM
> >> To: Aggrwal Poonam-B10812
> >> Cc: linuxppc-release@webnode01-prod1.am.freescale.net;
> >> linuxppc-dev@ozlabs.org
> >> Subject: Re: [PATCH][powerpc/85xx] P2020RDB Platform Support Added
> >>
> >> Hi, Poonam
> >>
> >> Poonam Aggrwal wrote:
> >>    =20
> >>> Adds P2020RDB basic support in linux.
> >>> Overview of P2020RDB platform
> >>> 	- DDR
> >>> 	  DDR2 1G
> >>> 	- NOR Flash
> >>> 	  16MByte
> >>> 	- NAND Flash
> >>> 	  32MByte
> >>> 	- 3 Ethernet interfaces
> >>> 	  1) etSEC1
> >>> 		- RGMII
> >>> 		- connected to a 5 port Vitesse Switch(VSC7385)
> >>> 		- Switch is memory mapped through eLBC interface(CS#2)
> >>> 		- IRQ1
> >>> 	  2) etSEC2
> >>> 		- SGMII
> >>> 		- connected to VSC8221
> >>> 		- IRQ2
> >>> 	  3) etSEC3
> >>> 		- RGMII
> >>> 		- connected to VSC8641
> >>> 		- IRQ3
> >>> 	- 2 1X PCIe interfaces
> >>> 	- SD/MMC ,USB
> >>> 	- SPI EEPROM
> >>> 	- Serial I2C EEPROM
> >>>
> >>> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> >>> ---
> >>> based on
> >>>      =20
> >> http://www.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> >>    =20
> >>>  arch/powerpc/boot/dts/p2020rdb.dts        |  586=20
> >>>      =20
> >> +++++++++++++++++++++++++++++
> >>    =20
> >>>  arch/powerpc/configs/mpc85xx_defconfig    |    1 +
> >>>  arch/powerpc/platforms/85xx/Kconfig       |    9 +
> >>>  arch/powerpc/platforms/85xx/Makefile      |    3 +-
> >>>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  141 +++++++
> >>>  5 files changed, 739 insertions(+), 1 deletions(-)  create mode
> >>> 100644 arch/powerpc/boot/dts/p2020rdb.dts
> >>>  create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> >>>
> >>> diff --git a/arch/powerpc/boot/dts/p2020rdb.dts
> >>> b/arch/powerpc/boot/dts/p2020rdb.dts
> >>> new file mode 100644
> >>> index 0000000..d6d8131
> >>> --- /dev/null
> >>> +++ b/arch/powerpc/boot/dts/p2020rdb.dts
> >>> @@ -0,0 +1,586 @@
> >>> +/*
> >>> + * P2020 RDB Device Tree Source
> >>> + *
> >>> + * Copyright 2009 Freescale Semiconductor Inc.
> >>> + *
> >>> + * This program is free software; you can redistribute =20
> it and/or=20
> >>> +modify it
> >>> + * under  the terms of  the GNU General  Public License as
> >>>      =20
> >> published
> >>    =20
> >>> +by the
> >>> + * Free Software Foundation;  either version 2 of the =20
> License, or=20
> >>> +(at your
> >>> + * option) any later version.
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +/ {
> >>> +	model =3D "fsl,P2020";
> >>> +	compatible =3D "fsl,P2020RDB";
> >>> +	#address-cells =3D <2>;
> >>> +	#size-cells =3D <2>;
> >>> +
> >>> +	aliases {
> >>> +		ethernet0 =3D &enet0;
> >>> +		ethernet1 =3D &enet1;
> >>> +		ethernet2 =3D &enet2;
> >>> +		serial0 =3D &serial0;
> >>> +		serial1 =3D &serial1;
> >>> +		pci0 =3D &pci0;
> >>> +		pci1 =3D &pci1;
> >>> +	};
> >>> +
> >>> +	cpus {
> >>> +		#address-cells =3D <1>;
> >>> +		#size-cells =3D <0>;
> >>> +
> >>> +		PowerPC,P2020@0 {
> >>> +			device_type =3D "cpu";
> >>> +			reg =3D <0x0>;
> >>> +			next-level-cache =3D <&L2>;
> >>> +		};
> >>> +
> >>> +		PowerPC,P2020@1 {
> >>> +			device_type =3D "cpu";
> >>> +			reg =3D <0x1>;
> >>> +			next-level-cache =3D <&L2>;
> >>> +		};
> >>> +	};
> >>> +
> >>> +	memory {
> >>> +		device_type =3D "memory";
> >>> +	};
> >>> +
> >>> +	localbus@ffe05000 {
> >>> +		#address-cells =3D <2>;
> >>> +		#size-cells =3D <1>;
> >>> +		compatible =3D "fsl,p2020-elbc", "fsl,elbc", "simple-bus";
> >>> +		reg =3D <0 0xffe05000 0 0x1000>;
> >>> +		interrupts =3D <19 2>;
> >>> +		interrupt-parent =3D <&mpic>;
> >>> +
> >>> +		/* NOR and NAND Flashes */
> >>> +		ranges =3D <0x0 0x0 0x0 0xef000000 0x01000000
> >>> +			  0x1 0x0 0x0 0xffa00000 0x00040000
> >>> +			  0x2 0x0 0x0 0xffb00000 0x08000000>;
> >>>  =20
> >>>      =20
> >> The comment is a bit misleading, CS2 is L2 switch.
> >>    =20
> > Okay will modify it.=20
> >  =20
> >> Also, are
> >> you sure the CS2 range shouldn't look like
> >>      =20
> >> 0x2 0x0 0x0 0xffb00000 0x00020000
> >>
> >> That's what L2switch reg property suggests. =20
> >>    =20
> > Thanks , for catching it!...this is a bug , I changed the=20
> size in the
> > reg property but not in the ranges.       =20
> >  =20
> >>> +
> >>> +		nor@0,0 {
> >>> +			#address-cells =3D <1>;
> >>> +			#size-cells =3D <1>;
> >>> +			compatible =3D "cfi-flash";
> >>> +			reg =3D <0x0 0x0 0x1000000>;
> >>> +			bank-width =3D <2>;
> >>> +			device-width =3D <1>;
> >>> +
> >>> +			vitesse-7385-fw@0 {
> >>> +				/* This location must not be altered  */
> >>> +				/* 256KB for Vitesse 7385
> >>>      =20
> >> Switch firmware */
> >>    =20
> >>> +				reg =3D <0x0 0x00040000>;
> >>> +				label =3D "NOR (RO) Vitesse-7385
> >>>      =20
> >> Firmware";
> >>    =20
> >>> +				read-only;
> >>> +			};
> >>>  =20
> >>>      =20
> >> Partitions should be declared as
> >>
> >>        partition@0 {
> >>                    reg =3D ...
> >>                    label =3D ...
> >>                    ...
> >>         }
> >>    =20
> > Doing it this way is good from readability perspective, but we=20
> > generally do not use this convention in our platforms eg 8572DS, etc
> >  =20
> >
> >  =20
>=20
> I think the DTS for 8572 should be fixed as well. The OF=20
> partition parser does not recognize your syntax and=20
> partitions will not appear in /proc/mtd.=20
> I've encountered
> this recently with mainline port of 8536DS. I've tried to=20
> copy partition info from 8572 and it didn't work until I've=20
> switched to new syntax.
Can u point me to some reference of this, shud they be partition@0,
partition@1, etc...
I am not able to configure all the partitions successfully.

Thanks=20
poonam
>=20
> Felix.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
