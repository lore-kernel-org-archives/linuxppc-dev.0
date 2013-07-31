Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A4412C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 09:52:59 +1000 (EST)
Date: Wed, 31 Jul 2013 18:52:47 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/fsl-booke: Rename b4qds.dts -> b4qds.dtsi.
To: Ian Campbell <Ian.Campbell@citrix.com>
References: <1369995280-20863-1-git-send-email-ian.campbell@citrix.com>
 <1375281925.7382.88.camel@kazak.uk.xensource.com>
In-Reply-To: <1375281925.7382.88.camel@kazak.uk.xensource.com> (from
 Ian.Campbell@citrix.com on Wed Jul 31 09:45:25 2013)
Message-ID: <1375314767.30721.120@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Shaveta Leekha <shaveta@freescale.com>, linux-kernel@vger.kernel.org,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Andy Fleming <afleming@freescale.com>,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've got it in my queue that I hope to send soon.

-Scott

On 07/31/2013 09:45:25 AM, Ian Campbell wrote:
> ping?
>=20
> On Fri, 2013-05-31 at 11:14 +0100, Ian Campbell wrote:
> > This file is a common include for B4860 and B4420 but is not a =20
> valid DTS itself:
> > 	  DTC     arch/powerpc/boot/b4qds.dtb
> > 	Error: arch/powerpc/boot/dts/b4qds.dts:35.1-2 syntax error
> > 	FATAL ERROR: Unable to parse input tree
> > 	make[1]: *** [arch/powerpc/boot/b4qds.dtb] Error 1
> > 	make: *** [b4qds.dtb] Error 2
> >
> > I spotted in build tests of device-tree.git, announcement
> > https://lkml.org/lkml/2013/4/24/209, which builds *.dts. Probably =20
> no one would
> > do this this in real life on linux.git but it still seems worth =20
> fixing.
> >
> > Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> > Cc: Shaveta Leekha <shaveta@freescale.com>
> > Cc: Minghuan Lian <Minghuan.Lian@freescale.com>
> > Cc: Andy Fleming <afleming@freescale.com>
> > Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> > Cc: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> > Cc: Kumar Gala <galak@kernel.crashing.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/powerpc/boot/dts/b4420qds.dts |    2 +-
> >  arch/powerpc/boot/dts/b4860qds.dts |    2 +-
> >  arch/powerpc/boot/dts/b4qds.dts    |  169 =20
> ------------------------------------
> >  arch/powerpc/boot/dts/b4qds.dtsi   |  169 =20
> ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 171 insertions(+), 171 deletions(-)
> >  delete mode 100644 arch/powerpc/boot/dts/b4qds.dts
> >  create mode 100644 arch/powerpc/boot/dts/b4qds.dtsi
> >
> > diff --git a/arch/powerpc/boot/dts/b4420qds.dts =20
> b/arch/powerpc/boot/dts/b4420qds.dts
> > index 923156d..508dbdf 100644
> > --- a/arch/powerpc/boot/dts/b4420qds.dts
> > +++ b/arch/powerpc/boot/dts/b4420qds.dts
> > @@ -33,7 +33,7 @@
> >   */
> >
> >  /include/ "fsl/b4420si-pre.dtsi"
> > -/include/ "b4qds.dts"
> > +/include/ "b4qds.dtsi"
> >
> >  / {
> >  	model =3D "fsl,B4420QDS";
> > diff --git a/arch/powerpc/boot/dts/b4860qds.dts =20
> b/arch/powerpc/boot/dts/b4860qds.dts
> > index 78907f3..6bb3707 100644
> > --- a/arch/powerpc/boot/dts/b4860qds.dts
> > +++ b/arch/powerpc/boot/dts/b4860qds.dts
> > @@ -33,7 +33,7 @@
> >   */
> >
> >  /include/ "fsl/b4860si-pre.dtsi"
> > -/include/ "b4qds.dts"
> > +/include/ "b4qds.dtsi"
> >
> >  / {
> >  	model =3D "fsl,B4860QDS";
> > diff --git a/arch/powerpc/boot/dts/b4qds.dts =20
> b/arch/powerpc/boot/dts/b4qds.dts
> > deleted file mode 100644
> > index e6d2f8f..0000000
> > --- a/arch/powerpc/boot/dts/b4qds.dts
> > +++ /dev/null
> > @@ -1,169 +0,0 @@
> > -/*
> > - * B4420DS Device Tree Source
> > - *
> > - * Copyright 2012 Freescale Semiconductor, Inc.
> > - *
> > - * Redistribution and use in source and binary forms, with or =20
> without
> > - * modification, are permitted provided that the following =20
> conditions are met:
> > - *     * Redistributions of source code must retain the above =20
> copyright
> > - *       notice, this list of conditions and the following =20
> disclaimer.
> > - *     * Redistributions in binary form must reproduce the above =20
> copyright
> > - *       notice, this list of conditions and the following =20
> disclaimer in the
> > - *       documentation and/or other materials provided with the =20
> distribution.
> > - *     * Neither the name of Freescale Semiconductor nor the
> > - *       names of its contributors may be used to endorse or =20
> promote products
> > - *       derived from this software without specific prior written =20
> permission.
> > - *
> > - *
> > - * ALTERNATIVELY, this software may be distributed under the terms =20
> of the
> > - * GNU General Public License ("GPL") as published by the Free =20
> Software
> > - * Foundation, either version 2 of that License or (at your =20
> option) any
> > - * later version.
> > - *
> > - * This software is provided by Freescale Semiconductor "as is" =20
> and any
> > - * express or implied warranties, including, but not limited to, =20
> the implied
> > - * warranties of merchantability and fitness for a particular =20
> purpose are
> > - * disclaimed. In no event shall Freescale Semiconductor be liable =20
> for any
> > - * direct, indirect, incidental, special, exemplary, or =20
> consequential damages
> > - * (including, but not limited to, procurement of substitute goods =20
> or services;
> > - * loss of use, data, or profits; or business interruption) =20
> however caused and
> > - * on any theory of liability, whether in contract, strict =20
> liability, or tort
> > - * (including negligence or otherwise) arising in any way out of =20
> the use of
> > - * this software, even if advised of the possibility of such =20
> damage.
> > - */
> > -
> > -/ {
> > -	model =3D "fsl,B4QDS";
> > -	compatible =3D "fsl,B4QDS";
> > -	#address-cells =3D <2>;
> > -	#size-cells =3D <2>;
> > -	interrupt-parent =3D <&mpic>;
> > -
> > -	ifc: localbus@ffe124000 {
> > -		reg =3D <0xf 0xfe124000 0 0x2000>;
> > -		ranges =3D <0 0 0xf 0xe8000000 0x08000000
> > -			  2 0 0xf 0xff800000 0x00010000
> > -			  3 0 0xf 0xffdf0000 0x00008000>;
> > -
> > -		nor@0,0 {
> > -			#address-cells =3D <1>;
> > -			#size-cells =3D <1>;
> > -			compatible =3D "cfi-flash";
> > -			reg =3D <0x0 0x0 0x8000000>;
> > -			bank-width =3D <2>;
> > -			device-width =3D <1>;
> > -		};
> > -
> > -		nand@2,0 {
> > -			#address-cells =3D <1>;
> > -			#size-cells =3D <1>;
> > -			compatible =3D "fsl,ifc-nand";
> > -			reg =3D <0x2 0x0 0x10000>;
> > -
> > -			partition@0 {
> > -				/* This location must not be altered  */
> > -				/* 1MB for u-boot Bootloader Image */
> > -				reg =3D <0x0 0x00100000>;
> > -				label =3D "NAND U-Boot Image";
> > -				read-only;
> > -			};
> > -
> > -			partition@100000 {
> > -				/* 1MB for DTB Image */
> > -				reg =3D <0x00100000 0x00100000>;
> > -				label =3D "NAND DTB Image";
> > -			};
> > -
> > -			partition@200000 {
> > -				/* 10MB for Linux Kernel Image */
> > -				reg =3D <0x00200000 0x00A00000>;
> > -				label =3D "NAND Linux Kernel Image";
> > -			};
> > -
> > -			partition@c00000 {
> > -				/* 500MB for Root file System Image */
> > -				reg =3D <0x00c00000 0x1F400000>;
> > -				label =3D "NAND RFS Image";
> > -			};
> > -		};
> > -
> > -		board-control@3,0 {
> > -			compatible =3D "fsl,b4qds-fpga", "fsl,fpga-qixis";
> > -			reg =3D <3 0 0x300>;
> > -		};
> > -	};
> > -
> > -	memory {
> > -		device_type =3D "memory";
> > -	};
> > -
> > -	dcsr: dcsr@f00000000 {
> > -		ranges =3D <0x00000000 0xf 0x00000000 0x01052000>;
> > -	};
> > -
> > -	soc: soc@ffe000000 {
> > -		ranges =3D <0x00000000 0xf 0xfe000000 0x1000000>;
> > -		reg =3D <0xf 0xfe000000 0 0x00001000>;
> > -		spi@110000 {
> > -			flash@0 {
> > -				#address-cells =3D <1>;
> > -				#size-cells =3D <1>;
> > -				compatible =3D "sst,sst25wf040";
> > -				reg =3D <0>;
> > -				spi-max-frequency =3D <40000000>; /* =20
> input clock */
> > -			};
> > -		};
> > -
> > -		sdhc@114000 {
> > -			/*Disabled as there is no sdhc connector on =20
> B4420QDS board*/
> > -			status =3D "disabled";
> > -		};
> > -
> > -		i2c@118000 {
> > -			eeprom@50 {
> > -				compatible =3D "at24,24c64";
> > -				reg =3D <0x50>;
> > -			};
> > -			eeprom@51 {
> > -				compatible =3D "at24,24c256";
> > -				reg =3D <0x51>;
> > -			};
> > -			eeprom@53 {
> > -				compatible =3D "at24,24c256";
> > -				reg =3D <0x53>;
> > -			};
> > -			eeprom@57 {
> > -				compatible =3D "at24,24c256";
> > -				reg =3D <0x57>;
> > -			};
> > -			rtc@68 {
> > -				compatible =3D "dallas,ds3232";
> > -				reg =3D <0x68>;
> > -			};
> > -		};
> > -
> > -		usb@210000 {
> > -			dr_mode =3D "host";
> > -			phy_type =3D "ulpi";
> > -		};
> > -
> > -	};
> > -
> > -	pci0: pcie@ffe200000 {
> > -		reg =3D <0xf 0xfe200000 0 0x10000>;
> > -		ranges =3D <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 =20
> 0x20000000
> > -			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 =20
> 0x00010000>;
> > -		pcie@0 {
> > -			ranges =3D <0x02000000 0 0xe0000000
> > -				  0x02000000 0 0xe0000000
> > -				  0 0x20000000
> > -
> > -				  0x01000000 0 0x00000000
> > -				  0x01000000 0 0x00000000
> > -				  0 0x00010000>;
> > -		};
> > -	};
> > -
> > -};
> > -
> > -/include/ "fsl/b4si-post.dtsi"
> > diff --git a/arch/powerpc/boot/dts/b4qds.dtsi =20
> b/arch/powerpc/boot/dts/b4qds.dtsi
> > new file mode 100644
> > index 0000000..e6d2f8f
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/b4qds.dtsi
> > @@ -0,0 +1,169 @@
> > +/*
> > + * B4420DS Device Tree Source
> > + *
> > + * Copyright 2012 Freescale Semiconductor, Inc.
> > + *
> > + * Redistribution and use in source and binary forms, with or =20
> without
> > + * modification, are permitted provided that the following =20
> conditions are met:
> > + *     * Redistributions of source code must retain the above =20
> copyright
> > + *       notice, this list of conditions and the following =20
> disclaimer.
> > + *     * Redistributions in binary form must reproduce the above =20
> copyright
> > + *       notice, this list of conditions and the following =20
> disclaimer in the
> > + *       documentation and/or other materials provided with the =20
> distribution.
> > + *     * Neither the name of Freescale Semiconductor nor the
> > + *       names of its contributors may be used to endorse or =20
> promote products
> > + *       derived from this software without specific prior written =20
> permission.
> > + *
> > + *
> > + * ALTERNATIVELY, this software may be distributed under the terms =20
> of the
> > + * GNU General Public License ("GPL") as published by the Free =20
> Software
> > + * Foundation, either version 2 of that License or (at your =20
> option) any
> > + * later version.
> > + *
> > + * This software is provided by Freescale Semiconductor "as is" =20
> and any
> > + * express or implied warranties, including, but not limited to, =20
> the implied
> > + * warranties of merchantability and fitness for a particular =20
> purpose are
> > + * disclaimed. In no event shall Freescale Semiconductor be liable =20
> for any
> > + * direct, indirect, incidental, special, exemplary, or =20
> consequential damages
> > + * (including, but not limited to, procurement of substitute goods =20
> or services;
> > + * loss of use, data, or profits; or business interruption) =20
> however caused and
> > + * on any theory of liability, whether in contract, strict =20
> liability, or tort
> > + * (including negligence or otherwise) arising in any way out of =20
> the use of
> > + * this software, even if advised of the possibility of such =20
> damage.
> > + */
> > +
> > +/ {
> > +	model =3D "fsl,B4QDS";
> > +	compatible =3D "fsl,B4QDS";
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +	interrupt-parent =3D <&mpic>;
> > +
> > +	ifc: localbus@ffe124000 {
> > +		reg =3D <0xf 0xfe124000 0 0x2000>;
> > +		ranges =3D <0 0 0xf 0xe8000000 0x08000000
> > +			  2 0 0xf 0xff800000 0x00010000
> > +			  3 0 0xf 0xffdf0000 0x00008000>;
> > +
> > +		nor@0,0 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			compatible =3D "cfi-flash";
> > +			reg =3D <0x0 0x0 0x8000000>;
> > +			bank-width =3D <2>;
> > +			device-width =3D <1>;
> > +		};
> > +
> > +		nand@2,0 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			compatible =3D "fsl,ifc-nand";
> > +			reg =3D <0x2 0x0 0x10000>;
> > +
> > +			partition@0 {
> > +				/* This location must not be altered  */
> > +				/* 1MB for u-boot Bootloader Image */
> > +				reg =3D <0x0 0x00100000>;
> > +				label =3D "NAND U-Boot Image";
> > +				read-only;
> > +			};
> > +
> > +			partition@100000 {
> > +				/* 1MB for DTB Image */
> > +				reg =3D <0x00100000 0x00100000>;
> > +				label =3D "NAND DTB Image";
> > +			};
> > +
> > +			partition@200000 {
> > +				/* 10MB for Linux Kernel Image */
> > +				reg =3D <0x00200000 0x00A00000>;
> > +				label =3D "NAND Linux Kernel Image";
> > +			};
> > +
> > +			partition@c00000 {
> > +				/* 500MB for Root file System Image */
> > +				reg =3D <0x00c00000 0x1F400000>;
> > +				label =3D "NAND RFS Image";
> > +			};
> > +		};
> > +
> > +		board-control@3,0 {
> > +			compatible =3D "fsl,b4qds-fpga", "fsl,fpga-qixis";
> > +			reg =3D <3 0 0x300>;
> > +		};
> > +	};
> > +
> > +	memory {
> > +		device_type =3D "memory";
> > +	};
> > +
> > +	dcsr: dcsr@f00000000 {
> > +		ranges =3D <0x00000000 0xf 0x00000000 0x01052000>;
> > +	};
> > +
> > +	soc: soc@ffe000000 {
> > +		ranges =3D <0x00000000 0xf 0xfe000000 0x1000000>;
> > +		reg =3D <0xf 0xfe000000 0 0x00001000>;
> > +		spi@110000 {
> > +			flash@0 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <1>;
> > +				compatible =3D "sst,sst25wf040";
> > +				reg =3D <0>;
> > +				spi-max-frequency =3D <40000000>; /* =20
> input clock */
> > +			};
> > +		};
> > +
> > +		sdhc@114000 {
> > +			/*Disabled as there is no sdhc connector on =20
> B4420QDS board*/
> > +			status =3D "disabled";
> > +		};
> > +
> > +		i2c@118000 {
> > +			eeprom@50 {
> > +				compatible =3D "at24,24c64";
> > +				reg =3D <0x50>;
> > +			};
> > +			eeprom@51 {
> > +				compatible =3D "at24,24c256";
> > +				reg =3D <0x51>;
> > +			};
> > +			eeprom@53 {
> > +				compatible =3D "at24,24c256";
> > +				reg =3D <0x53>;
> > +			};
> > +			eeprom@57 {
> > +				compatible =3D "at24,24c256";
> > +				reg =3D <0x57>;
> > +			};
> > +			rtc@68 {
> > +				compatible =3D "dallas,ds3232";
> > +				reg =3D <0x68>;
> > +			};
> > +		};
> > +
> > +		usb@210000 {
> > +			dr_mode =3D "host";
> > +			phy_type =3D "ulpi";
> > +		};
> > +
> > +	};
> > +
> > +	pci0: pcie@ffe200000 {
> > +		reg =3D <0xf 0xfe200000 0 0x10000>;
> > +		ranges =3D <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 =20
> 0x20000000
> > +			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 =20
> 0x00010000>;
> > +		pcie@0 {
> > +			ranges =3D <0x02000000 0 0xe0000000
> > +				  0x02000000 0 0xe0000000
> > +				  0 0x20000000
> > +
> > +				  0x01000000 0 0x00000000
> > +				  0x01000000 0 0x00000000
> > +				  0 0x00010000>;
> > +		};
> > +	};
> > +
> > +};
> > +
> > +/include/ "fsl/b4si-post.dtsi"
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
>=20
>=20

=
