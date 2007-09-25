Return-Path: <david-b@pacbell.net>
Received: from smtp121.sbc.mail.re3.yahoo.com (smtp121.sbc.mail.re3.yahoo.com
	[66.196.96.94]) by ozlabs.org (Postfix) with SMTP id B587CDDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 03:05:24 +1000 (EST)
Date: Tue, 25 Sep 2007 09:58:45 -0700
From: David Brownell <david-b@pacbell.net>
To: galak@kernel.crashing.org, avorontsov@ru.mvista.com
Subject: Re: [spi-devel-general] [PATCH 7/7] [POWERPC][SPI] spi_mpc83xx:	allow
	use on MPC85xx
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143531.GG5323@localhost.localdomain>
	<16E78F0E-B57B-4084-887E-5D2F9C1D0331@kernel.crashing.org>
	<20070925151819.GA6757@localhost.localdomain>
In-Reply-To: <20070925151819.GA6757@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20070925165845.40B0E2397FB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >> -	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
> >> +	depends on SPI_MASTER && (PPC_83xx || PPC_85xx) && EXPERIMENTAL
> >
> > Should that really be just PPC_83xx || QUICC_ENGINE?
>
> Well, I thought about that. By now I'm unsure if every QE
> implementation will be compatible with further ones.

How many other QE implementations exist?  Is that sort of
gratuitous breakage something Freescale makes a habit of?


>	So far
> I've tested this driver on MPC8323 and MPC8568. If we'll see
> more and more compatible QE SPI controllers, of course we
> may just do || QUICC_ENGINE.
>
> PPC_83xx || PPC_85xx
> PPC_83xx || QUICC_ENGINE
>
> Today first option saves us four bytes. ;-)

It'd be good if someone would look at the relevant docs.

I'll wait for a PPC signoff before I forward this for
merge with SPI stuff...

_ Dave
