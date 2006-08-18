Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4732F67B32
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Aug 2006 18:40:57 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7I8euco019951 for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Aug 2006 01:40:56 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7I8essb010982
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Aug 2006 03:40:55 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: USB-Driver for Freescale ehci-fsl.c on Kernel 2.6.17
Date: Fri, 18 Aug 2006 16:41:22 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FBD3D@zch01exm20.fsl.freescale.net>
In-Reply-To: <DADA32856852FC458E0F96B664A6F55E011E23F8@kom-mailsrv1.kontron-modular.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Claus Gindhart" <claus.gindhart@kontron.com>,
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

ehci-fsl.c is included in ehci.c, not handled by Makefile.

Best Regards,
Leo
> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
Behalf Of
> Claus Gindhart
> Sent: Friday, August 18, 2006 2:26 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: USB-Driver for Freescale ehci-fsl.c on Kernel 2.6.17
>=20
> Hi,
>=20
> currently i am migrating an existing Linux-BSP for the MPC8347/9 from
Kernel 2.6.13
> to 2.6.17 with flattened device tree.
>=20
> Now, i recognized, that the Makefile and Kconfig in drivers/usb/host
do not have
> any entries to configure and compile the ehci-fsl.c driver.
>=20
> Does this mean, that ehci-fsl.c is no longer required, because the
generic
> EHCI-driver now handles this; or is it just the case, that USB for
Freescale
> processor was not yet tested on Kernel 2.6.17 ?
>=20
> --
> Mit freundlichen Gruessen / Best regards
>=20
> Claus Gindhart
> SW R&D
> Kontron Modular Computers
> phone :++49 (0)8341-803-374
> mailto:claus.gindhart@kontron-modular.com
> http://www.kontron.com
>=20
> -----BEGIN GEEK CODE BLOCK-----
>   Version: 3.1
>   GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
>   K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
>   D-- G e++> h--- !r x+++
> ------END GEEK CODE BLOCK------
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
