Return-Path: <geert@linux-m68k.org>
Received: from hoefnix.telenet-ops.be (hoefnix.telenet-ops.be [195.130.132.54])
	by ozlabs.org (Postfix) with ESMTP id 415C1DDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 18:09:53 +1000 (EST)
Received: from assei1bl6.telenet-ops.be (assei1bl6.telenet-ops.be
	[195.130.133.68])
	by hoefnix.telenet-ops.be (Postfix) with ESMTP id 2DF529DCFB
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 10:09:51 +0200 (CEST)
Date: Fri, 13 Apr 2007 10:09:47 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
In-Reply-To: <Pine.LNX.4.63.0704121917260.29621@qynat.qvtvafvgr.pbz>
Message-ID: <Pine.LNX.4.64.0704131009190.16292@anakin>
References: <1175644642.10567.31.camel@shinybook.infradead.org><200704032210
	02.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org><20070403.181645.6815945
	8.davem@davemloft.net>
	<20070404022828.5c9b97f3@the-village.bc.nu><Pine.LNX.4.64.0704032307001.780
	2@mtl.rackplans.net>
	<m3tzvm6fgw.fsf@ursa.amorsen.dk><adabqhtip2n.fsf@cisco.com>
	<Pine.LNX.4.64.0704122243280.9866@mtl.rackplans.net>
	<Pine.LNX.4.63.0704121917260.29621@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Gerhard Mack <gmack@innerfire.net>,
	linux-kernel@vger.kernel.org, Benny Amorsen <benny+usenet@amorsen.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 12 Apr 2007, David Lang wrote:
> On Thu, 12 Apr 2007, Gerhard Mack wrote:
> > Sometimes it's not the speed it's the cost.. The best I've ever done is
> > 5.5 interfaces per u/ Although with a better motherboard and case it might
> > have been different.
> 
> I have a bunch of servers from rackable, dual core cpu, 2G ram 2xgigE on the 
> motherboard (1x100M on motherboard), 4x Intel E1000 quad port cards, 120G SATA 
> drive, DVD burner, floppy
> 
> 3u, 18 gig ports, just under $5k

I don't think we're still talking about _serial_ ports?

Gr{oetje,eeting}s,

						Geert

P.S. Yes, Ethernet is serial ;-)
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
