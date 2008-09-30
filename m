Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07BD7DDDF4
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 17:23:19 +1000 (EST)
Subject: Re: Please pull from 'dma' branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <295973D9-5AD2-47A3-B858-CED501169D86@kernel.crashing.org>
References: <Pine.LNX.4.64.0809241652540.22678@blarg.am.freescale.net>
	<295973D9-5AD2-47A3-B858-CED501169D86@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 30 Sep 2008 17:23:13 +1000
Message-Id: <1222759393.9006.49.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Becky Bruce (5):
> >      powerpc: Rename dma_64.c to dma.c
> >      powerpc: Move iommu dma ops from dma.c to dma-iommu.c
> >      powerpc: Drop archdata numa_node
> >      powerpc: Merge 32 and 64-bit dma code
> >      powerpc: Make dma_addr_t a u64 if CONFIG_PHYS_64BIT is set
> 
> Paul,
> 
> poke..

Paul's on leave this week, I'll pick up your stuff.

Cheers,
Ben.
