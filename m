Date: Fri, 3 Oct 2003 08:08:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Typo fix in 2.6.0-test5
Message-ID: <20031003150804.GB21468@ip68-0-152-218.tc.ph.cox.net>
References: <20031002190616.GA21029@ip68-0-152-218.tc.ph.cox.net> <Pine.LNX.4.44.0310031352420.1192-100000@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0310031352420.1192-100000@zirkon.biophys.uni-duesseldorf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 03, 2003 at 01:54:25PM +0200, Michael Schmitz wrote:
> > > Seeing as linuxppc-2.5 is the latest for those stuck with rsync, can we
> > > get this typo fix in?
> >
> > Only by sending it to lkml and/or jeff garzik.
>
> OK; I'll collect some more things for that.

ok.

> > > Also, include/video/macmodes.h is missing (used by matroxfb).
> >
> > Is it in the bk tree as of then (can be checked via web pages)?
>
> Nope. Missing in the 2.5 devel bk tree as well. It might be by design, and
> matroxfb is really what's broken, though.

Then it's an issue for lkml and/or the matroxfb maintainer.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
