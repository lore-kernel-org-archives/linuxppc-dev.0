Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0F4052C0131
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 02:03:42 +1100 (EST)
Subject: Re: [PATCH 2/6] powerpc/fsl-booke: Add initial B4860QDS board device
 tree
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <E12D2F89F87F4A49B0320A4C2DE7E749144AA5@039-SN2MPN1-011.039d.mgd.msft.net>
Date: Mon, 18 Mar 2013 10:02:33 -0500
Message-Id: <5594D9B8-885F-4A02-9F7D-B6BFA8BD84C8@kernel.crashing.org>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
 <1363334109-21922-2-git-send-email-shaveta@freescale.com>
 <7EB2D4A9-A5BC-4958-9AD8-51B254666356@kernel.crashing.org>
 <E12D2F89F87F4A49B0320A4C2DE7E749144AA5@039-SN2MPN1-011.039d.mgd.msft.net>
To: Leekha Shaveta-B20052 <B20052@freescale.com>
Cc: Fleming Andy-AFLEMING <afleming@freescale.com>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Lian Minghuan-B31939 <B31939@freescale.com>,
 Mehresh Ramneek-B31383 <B31383@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 18, 2013, at 1:31 AM, Leekha Shaveta-B20052 wrote:

>=20
>=20
> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Saturday, March 16, 2013 1:57 AM
> To: Leekha Shaveta-B20052
> Cc: linuxppc-dev@lists.ozlabs.org; Lian Minghuan-B31939; Fleming =
Andy-AFLEMING; Aggrwal Poonam-B10812; Mehresh Ramneek-B31383
> Subject: Re: [PATCH 2/6] powerpc/fsl-booke: Add initial B4860QDS board =
device tree
>=20
>=20
> On Mar 15, 2013, at 2:55 AM, Shaveta Leekha wrote:
>=20
>> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>> Signed-off-by: Andy Fleming <afleming@freescale.com>
>> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
>> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> arch/powerpc/boot/dts/b4860qds.dts |  178=20
>> ++++++++++++++++++++++++++++++++++++
>> 1 files changed, 178 insertions(+), 0 deletions(-) create mode 100644=20=

