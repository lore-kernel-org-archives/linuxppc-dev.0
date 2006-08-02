Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id D602D67B9F
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 19:27:14 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k729cuwT019215
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 02:38:56 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k729RANn006121
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 04:27:12 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: SMP in 32-bit arch/powerpc
Date: Wed, 2 Aug 2006 17:27:08 +0800
Message-ID: <2176B872C0407E44887F07CCAA86929307704F@zch01exm21.fsl.freescale.net>
In-Reply-To: <1154507145.24203.0.camel@localhost.localdomain>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Adrian Cox" <adrian@humboldt.co.uk>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Do you have more detailed descriptions? Our MPC8641D(dual-7448 core CPU)
board works well.

Best Regards,
Zhang Wei=20

> -----Original Message-----
> From: linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.or
> g] On Behalf Of Adrian Cox
> Sent: Wednesday, August 02, 2006 4:26 PM
> To: linuxppc-dev@ozlabs.org
> Subject: SMP in 32-bit arch/powerpc
>=20
> Is anybody else having problems with 32-bit SMP support in=20
> arch/powerpc?
> I'm using 2.6.17 as my current base, because I've not yet merged the
> latest mpic changes.
>=20
> I'm currently bringing up a dual-7448 board, and when I build=20
> the kernel
> with CONFIG_SMP, the bootmem allocator corrupts the device tree. The
> strange thing is, this still happens when I don't start the=20
> second CPU.
> Kernels built without CONFIG_SMP run flawlessly on the same hardware.
>=20
> --=20
> Adrian Cox <adrian@humboldt.co.uk>
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
