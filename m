Date: Wed, 13 Sep 2000 00:14:46 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Costabel <costabel@wanadoo.fr>
cc: toa@pop.agri.ch, Paul Mackerras <paulus@linuxcare.com>,
        Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: success 2.4.0-test8 with latest bk
In-Reply-To: <39BE9C18.769B8EAE@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10009130011300.372-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 12 Sep 2000, Martin Costabel wrote:
> Andreas Tobler wrote:
> > I want to express my thanks to you including Geert's pci-res patch, now
> > I'm able again to run the latest devel tree from bk on my ancient 7200
> > with it's 2940UW.
> > It is running since three h.
>
> You are lucky. For me it stops booting after the "freeing unused kernel
> memory" line. The one from 2 days ago had 2 days uptime.

Usually this means that some function/data is marked __init while it must not.
Quick verification: #undef __init / #define __init etc.

Just wondering: wouldn't it be possible to write some tool to find such bugs?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
