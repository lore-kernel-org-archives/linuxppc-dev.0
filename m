Date: Thu, 1 Mar 2001 21:18:37 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Daniel Berlin <dberlin@redhat.com>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: u64 fun and PCI DMA not working for things behind bridges?
In-Reply-To: <m2hf1dy1eo.fsf@dynamic-addr-83-177.resnet.rochester.edu>
Message-ID: <Pine.LNX.4.05.10103012117070.21363-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 1 Mar 2001, Daniel Berlin wrote:
> Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> writes:
> > > I can't compile the drivers without optimization, or else i get
> > > references to functions that don't exist in the kernel, for some
> > > reason.
> >
> > What exact functions don't exist?
>
> Any extern inline functions.

`extern inline' is deprecated, in favor of `static inline'. During the last few
weeks, many of them were converted, albeit not in include/asm-ppc/.

I suppose this will solve the link problem with -O0 as well, since the compiler
will no longer think non-inlined functions are avilable externally?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
