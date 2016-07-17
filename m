Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsjFL1fVbzDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 20:28:22 +1000 (AEST)
In-Reply-To: <1468402531-4914-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [for-4.8,01/12] Fix .long's in mm/tlb-radix.c to more meaningful
Message-Id: <3rsjFL0yGWz9t0J@ozlabs.org>
Date: Sun, 17 Jul 2016 20:28:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-07 at 09:35:20 UTC, "Aneesh Kumar K.V" wrote:
> From: Balbir Singh <bsingharora@gmail.com>
> 
> The .longs with the shifts are harder to read, use more
> meaningful names for the opcodes. PPC_TLBIE_5 is introduced
> for the 5 opcode variation of the instruction due to an existing
> op-code for the 2 opcode variant
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Patches 1-10 and 12 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8cd6d3c23e226ec6cb8825e1aa

cheers
