Return-Path: <SRS0=LhWK=TL=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 7EF10DE02E
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 08:50:11 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] [POWERPC] AMCC Kilauea (405EX): Disable EMAC loopback mode
Date: Fri, 22 Feb 2008 22:49:58 +0100
References: <1203669132-9385-1-git-send-email-sr@denx.de>
	<20080222143621.0579729b@weaponx>
In-Reply-To: <20080222143621.0579729b@weaponx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802222249.58503.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 22 February 2008, Josh Boyer wrote:
> On Fri, 22 Feb 2008 09:32:12 +0100
>
> Stefan Roese <sr@denx.de> wrote:
> > 405EX(r) has SDR0_MFR[E0CS/E1CS] set after reset. This selects
> > the internal loopback mode. Clear these bits so that both EMACs
> > don't use loopback mode as default.
> >
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > ---
> > I'm not sure if this should be done here in the board platform code,
> > or in the newemac driver or perhaps in some code common for 405EX.
> >
> > Any thoughts on this welcome.
>
> Why isn't this done in U-Boot?  Or is it done if the network interface
> is used?

Correct. It's only done upon EMAC usage in U-Boot. So when booting completely 
from FLASH, EMAC in Linux is not working.

Best regards,
Stefan
