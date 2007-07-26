Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 72C10DDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 02:05:04 +1000 (EST)
Date: Thu, 26 Jul 2007 11:04:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Zang Roy-r61911 <tie-fei.zang@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: Fwd: [PATCH] bootwrapper: adds cuboot for MPC7448HPC2 platform
Message-ID: <20070726160455.GA28491@ld0162-tx32.am.freescale.net>
References: <1184144056.23579.16.camel@localhost.localdomain>
	<B37B73EC-54FE-442C-A1FF-348D89D3D840@kernel.crashing.org>
	<20070726065902.GD1149@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070726065902.GD1149@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 04:59:02PM +1000, David Gibson wrote:
> > >+#define TARGET_HAS_ENET1
> > >+#include "ppcboot.h"
> 
> Including ppcboot.h without first defining TARGET_* defines which give
> the type of system seems... fragile at best, broken at worst.  Surely
> this can only work by accident.

What target do you suggest he define?  There happen to be none in
ppcboot.h that are appropriate, because there are no special fields for
this target (other than eth1).

And yes, it's fragile -- the entire bd_t mechanism is fragile.  In the
absence of a time machine, there's not much we can do about it other than
encourage people to upgrade their u-boot.

-Scott
