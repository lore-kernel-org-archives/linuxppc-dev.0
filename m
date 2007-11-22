Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48475DDECF
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 11:52:34 +1100 (EST)
Subject: Re: [PATCH 12/14] powerpc: Add early udbg support for 40x processors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40711211620q4450f3c2g2450157e37eb7c9@mail.gmail.com>
References: <20071121061555.55B06DDFA8@ozlabs.org>
	<fa686aa40711211547nf9d58c4t1bc7a512c699cb02@mail.gmail.com>
	<1195689601.6970.115.camel@pasglop>
	<fa686aa40711211620q4450f3c2g2450157e37eb7c9@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 22 Nov 2007 11:52:24 +1100
Message-Id: <1195692744.6970.122.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> fixed speed
> 4 registers: rx, tx, status & control
> 
> rx & tx are... well... rx and tx registers
> status has a number of bits reporting fifos full/empty etc.
> control has three bits; reset tx, reset rx and interrupt enable.
> 
> See the top of drivers/serial/uartlite.c
> 
> Very simple stuff; but definitely not 16550.

Yuck, they could have made it look like 16550 at least...

Oh well, that's allright, select'ing it wont break anything anyway.

Ultimately, we can if we want have a list of all support 40x (and 4xx)
variants and select what we want in a given kernel build. Those variants
would themselves select the individual bits they care about...

Ben.
