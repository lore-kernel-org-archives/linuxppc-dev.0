Message-ID: <39BFEFAA.993C37D3@wanadoo.fr>
Date: Wed, 13 Sep 2000 23:20:42 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: success 2.4.0-test8 with latest bk
References: <200009132025.WAA00853@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
> On  13 Sep, this message from Benjamin Herrenschmidt echoed through cyberspace:

> > That's not the first time I notice this strange behaviour. I meant, this

> Same for me, except that for a few weeks now I'm basically stuck in a
> non-booting mood. One out of roughly 20 tries boots indeed; all the
> other stop in various places in init/main.c. Not even going into xmon...
>
> Since it doesn't seem to be a reproducible crash in one specific place,
> its rather hard to isolate the problem. I feel like chasing ghosts...
> Anybody got Ghostbusters' phone?

Actually, it (latest bk-2.4.0-test) is now pretty stable again on my old
6400(*). The only problems are those that seem to plague everybody:

I had to apply Al Viro's remaining fix for
fs/buffers.c:block_truncate_page() ("kernel BUG at ll_rw_blk.c:711"),
otherwise I was dropped into xmon all the time. Linus seems to hide
under a ton of brown paper bags.

There are now processes that don't listen to SIGHUP or to Ctrl-C (bk
sccstool, for example) and get transformed into zombies.

(*) I'll check your valkyriefb patch as soon as I can find it, so it
might not remain as stable :-)

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
