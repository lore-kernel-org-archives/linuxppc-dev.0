Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B8419DE066
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 22:38:40 +1000 (EST)
Date: Thu, 22 May 2008 16:38:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Chen Gong <G.Chen@freescale.com>
Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling support for the card
	detectline
Message-ID: <20080522123838.GA27149@polina.dev.rtsoft.ru>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
	<58A20A281BAF1047B4EAE68DE5C0BDC2F16E6A@zch01exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <58A20A281BAF1047B4EAE68DE5C0BDC2F16E6A@zch01exm21.fsl.freescale.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net, Tabi Timur <timur@freescale.com>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 19, 2008 at 11:02:13AM +0800, Chen Gong wrote:
> 
> > -----Original Message-----
> > From: linuxppc-dev-bounces+b11801=freescale.com@ozlabs.org 
> > [mailto:linuxppc-dev-bounces+b11801=freescale.com@ozlabs.org] 
> > On Behalf Of Anton Vorontsov
> > Sent: 2008?5?17? 0:51
> > To: Kumar Gala; David Brownell; Pierre Ossman
> > Cc: linuxppc-dev@ozlabs.org; 
> > spi-devel-general@lists.sourceforge.net; 
> > linux-kernel@vger.kernel.org; Tabi Timur
> > Subject: [PATCH 3/4] [MMC] mmc_spi: add polling support for 
> > the card detectline
> > 
> > Some boards do not use interrupts on the CD line, so we want 
> > to poll the CD and see if there was a change. 1 second poll 
> > interval seems resonable.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  drivers/mmc/host/mmc_spi.c  |   51 
> 
> I want to know whether every card working well ? Because I'm working
> For 83xx MMC-over-SPI support, the presented concrete methods I used as
> you do,
> but only 256M card seems good, 512M or 1G/2G card all have some problems

So far I don't have cards larger than 256M. Will try to get one though.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
