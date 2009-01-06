Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A138FDE2CE
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 11:05:35 +1100 (EST)
Date: Mon, 05 Jan 2009 16:05:35 -0800 (PST)
Message-Id: <20090105.160535.24967514.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] net/ehea: bitops work on unsigned longs
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090106105951.62b0429d.sfr@canb.auug.org.au>
References: <20081231141853.c6d123c4.sfr@canb.auug.org.au>
	<20081230.215156.151347026.davem@davemloft.net>
	<20090106105951.62b0429d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, netdev@vger.kernel.org, raisch@de.ibm.com,
	themann@de.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 6 Jan 2009 10:59:51 +1100

> Hi Dave,
> 
> On Tue, 30 Dec 2008 21:51:56 -0800 (PST) David Miller <davem@davemloft.net> wrote:
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Wed, 31 Dec 2008 14:18:53 +1100
> > 
> > > These changes will avoid several warnings when we change u64 to unsigned
> > > long long.
> > > 
> > > Also, ehea_driver_flags is only used in ehca_main.c
> > > 
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > 
> > And also rejected, just like the previous two.
> > 
> > This is so much worse than the problems we had with
> > printing u64's and it's being done as a result to
> > the "fix" for that.
> 
> How is this worse than anything?  The only thing wrong with this patch is
> the commit message ... Lets try this (if this doesn't address your
> problems, then assume I am too dense for your original explanation):

Aha, yes the commit message fooled me :-)  New patch is fine and
I'll toss this into net-2.6
