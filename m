Date: Wed, 17 Nov 1999 22:08:17 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel debugging??
In-Reply-To: <3831DE3B.5F2C790@wanadoo.fr>
Message-ID: <Pine.LNX.4.05.9911172207200.25661-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 16 Nov 1999, Martin Costabel wrote:
> Geert Uytterhoeven wrote:
> > > And I could boot a stock 2.3.26 with changes in asm-ppc/fcntl.h
> > > (O_LARGEFILE ....)
> > 
> > That's very interesting to know! It means we just have to analyse the 2.3.27
> > and 2.3.28 patches to find out what went wrong.
> 
> Just for information: Paul M's 2.3.27 rsync kernel compiles and runs
> just fine on this Pmac 6400. The machine swaps like crazy and is
> therefore rather slow, but I am not sure if this is the kernel's fault.

Are you sure about the version? I just checked out this tree, and it's 2.3.22,
according to the Makefile. Perhaps I made a mistake? This is the first time I
used rsync (`rsync -auvz samba.anu.edu.au::linux-pmac-devel .').

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
