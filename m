Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 79EAD67A04
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Apr 2006 06:29:17 +1000 (EST)
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to
	1GB, V2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Mason <jdmason@us.ibm.com>
In-Reply-To: <20060415133752.GB7712@us.ibm.com>
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
	<20060413025233.GE24769@pb15.lixom.net>
	<20060413064027.GH10412@granada.merseine.nu>
	<1144925149.4935.14.camel@localhost.localdomain>
	<20060413160712.GG24769@pb15.lixom.net>
	<20060413173121.GJ10412@granada.merseine.nu>
	<1144961564.4935.24.camel@localhost.localdomain>
	<20060414144830.GQ10412@granada.merseine.nu>
	<1145048275.4223.32.camel@localhost.localdomain>
	<20060415133752.GB7712@us.ibm.com>
Content-Type: text/plain
Date: Sun, 16 Apr 2006 06:28:55 +1000
Message-Id: <1145132935.4233.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-04-15 at 08:37 -0500, Jon Mason wrote:
> On Sat, Apr 15, 2006 at 06:57:55AM +1000, Benjamin Herrenschmidt wrote:
> > 
> > > What I had in mind is an interface that given a PCI bridge will tell
> > > you what's the most restrictive DMA mask for a device on that bridge,
> > > so that you'll know whether you need to enable the IOMMU for that
> > > bridge. I'll even settle for a function that tells you what's the most
> > > restrictive DMA mask in the system, period. There's nothing inherently
> > > arch specific about this.
> > >
> > > (and as a side note, the IOMMU we are working on on x86-64 is Calgary,
> > > which is actually roughly the same chipset used in some PPC
> > > machines...)
> > 
> > Not sure I ever heard about that... What chipsets ?
> 
> The pSeries POWER4 based systems (Regatta) had Calgary, and the 
> RS/6000 POWER3 based systems (Condor) had Winnipeg (a precursor to
> Calgary, with many of the same features).

Ah ok, I'm not familiar with the IBM chipset names

Ben.
