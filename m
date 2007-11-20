Return-Path: <DaveLiu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DD6FCDDE19
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 15:38:39 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lAK4cXL1022975 for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Nov 2007 21:38:34 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lAK4cWZW006721
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Nov 2007 22:38:33 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: How can I make the DDR momory storage bigger than 256M?
Date: Tue, 20 Nov 2007 12:38:30 +0800
Message-ID: <995B09A8299C2C44B59866F6391D2635D331A9@zch01exm21.fsl.freescale.net>
In-Reply-To: <395483341.30896@tsinghua.org.cn>
References: <395483341.30896@tsinghua.org.cn>
From: "Liu Dave" <DaveLiu@freescale.com>
To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Guo,

Please post your question to u-boot maillist:

u-boot-users@lists.sourceforge.net=20

Please check if you have the correct BATs for 1GB memory.
1GB memory should need 4 BATs.

Regards,
Dave

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+daveliu=3Dfreescale.com@ozlabs
> .org] On Behalf Of =B9=F9=BE=A2
> Sent: 2007=C4=EA11=D4=C219=C8=D5 10:42 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: How can I make the DDR momory storage bigger than 256M?
>=20
> Hi,friends,
>=20
> I used the U-Boot 1.2.0 on MPC8360E board. My board work=20
> nomally with 256M DDR-1
> Memory.  If I change the DDR-1 up to 1GB, the U-Boot can=20
> visit the DDR address
> range from 0x00000000 to 0x10000000, but it can not visit the=20
> address bigger than
> 0x10000000,I wat wondering why? Thanks.
>=20
> Using the 1GB DDR-1, I can write the u-boot to my flash by=20
> CodeWarrior.
>=20
> Follow is the information that when I test the DDR on u-boot,=20
> the start address is
> 0x1ff00000, the end address is 0x20000000;it was dead when=20
> visit the DDR.
>=20
>=20
>=20
>=20
>=20
>=20
> U-Boot 1.2.0 (Nov 19 2007 - 20:55:34) MPC83XX                =20
>                =20
>                                                              =20
>                =20
> CPU:   e300c1, MPC8360E, Rev: 20 at 528 MHz, CSB:  264 MHz   =20
>                =20
> Board: Freescale MPC8360EMDS                                 =20
>                =20
> I2C:   ready                                                 =20
>                =20
> DRAM:                                                        =20
>                =20
> DIMM type:                                                   =20
>                =20
> SPD size:        128                                         =20
>                =20
> EEPROM size:     256                                         =20
>                =20
> Memory type:     7                                           =20
>                =20
> Row addr:        13                                          =20
>                =20
> Column addr:     11                                          =20
>                =20
> # of rows:       2                                           =20
>                =20
> Row density:     128                                         =20
>                =20
> # of banks:      4                                           =20
>                =20
> Data width:      64                                          =20
>                =20
> Chip width:      8                                           =20
>                =20
> Refresh rate:    82                                          =20
>                =20
> CAS latencies:   18                                          =20
>                =20
> Write latencies: 02                                          =20
>                =20
> tRP:             60                                          =20
>                =20
> tRCD:            60                                          =20
>                =20
>                                                              =20
>                =20
>                                                              =20
>                =20
> cs0_bnds =3D 0x0000001f                                        =20
>                =20
> cs0_config =3D 0x80000103                                      =20
>                =20
> cs1_bnds =3D 0x0020003f                                        =20
>                =20
> cs1_config =3D 0x80000103                                      =20
>                =20
> DDR:bar=3D0x00000000                                           =20
>                =20
> DDR:ar=3D0x8000001d                                            =20
>                =20
> DDR: caslat SPD bit is 4                                     =20
>                =20
> DDR:Module maximum data rate is: 400Mhz                      =20
>                =20
> DDR:Effective data rate is: 266Mhz                           =20
>                =20
> DDR:The MSB 1 of CAS Latency is: 4                           =20
>                =20
> DDR: effective data rate is 266 MHz                          =20
>                =20
> DDR: caslat SPD bit is 4, controller field is 0x5            =20
>                =20
> DDR:timing_cfg_1=3D0x26252727                                  =20
>                =20
> DDR:timing_cfg_2=3D0x00004841                                  =20
>                =20
>                                                              =20
>                =20
>    DDR DIMM: data bus width is 64 bit without ECC            =20
>                =20
> DDR:sdram_mode=3D0x00000032                                    =20
>                =20
> DDR: sdram_mode2 =3D 0x00000000                                =20
>                =20
> DDR:sdram_interval=3D0x04060100                                =20
>                =20
> DDR:sdram_clk_cntl=3D0x02000000                                =20
>                =20
>    DDRC ECC mode: OFF                                        =20
>                =20
> DDR:sdram_cfg=3D0xc2008000                                     =20
>                =20
>                                                              =20
>                =20
>    SDRAM on Local Bus: 64 MB                                 =20
>                =20
>    DDR RAM: 1024 MB                                          =20
>                =20
> DDR test phase 1:             =20
>=20
>=20
> (dead)
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
