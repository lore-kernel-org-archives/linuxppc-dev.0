Date: Fri, 7 Jul 2000 16:13:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Hollis Blanchard <hollis@amulet.co.jp>
cc: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org,
        Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: RFC: Changing default partition type for linux/ppc
In-Reply-To: <3965D1D8.C7B9F28E@amulet.co.jp>
Message-ID: <Pine.LNX.4.10.10007071611120.505-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 7 Jul 2000, Hollis Blanchard wrote:
> > What prospect of sharing swap space between MacOS X and linux in dual/multi
> > boot machines?
>
> I don't know the details, but I know that you must run mkswap on a new
> swap partition. Since I don't imagine any particular effort has been put
> in to keeping Linux and BSD mkswap's compatible, I doubt it would be
> possible.

Then run `mkswap' (or whatever it's called in your-other-OS) in one of the
boot scripts.

I've been using a similar scheme to share the swap partition for Linux/m68k
and AmigaOS VMM040, many years ago.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
