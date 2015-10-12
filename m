Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48DB91A0BE5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 22:21:22 +1100 (AEDT)
In-Reply-To: <1444291168-2360-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2] powerpc: Fix _ALIGN_* errors due to type difference.
Message-Id: <20151012112122.2F5E4140D7C@ozlabs.org>
Date: Mon, 12 Oct 2015 22:21:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-10 at 07:59:28 UTC, "Aneesh Kumar K.V" wrote:
> This avoid errors like
> 
>         unsigned int usize = 1 << 30;
>         int size = 1 << 30;
>         unsigned long addr = 64UL << 30 ;
> 
>         value = _ALIGN_DOWN(addr, usize); -> 0
>         value = _ALIGN_DOWN(addr, size);  -> 0x1000000000
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f78f7ed72632a0794161f290

cheers
