Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA866DDE9E
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 18:47:57 +1000 (EST)
Date: Sat, 27 Oct 2007 10:46:42 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 1/2] PowerPC: Add 44x NDFC device-tree aware support
In-Reply-To: <200710270653.32459.sr@denx.de>
Message-ID: <alpine.LFD.0.9999.0710271045400.3186@localhost.localdomain>
References: <20071026163958.GA11784@ru.mvista.com>
	<200710270653.32459.sr@denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 27 Oct 2007, Stefan Roese wrote:

> Hi Valentine,
> 
> On Friday 26 October 2007, Valentine Barshak wrote:
> > This adds device-tree aware PowerPC 44x NDFC (NAND Flash Controller)
> > driver. The code is based on the original ndfc.c driver by Thomas Gleixner.
> > The major difference is that here we try to handle all chips found as one
> > mtd device instead of having a separate one on each chip.
> > The partition handling code is based on the physmap_of one.
> > The the first 4 bits of the "bank-mask" property show which of the 4 NDFC
> > banks have chips attached. The "bank-width" property is 1 for 8-bit flash
> > and 2 for a 16-bit one.
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>
> Are you sure you have the Signed-off-by from Thomas already on this?

Definitely not.

	tglx
