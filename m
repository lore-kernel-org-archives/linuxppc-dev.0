Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 97EA02C007D
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2012 15:45:51 +1000 (EST)
Message-ID: <1347601540.2386.1.camel@pasglop>
Subject: Re: [PATCH] powerpc: Add an xmon command to dump one or all pacas
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 14 Sep 2012 15:45:40 +1000
In-Reply-To: <1347597870.6883.0.camel@concordia>
References: <1347436360-29095-1-git-send-email-michael@ellerman.id.au>
 <1347439541.2603.100.camel@pasglop> <1347597870.6883.0.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-09-14 at 14:44 +1000, Michael Ellerman wrote:
> On Wed, 2012-09-12 at 18:45 +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2012-09-12 at 17:52 +1000, Michael Ellerman wrote:
> > > This was originally motivated by a desire to see the mapping between
> > > logical and hardware cpu numbers.
> > > 
> > > But it seemed that it made more sense to just add a command to dump
> > > (most of) the paca.
> > > 
> > > With no arguments "dp" will dump the paca for all possible cpus. If
> > > there are no possible cpus, like early in boot, it will tell you that.
> > 
> > I'd rather "dp" dump the paca for the current active CPU in xmon.
> > Shouldn't be hard to make a "dpa" that dumps them all too.
> 
> OK.
> 
> I also want to be able to dump the paca of a cpu not in xmon, so I'll
> keep the "dp #" variant as well.

Yes, absolutely.

Cheers,
Ben.
