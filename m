Message-ID: <3986152C.992C3CE8@denise.shiny.it>
Date: Mon, 31 Jul 2000 20:09:16 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
CC: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org,
        Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Stealth port problems
References: <XFMail.000731150122.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Giuliano Pochini wrote:
>
> >#if !defined(CONFIG_KGDB) && defined(SUPPORT_SERIAL_DMA)
> >       if (ch->n_addrs >= 3 && ch->n_intrs == 3)
> >               zss->has_dma = 1;
> >#endif
> >
> > I think the last two addresses correspond to DMA addresses for all
> > SCC capable machines so far, so this change should be ok.
>
> I had the time to try the patch for just a few minutes. It enables the dma
> code successfully and it seems to work fine. More testing this night.
>
> Tnx !

I confirm. It works fine.

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
