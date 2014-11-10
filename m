Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F5071A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 17:57:17 +1100 (AEDT)
Message-ID: <1415602628.5769.17.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/2] Add IPMI support for powernv powerpc machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alistair Popple <alistair@popple.id.au>
Date: Mon, 10 Nov 2014 17:57:08 +1100
In-Reply-To: <11418996.omepm2UeRF@mexican>
References: <1415245107.292153.444216242273.0.gpush@pablo>
 <5460307C.9060502@ozlabs.org>
 <1415598090.5769.15.camel@kernel.crashing.org>
 <11418996.omepm2UeRF@mexican>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: openipmi-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 Jeremy Kerr <jk@ozlabs.org>, minyard@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-10 at 17:01 +1100, Alistair Popple wrote:
> Ben,
> 
> > 
> > Our OPAL interface can only do one at a time ? Because our underlying FW
> > driver already has a queue ..
> 
> The OPAL interface supports sending more than one message at a time using the 
> underlying FW queue as you suggest. However in theory the interface doesn't 
> make any response order guarantees, but in practice they should be ordered as 
> our BMC doesn't send out-of-order responses.

Can't we put some ID in the response message ? OPAL messages have
room...

Cheers,
Ben.

> Regards,
> 
> Alistair
> 
> > > > I'll look at doing that.  If that is the case, then your NULL check
> > > > for current message should probably be a BUG_ON().
> > > 
> > > OK, I'll update this when the msghandler bit is implemented.
> > > 
> > > > Do you need to handle any BMC flags?  Particularly incoming events?
> > > 
> > > Not at this stage - we may in future though.
> > > 
> > > Cheers,
> > > 
> > > 
> > > Jeremy
> > > _______________________________________________
> > > Linuxppc-dev mailing list
> > > Linuxppc-dev@lists.ozlabs.org
> > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
