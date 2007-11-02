Return-Path: <Emilian.Medve@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 826FBDDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 23:55:20 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lA2CtDYB007681
	for <linuxppc-embedded@ozlabs.org>; Fri, 2 Nov 2007 05:55:14 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lA2CtD1s017155
	for <linuxppc-embedded@ozlabs.org>; Fri, 2 Nov 2007 07:55:13 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: The question about the fail at the begin of linux on MPC8360E.
Date: Fri, 2 Nov 2007 05:55:12 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E270174CCE3@az33exm24.fsl.freescale.net>
In-Reply-To: <393972917.10298@tsinghua.org.cn>
References: <393972917.10298@tsinghua.org.cn>
From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
To: =?GB2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>,
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

Hi there,


You need a device tree. The defaut one is =
arch/powerpc/boot/dts/mpc836x_mds.dts. You need the DTC (Device Tree =
Compiler) from here http://jdl.com/git_repos/?p=3Ddtc.git;a=3Dsummary. =
This should be enough to give you some reading pointers.


Cheers,
Emil.


> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+emilian.medve=3Dfreescale.com@ozlabs.o
> rg=20
> [mailto:linuxppc-embedded-bounces+emilian.medve=3Dfreescale.com@
> ozlabs.org] On Behalf Of ??
> Sent: Thursday, November 01, 2007 10:09 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: The question about the fail at the begin of linux on=20
> MPC8360E.
>=20
> Hi,friends,
> Thanks.
>=20
> We boot the linux-2.6.22 on MPC8360 board, it failed, follow=20
> is the output
> information. we just only success on linux-2.6.11, but fail=20
> on linux-2.6.19 and
> linux-2.6.22. Both 2.6.19 and 2.6.22 are failed on same=20
> position,please see follow
> information. linux-2.6.19 and linux-2.6.22 are come from BSP=20
> of freescale. I used
> the u-boot-1.2.0 that compiled by myself. We guess that maybe=20
> we did not setup the
> bootargs parameter on u-boot rightly or maybe the DDR-I=20
> hardware circuit design is
> not good enough.
>=20
> If the reason is the bootargs parameter, could you tell me=20
> what is the right
> bootargs for linux-2.6.19 and linux-2.6.22?
>=20
> If the reason is the DDR, I want to boot the linux on my=20
> SDRAM chip,kick off the
> DDR, my SDRAM located on the address of F0000000~F3FFFFFF,=20
> total 64MB. How can I
> modify the source code of linux to re-map it and ramdisk and=20
> others to my SDRAM
> chip space?
>=20
>=20
> Follow is the fail information:
> =3D> bootm 0c000000 0e000000
> ## Booting image at 0c000000 ...
>    Image Name:   Linux-2.6.22
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1333681 Bytes =3D  1.3 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at 0e000000 ...
>    Image Name:   uboot ext2 ramdisk rootfs
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    3589813 Bytes =3D  3.4 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Loading Ramdisk to 0fc3e000, end 0ffaa6b5 ... OK   =20
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
