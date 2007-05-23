Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15F59DDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 12:48:23 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4N2mIJ6024045
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 19:48:18 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4N2mGNN017438
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 21:48:17 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 0/5] Add the support for MPC8641 silicon rev 2.0
	andMPC8641HPCN board 2.0
Date: Wed, 23 May 2007 10:48:14 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C234A09@zch01exm26.fsl.freescale.net>
In-Reply-To: <1179856039.27985.17.camel@rhino>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<1179856039.27985.17.camel@rhino>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Wade Farnsworth" <wfarnsworth@mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

They are against to Paul's git tree and I've verified these patches
again today.

They can be applied to Paul's top git tree successfully.

Thanks!
Wei=20

> -----Original Message-----
> From: Wade Farnsworth [mailto:wfarnsworth@mvista.com]=20
> Sent: Wednesday, May 23, 2007 1:47 AM
> To: Zhang Wei-r63237
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 0/5] Add the support for MPC8641 silicon=20
> rev 2.0 andMPC8641HPCN board 2.0
>=20
> On Tue, 2007-05-22 at 11:38 +0800, Zhang Wei wrote:
> > Hi, Paul,
> >=20
> > The below 5 patches add the support for MPC8641 rev 2.0=20
> silicon and MPC8641HPCN board 2.0.
> >=20
> >   [PATCH 1/5] Remove the errata fix codes for MPC8641=20
> silicon ver 1.0 which is end of life.
> >   [PATCH 2/5] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
> >   [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
> >   [PATCH 4/5] Set RC of mpc8641 to transparent bridge for=20
> transfer legacy I/O access.
> >   [PATCH 5/5] Set IDE in ULI1575 to not native mode.
> >=20
> > The MPC8641 rev 2.0 silicon fix the PCI/PCI-Express errata=20
> in rev 1.0. And the rev 1.0 silicon is end of life. So the=20
> dts tree and codes should be changes. Codes which are not=20
> compatible with PCI/PCI-Express specifications are removed.=20
> Some minor issues are fixed.
> >=20
> > Thanks!
> >=20
> > Best Regards,
> > Zhang Wei
> >=20
>=20
> I can't get your patches to apply to Paulus' tree.  Which=20
> tree are these
> against?
>=20
> --Wade
>=20
>=20
