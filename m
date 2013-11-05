Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EBA2B2C019C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 06:54:14 +1100 (EST)
Message-ID: <1383681240.4776.97.camel@pasglop>
Subject: Re: [PATCH 3/7] IBM Akebono: Add support for a new PHY to the IBM
 emac driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Hutchings <bhutchings@solarflare.com>
Date: Wed, 06 Nov 2013 06:54:00 +1100
In-Reply-To: <1383675404.2868.8.camel@bwh-desktop.uk.level5networks.com>
References: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
 <1383629471-16979-3-git-send-email-alistair@popple.id.au>
 <1383675404.2868.8.camel@bwh-desktop.uk.level5networks.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-11-05 at 18:16 +0000, Ben Hutchings wrote:
> On Tue, 2013-11-05 at 16:31 +1100, Alistair Popple wrote:
> [...]
> > --- a/drivers/net/ethernet/ibm/emac/Kconfig
> > +++ b/drivers/net/ethernet/ibm/emac/Kconfig
> > @@ -55,6 +55,10 @@ config IBM_EMAC_RGMII
> >  	bool
> >  	default n
> >  
> > +config IBM_EMAC_RGMII_WOL
> > +	bool
> > +	default n
> > +
> [...]
> 
> So no-one can even build-test this at present!

Patch 7/7 adds the select to the platform, isn't that sufficient ?

It's an SoC bit so there's little point making it generally
selectable by the user.

Alistair: The commit name should be different, it's not a PHY you are
adding, it's a PHY interface (the PHY itself is off chip).

Cheers,
Ben.
