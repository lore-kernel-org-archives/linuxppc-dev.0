Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C9593DDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 15:33:50 +1100 (EST)
Date: Fri, 14 Dec 2007 21:50:01 -0600
From: Scott Wood <scottwood@freescale.com>
To: dwmw2@infradead.org, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 4/4] Freescale enhanced Local Bus Controller FCM NAND
	support.
Message-ID: <20071215035001.GB20533@ld0162-tx32.am.freescale.net>
References: <20071214221736.GA21231@loki.buserror.net>
	<20071215025851.GA8430@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071215025851.GA8430@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 15, 2007 at 01:58:51PM +1100, David Gibson wrote:
> On Fri, Dec 14, 2007 at 04:17:36PM -0600, Scott Wood wrote:
> > Signed-off-by: Nick Spence <nick.spence@freescale.com>
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> > Fixed some formatting issues, removed some leftover debugging cruft,
> > and added a comment about potential conflicts in the interrupt
> > handling.
> 
> Why is the NAND MTD driver specific to the elbc bus?

Because the NAND flash controller is part of the elbc.

> And why does it bind to the elbc node, rather than the nand node under
> it?

The FCM registers are part of the eLBC register block; the chip select
mapping is just a data buffer.

-Scott
