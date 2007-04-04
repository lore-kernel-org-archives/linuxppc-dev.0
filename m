Return-Path: <geert@linux-m68k.org>
Received: from adicia.telenet-ops.be (adicia.telenet-ops.be [195.130.132.56])
	by ozlabs.org (Postfix) with ESMTP id D30B7DDE38
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 17:04:44 +1000 (EST)
Date: Wed, 4 Apr 2007 09:04:42 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
In-Reply-To: <20070403.225006.119275067.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0704040903470.20803@anakin>
References: <20070404022544.59b022a6@the-village.bc.nu>
	<17939.10130.687893.167511@cargo.ozlabs.ibm.com>
	<1175663999.2932.8.camel@shinybook.infradead.org>
	<20070403.225006.119275067.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
	linux-kernel@vger.kernel.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Apr 2007, David Miller wrote:
> From: David Woodhouse <dwmw2@infradead.org>
> Date: Wed, 04 Apr 2007 01:19:59 -0400
> 
> > I don't see why that 'should' be the case. Certainly it _isn't_ the case
> > on most supported platforms -- we have separate device numbers, and
> > names, for most types of ports. There's only one or two drivers which
> > abuse ttySn for anything other than 8250 ports.
> 
> sunsu, sunzilog, pmac_zilog, sunsab, etc.

amiserial.

> The list is longer than you think.  In fact the convention is
> very well established.

And I guess the recently revived Atari serial driver, too.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
