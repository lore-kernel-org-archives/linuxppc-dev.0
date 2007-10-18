Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0AB6EDDE38
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 13:36:57 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9I3aqhQ015996
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 20:36:52 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9I3apuQ029109
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 22:36:51 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v4 9/9] add MPC837x MDS board default device tree
Date: Thu, 18 Oct 2007 11:36:53 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5B39@zch01exm26.fsl.freescale.net>
In-Reply-To: <3E4B0158-F1E9-49A7-A8AF-AB444C222E4A@kernel.crashing.org>
References: <1192460210-26920-1-git-send-email-leoli@freescale.com>
	<3E4B0158-F1E9-49A7-A8AF-AB444C222E4A@kernel.crashing.org>
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
> Sent: Wednesday, October 17, 2007 9:55 PM
> To: Li Yang-r58472
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v4 9/9] add MPC837x MDS board default device tree
>=20
>=20
> On Oct 15, 2007, at 9:56 AM, Li Yang wrote:
>=20
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/mpc8377_mds.dts |  281 ++++++++++++++++++++++
> > +++++++++
> >  arch/powerpc/boot/dts/mpc8378_mds.dts |  263 ++++++++++++++++++++++
> > +++++++
> >  arch/powerpc/boot/dts/mpc8379_mds.dts |  299 ++++++++++++++++++++++
> > +++++++++++
> >  3 files changed, 843 insertions(+), 0 deletions(-)  create mode=20
> > 100644 arch/powerpc/boot/dts/mpc8377_mds.dts
> >  create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
> >  create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts

{snip}

> > +		};
> > +	};
> > +
> > +	memory {
> > +		device_type =3D "memory";
> > +		reg =3D <00000000 20000000>;	// 512MB at 0
> > +	};
> > +
> > +	soc837x@e0000000 {
>=20
> make this just 'soc@e0000000'
>=20

The current u-boot support uses soc837x.  U-boot should be changed first
for soc@e0000000 to work.

- Leo
