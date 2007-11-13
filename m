Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1097FDDD0A
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 20:55:35 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc: Make isa_mem_base common to 32 and 64 bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0711130917350.31003@pademelon.sonytel.be>
References: <20071113044429.461B1DDE2E@ozlabs.org>
	<Pine.LNX.4.62.0711130917350.31003@pademelon.sonytel.be>
Content-Type: text/plain
Date: Tue, 13 Nov 2007 20:55:24 +1100
Message-Id: <1194947724.18185.97.camel@pasglop>
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


> > +/* ISA Memory physical address (or 0 if none) */
>                                    ^^^^^^^^^^^^
> > +resource_size_t isa_mem_base    = 0;
> 
> Let's hope this doesn't confuse too many people, as 0 is the valid value on
> legacy PC hardware ;-)

True, but that's been our default so far so I'm just not changing
existing behaviour. If it's bogus, it will need a separate fix.

Cheers,
Ben.
