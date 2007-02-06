Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id DDBC3DDE38
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 14:16:36 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l163GZoN010952
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 20:16:35 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l163GNbr007486
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 21:16:28 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/3] 8349emds default dts updates for USB change
Date: Tue, 6 Feb 2007 11:17:40 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D41BD@zch01exm26.fsl.freescale.net>
In-Reply-To: <C70056A2-0B73-4702-9749-2CC744F89416@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Monday, February 05, 2007 11:07 PM
> To: Li Yang-r58472
> Cc: Paul; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 3/3] 8349emds default dts updates for USB change
>=20
>=20
> On Feb 5, 2007, at 3:10 AM, Li Yang wrote:
>=20
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > arch/powerpc/boot/dts/mpc8349emds.dts |    6 ++++++
> > 1 files changed, 6 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/
> > boot/dts/mpc8349emds.dts
> > index efceb34..ba31af1 100644
> > --- a/arch/powerpc/boot/dts/mpc8349emds.dts
> > +++ b/arch/powerpc/boot/dts/mpc8349emds.dts
> > @@ -39,6 +39,11 @@
> > 		reg =3D <00000000 10000000>;	// 256MB at 0
> > 	};
> > +	bcsr@f8000000 {
> > +		device_type =3D "board-control";
> > +		reg =3D <e2400000 8000>;
>=20
> Are the bcsr's at f8000000 or e2400000?

According to the default u-boot configuration in tree, it is e2400000.

- Leo
