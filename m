Date: Sun, 15 Jun 2003 17:07:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matt Porter <mporter@kernel.crashing.org>, akuster@mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: GPL inconsistency in arch/ppc/ocp/xlinx/
Message-ID: <20030616000707.GB17654@ip68-0-152-218.tc.ph.cox.net>
References: <20030524201213.GA8256@lst.de> <20030612203205.GA23017@lst.de> <20030612134519.C4693@home.com> <20030615174153.GB4511@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030615174153.GB4511@lst.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jun 15, 2003 at 07:41:53PM +0200, Christoph Hellwig wrote:

>
> On Thu, Jun 12, 2003 at 01:45:19PM -0700, Matt Porter wrote:
> > Multiple people have found that Armin in no longer answering linuxppc
> > related email so this doesn't really mean anything...he's disappeared
> > from the community.  I'll query a couple folks in mvista, I would
> > have thought the "right" person would see this here.
>
> Well, the original post went to linuxppc-dev, too where other mvista
> folks are subscribed.

... which is why someone told Peter to start with.  But, if you can't
remove the offending line, neither can anyone at mvista, regardless of
the hat they are wearing.

> Really, the problem is that due to this the
> linuxppc tree isn't distributable in a strictly legaleese sense so
> I'd really epect some more action from mvista.

True.  But this isn't evil proprietary code, it's GPL with a standard
for the embedded world clause about life support systems.  As an aside,
would the GPL prevent a big sticker on the box saying "Don't use me in
life support systems" ?  My (alibiet biased) take is that it's intended
along those lines.  From an otherwise good-faith effort.

> If this isn't solved by the end of thise week I'll submit a patch
> to remove these files to Paul.

Please don't.  Paul is aware of the issue, and aware that Xilinx has
been notified.  If things aren't moving at a pace of his liking, he can
remove it.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
