Subject: Re: Typo fix in 2.6.0-test5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.44.0310031352420.1192-100000@zirkon.biophys.uni-duesseldorf.de>
References: 
	 <Pine.LNX.4.44.0310031352420.1192-100000@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain
Message-Id: <1065192807.23151.19.camel@gaston>
Mime-Version: 1.0
Date: Fri, 03 Oct 2003 16:53:27 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-10-03 at 13:54, Michael Schmitz wrote:
> > > Seeing as linuxppc-2.5 is the latest for those stuck with rsync, can we
> > > get this typo fix in?
> >
> > Only by sending it to lkml and/or jeff garzik.
>
> OK; I'll collect some more things for that.
>
> > > Also, include/video/macmodes.h is missing (used by matroxfb).
> >
> > Is it in the bk tree as of then (can be checked via web pages)?
>
> Nope. Missing in the 2.5 devel bk tree as well. It might be by design, and
> matroxfb is really what's broken, though.

No, it's not missing afaik, it's just not where matroxfb is looking for

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
