Date: Wed, 9 Feb 2000 22:41:55 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Vger CVS R.I.P. (Was Re: the state of the linuxppc-dev community)
In-Reply-To: <Pine.LNX.4.05.10002092218260.889-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10002092236290.15408-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Speaking of CVS, I find it strange that nobody in this thread mentions
> > the vger CVS tree any more (but then I am finding many things strange
> > recently, "ppclinux".apple.com forgetting mklinux and so on, it's
> > probably me getting old). Until very recently, this tree maintained a
>                                   ^^^^^^^^^^^^^
> Say 3-4 months ago.

At least 2 months from what I recall, but I admit I haven't used vger
since 2.3.18-vger horribly broke booting my Lombard and I couldn't figure
out how to get any console output before framebuffer console init.

> > very up-to-date version of PPC patches. It seems that since yesterday,
> > PPC support on this tree is officially dead. There are comments like
> >
> > RCS file: /cvs/linux/linux/include/asm-ppc/hw_irq.h,v
> > []
> > revision 1.3
> > date: 2000/02/07 21:37:25;  author: davem;  state: Exp;  lines: +1 -1
> > Not maintained here anymore.
> >
> > Very sad. As a user, I found CVS much better than rsync, because it
> > gives much more information and has more intelligence in merging with
> > local changes. I only hope that bitkeeper will give similar
> > possibilities.

Very sad indeed. Though rsync didn't destroy my local changes so far (huge
additions to adb.c, that was easy to merge. Reminds me to send those off
to Paul, argh).

> BK should be(come) better than CVS. I'm happy with BK now (sort of, still
> getting used to it).

And I just got used to CVS :-(( I'd need a BK primer when it gets
available.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
