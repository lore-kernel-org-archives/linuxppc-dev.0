Date: Sun, 15 Jun 2003 17:04:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Peter Ryser <Peter.Ryser@xilinx.com>, akuster@mvista.com,
	linuxppc-dev@lists.linuxppc.org, Scott Anderson <sanders@mvista.com>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: GPL inconsistency in arch/ppc/ocp/xlinx/
Message-ID: <20030616000417.GA17654@ip68-0-152-218.tc.ph.cox.net>
References: <20030524201213.GA8256@lst.de> <20030612203205.GA23017@lst.de> <20030612205523.GI828@ip68-0-152-218.tc.ph.cox.net> <20030615174714.GA4672@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
In-Reply-To: <20030615174714.GA4672@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jun 15, 2003 at 07:47:14PM +0200, Christoph Hellwig wrote:

> On Thu, Jun 12, 2003 at 01:55:23PM -0700, Tom Rini wrote:
> > I think you should ask someone responsible first.  And on the correct
> > mailing list as well.  Armin is not responsible for this code, Scott
> > Anderson is.  Armin just put it into the linuxppc-2.5 tree.
>
> Well, thanks for this explanation, you might aswell have answered when
> I posted thiß to the linuxppc list the first time.  But neither of this
> is guessable, the only info I had is that Armin commited it..

I thought you had seen the msg I left for you on IRC.  Either way, lets
try this again (and this could probably use being thrown up somewhere in
general even):

Welcome to the wonderful world of the ppc32 kernel.  By and large, code
has (and in some cases, still is :( ) started off first, and kept more
up to date in the linuxppc_2_4_devel tree (see
http://penguinppc.org/dev/kernel.shtml) for any platform that is not a
PowerMac.  Similarly, discussion of most development issues, for
non-powermacs, takes place on the linuxppc-embedded@lists.linuxppc.org
list.  For pmacs, things seem to be spread over debian-powerpc, (quite
probably) the yellowdog users list, and to a lesser extent, the
linuxppc-users list as well.

> > Second,
> > Peter Ryser (who handles the Xilinx side of things) is on the
> > linuxppc-embedded list, where most of the 4xx people are.  Finally,
> > Peter knows about this, and last I knew was talking to their legal
> > department.  Peter, any news on this?
>
> Yeah, I think it's _really_ time we get any update on this.  Guys,
> remember that this renders the linuxppc tree undistributable in
> strong legaleese so you'd better care.

Personally, I don't think it's a big deal, so long as it doesn't get
dropped on the floor, but it does need to be resolved.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
