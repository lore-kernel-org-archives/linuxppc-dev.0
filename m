Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 74D72DE30F
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 17:44:04 +1000 (EST)
Date: Wed, 06 Aug 2008 00:44:03 -0700 (PDT)
Message-Id: <20080806.004403.108134255.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080806174233.3da5daea.sfr@canb.auug.org.au>
References: <1218003249.7893.19.camel@localhost>
	<fa686aa40808052334m2946298aw453afce8b47e6bf7@mail.gmail.com>
	<20080806174233.3da5daea.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 6 Aug 2008 17:42:33 +1000

> Hi Grant,
> 
> On Wed, 6 Aug 2008 00:34:04 -0600 "Grant Likely" <grant.likely@secretlab.ca> wrote:
> >
> > On Wed, Aug 6, 2008 at 12:14 AM, Michael Ellerman
> > <michael@ellerman.id.au> wrote:
> > > On Wed, 2008-08-06 at 00:02 -0600, Grant Likely wrote:
> > >> From: Grant Likely <grant.likely@secretlab.ca>
> > >>
> > >> of_lookup_stdout() is useful for figuring out what device to use as output
> > >> for early boot progress messages.  It returns the node pointed to by the
> > >> linux,stdout-path property in the chosen node.
> > >
> > > Nice. You don't feel like converting all the places that currently do it
> > > by hand to use this do you :)
> > 
> > Yep, I'll do this.  :-)
> 
> Could you also send an email to Dave Miller to see if he has any objections
> to this function being generic (since the Sparc guys share this code).

I already voiced my concerns.
