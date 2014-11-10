Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id 91A021A0245
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 17:01:44 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] Add IPMI support for powernv powerpc machines
Date: Mon, 10 Nov 2014 17:01:16 +1100
Message-ID: <11418996.omepm2UeRF@mexican>
In-Reply-To: <1415598090.5769.15.camel@kernel.crashing.org>
References: <1415245107.292153.444216242273.0.gpush@pablo>
 <5460307C.9060502@ozlabs.org> <1415598090.5769.15.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: openipmi-developer@lists.sourceforge.net, Jeremy Kerr <jk@ozlabs.org>,
 minyard@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

> 
> Our OPAL interface can only do one at a time ? Because our underlying FW
> driver already has a queue ..

The OPAL interface supports sending more than one message at a time using the 
underlying FW queue as you suggest. However in theory the interface doesn't 
make any response order guarantees, but in practice they should be ordered as 
our BMC doesn't send out-of-order responses.

Regards,

Alistair

> > > I'll look at doing that.  If that is the case, then your NULL check
> > > for current message should probably be a BUG_ON().
> > 
> > OK, I'll update this when the msghandler bit is implemented.
> > 
> > > Do you need to handle any BMC flags?  Particularly incoming events?
> > 
> > Not at this stage - we may in future though.
> > 
> > Cheers,
> > 
> > 
> > Jeremy
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
