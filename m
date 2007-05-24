Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80AD4DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 19:44:10 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4O9i5JX020863
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 02:44:05 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4O9i3rR027980
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 04:44:04 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Porting RapidIO from ppc arch to powerpc arch in support
	ofMPC8641D
Date: Thu, 24 May 2007 17:44:02 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C307092@zch01exm26.fsl.freescale.net>
In-Reply-To: <200705241119.23793.arnd@arndb.de>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<200705230105.53013.arnd@arndb.de>
	<46B96294322F7D458F9648B60E15112C307037@zch01exm26.fsl.freescale.net>
	<200705241119.23793.arnd@arndb.de>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> On Thursday 24 May 2007, Zhang Wei-r63237 wrote:
> > Of_platform_driver is a good framework. But this RapidIO=20
> driver is not a
> > device driver. It's a _bus_ driver very similar to PCI bus. So,
> > of_platform_driver is not fit here.
>=20
> But there is not a fundamental difference between the two. In=20
> the Linux
> driver model, a bus driver is a simply device driver whose=20
> devices have
> other devices as child nodes.
>=20
> Your example of PCI buses fits well here. Traditionally, each platform
> had its own PCI scanning code that went looking for pci host bridges.
> Now we have the of_pci_phb_driver in arch/powerpc/kernel/of_platform.c
> that automatically sets up the bridges, and the platform only
> needs to provide a ppc_md.pci_setup_phb() callback.
>=20

Add the rio scaning code to of_platform.c such as pci is ok?

Thanks!
-wei