>> arch/powerpc/boot/dts/b4860qds.dts
>>=20
>> diff --git a/arch/powerpc/boot/dts/b4860qds.dts=20
>> b/arch/powerpc/boot/dts/b4860qds.dts
>> new file mode 100644
>> index 0000000..ae6ac05
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/b4860qds.dts
>> @@ -0,0 +1,178 @@
>> +/*
>> + * B4860DS Device Tree Source
>> + *
>> + * Copyright 2012 Freescale Semiconductor Inc.
>> + *
>> + * Redistribution and use in source and binary forms, with or =
without
>> + * modification, are permitted provided that the following =
conditions are met:
>> + *     * Redistributions of source code must retain the above =
copyright
>> + *       notice, this list of conditions and the following =
disclaimer.
>> + *     * Redistributions in binary form must reproduce the above =
copyright
>> + *       notice, this list of conditions and the following =
disclaimer in the
>> + *       documentation and/or other materials provided with the =
distribution.
>> + *     * Neither the name of Freescale Semiconductor nor the
>> + *       names of its contributors may be used to endorse or promote =
products
>> + *       derived from this software without specific prior written =
permission.
>> + *
>> + *
>> + * ALTERNATIVELY, this software may be distributed under the terms =
of=20
>> +the
>> + * GNU General Public License ("GPL") as published by the Free=20
>> +Software
>> + * Foundation, either version 2 of that License or (at your option)=20=

>> +any
>> + * later version.
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' =
AND=20
>> +ANY
>> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE=20=

>> +IMPLIED
>> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR =
PURPOSE=20
>> +ARE
>> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE=20=

>> +FOR ANY
>> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR =
CONSEQUENTIAL=20
>> +DAMAGES
>> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS =
OR=20
>> +SERVICES;
>> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER=20=

>> +CAUSED AND
>> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT =
LIABILITY,=20
>> +OR TORT
>> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE=20=

>> +USE OF THIS
>> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> + */
>> +
>> +/include/ "fsl/b4860si-pre.dtsi"
>> +
>> +/ {
>> +	model =3D "fsl,B4860QDS";
>> +	compatible =3D "fsl,B4860QDS";
>> +	#address-cells =3D <2>;
>> +	#size-cells =3D <2>;
>> +	interrupt-parent =3D <&mpic>;
>> +
>> +	ifc: localbus@ffe124000 {
>> +		reg =3D <0xf 0xfe124000 0 0x2000>;
>> +		ranges =3D <0 0 0xf 0xe8000000 0x08000000
>> +			  2 0 0xf 0xff800000 0x00010000
>> +			  3 0 0xf 0xffdf0000 0x00008000>;
>> +
>> +		nor@0,0 {
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <1>;
>> +			compatible =3D "cfi-flash";
>> +			reg =3D <0x0 0x0 0x8000000>;
>> +			bank-width =3D <2>;
>> +			device-width =3D <1>;
>> +		};
>> +
>> +		nand@2,0 {
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <1>;
>> +			compatible =3D "fsl,ifc-nand";
>> +			reg =3D <0x2 0x0 0x10000>;
>> +
>> +			partition@0 {
>> +				/* This location must not be altered  */
>> +				/* 1MB for u-boot Bootloader Image */
>> +				reg =3D <0x0 0x00100000>;
>> +				label =3D "NAND U-Boot Image";
>> +				read-only;
>> +			};
>> +
>> +			partition@100000 {
>> +				/* 1MB for DTB Image */
>> +				reg =3D <0x00100000 0x00100000>;
>> +				label =3D "NAND DTB Image";
>> +			};
>> +
>> +			partition@200000 {
>> +				/* 10MB for Linux Kernel Image */
>> +				reg =3D <0x00200000 0x00A00000>;
>> +				label =3D "NAND Linux Kernel Image";
>> +			};
>> +
>> +			partition@c00000 {
>> +				/* 500MB for Root file System Image */
>> +				reg =3D <0x00c00000 0x1F400000>;
>> +				label =3D "NAND RFS Image";
>> +			};
>> +		};
>> +
>> +		board-control@3,0 {
>> +			compatible =3D "fsl,b4860qds-fpga", =
"fsl,fpga-qixis";
>> +			reg =3D <3 0 0x300>;
>> +		};
>> +	};
>> +
>=20
> dscr nodes are missing and should be included
> [SL] I don't have much idea about dcsr nodes structure and their =
respective testing, also couldn't find then in T4 device tree files. I =
have added initial device trees. Dcsr may be added later as updation. =
What do you say? =20

I'll add them to T4, but if you look at the internal FSL SDK tree you =
will see they've been added for T4 & B4.

>=20
>=20
>> +	memory {
>> +		device_type =3D "memory";
>> +	};
>> +
>> +	soc: soc@ffe000000 {
>> +		ranges =3D <0x00000000 0xf 0xfe000000 0x1000000>;
>> +		reg =3D <0xf 0xfe000000 0 0x00001000>;
>> +		spi@110000 {
>> +			flash@0 {
>> +				#address-cells =3D <1>;
>> +				#size-cells =3D <1>;
>> +				compatible =3D "sst,sst25wf040";
>> +				reg =3D <0>;
>> +				spi-max-frequency =3D <40000000>; /* =
input clock */
>> +			};
>> +		};
>> +
>> +		sdhc@114000 {
>> +			status =3D "disabled";
>> +		};
>> +
>> +		i2c@118000 {
>> +			eeprom@50 {
>> +				compatible =3D "at24,24c64";
>> +				reg =3D <0x50>;
>> +			};
>> +			eeprom@51 {
>> +				compatible =3D "at24,24c256";
>> +				reg =3D <0x51>;
>> +			};
>> +			eeprom@53 {
>> +				compatible =3D "at24,24c256";
>> +				reg =3D <0x53>;
>> +			};
>> +			eeprom@57 {
>> +				compatible =3D "at24,24c256";
>> +				reg =3D <0x57>;
>> +			};
>> +			rtc@68 {
>> +				compatible =3D "dallas,ds3232";
>> +				reg =3D <0x68>;
>> +				interrupts =3D <0x1 0x1 0 0>;
>=20
> there is no IRQ for RTC on the board.
> [SL] will remove it.=20
>=20
>> +			};
>> +		};
>> +
>> +		usb@210000 {
>> +			dr_mode =3D "host";
>> +			phy_type =3D "ulpi";
>> +		};
>> +
>> +	};
>> +
>> +	pci0: pcie@ffe200000 {
>> +		reg =3D <0xf 0xfe200000 0 0x10000>;
>> +		ranges =3D <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 =
0x20000000
>> +			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 =
0x00010000>;
>> +		pcie@0 {
>> +			ranges =3D <0x02000000 0 0xe0000000
>> +				  0x02000000 0 0xe0000000
>> +				  0 0x20000000
>> +
>> +				  0x01000000 0 0x00000000
>> +				  0x01000000 0 0x00000000
>> +				  0 0x00010000>;
>> +		};
>> +	};
>> +
>> +	rio: rapidio@ffe0c0000 {
>> +		reg =3D <0xf 0xfe0c0000 0 0x11000>;
>> +
>> +		port1 {
>> +			ranges =3D <0 0 0xc 0x20000000 0 0x10000000>;
>> +		};
>> +		port2 {
>> +			ranges =3D <0 0 0xc 0x30000000 0 0x10000000>;
>> +		};
>> +	};
>> +
>> +};
>> +
>> +/include/ "fsl/b4860si-post.dtsi"
>> --
>> 1.7.6.GIT
>>=20
>=20
>=20
> Regards,
> Shaveta
>=20
>=20
