Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CC491A0CA4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:40:09 +1100 (AEDT)
In-Reply-To: <1456805714-21774-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [3/4] powerpc/mm: Switch book3s 64 with 64K page size to 4 level
 page table
Message-Id: <20160304004008.F35CC141B86@ozlabs.org>
Date: Fri,  4 Mar 2016 11:40:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-01-03 at 04:15:13 UTC, "Aneesh Kumar K.V" wrote:
> This is needed so that we can support both hash and radix page table
> using single kernel. Radix kernel uses a 4 level table.
> 
> We now use physical address in upper page table tree levels. Even though
> they are aligned to their size, for the masked bits we use the
> bit positions as per PowerISA 3.0.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/368ced78e6ed3d72c2acc61233

cheers
