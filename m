Date: Mon, 8 May 2000 11:50:49 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: james  woodyatt <jhw@wetware.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Help with cross-endian bitfields?
In-Reply-To: <v03110702b53c10dcc4d9@[208.177.152.17]>
Message-ID: <Pine.LNX.4.10.10005081150260.312-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 May 2000, james  woodyatt wrote:
> Daniel Jacobowitz <drow@false.org> wrote:
> >On Fri, May 05, 2000 at 03:27:21PM -0400, jlquinn@us.ibm.com wrote:
> >>
> [...]
> >> Can someone tell me what's going on here?  Am I going to have to have
> >> ifdef's on these structs, or resort to mask macros, or is there a
> >> reasonable solution here.
> >
> >As Dan Malek said, there is no defined ordering.  The compiler is free
> >to do whatever it wishes.  You can't assume that.  (I think.)
> [...]
>
> It's absolutely true.
>
> Not only is there no defined ordering, the ANSI standard says that it
> doesn't even need to use bitfield operations in the machine code.  It's
> allowed to pad arbitrarily between the bitfields.  It's allowed to
> completely ignore the bitfield widths and treat the members like integers.
> It's even allowed to order the very bits themselves in weird ways, if it
> thinks the processor will like it better that way.
>
> Bitfields are just not even remotely portable.
>
> C structures should not be used to represent portable serializations of
> external data.  Period.  Yes, they're convenient-- but your compiler and my
> compiler don't have to agree on practically anything about them.

And we all use gcc to compile Linux kernels... So the only remaining issue is
endianness.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
