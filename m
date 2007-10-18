Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE862DDF88
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 01:10:51 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9IFAkai013223
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 08:10:46 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9IFAis3028818
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 10:10:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v6 resend 9/9] add MPC837x MDS board default device tree
Date: Thu, 18 Oct 2007 23:10:43 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5BD6@zch01exm26.fsl.freescale.net>
In-Reply-To: <F1717431-3C1F-4528-9949-32C156F5DD4F@kernel.crashing.org>
References: <1192720186-25228-1-git-send-email-leoli@freescale.com>
	<F1717431-3C1F-4528-9949-32C156F5DD4F@kernel.crashing.org>
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
> Sent: Thursday, October 18, 2007 11:02 PM
> To: Li Yang-r58472
> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH v6 resend 9/9] add MPC837x MDS board=20
> default device tree
>=20
>=20
> On Oct 18, 2007, at 10:09 AM, Li Yang wrote:
>=20
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > Fix a typo in previous one.
> >
> >  arch/powerpc/boot/dts/mpc8377_mds.dts |  282 ++++++++++++++++++++++
> > +++++++++
> >  arch/powerpc/boot/dts/mpc8378_mds.dts |  264 ++++++++++++++++++++++
> > +++++++
> >  arch/powerpc/boot/dts/mpc8379_mds.dts |  300 ++++++++++++++++++++++
> > +++++++++++
> >  3 files changed, 846 insertions(+), 0 deletions(-)  create mode=20
> > 100644 arch/powerpc/boot/dts/mpc8377_mds.dts
> >  create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
> >  create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts
>=20
> still has issues with the i2c nodes.  (maybe v7 will be lucky)

Do we still need address-cell and size-cell even when it has no child
node?

- Leo
