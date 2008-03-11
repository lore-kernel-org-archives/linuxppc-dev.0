Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FC36DDEEF
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 19:53:16 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m2B8r9mi006228
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 01:53:10 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m2B8r8kP001552
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 03:53:09 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 11/17] Add memory mapping driver to RapidIO.
Date: Tue, 11 Mar 2008 16:53:09 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AECE5158@zch01exm26.fsl.freescale.net>
In-Reply-To: <20080305135148.21d6c25a.sfr@canb.auug.org.au>
References: <1204648202-5495-1-git-send-email-wei.zhang@freescale.com><1204648202-5495-2-git-send-email-wei.zhang@freescale.com><1204648202-5495-3-git-send-email-wei.zhang@freescale.com><1204648202-5495-4-git-send-email-wei.zhang@freescale.com><1204648202-5495-5-git-send-email-wei.zhang@freescale.com><1204648202-5495-6-git-send-email-wei.zhang@freescale.com><1204648202-5495-7-git-send-email-wei.zhang@freescale.com><1204648202-5495-8-git-send-email-wei.zhang@freescale.com><1204648202-5495-9-git-send-email-wei.zhang@freescale.com><1204648202-5495-10-git-send-email-wei.zhang@freescale.com><1204648202-5495-11-git-send-email-wei.zhang@freescale.com><20080304213735.c77d6203.sfr@canb.auug.org.au><ABF87B0B6A38C0458E319AC973ED68AECE4522@zch01exm26.fsl.freescale.net>
	<20080305135148.21d6c25a.sfr@canb.auug.org.au>
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

I've updated those patches with fixing up.

Thanks!=20
Wei.

> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]=20
> Sent: Wednesday, March 05, 2008 10:52 AM
> To: Zhang Wei
> Cc: linuxppc-dev@ozlabs.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 11/17] Add memory mapping driver to RapidIO.
>=20
> Hi Weu,
>=20
> On Wed, 5 Mar 2008 09:59:38 +0800 "Zhang Wei"=20
> <Wei.Zhang@freescale.com> wrote:
> >
> > Thanks! I'm considering to commit a updated patch or new=20
> code cleaning
> > patch.
> > How about your idea?
>=20
> Preferably, fix up the patches.  If that is a pain, then a=20
> followup patch
> that cleans up is ok as these do not affect the correctness=20
> of the code.
>=20
> --=20
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
>=20
