Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 31 Dec 2002 09:13:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel patch: 8xx FEC extensions
Message-ID: <20021231161305.GC12063@opus.bloom.county>
References: <20021231155241.GA12063@opus.bloom.county> <20021231155839.6D6F8C6139@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021231155839.6D6F8C6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 31, 2002 at 04:58:34PM +0100, Wolfgang Denk wrote:
> In message <20021231155241.GA12063@opus.bloom.county> you wrote:
> >
> > But I'll hold off on this section of the patch until everyone is happy.
>
> How do we _get_ happy, then?

Well, Dan thinks that dropping the 'violatile' here will do bad things,
you believe it will fix a problem, and I think it's fishy that a
volatile is needed here at all.  If you want to get just the multicast
stuff in, a seperate patch of just the multicast code would expidite
that.  For this particular problem I'd like you and Dan to agree on
something.

And BTW, the other patches haven't been committed yet only because my
machine with all of my bk trees on it is still being reinstalled.  They
will be as soon as I get the machine useable again. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
