Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZx115GNdzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 19:26:29 +1000 (AEST)
In-Reply-To: <1466143836-10034-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2] powerpc/mm/radix: Update Radix tree size as per ISA 3.0
Message-Id: <3rZx114DFqz9t1J@ozlabs.org>
Date: Thu, 23 Jun 2016 19:26:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-17-06 at 06:10:36 UTC, "Aneesh Kumar K.V" wrote:
> ISA 3.0 updated it to be encoded as Radix tree size = 2^(RTS + 31). We
> have it encoded as 2^(RTS + 28). Add a helper with the correct encoding
> and use it instead of opencoding.
> 
> Fixes commit 2bfd65e45e87 ("powerpc/mm/radix: Add radix callbacks for
> early init routine ")
> 
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b23d9c5b9c83c05e013aa52460

cheers
