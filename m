Subject: Re: [PATCH] ppc32: arch code preempt fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.58.0403252207320.8124@ppc970.osdl.org>
References: <1080271455.1196.13.camel@gaston>
	 <Pine.LNX.4.58.0403252207320.8124@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1080284133.1333.7.camel@gaston>
Mime-Version: 1.0
Date: Fri, 26 Mar 2004 17:55:33 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-03-26 at 17:12, Linus Torvalds wrote:
>
> On Fri, 26 Mar 2004, Benjamin Herrenschmidt wrote:
> >
> > I figured the best way to stop beeing bothered by users trying to run
> > preempt was to fix it ;)
> >
> > Here's a first batch that close some races we had when testing regs->msr
> > for altivec or FPU enable, then doing the giveup_* function.  A preempt
> > in between those would have caused us to save a stale altivec or FPU
> > context.
>
> Ok, this clashed with Paul work on threaded core-dumps.
>
> I fixed up the clashes by hand, but you should really check the end result
> for sanity. Ben, Paul?

Will do, thanks. Sorry for the clash, I should have pulled this morning..

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
