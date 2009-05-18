Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 0DF22DE03E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 08:19:00 +1000 (EST)
Date: Tue, 19 May 2009 00:18:47 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
Subject: Re: [PATCH] Allow selecting mv643xx_eth on Pegasos again
Message-ID: <20090518221847.GA17348@iram.es>
References: <20090518173756.GA11805@iram.es>
	<598D5675D34BE349929AF5EDE9B03E2702C2D323@az33exm24.fsl.freescale.net>
	<20090518184752.GA12972@iram.es>
	<598D5675D34BE349929AF5EDE9B03E2702C2D3A5@az33exm24.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E2702C2D3A5@az33exm24.fsl.freescale.net>
Cc: netdev@vger.kernel.org, tbm@cyrius.com, LinuxPPC <linuxppc-dev@ozlabs.org>,
	pacman@kosh.dhis.org, David Miller <davem@davemloft.net>,
	Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Medve

On Mon, May 18, 2009 at 01:15:12PM -0700, Medve Emilian-EMMEDVE1 wrote:
> 
> You're correct. MV64360 seems to be stale. Do you want to re-spin your
> patch to get rid of it?


No problem, bu should I respin in from the current official git
or on top of yours?

> 
> (I wouldn't create a dependency between MV643XX_ETH and PPC_CHRP.)

Fine with me.

	Regards,
	Gabriel
