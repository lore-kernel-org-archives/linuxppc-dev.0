Date: Tue, 4 Feb 2003 09:04:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: was: FEC on MPC860T & race condition
Message-ID: <20030204160401.GA30936@ip68-0-152-218.tc.ph.cox.net>
References: <3E395B40.9090506@imc-berlin.de> <3E39898E.5060804@embeddededge.com> <3E3A3EE9.7000608@imc-berlin.de> <20030203210959.GA7857@ip68-0-152-218.tc.ph.cox.net> <3E3F7C29.8030807@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E3F7C29.8030807@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Feb 04, 2003 at 09:39:05AM +0100, Steven Scholz wrote:
> Tom Rini schrieb:
> > On Fri, Jan 31, 2003 at 10:16:25AM +0100, Steven Scholz wrote:
> >
> >>Dan Malek wrote:
> >>
> >>>Steven Scholz wrote:
> >>>
> >>>
> >>>>You, Laurent, told us about a race condition.
> >>>>You, Dan, first claimed, it was already fix but mentioned later that
> >>>>the patch
> >>>>was somehow lost.
> >>>
> >>>
> >>>IIRC, it was the usual problem of having it fixed in only one of the
> >>>two 2.4 trees.  I ensured both trees were made up to date.
> >>
> >>There is still no fix in linuxppc_2_4_devel!
> >
> >
> > Um, but there is in linuxppc_2_4 ?
> Is that a question or a statement?

A question.

> I just hab a look at arch/ppc/8xx_io/fec.c in the recent linuxppc_2_4 and
> could find this problem fixed! The MII irq is still requested very early
> without waiting for the PHY to discovered!

So linuxppc_2_4 has a partial fix then is what you're saying?  Around
what lines?  I'm interested to see why _devel doesn't have this.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
