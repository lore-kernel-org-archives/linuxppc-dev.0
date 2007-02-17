Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 643FEDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 20:14:16 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'David Brownell'" <david-b@pacbell.net>
Subject: RE: [spi-devel-general] [PATCH] Adapt spi_mpc83xx SPI driver for 832x
Date: Sat, 17 Feb 2007 10:14:07 +0100
Message-ID: <003d01c75273$fa644360$1e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200702161817.43515.david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net,
	'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net] 
> Sent: den 17 februari 2007 03:18
> To: joakim.tjernlund@transmode.se
> Cc: Kumar Gala; spi-devel-general@lists.sourceforge.net; 
> 'linuxppc-dev Development'
> Subject: Re: [spi-devel-general] [PATCH] Adapt spi_mpc83xx 
> SPI driver for 832x
> 
> On Thursday 14 December 2006 2:02 am, Joakim Tjernlund wrote:
> 
> > patch needs a litte work, the shift is diffrent for tx 
> resp. rx so I 
> > adjusted that and added a temp hack(still in patch below) 
> to force qe_mode.
> > The name qe_mode is misleading. This i a QE enabled CPU, 
> but SPI is running
> > in cpu mode. qe_mode implies that SPI is runing in native QUICC 
> > mode.
> > 
> > Adjusted patch(lets hope I didn't mangle this one:):
> 
> What's the story on this?  I see that no followup patch has 
> been submitted,
> so this 832x support is still not merged ...
> 
> I'm deleting all this 83xx history from my "pending" mbox, so 
> if anyone
> wants this support in the mainstream kernel, this is the only reminder
> you'll get from me.
> 
> - Dave

[snip code]

I think Kumar wanted to clean it up before submission.
Something needs to be added to the device tree I think.

 Jocke
