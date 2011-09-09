Return-Path: <r61911@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8BC6B6FA3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Sep 2011 22:17:03 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Wolfram Sang <w.sang@pengutronix.de>, "cjb@laptop.org" <cjb@laptop.org>
Subject: RE: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
Date: Fri, 9 Sep 2011 12:16:56 +0000
Message-ID: <2239AC579C7D3646A720227A37E026811A228B@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
	<20110909114004.GP1912@pengutronix.de>
In-Reply-To: <20110909114004.GP1912@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Xu Lei-B33228 <B33228@freescale.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Friday, September 09, 2011 19:40 PM
> To: Zang Roy-R61911
> Cc: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; akpm@linux-
> foundation.org; cbouatmailru@gmail.com; Xu Lei-B33228; Kumar Gala
> Subject: Re: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
>=20
> Hi,
>=20
> On Fri, Sep 09, 2011 at 08:05:46PM +0800, Roy Zang wrote:
> > From: Xu lei <B33228@freescale.com>
> >
> > Freescale eSDHC registers only support 32-bit accesses,
> > this patch ensures that all Freescale eSDHC register accesses
> > are 32-bit.
>=20
> So, what about the byte-swapping that Anton needed? You are simply
> removing that if I am not mistaken.
>=20
> > Signed-off-by: Xu lei <B33228@freescale.com>
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> > ---
> > This is a patch resend
> > http://patchwork.ozlabs.org/patch/106245/
> > based on latest Linus tree.
> >
> > Andrew,
> > Could you help to  pick up this patch first?
>=20
> mmc-list is not dead, it must go via Chris, I'd think.
This is the third time that I re-send this patch to the list.  There is no =
comment.
That is why I ask Andrew's help.
>=20
> >  drivers/mmc/host/sdhci-of-esdhc.c |   18 ++++++++++++++----
> >  1 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci=
-of-
> esdhc.c
> > index fe604df..40036f6 100644
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -1,7 +1,7 @@
> >  /*
> >   * Freescale eSDHC controller driver.
> >   *
> > - * Copyright (c) 2007 Freescale Semiconductor, Inc.
> > + * Copyright (c) 2007, 2010 Freescale Semiconductor, Inc.
>=20
> I wonder if such a small change has impact on the copyright.
I just update the year for tracking. Anything wrong?
Roy
