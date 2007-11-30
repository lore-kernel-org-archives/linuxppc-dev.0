Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8AAE7DDE44
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 20:55:41 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lAU9tZ0h020351
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 02:55:35 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lAU9tX2e021412
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 03:55:34 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v7 9/9] add MPC837x MDS board default device tree
Date: Fri, 30 Nov 2007 17:55:32 +0800
Message-ID: <989B956029373F45A0B8AF029708189001A1CE79@zch01exm26.fsl.freescale.net>
In-Reply-To: <3E2C1CAC-3BBE-404F-B678-FE4504C7B45D@kernel.crashing.org>
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<1192793930-26039-5-git-send-email-leoli@freescale.com>
	<1192793930-26039-6-git-send-email-leoli@freescale.com>
	<1192793930-26039-7-git-send-email-leoli@freescale.com>
	<1192793930-26039-8-git-send-email-leoli@freescale.com>
	<1192793930-26039-9-git-send-email-leoli@freescale.com>
	<1192793930-26039-10-git-send-email-leoli@freescale.com>
	<3E2C1CAC-3BBE-404F-B678-FE4504C7B45D@kernel.crashing.org>
From: "Li Yang" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Friday, November 30, 2007 8:44 AM
> To: Li Yang
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v7 9/9] add MPC837x MDS board default device tree
>=20
>=20
> On Oct 19, 2007, at 6:38 AM, Li Yang wrote:
>=20
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > Updated pci node.
> > arch/powerpc/boot/dts/mpc8377_mds.dts |  282=20
> ++++++++++++++++++++++++
> > +++++++
> > arch/powerpc/boot/dts/mpc8378_mds.dts |  264=20
> ++++++++++++++++++++++++
> > +++++
> > arch/powerpc/boot/dts/mpc8379_mds.dts |  300=20
> ++++++++++++++++++++++++
> > +++++++++
> > 3 files changed, 846 insertions(+), 0 deletions(-) create=20
> mode 100644=20
> > arch/powerpc/boot/dts/mpc8377_mds.dts
> > create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
> > create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts
>=20
> Can you make the following updates:
>=20
> * Drop serdes and phy-handles
> * Update sata nodes:
>=20
> +	sata@19000 {
> +		compatible =3D "fsl,mpc8315-sata", "fsl,sata-pq2pro;
> +		reg =3D <19000 1000>;
> +		interrupts =3D <2d 8>;
> +		interrupt-parent =3D < &ipic >;
> +        };
>=20
> * Added labels for ethernet (enet), serial, pci
>=20
> (some examples below):

I will make the changes and update you later.

- Leo
