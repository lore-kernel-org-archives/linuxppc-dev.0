Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9001BDDE9E
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 07:44:22 +1100 (EST)
Message-Id: <32B523EF-18CD-44BD-8B00-FEE38443B481@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: update powerpc.git next and pull in some of benh's mmu patches
Date: Mon, 15 Dec 2008 14:44:12 -0600
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Can you update powerpc.git to linus's top of tree (we need the  
tlbil_va patch Linus picked up).

Also, can you pull in my next tree and some of Ben's trivial mmu  
related changes:

1/16 powerpc: Fix bogus cache flushing on all 40x and BookE processors  
v2	-- in my next tree (pull request sent)
2/16 powerpc: Fix asm EMIT_BUG_ENTRY with !CONFIG_BUG
4/16 powerpc/fsl-booke: Fix problem with _tlbil_va	-- pick up via  
update to linus head
5/16 powerpc/mm: Add local_flush_tlb_mm() to SW loaded TLB  
implementations -- ack'd
8/16 powerpc/mm: Rename tlb_32.c and tlb_64.c to tlb_hash32.c and  
tlb_hash64.c -- looks like a pure move
10/16 powerpc/mm: Remove flush_HPTE()

Patches I want to still review and test:

6/16 powerpc/mm: Split mmu_context handling v3
7/16 powerpc/mm: Rework context management for CPUs with no hash table  
v2
9/16 powerpc/mm: Introduce MMU features v2
11/16 powerpc/mm: Add SMP support to no-hash TLB handling v3
12/16 powerpc/mm: Split low level tlb invalidate for nohash processors
14/16 powerpc/mm: Runtime allocation of mmu context maps for nohash  
CPUs v2
15/16 powerpc/mm: Rework usage of _PAGE_COHERENT/NO_CACHE/GUARDED

Pathces left up to Josh & Ben

3/16 powerpc/4xx: Extended DCR support v2
13/16 powerpc/44x: No need to mask MSR:CE, ME or DE in _tlbil_va on 440
16/16 powerpc/44x: 44x TLB doesn't need "Guarded" set for all pages

- k
