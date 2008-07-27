Return-Path: <david-b@pacbell.net>
Received: from smtp122.sbc.mail.sp1.yahoo.com (smtp122.sbc.mail.sp1.yahoo.com
	[69.147.64.95]) by ozlabs.org (Postfix) with SMTP id DD0F8DDF9E
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 08:13:04 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [PATCH 1/4] [SPI] [POWERPC] spi_mpc83xx:
	handles Freescale	MPC8610 as well
Date: Sun, 27 Jul 2008 15:12:58 -0700
References: <20080516165052.GA24196@polina.dev.rtsoft.ru>
	<20080516190438.GA2758@loki.buserror.net>
In-Reply-To: <20080516190438.GA2758@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807271512.58969.david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 16 May 2008, Scott Wood wrote:
> On Fri, May 16, 2008 at 08:50:52PM +0400, Anton Vorontsov wrote:
> >  config SPI_MPC83xx
> >  	tristate "Freescale MPC83xx/QUICC Engine SPI controller"
> > -	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE) && EXPERIMENTAL
> > +	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE || PPC_86xx) && EXPERIMENTAL
> 
> How about "depends on SPI_MASTER && FSL_SOC && EXPERIMENTAL"?
> 
> Plus, we should change the option text to something like "MPC8xxx SPI
> controller".

Is there an approved-by-powerpc-folk version of this patch yet?
(Noting that SPI_MASTER is now implicit ...)
