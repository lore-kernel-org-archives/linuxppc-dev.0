Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D070EDDF53
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:33:28 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l9IDXMac014719
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 06:33:22 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9IDXK1Q010796
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 08:33:21 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v5 9/9] add MPC837x MDS board default device tree
Date: Thu, 18 Oct 2007 21:33:19 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5BCC@zch01exm26.fsl.freescale.net>
In-Reply-To: <9982D235-54B3-4733-8F67-4F75C7D1AFC3@kernel.crashing.org>
References: <1192702580-6353-1-git-send-email-leoli@freescale.com>
	<9982D235-54B3-4733-8F67-4F75C7D1AFC3@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
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
> Sent: Thursday, October 18, 2007 9:17 PM
> To: Li Yang-r58472
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v5 9/9] add MPC837x MDS board default device tree
>=20
> is it me or are you just posting the patches you're updating?=20
>  (this is the only v5 patch I saw in the series)

I'm only posting the patch updated, to prevent spamming the list.  If
you want, I can send the whole series to you.

>=20
> On Oct 18, 2007, at 5:16 AM, Li Yang wrote:
>=20
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/=20
> > boot/dts/mpc8377_mds.dts new file mode 100644 index 0000000..8530de6

> > +	memory {
> > +		device_type =3D "memory";
> > +		reg =3D <00000000 20000000>;	// 512MB at 0
> > +	};
> > +
> > +	soc837x@e0000000 {
>=20
> soc@e0000000

I can update this now, but the device tree won't be usable by current
u-boot.

> > +		spi@7000 {
> > +			compatible =3D "mpc83xx_spi";
> > +			reg =3D <7000 1000>;
> > +			interrupts =3D <10 8>;
> > +			interrupt-parent =3D < &ipic >;
>=20
> mode =3D "cpu";

Oh ya,  the spec has been changed.  I also need to update mpc83xx_spi to
fsl_spi.

- Leo
