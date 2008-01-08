Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17775DDEA0
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 18:57:49 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m087vYtn009444
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 00:57:35 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m087vXLM008604
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 01:57:34 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/3] add default device trees for MPC837x MDS board
Date: Tue, 8 Jan 2008 15:57:32 +0800
Message-ID: <989B956029373F45A0B8AF029708189001BA00F1@zch01exm26.fsl.freescale.net>
In-Reply-To: <FB3D7D27-D06F-4AD2-B4A1-00FBA26251AF@kernel.crashing.org>
References: <1199707400-23588-1-git-send-email-leoli@freescale.com>
	<FB3D7D27-D06F-4AD2-B4A1-00FBA26251AF@kernel.crashing.org>
From: "Li Yang" <LeoLi@freescale.com>
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
> Sent: Tuesday, January 08, 2008 3:37 PM
> To: Li Yang
> Cc: linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: Re: [PATCH 1/3] add default device trees for MPC837x=20
> MDS board
>=20
>=20
> On Jan 7, 2008, at 6:03 AM, Li Yang wrote:
>=20
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > address comments and use new dts spec.
> >
> > arch/powerpc/boot/dts/mpc8377_mds.dts |  277=20
> ++++++++++++++++++++++++
> > +++++++
> > arch/powerpc/boot/dts/mpc8378_mds.dts |  263=20
> ++++++++++++++++++++++++
> > +++++
> > arch/powerpc/boot/dts/mpc8379_mds.dts |  291=20
> ++++++++++++++++++++++++
> > +++++++++
> > 3 files changed, 831 insertions(+), 0 deletions(-)
>=20
> Could I convince you to convert these to dts-v1 format?

Ok, I can do it.  The DTS spec changes too much lately.  :(

- Leo
