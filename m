Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 3 Apr 2003 07:59:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Disabling data cache
Message-ID: <20030403145906.GA3867@ip68-0-152-218.tc.ph.cox.net>
References: <20030402194622.GA30107@ip68-0-152-218.tc.ph.cox.net> <20030402201914.6C7F2C587C@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030402201914.6C7F2C587C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 02, 2003 at 10:19:09PM +0200, Wolfgang Denk wrote:
>
> In message <20030402194622.GA30107@ip68-0-152-218.tc.ph.cox.net> you wrote:
> >
> > > It was orginally done for 8xx processors.  I suspect someone (I don't
> > > think it was me) :-) tried to consolidate 8xx and 82xx CPM configurations
> > > and messed it up.
> >
> > My guess and recollection is that the 8260 version of this was to
> > disable the DCACHE in a certain manner, because of buggy silicon on a
> > specific board.  Someone unmerged this bit of code later I think.
>
> It might have been me. We had problems on  the  first  prototypes  of
> TQM8260 boards; the board configuration with L2 cache would only work
> with  DC turned off. The problem disappeared with later silicon, so I
> never checked again what happened with the code.

So the question now is do you still care about this case, or can it go
away in the public tree?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
