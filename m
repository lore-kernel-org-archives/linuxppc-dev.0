Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6A357DDF19
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 22:53:18 +1100 (EST)
Subject: Re: [PATCH] PowerPC 4xx: Add dcri_clrset() for locked
	read/modify/write functionality
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <47CFD607.2000309@ru.mvista.com>
References: <20080305183804.GA21760@ru.mvista.com>
	<1204761978.21545.240.camel@pasglop>
	<20080305191216.5089f696@zod.rchland.ibm.com>
	<47CFD607.2000309@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 22:50:37 +1100
Message-Id: <1204804237.21545.257.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-03-06 at 14:31 +0300, Valentine Barshak wrote:
> Josh Boyer wrote:
> > On Thu, 06 Mar 2008 11:06:18 +1100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> >> On Wed, 2008-03-05 at 21:38 +0300, Valentine Barshak wrote:
> >>> This adds dcri_clrset() macro which does read/modify/write
> >>> on indirect dcr registers while holding indirect dcr lock.
> >>>
> >>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> >> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Indeed, looks good.  Valentine, are you going to rework your EMAC patch
> > to use this?
> > 
> > josh
> 
> Yes, I was going to update the pcie stuff and rework the emac patches.

The PCIe stuff is less of an issue as it happens early during boot,
there should be no race there, but it's still a good idea in the long
run. The EMAC bits look more like that kind of stuff we should have
ready asap for linux-next.

Cheers,
Ben.
