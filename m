Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7679CDDDEE
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 16:59:15 +1100 (EST)
Subject: Re: [PATCH 4/4] PowerPC: Add PCI node to 440GRx Rainier DTS.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200712220654.51132.sr@denx.de>
References: <20071221162708.GA1724@ru.mvista.com>
	<1198272111.6737.9.camel@pasglop>  <200712220654.51132.sr@denx.de>
Content-Type: text/plain
Date: Sat, 22 Dec 2007 16:58:57 +1100
Message-Id: <1198303137.11782.0.camel@pasglop>
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


On Sat, 2007-12-22 at 06:54 +0100, Stefan Roese wrote:
> On Friday 21 December 2007, Benjamin Herrenschmidt wrote:
> > On Fri, 2007-12-21 at 19:27 +0300, Valentine Barshak wrote:
> > > +                       /* All PCI interrupts are routed to IRQ 67 */
> > > +                       interrupt-map-mask = <0000 0 0 0>;
> > > +                       interrupt-map = < 0000 0 0 0 &UIC2 3 8 >;
> > > +               };
> >
> > Same question as for Sequoia...
> 
> Correct here too. Rainier (440GRx) is basically a stripped of version of the 
> Sequioa (440EPx).

I hope they accompany it with a design note: "don't do that in your
actual products" :-)

Ben.
