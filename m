Message-ID: <XFMail.000731150122.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000730071543.1508E-100000@ofey.inetnebr.com>
Date: Mon, 31 Jul 2000 15:01:22 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Takashi Oe <toe@unlserve.unl.edu>
Subject: Re: Stealth port problems
Cc: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>#if !defined(CONFIG_KGDB) && defined(SUPPORT_SERIAL_DMA)
>       if (ch->n_addrs >= 3 && ch->n_intrs == 3)
>               zss->has_dma = 1;
>#endif
>
> I think the last two addresses correspond to DMA addresses for all
> SCC capable machines so far, so this change should be ok.

I had the time to try the patch for just a few minutes. It enables the dma
code successfully and it seems to work fine. More testing this night.

Tnx !

Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
