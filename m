Date: Thu, 2 Oct 2003 12:06:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Stefan Berndtsson <stefan@nocrew.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Typo fix in 2.6.0-test5
Message-ID: <20031002190616.GA21029@ip68-0-152-218.tc.ph.cox.net>
References: <20030930230828.GA12343@ip68-0-152-218.tc.ph.cox.net> <Pine.LNX.4.44.0310021828010.23664-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0310021828010.23664-100000@opal.biophys.uni-duesseldorf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 02, 2003 at 06:37:16PM +0200, Michael Schmitz wrote:
> > > linux-2.6.0-test5, rsynced from source.mvista.com::linuxppc-2.5 (is there
> > > a more recently updated source than that?) doesn't seem to have a working
> > > sleep-mode in an ibook2 (late 2001, 600MHz, M3/R128).
> >
> > It's as up to date as the bk tree as no one has pulled -test6 into it
> > yet.  The rsync trees on source.mvista.com lag ~1 hour (or less) behind
> > the bitkeeper versions of the trees.
>
> Seeing as linuxppc-2.5 is the latest for those stuck with rsync, can we
> get this typo fix in?

Only by sending it to lkml and/or jeff garzik.

> Also, include/video/macmodes.h is missing (used by matroxfb).

Is it in the bk tree as of then (can be checked via web pages)?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
