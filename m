Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2042EDDE45
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 08:31:37 +1100 (EST)
Date: Wed, 28 Nov 2007 15:34:45 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 5/14] powerpc: Fix 440/440A machine check handling
Message-ID: <20071128213445.GA29962@lixom.net>
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121061714.0AB82DEAF1@ozlabs.org>
	<20071121071240.141d2917@weaponx>
	<1195674530.6970.86.camel@pasglop>
	<20071121135109.73b9e98f@weaponx>
	<1195675525.6970.100.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1195675525.6970.100.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 22, 2007 at 07:05:25AM +1100, Benjamin Herrenschmidt wrote:
> 
> On Wed, 2007-11-21 at 13:51 -0600, Josh Boyer wrote:
> > > Hrm... it's per processor, not per board. I didn't feel like digging
> > > which board uses which processor and go fixup all the ppc_md's
> > 
> > Sounds like something a generic function could probe for from the DTS.
> > I'll look at doing something here when I start making 44x
> > multiplatform
> > (soon).
> 
> Well... we already probe the CPU type.... from cputable.
> 
> So if there was a place to put that, it would be the cputable.

It could make sense to have _both_ platform (ppc_md) and cputable
functions, since some info is likely to be core-specific, other might
be board/chipset/SoC-specific.


-Olof
