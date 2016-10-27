Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4Pzg6HG3zDt3Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 22:38:55 +1100 (AEDT)
In-Reply-To: <20161024032043.22455-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: Use tlbiel only if we ever ran on the current cpu
Message-Id: <3t4Pzg56sCz9s3v@ozlabs.org>
Date: Thu, 27 Oct 2016 22:38:55 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-24-10 at 03:20:43 UTC, "Aneesh Kumar K.V" wrote:
> Before this patch, we used tlbiel, if we ever ran only on this core.
> That was mostly derived from the nohash usage of the same. But the
> ISA 3.0 clarifies tlbiel such that
> 
> "All TLB entries that have all of the following properties are made
> invalid on the thread executing the tlbiel instruction"
> 
> Hence use tlbiel, if we only ever ran on just the current cpu.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bd77c4498616e27d5725b5959d880c

cheers
