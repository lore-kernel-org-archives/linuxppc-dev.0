Date: Mon, 23 Jul 2001 09:07:52 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Larry McVoy <lm@bitmover.com>
Cc: Troy Benjegerdes <hozer@drgw.net>,
	linuxppc-dev@lists.linuxppc.org,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: kernel ftp ?
In-Reply-To: <20010722151518.A6437@work.bitmover.com>
Message-ID: <Pine.LNX.4.05.10107230857310.14709-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 22 Jul 2001, Larry McVoy wrote:
> > fact, BK takes MORE bandwidth than rsync on a 'clone' operation because it
> > has to ship the complete revision history along.
>
> Wow.  Amazing insight, that.  You could say "copying 100MB takes MORE
> bandwidth than copying 50MB because you have to ship the second 50MB",
> and that would be an equally amazing insight.

Yes, indeed we're comparing apples to oranges (I think that's how you say it in
English, in Dutch we compare apples to lemons :-)

We developers do want the extra 50 MB, but mere mortals don't. They just want a
copy of the latest version of the tree. Hacking is beyond their capabilities.

IMHO, bk en rsync both have their uses.

Gr{oetje,eeting}s,

						Geert

P.S. I do agree more or less to the other arguments in your mail, about null
     pulls and the scarcity of resources.
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
