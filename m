Date: Thu, 8 Nov 2001 13:07:55 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Chris Emerson <chris@tartarus.org>
Cc: Paul Mackerras <paulus@samba.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The Plan
In-Reply-To: <20011108111401.A18221@ixion.tartarus.org>
Message-ID: <Pine.GSO.4.21.0111081307200.11099-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 8 Nov 2001, Chris Emerson wrote:
> On Wed, Nov 07, 2001 at 10:35:07PM +1100, Paul Mackerras wrote:
> > (to reduce the arch/ppc/kernel clutter, that is)
> >
> > This is what I am thinking of; I have implemented it locally here and
> > I'm doing test compiles with arch/ppc/configs/*.
> >
> > - arch/ppc/kernel/ppc_asm.h moves to include/asm-ppc, and the contents
> >   of ppc_asm.tmpl get folded into it, with corresponding changes to
> >   arch/ppc/*/*.S.
>
> This sounds like a good thing for the user-mode port, which tries to use
> a couple of the assembler files from arch/ppc.  There's some hideous symlink
> hackery going on to get them to work at the moment.  If it's all just in
> include/asm-ppc, that should be much nicer.

Both MIPS and ARM have board-specific directories in include/asm-*/ and
arch/*/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
