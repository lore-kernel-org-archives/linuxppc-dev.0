Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4B075DDE9F
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 09:22:51 +1100 (EST)
Date: Tue, 31 Mar 2009 15:22:37 -0700 (PDT)
Message-Id: <20090331.152237.210090951.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 00/14] Add common OF device tree support for MDIO busses
From: David Miller <davem@davemloft.net>
In-Reply-To: <fa686aa40903311519m3108c697v52180d192975a3b1@mail.gmail.com>
References: <20090331075537.1427.7819.stgit@localhost.localdomain>
	<20090331.145738.36845509.davem@davemloft.net>
	<fa686aa40903311519m3108c697v52180d192975a3b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: Joakim.Tjernlund@transmode.se, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, afleming@freescale.com, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 31 Mar 2009 16:19:42 -0600

> On Tue, Mar 31, 2009 at 3:57 PM, David Miller <davem@davemloft.net> wrote:
> > It therefore didn't get any -next exposure, so it's unreasonable to
> > merge this stuff now.
> 
> Since when has sitting in a -next tree been a requirement for merging
> when the series has been kept up to date and tested?  I purposefully
> kept it out of -next to ensure that when it was applied for real to a
> -next tree it would be as complete, bug free, and bisectable as
> possible since once it hits a signed-off -next branch the individual
> commit cannot be modified.

I know your pissed off, but take a deep breath and consider this
from my position.

If I don't put a line in the sand somewhere, everyone can say
"I've been working so hard, I posted it to the lists a thousand
times, I have tons of testers" and I have to put the change in.

That doesn't work, so please wait until the next release to get
your changes in.  And get them into a tree that gets exposure
in linux-next.  Then you have nothing to worry about.

Thank you.
