Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D385367E1E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 03:37:39 +1000 (EST)
Date: Mon, 1 Aug 2005 12:37:28 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Vikas Aggarwal" <va824363@albany.edu>
Message-Id: <20050801123728.62764c7e.kim.phillips@freescale.com>
In-Reply-To: <33216.24.92.61.26.1122857296.squirrel@24.92.61.26>
References: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
	<20050729153323.3f2c62ad.kim.phillips@freescale.com>
	<32798.24.92.61.26.1122694772.squirrel@24.92.61.26>
	<20050730183217.3310585b.kim.phillips@freescale.com>
	<33216.24.92.61.26.1122857296.squirrel@24.92.61.26>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8248  SEC -- interrupt handler "is" invoked
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 31 Jul 2005 20:48:16 -0400 (EDT)
"Vikas Aggarwal" <va824363@albany.edu> wrote:

> Tried it as u said . No luck :(
> But something more i noted now in CPSR(channel pointer status
> register=0x2040)  that before ISR invoked it has 0x0:0x7.
> 
> After ISR invoked it has 0x7:0x2007 .  The 7 in low bits means
> channel_error and 2 is at "reserved" bits as per documentation, don't know
> what that means.
> 
> I also tried kmalloc with GFP_DMA, for the memory where i create the
> Descriptor.
> Please keep giving ideas for debugging this as this is what driving me
> right now.
> regards
> -vikas


So you reset the master, then the channel, allocate the RNG descriptor, allocate the random data buffer, fill the descriptor with values for an RNG request the size of your buffer (filling with the physical address of your random data buffer), and submit the descriptor's physical address to the FR..

btw, I'm finding it hard to help without seeing sec register transaction data, descriptor data, virtual and physical addresses, etc.

Kim
