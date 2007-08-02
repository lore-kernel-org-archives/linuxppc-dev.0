Return-Path: <david-b@pacbell.net>
Received: from smtp109.sbc.mail.re2.yahoo.com (smtp109.sbc.mail.re2.yahoo.com
	[68.142.229.96]) by ozlabs.org (Postfix) with SMTP id CE61BDDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 07:47:25 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [PATCH] [SPI][POWERPC] spi_mpc83xx: in "QE
	mode" spiclk is sysclk/2
Date: Thu, 2 Aug 2007 14:47:21 -0700
References: <20070802142641.GA6309@localhost.localdomain>
In-Reply-To: <20070802142641.GA6309@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708021447.22028.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 02 August 2007, Anton Vorontsov wrote:
> Probably someday mpc83xx_spi->sysclk should be renamed to
> mpc83xx_spi->spiclk to be less confusing.

Why not "today", with this patch?  That would fix some of
the root cause of this bug...
