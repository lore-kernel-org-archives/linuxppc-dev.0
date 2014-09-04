Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews02.kpnxchange.com (cpsmtpb-ews02.kpnxchange.com
 [213.75.39.5])
 by lists.ozlabs.org (Postfix) with ESMTP id 903101A004F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 08:20:46 +1000 (EST)
Message-ID: <1409869242.5546.119.camel@x220>
Subject: Re: [PATCH] IBM Akebono: Remove obsolete config select
From: Paul Bolle <pebolle@tiscali.nl>
To: Alistair Popple <alistair@popple.id.au>
Date: Fri, 05 Sep 2014 00:20:42 +0200
In-Reply-To: <1774195.a1B25gz7RT@mexican>
References: <1398998002.2925.15.camel@pasglop>
 <1399018005-23136-1-git-send-email-alistair@popple.id.au>
 <1402660592.28881.22.camel@x220> <1774195.a1B25gz7RT@mexican>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-06-20 at 10:10 +1000, Alistair Popple wrote:
> Hi Ben,
> 
> It looks like we may have missed this trivial fix? Can you please apply it to 
> your tree?
> 
> Regards,
> 
> Alistair
> 
> On Fri, 13 Jun 2014 13:56:32 Paul Bolle wrote:
> > On Fri, 2014-05-02 at 18:06 +1000, Alistair Popple wrote:
> > > The original implementation of MMC support for Akebono introduced a
> > > new configuration symbol (MMC_SDHCI_OF_476GTR). This symbol has been
> > > dropped in favour of using the generic platform driver however the
> > > select for this symbol was mistakenly left in the platform
> > > configuration.
> > > 
> > > This patch removes the obsolete symbol selection.
> > > 
> > > Signed-off-by: Alistair Popple <alistair@popple.id.au>
> > 
> > This patch hasn't yet entered linux-next nor Linus' tree. Is it queued
> > somewhere? If not, would a
> >     Acked-by: Paul Bolle <pebolle@tiscali.nl>
> > 
> > help to get this trivial patch queued for either of those trees?
> > 
> > 
> > Paul Bolle
> > 
> > > ---
> > > 
> > >  arch/powerpc/platforms/44x/Kconfig | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/arch/powerpc/platforms/44x/Kconfig
> > > b/arch/powerpc/platforms/44x/Kconfig index 8beec7d..908bf11 100644
> > > --- a/arch/powerpc/platforms/44x/Kconfig
> > > +++ b/arch/powerpc/platforms/44x/Kconfig
> > > @@ -220,7 +220,6 @@ config AKEBONO
> > > 
> > >  	select USB_EHCI_HCD_PLATFORM
> > >  	select MMC_SDHCI
> > >  	select MMC_SDHCI_PLTFM
> > > 
> > > -	select MMC_SDHCI_OF_476GTR
> > > 
> > >  	select ATA
> > >  	select SATA_AHCI_PLATFORM
> > >  	help

This trivial cleanup is still not in linux-next nor in Linus' tree.
Could someone else please have a look at it?

Thanks,


Paul Bolle
