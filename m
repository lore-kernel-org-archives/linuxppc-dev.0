Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A4CD3DDE30
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 02:40:57 +1000 (EST)
Date: Fri, 27 Jul 2007 11:40:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Message-ID: <20070727164047.GB26893@ld0162-tx32.am.freescale.net>
References: <20070726135738.GB5643@localhost.localdomain>
	<7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
	<20070727114559.GB11463@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070727114559.GB11463@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2007 at 03:45:59PM +0400, Anton Vorontsov wrote:
> Sure, technically nothing prevents this. But, QE specs names
> SPIs by these ids. Plus, from the kernel side spi name will be
> not pretty, it will be spi1216.1. Reg value making little sense
> to the userspace (or kernel-side SPI layer). Still want get
> rid of device-id?

Naming devices for human consumption is a more general problem than
device-id addresses; I'd like to see a standard "label" property added to
the device tree spec that software could use to present a human-friendly
label that corresponds to markings on the case, position on the board,
etc.

-Scott
