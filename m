Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlyx5N4PzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:17 +1100 (AEDT)
In-Reply-To: <20171016070140.4574-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/hash: Add pr_fmt() to hash_utils64.c
Message-Id: <3yWlyv60FGz9s7c@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-16 at 07:01:40 UTC, "Aneesh Kumar K.V" wrote:
> Make the printks look a bit nicer by adding a prefix.
> 
> Radix config now do
>  radix-mmu: Page sizes from device-tree:
>  radix-mmu: Page size shift = 12 AP=0x0
>  radix-mmu: Page size shift = 16 AP=0x5
>  radix-mmu: Page size shift = 21 AP=0x1
>  radix-mmu: Page size shift = 30 AP=0x2
> 
> This patch update hash config to do similar dmesg output. With the patch we have
> 
>  hash-mmu: Page sizes from device-tree:
>  hash-mmu: base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
>  hash-mmu: base_shift=12: shift=16, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=7
>  hash-mmu: base_shift=12: shift=24, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=56
>  hash-mmu: base_shift=16: shift=16, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=1
>  hash-mmu: base_shift=16: shift=24, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=8
>  hash-mmu: base_shift=20: shift=20, sllp=0x0111, avpnm=0x00000000, tlbiel=0, penc=2
>  hash-mmu: base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, tlbiel=0, penc=0
>  hash-mmu: base_shift=34: shift=34, sllp=0x0120, avpnm=0x000007ff, tlbiel=0, penc=3
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7f142661d41e5243c99c6ad2ff72aa

cheers
