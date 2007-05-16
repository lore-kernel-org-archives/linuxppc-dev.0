Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BA62FDDED2
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 12:08:06 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4G280sg016166
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 19:08:01 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4G27xRq003604
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 21:08:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 2/2] powerpc: Fix Section mismatch warnings
Date: Wed, 16 May 2007 10:09:41 +0800
Message-ID: <989B956029373F45A0B8AF0297081890B760A2@zch01exm26.fsl.freescale.net>
In-Reply-To: <4575ED11-C144-49CF-9FBA-0613B61EFCE3@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
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
> Sent: Tuesday, May 15, 2007 10:07 PM
> To: Li Yang-r58472
> Cc: Paul; linuxppc-dev@ozlabs.org; Linux Kernel
> Subject: Re: [PATCH 2/2] powerpc: Fix Section mismatch warnings
>=20
>=20
> On May 14, 2007, at 5:59 AM, Li Yang wrote:
>=20
> > This patch fix the following Section mismatch warnings
> > in powerpc code.
> >
> > WARNING: arch/powerpc/platforms/built-in.o - Section mismatch:
> > reference to .init.data:mv643xx_eth_pd_devs from .text between
> > 'mv643xx_eth_add_pds' (at offset 0x9ed2) and 'gg2_read_config'
> > WARNING: arch/powerpc/platforms/built-in.o - Section mismatch:
> > reference to .init.data:mv643xx_eth_pd_devs from .text between
> > 'mv643xx_eth_add_pds' (at offset 0x9ed6) and 'gg2_read_config'
> > WARNING: arch/powerpc/platforms/built-in.o - Section mismatch:
> > reference to .init.text:note_scsi_host from __ksymtab between
> > '__ksymtab_note_scsi_host' (at offset 0x8) and
'__ksymtab_sys_ctrler'
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> >  arch/powerpc/platforms/chrp/pegasos_eth.c |    2 +-
> >  arch/powerpc/platforms/powermac/setup.c   |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> Did you change anything?

Nothing yet. I think it's a delay of mail system.

- Leo
