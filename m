Return-Path: <B21284@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) by ozlabs.org (Postfix) with ESMTP id EB401B70A5
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 17:35:36 +1000 (EST)
Received: from mail53-tx2 (localhost.localdomain [127.0.0.1])	by
	mail53-tx2-R.bigfish.com (Postfix) with ESMTP id B04951B182D0	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 07:35:33 +0000 (UTC)
Received: from TX2EHSMHS019.bigfish.com (unknown [10.9.14.252])	by
	mail53-tx2.bigfish.com (Postfix) with ESMTP id 6F9BCD0053	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 07:35:33 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6Q7ZWeW002872	for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Jul 2010 00:35:32 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6Q7ZXTX002333	for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Jul 2010 02:35:34 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 5/6] powerpc/of: add eSPI controller dts bindings
Date: Mon, 26 Jul 2010 15:35:26 +0800
Message-ID: <73839B4A0818E747864426270AC332C305400648@zmy16exm20.fsl.freescale.net>
In-Reply-To: <20100726003343.GD25419@angua.secretlab.ca>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-5-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-6-git-send-email-Mingkai.hu@freescale.com>
	<20100726003343.GD25419@angua.secretlab.ca>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Zang Roy-R61911 <R61911@freescale.com>
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
> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of=20
> Grant Likely
> Sent: Monday, July 26, 2010 8:34 AM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang=20
> Roy-R61911
> Subject: Re: [PATCH 5/6] powerpc/of: add eSPI controller dts bindings
>=20
> On Tue, Jul 20, 2010 at 10:08:24AM +0800, Mingkai Hu wrote:
> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> > ---
> >  Documentation/powerpc/dts-bindings/fsl/spi.txt |   20=20
> ++++++++++++++++++++
> >  1 files changed, 20 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/Documentation/powerpc/dts-bindings/fsl/spi.txt=20
> > b/Documentation/powerpc/dts-bindings/fsl/spi.txt
> > index 80510c0..b360bf9 100644
> > --- a/Documentation/powerpc/dts-bindings/fsl/spi.txt
> > +++ b/Documentation/powerpc/dts-bindings/fsl/spi.txt
> > @@ -29,3 +29,23 @@ Example:
> >  		gpios =3D <&gpio 18 1	// device reg=3D<0>
> >  			 &gpio 19 1>;	// device reg=3D<1>
> >  	};
> > +
> > +
> > +* eSPI (Enhanced Serial Peripheral Interface)
> > +
> > +Required properties:
> > +- compatible : should be "fsl,espi".
>=20
> Good practice is to always fully identify the SoC in the=20
> compatible values, followed by an optional list of other=20
> specific chips it is compatible with.  Generic compatibles=20
> like "fsl,espi" are not a good idea.
>=20
> +- compatible: should be "fsl,<chip>-espi".
>=20

Ok, the mpc8536 is the first chip to develop this driver, so will use
"fsl,mpc8536-espi".

Thanks,
Mingkai
