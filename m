Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 765C2DDE21
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 08:56:14 +1000 (EST)
Date: Wed, 11 Apr 2007 17:56:07 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 1/4] powerpc: document max-speed and interface-type
	properties
Message-Id: <20070411175607.5ef11341.kim.phillips@freescale.com>
In-Reply-To: <006a01c77c82$bd304b40$6667a8c0@Jocke>
References: <20070410165639.1b619c34.kim.phillips@freescale.com>
	<006a01c77c82$bd304b40$6667a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 11 Apr 2007 23:45:36 +0200
"Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:

> 
> > +   - interface-type : a string naming the controller/PHY 
> > interface type,
> > +     i.e., one of "mii", "gmii", "sgmii", "tbi", "rmii", 
> > "rgmii", or "rtbi".
> 
> Hmm, what if I have a direct MII to MII connection without a PHY in between?

that would depend on the connection itself (and how you wanted your UCC configured).  It would still be one of the above, since those are what the UCC supports.

> Will this support such a "fixed" connection?

I don't see why not.

> How do I express that in OF speak?

omit the PHY node?

Kim
