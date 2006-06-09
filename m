Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 929DE67B1C
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 02:09:56 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/10 v2] Add MPC8641 HPCN PCI and PCI-Express files. 
In-Reply-To: Your message of "Fri, 09 Jun 2006 14:33:15 +1000."
	<1149827596.12687.53.camel@localhost.localdomain>
References: <1149803866.23938.280.camel@cashmere.sps.mot.com>
	<1149827596.12687.53.camel@localhost.localdomain>
Date: Fri, 09 Jun 2006 11:09:51 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FojYV-0004O8-L0@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Benjamin Herrenschmidt mumbled:
> On Thu, 2006-06-08 at 16:57 -0500, Jon Loeliger wrote:
> > Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
> > Signed-off-by: Wei Zhang <Wei.Zhang@freescale.com>
> > Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> 
> There are various things in this code that duplicate names used by other
> platforms and thus makes the board unsuitable for use in a common
> kernel. That needs to be fixed. Try avoiding too generic names. Also,
> PCI Express shall be named "pcie" and not "pex" :)
> 
> I don't have time at the moment to go too deep in the details here.
> 
> Ben.

I will also prefix some routines with mpc86xx_ to avoid
the generic names problems.  But I'm not sure which other
platforms you expect this one kernel image to run on.
Specifically, this pcie code is very similar to the 8548
family, but not exactly the same.

My understanding is that we are shooting for a single 86xx
family kernel image here, with this 8641 HPCN platform being
the first such port.

I will s/pex/pcie/g and rename files accordingly.

jdl
