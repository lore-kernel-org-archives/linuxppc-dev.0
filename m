Message-ID: <38A1D81A.3BB316E6@wanadoo.fr>
Date: Wed, 09 Feb 2000 22:11:54 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Vger CVS R.I.P. (Was Re: the state of the linuxppc-dev community)
References: <Pine.LNX.4.10.10002091152160.11080-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
[]
> I could imagine a reworked web site, plus CVS or other access to the
> sources would be a good start. I agree with Tony Mantler on the importance
> of CVS - having run the m68k Mac port almost as one-man-show for a year,
> switching to CVS encouraged at least five more people to start working on
> various parts. Getting the latest sources without waiting for me
> to build a new diff, checking in patches directly and improved
> communication were instrumental in advancing development.

Speaking of CVS, I find it strange that nobody in this thread mentions
the vger CVS tree any more (but then I am finding many things strange
recently, "ppclinux".apple.com forgetting mklinux and so on, it's
probably me getting old). Until very recently, this tree maintained a
very up-to-date version of PPC patches. It seems that since yesterday,
PPC support on this tree is officially dead. There are comments like

RCS file: /cvs/linux/linux/include/asm-ppc/hw_irq.h,v
[]
revision 1.3
date: 2000/02/07 21:37:25;  author: davem;  state: Exp;  lines: +1 -1
Not maintained here anymore.

Very sad. As a user, I found CVS much better than rsync, because it
gives much more information and has more intelligence in merging with
local changes. I only hope that bitkeeper will give similar
possibilities.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
