Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D89101A0C95
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 09:48:26 +1100 (AEDT)
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129]) by ozlabs.org (Postfix) with ESMTP id 811841400D2
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2014 09:48:26 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Paul Bolle <pebolle@tiscali.nl>, Jiri Kosina <trivial@kernel.org>
Subject: Re: [PATCH] [TRIVIAL] IBM Akebono: Remove select of IBM_EMAC_RGMII_WOL
Date: Tue, 23 Dec 2014 09:48:23 +1100
Message-ID: <2224792.Nmvmc626jj@mexican>
In-Reply-To: <1419243273.30945.19.camel@x220>
References: <1415008333.20372.26.camel@x220> <1419243273.30945.19.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

These days I've been made maintainer of the PPC4XX tree so maybe adding Acked-
by: Alistair Popple <alistair@popple.id.au> might help?

Jiri, if you would rather this go via the main PPC tree please let us know and 
we'll see if Michael Ellerman (added to CC) would be willing to take it (he 
has taken over most of the day to day maintenance of the PPC tree). Thanks!

Regards,

Alistair

On Mon, 22 Dec 2014 11:14:33 Paul Bolle wrote:
> Hi Jiri,
> 
> On Mon, 2014-11-03 at 10:52 +0100, Paul Bolle wrote:
> > Commit 2a2c74b2efcb ("IBM Akebono: Add the Akebono platform") added a
> > select of IBM_EMAC_RGMII_WOL. But that Kconfig symbol isn't (yet) part
> > of the tree. So this select has been a nop since that commit was
> > included in v3.16-rc1.
> > 
> > The code to add this symbol is not included in next-20141103. So let's
> > remove this select. It can be readded when that symbol is actually added
> > to the tree.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > Cc: Alistair Popple <alistair@popple.id.au>
> > ---
> > Untested. Done on top of next-20141103.
> > 
> > Third time's a charm? First raised in
> > https://lkml.org/lkml/2014/5/1/106 . Reminder sent in
> > https://lkml.org/lkml/2014/9/4/645 . I'm not aware of any news on this
> > front, so this trivial patch seems reasonable now.
> > 
> > A patch to readd this select could be added - if people still care about
> > it, that is - in the series that adds this symbol. A web search suggests
> > Alistair takes care of that series, so Alistair gets a Cc: here.
> 
> This select of IBM_EMAC_RGMII_WOL still shows up in next-20141221 and
> v3.19-rc1. Did you have a chance to look at this patch?
> 
> >  arch/powerpc/platforms/44x/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/platforms/44x/Kconfig
> > b/arch/powerpc/platforms/44x/Kconfig index d2ac1c116454..5538e57c36c1
> > 100644
> > --- a/arch/powerpc/platforms/44x/Kconfig
> > +++ b/arch/powerpc/platforms/44x/Kconfig
> > @@ -214,7 +214,6 @@ config AKEBONO
> > 
> >  	select ETHERNET
> >  	select NET_VENDOR_IBM
> >  	select IBM_EMAC_EMAC4
> > 
> > -	select IBM_EMAC_RGMII_WOL
> > 
> >  	select USB if USB_SUPPORT
> >  	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> >  	select USB_EHCI_HCD_PLATFORM if USB_EHCI_HCD
> 
> Thanks,
> 
> 
> Paul Bolle
