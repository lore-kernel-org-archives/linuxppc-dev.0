Date: Wed, 9 Feb 2000 22:23:02 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Vger CVS R.I.P. (Was Re: the state of the linuxppc-dev community)
In-Reply-To: <38A1D81A.3BB316E6@wanadoo.fr>
Message-ID: <Pine.LNX.4.05.10002092218260.889-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Feb 2000, Martin Costabel wrote:
> Michael Schmitz wrote:
> []
> > I could imagine a reworked web site, plus CVS or other access to the
> > sources would be a good start. I agree with Tony Mantler on the importance
> > of CVS - having run the m68k Mac port almost as one-man-show for a year,
> > switching to CVS encouraged at least five more people to start working on
> > various parts. Getting the latest sources without waiting for me
> > to build a new diff, checking in patches directly and improved
> > communication were instrumental in advancing development.
>
> Speaking of CVS, I find it strange that nobody in this thread mentions
> the vger CVS tree any more (but then I am finding many things strange
> recently, "ppclinux".apple.com forgetting mklinux and so on, it's
> probably me getting old). Until very recently, this tree maintained a
                                  ^^^^^^^^^^^^^
Say 3-4 months ago.

> very up-to-date version of PPC patches. It seems that since yesterday,
> PPC support on this tree is officially dead. There are comments like
>
> RCS file: /cvs/linux/linux/include/asm-ppc/hw_irq.h,v
> []
> revision 1.3
> date: 2000/02/07 21:37:25;  author: davem;  state: Exp;  lines: +1 -1
> Not maintained here anymore.
>
> Very sad. As a user, I found CVS much better than rsync, because it
> gives much more information and has more intelligence in merging with
> local changes. I only hope that bitkeeper will give similar
> possibilities.

BK should be(come) better than CVS. I'm happy with BK now (sort of, still
getting used to it).

But I understand your frustration: I felt the same during the 2 months between
my vger-cvs and ppc-bk times. Let's hope ppc-bk is opened for the public
soon... IMHO bk is sufficient mature to have a positive netto gain for
Linux/PPC when combining a beta bk with the opening of the PPC kernel tree.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
