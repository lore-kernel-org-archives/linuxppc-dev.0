Date: Fri, 3 Oct 2003 13:54:25 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Typo fix in 2.6.0-test5
In-Reply-To: <20031002190616.GA21029@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.LNX.4.44.0310031352420.1192-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Seeing as linuxppc-2.5 is the latest for those stuck with rsync, can we
> > get this typo fix in?
>
> Only by sending it to lkml and/or jeff garzik.

OK; I'll collect some more things for that.

> > Also, include/video/macmodes.h is missing (used by matroxfb).
>
> Is it in the bk tree as of then (can be checked via web pages)?

Nope. Missing in the 2.5 devel bk tree as well. It might be by design, and
matroxfb is really what's broken, though.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
