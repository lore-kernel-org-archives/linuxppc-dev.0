Return-Path: <david-b@pacbell.net>
Received: from smtp110.sbc.mail.re2.yahoo.com (smtp110.sbc.mail.re2.yahoo.com
	[68.142.229.95]) by ozlabs.org (Postfix) with SMTP id 27733DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 04:48:05 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [PATCH 2/3] [SPI] Add new mode: SPI_LOOP
Date: Wed, 1 Aug 2007 11:25:47 -0700
References: <20070726134754.GA3539@localhost.localdomain>
	<200707262007.07537.david-b@pacbell.net> <46A967D5.30606@whoi.edu>
In-Reply-To: <46A967D5.30606@whoi.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708011125.47934.david-b@pacbell.net>
Cc: Ned Forrester <nforrester@whoi.edu>, linuxppc-dev@ozlabs.org,
	Stephen Street <stephen@streetfiresound.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 July 2007, Ned Forrester wrote:
> David Brownell wrote:
> > On Thursday 26 July 2007, Anton Vorontsov wrote:
> >> Loopback mode is supported by various controllers, this mode
> >> is useful for testing, especially in conjunction with spidev
> >> driver.
> > 
> > ISTR that Stephen Street provided a loopback mode for debug
> > in his pxa2xx_spi code.  And I know you're fight that this
> > mode shows up in a lot of hardware.
> > 
> > Comments, anyone?  This seems like a fair way to expose this
> > mechanism.  And I tend to agree that it'd mostly be useful in
> > conjunction with "spidev".
> 
> Yes, it is in pxa2xx_spi.  It is passed in a structure that is attached 
> to spi_board_info.controller_data.  I have used it to great effect to 
> test data modes in the driver for which I have no external hardware 
> support: various bits/word, clock frequencies, fifo thresholds, dma 
> burst sizes, etc.

Well, the SPI_LOOP stuff is now in kernel.org GIT and 2.6.23-rc2,
so if someone wants to update pxa2xx_spi to support this through
spi->mode instead of controller data, now is a good time to start
working on that.

- Dave
