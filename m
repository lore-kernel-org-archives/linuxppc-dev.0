Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A6FF1DE05E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 08:59:51 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBDLxlJc006377
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 16:59:47 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBDLxlWR131776
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 14:59:47 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBDLxlur016911
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 14:59:47 -0700
Date: Thu, 13 Dec 2007 15:59:46 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 19/20] [POWERPC] pci32: 4xx embedded platforms want to
	reassign all PCI resources
Message-ID: <20071213155946.0e0c39a0@weaponx>
In-Reply-To: <1197581846.15741.183.camel@pasglop>
References: <20071213073851.C321FDDFC9@ozlabs.org>
	<20071213130113.59342c40@weaponx>
	<1197578243.15741.150.camel@pasglop>
	<20071213144056.1a46b7a3@weaponx>
	<1197579177.15741.169.camel@pasglop>
	<20071213151138.02db0cd8@weaponx>
	<1197581846.15741.183.camel@pasglop>
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

On Fri, 14 Dec 2007 08:37:26 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Thu, 2007-12-13 at 15:11 -0600, Josh Boyer wrote:
> > Well, there is physical PCI hardware on the boards, yes.  But what if
> > people have no intention of using it?  E.g. they have no devices, etc.
> > Now we're requiring PCI support to be built into the kernel.
> > 
> > I'm just being pedantic about keeping embedded tiny.
> 
> Keeping your embedded design tiny (and thus your own BSP) is one thing,
> but adding ifdef's all over the place so that somebody can tinify an
> eval board, I'm less sure about this... but if you want, you can fixup
> my patches.

I'm not really advocating for ifdefs.  If it annoys me enough (which I
doubt it will), then I'd try to come up with some way to avoid those
too.  For now, I think selecting PCI in Kconfig for those boards is OK.

josh
