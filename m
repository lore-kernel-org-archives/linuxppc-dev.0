Date: Tue, 28 Dec 1999 13:35:57 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: weasel@cs.stanford.edu
cc: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        "Jens Ch. Restemeier" <jrestemeier@currantbun.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Update - Re: Open Sourced Glide on Linux PPC
In-Reply-To: <w9kr9g8mipm.fsf@euclide.irisa.fr>
Message-ID: <Pine.LNX.4.05.9912281334500.389-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 27 Dec 1999, Peter Chang wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > If you use the *mb() macros instead of eieio(), you don't have to use #ifdefs
> > and it'll work automagically on e.g. Alpha as well.
> 
> This I know less about, but these might fence more often than strictly necessary?

wmb() is a barrier for writing.
rmb() is a barrier for reading.
mb() is a barrier for both and thus the `safest'.

The main advantage is that these are defined for all architectures, unlike
eieio().

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
