Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F7D9DDEA0
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 12:59:45 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m251xdA8000251
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 18:59:40 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m251xcAR025135
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Mar 2008 19:59:39 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 11/17] Add memory mapping driver to RapidIO.
Date: Wed, 5 Mar 2008 09:59:38 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AECE4522@zch01exm26.fsl.freescale.net>
In-Reply-To: <20080304213735.c77d6203.sfr@canb.auug.org.au>
References: <1204648202-5495-1-git-send-email-wei.zhang@freescale.com><1204648202-5495-2-git-send-email-wei.zhang@freescale.com><1204648202-5495-3-git-send-email-wei.zhang@freescale.com><1204648202-5495-4-git-send-email-wei.zhang@freescale.com><1204648202-5495-5-git-send-email-wei.zhang@freescale.com><1204648202-5495-6-git-send-email-wei.zhang@freescale.com><1204648202-5495-7-git-send-email-wei.zhang@freescale.com><1204648202-5495-8-git-send-email-wei.zhang@freescale.com><1204648202-5495-9-git-send-email-wei.zhang@freescale.com><1204648202-5495-10-git-send-email-wei.zhang@freescale.com><1204648202-5495-11-git-send-email-wei.zhang@freescale.com>
	<20080304213735.c77d6203.sfr@canb.auug.org.au>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Stephen,

Thanks! I'm considering to commit a updated patch or new code cleaning
patch.
How about your idea?

Cheers!
Wei=20

> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]=20
> Sent: Tuesday, March 04, 2008 6:38 PM
> To: Zhang Wei
> Cc: mporter@kernel.crashing.org; galak@kernel.crashing.org;=20
> linuxppc-dev@ozlabs.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 11/17] Add memory mapping driver to RapidIO.
>=20
> On Wed,  5 Mar 2008 00:29:56 +0800 Zhang Wei=20
> <wei.zhang@freescale.com> wrote:
> >
> > +	if (!(rmem->virt =3D dma_alloc_coherent(NULL, rmem->size,
> > +				&rmem->iores.start, GFP_KERNEL))) {
>=20
> Please separate assignments from tests.
>=20
> > +	if ((ret =3D rio_space_claim(rmem))) {
>=20
> Again.
>=20
> --=20
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
>=20
