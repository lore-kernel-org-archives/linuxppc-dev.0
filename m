Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D3B30DE085
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 01:37:49 +1000 (EST)
Date: Mon, 26 May 2008 19:37:47 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Chen Gong <G.Chen@freescale.com>
Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling support for the
	carddetectline
Message-ID: <20080526153747.GA31663@polina.dev.rtsoft.ru>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
	<58A20A281BAF1047B4EAE68DE5C0BDC2F16E6A@zch01exm21.fsl.freescale.net>
	<20080522123838.GA27149@polina.dev.rtsoft.ru>
	<58A20A281BAF1047B4EAE68DE5C0BDC2F176EF@zch01exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <58A20A281BAF1047B4EAE68DE5C0BDC2F176EF@zch01exm21.fsl.freescale.net>
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

On Thu, May 22, 2008 at 09:44:57PM +0800, Chen Gong wrote:
[...]
> > > I want to know whether every card working well ? Because 
> > I'm working 
> > > For 83xx MMC-over-SPI support, the presented concrete 
> > methods I used 
> > > as you do, but only 256M card seems good, 512M or 1G/2G 
> > card all have 
> > > some problems
> > 
> > So far I don't have cards larger than 256M. Will try to get 
> > one though.
> > 
> Thanks, if you have any new test report pls contact me.

Just tested with Apacer 1GB MicroSD (connected through dumb adapter),
it works quite well here. I've successfully wrote 10 mb file onto ext2
formatted partition...

> BTW, a fews days ago Joakim Tjernlund made a heavy fix for 
> spi_mpc83xx.c to resolve clock glitch. But it looks no any impact
> for me, but maybe it has positive effect for you.

Yup, I use it.

Btw, which mmc driver are you using? The one from MPC8610HPCD
BSP or mainline's mmc_spi?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
