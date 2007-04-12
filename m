Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id E33F5DDED0
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 16:49:15 +1000 (EST)
Subject: Re: [PATCH 1/4] powerpc: document max-speed and interface-type
	properties
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20070411175607.5ef11341.kim.phillips@freescale.com>
References: <20070410165639.1b619c34.kim.phillips@freescale.com>
	<006a01c77c82$bd304b40$6667a8c0@Jocke>
	<20070411175607.5ef11341.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 08:49:13 +0200
Message-Id: <1176360553.12080.92.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-11 at 17:56 -0500, Kim Phillips wrote:
> On Wed, 11 Apr 2007 23:45:36 +0200
> "Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:
> 
> > 
> > > +   - interface-type : a string naming the controller/PHY 
> > > interface type,
> > > +     i.e., one of "mii", "gmii", "sgmii", "tbi", "rmii", 
> > > "rgmii", or "rtbi".
> > 
> > Hmm, what if I have a direct MII to MII connection without a PHY in between?
> 
> that would depend on the connection itself (and how you wanted your UCC configured).  It would still be one of the above, since those are what the UCC supports.
> 
Right, should be mii then.

> > Will this support such a "fixed" connection?
> 
> I don't see why not.
Great.
> 
> > How do I express that in OF speak?
> 
> omit the PHY node?
> 
hmm, don't think so. I need to define a pseudo PHY of sorts but I
don't know how yet.

 Jocke

> Kim
> 
> 
