Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6415DDE21
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 19:31:41 +1000 (EST)
Subject: Re: [RFC/PATCH] Block device for the ISS simulator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20081003083522.GB25683@infradead.org>
References: <20081003000904.0A812DDEEE@ozlabs.org>
	<20081003083522.GB25683@infradead.org>
Content-Type: text/plain
Date: Fri, 03 Oct 2008 19:29:40 +1000
Message-Id: <1223026180.12264.174.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-03 at 04:35 -0400, Christoph Hellwig wrote:
> On Fri, Oct 03, 2008 at 10:08:42AM +1000, Benjamin Herrenschmidt wrote:
> > The ISS simulator is a simple powerpc simulator used among other things
> > for hardware bringup. It implements a simple memory mapped block device
> > interface.
> > 
> > This is a simple block driver that attaches to it. Note that the choice
> > of a major device number is fishy, though because it's a simulator and
> > not real hardware, it's not necessarily a big deal.
> 
> Please don't put in more block devices for every bloody simulator in the
> world.  Just emulated some simpler enough existing hardware.

I'm not sure I want it merged, but having it on the list "for the
record" is useful and it might be useful to get comments in case it's
terminally busted :-)

I'm trying to get ISS to implement an IDE interface in fact.

Cheers,
Ben.
