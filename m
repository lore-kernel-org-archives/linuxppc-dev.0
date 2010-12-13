Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 942261007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 21:32:08 +1100 (EST)
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8ABFB@saturn3.aculab.com>
References: <OF51D61C57.96435CC9-ONC12577F6.00326299-C12577F6.0032BA93@transmode.se>
	<AE90C24D6B3A694183C094C60CF0A2F6D8ABFB@saturn3.aculab.com>
Subject: RE: MPC831x (and others?) NAND erase performance improvements
To: "David Laight" <David.Laight@ACULAB.COM>
Message-ID: <OF4BAAB822.8E759F4C-ONC12577F8.00393E37-C12577F8.0039DC9E@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 13 Dec 2010 11:32:00 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Mark Mason <mason@postdiluvian.org>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"David Laight" <David.Laight@ACULAB.COM> wrote on 2010/12/13 09:33:37:
>
>
> > > An external IRQ line would let you limit interrupts to rising edges
> > > rather than all edges, though you'd lose the ability to
> > > directly read the line status.
> >
> > oh, one cannot read the IRQ line? didn't know that. Also I not sure
> > all Freescale CPUs can do rising edge.
>
> I suspect that you may be able to leave the interupt masked, but still
> read the 'interrupt pending' register. Which would have the same effect.

Ah, that should work too. I should be able to read the 'interrupt pending'
register at all times, even when it isn't masked.

What if one has several NAND chips to build a big FS? Is the NAND
controller equipped to handle that?

>
> Our HW engineers tend to feed everything into an FPGA since it
> gives than a lot more flexibility over pin connections.
> In which case the invertor is trivial.
> (and the fpga interface can read the status!)

Yes, but not all of our boards have FPGA and we load the FPGA
from the SW so it is a chicken and egg problem for us.

     Jocke
