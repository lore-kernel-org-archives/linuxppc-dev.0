Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-231-monday.dmz.nerim.net
	[195.5.254.231]) by ozlabs.org (Postfix) with ESMTP id 9AB4C67B55
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 16:57:27 +1000 (EST)
Received: from kraid.nerim.net (smtp-101-monday.nerim.net [62.4.16.101])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id 5C4C13B76F
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 08:57:22 +0200 (CEST)
Date: Mon, 31 Jul 2006 08:57:24 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] I2C-MPC: Fix up error handling
Message-Id: <20060731085724.00447d21.khali@linux-fr.org>
In-Reply-To: <A18434C2-2C6F-4052-B3F3-AE9D2CE38BE3@kernel.crashing.org>
References: <20060609095421.7157dc53.khali@linux-fr.org>
	<20060730131440.1d4fcbe6.khali@linux-fr.org>
	<A18434C2-2C6F-4052-B3F3-AE9D2CE38BE3@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Munaut <tnt@246tNt.com>, Sylvain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Quoting myself:
> > > Could anyone please comment on this i2c-mpc patch, and give it some
> > > testing on different systems? I'm fine with the error propagation
> > > fixes, but less fine with the random resets being added, and rather
> > > unhappy with the "retry once more just in case" thing, which I think,
> > > if really needed, should instead be implemented using the standard
> > > i2c_adapter.retries mechanism.
> >
> > Can anyone please comment on this patch? Andrew Morton keeps  
> > forwarding it to me, but I don't think I can accept it as is (see
> > my complaints above.)
> 
> If I find some time, let me split out the error propagation so we can  
> get that fix up stream.  The other code was to handle a buggy device  
> that was connected in one system I was working on.

Sounds like a good plan, thanks.

-- 
Jean Delvare
