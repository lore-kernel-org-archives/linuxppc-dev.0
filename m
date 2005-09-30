Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 08D776842A
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Oct 2005 02:23:59 +1000 (EST)
Date: Fri, 30 Sep 2005 17:18:22 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Corey Minyard <minyard@acm.org>
In-Reply-To: <433D557C.4020301@acm.org>
Message-ID: <Pine.LNX.4.62.0509301717510.9170@numbat.sonytel.be>
References: <20050929183221.GA17292@i2.minyard.local>
	<20050929203647.GA6597@mag.az.mvista.com>
	<433D557C.4020301@acm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: MV64x60 watchdog timer driver updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 Sep 2005, Corey Minyard wrote:
> Mark A. Greer wrote:
> > On Thu, Sep 29, 2005 at 01:32:21PM -0500, Corey Minyard wrote:
> > > James looked at an earlier version and said it was ok, and suggested
> > > a few changes.  This has been tested against 2.6.14-rc2 on a Katana.
> > > 
> > > Note that the bus_clk value from the platform information seems to
> > > be in MHZ, but the actual frequency is generally 133,333,333, not
> > > 133,000,000.  I don't think the inaccuracy matters here, but it seems
> > > a little odd.
> > >    
> > 
> > Yes, it makes more sense to me to pass the actual frequency and not do
> > the '* 1000000'.
> >  
> The only trouble is if  you go over 4GHZ...  Maybe it should be in KHZ instead
> of MHZ?  or 64-bits?  Or maybe we don't worry about >4GHZ busses?
> 
> Also, how would one go about changing this?  Would you need something like:
> 
> if (bus_clk < 1000)
>  bus_clk *= 1000000
> 
> for backwards compatability?

Hey, don't touch the i2c! ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
