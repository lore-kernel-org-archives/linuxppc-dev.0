Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD3D767C4E
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 08:08:05 +1000 (EST)
Subject: Re: [PATCH 4/10 v2] Guard L3CR references with CPU_FTR_L3CR.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1FojPE-0004Aj-0l@jdl.com>
References: <1149803912.23938.282.camel@cashmere.sps.mot.com>
	<1149826679.12687.44.camel@localhost.localdomain>
	<E1FojPE-0004Aj-0l@jdl.com>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 08:07:50 +1000
Message-Id: <1149890870.12687.68.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-09 at 11:00 -0500, Jon Loeliger wrote:
> So, like, the other day Benjamin Herrenschmidt mumbled:
> > On Thu, 2006-06-08 at 16:58 -0500, Jon Loeliger wrote:
> > > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> > 
> > Beware about this one... the CPU setup code might run before the feature
> > fixup in the future...
> > ...
> > or go read the feature bit directly in the structure
> > rather than relying on the fixup mecanism.
> 
> OK.
> 
> > you should probably do a separate setup function for your core
> 
> Truth be told, this is a pretty generic fix for other
> parts as well. If I recall correctly, 7447, 7448, 7448A and 7450
> as well as the new 8641 now.
> 
> But I can certainly introduce a new setup function here
> if you think that is the right thing to do.  No problem.

No, go for the generic fix.

Ben.
