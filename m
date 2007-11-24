Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4EDF0DDE34
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 16:09:27 +1100 (EST)
Date: Fri, 23 Nov 2007 21:10:39 -0800
From: Greg KH <gregkh@suse.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/5] USB: Make usb_hcd_irq work for multi-role USB
	controllers w/ shared irq
Message-ID: <20071124051039.GA11029@suse.de>
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
	<20071124002431.25361.23974.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071124002431.25361.23974.stgit@trillian.cg.shawcable.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 23, 2007 at 05:24:31PM -0700, Grant Likely wrote:
> From: Peter Korsgaard <peter.korsgaard@barco.com>
> 
> Some multi-role (host/peripheral) USB controllers use a shared interrupt
> line for all parts of the chip. Export usb_hcd_irq so drivers can call it
> from their interrupt handler instead of duplicating code.
> Drivers pass an irqnum of 0 to usb_add_hcd to signal that the interrupt handler
> shouldn't be registerred by the core.

What about for platforms where irq 0 is a valid irq?

thanks,

greg k-h
