Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 4A1F167B8B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 08:40:14 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Andy Fleming'" <afleming@freescale.com>
Subject: RE: [PATCH] Slight refactor of interrupt mapping for FSL parts
Date: Fri, 20 Oct 2006 00:40:11 +0200
Message-ID: <02d901c6f3cf$8952e990$1267a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <E86BE632-0841-4572-BE65-C308B0E0BF78@freescale.com>
Cc: linuxppc-dev@ozlabs.org, 'Jeff Garzik' <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> On Oct 16, 2006, at 16:51, Joakim Tjernlund wrote:
> 
> >>> -#define PHY_POLL		-1
> >>> +#define PHY_POLL		NO_IRQ
> >>>  #define PHY_IGNORE_INTERRUPT	-2
> >
> > What does PHY_IGNORE_INTERRUPT mean? Can I use that in a dummy PHY
> > driver that just pretends that all is well? Got a ethernet port that
> > is connect to a switch directly over MII.
> > How do I express -2 in a dts file?
> 
> 
> PHY_IGNORE_INTERRUPT means that the PHY Lib will not poll the  
> interface, nor will it register for the interrupt.  Actually, it  
> would be best for a dummy PHY driver.  Take a look at the driver in  
> drivers/phy/fixed.c.  It's there to provide that kind of interface.   
> It looks like it uses -1, which is a problem, but my revision 
> of this  
> patch will fix that.

Great, thanks. I don't see how to connect this PHY to ucc_geth driver yet. I think
it needs some PHY work first.

Maybe this patch,http://ozlabs.org/pipermail/linuxppc-dev/2006-October/026690.html, will make it better?
Why hasn't it been applied yet?

 Jocke
