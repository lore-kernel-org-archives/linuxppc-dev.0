Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61CA3DDF86
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 10:27:45 +1100 (EST)
Subject: Re: update powerpc.git next and pull in some of benh's mmu patches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <32B523EF-18CD-44BD-8B00-FEE38443B481@freescale.com>
References: <32B523EF-18CD-44BD-8B00-FEE38443B481@freescale.com>
Content-Type: text/plain
Date: Tue, 16 Dec 2008 10:25:29 +1100
Message-Id: <1229383529.26324.131.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Patches I want to still review and test:
> 
> 6/16 powerpc/mm: Split mmu_context handling v3
> 7/16 powerpc/mm: Rework context management for CPUs with no hash table  
> v2
> 9/16 powerpc/mm: Introduce MMU features v2
> 11/16 powerpc/mm: Add SMP support to no-hash TLB handling v3
> 12/16 powerpc/mm: Split low level tlb invalidate for nohash processors
> 14/16 powerpc/mm: Runtime allocation of mmu context maps for nohash  
> CPUs v2
> 15/16 powerpc/mm: Rework usage of _PAGE_COHERENT/NO_CACHE/GUARDED

New variants of the above coming. Note that pretty much any patch
touching cputable will break the mmu features patch, which is a pain to
fixup. The patch is based on -top- of the DCR stuff which touches
cputable, so please, Josh, review it asap so it can go in as a
pre-req :-)

Cheers,
Ben.
