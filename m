Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69C031A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 17:47:10 +1000 (AEST)
In-Reply-To: <1439449674-32191-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: khandual@linux.vnet.ibm.com
Subject: Re: [v2] powerpc/slb: Define an enum for the bolted indexes
Message-Id: <20151002074710.14F741409A0@ozlabs.org>
Date: Fri,  2 Oct 2015 17:47:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-13-08 at 07:07:54 UTC, Michael Ellerman wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> This patch defines macros for the three bolted SLB indexes we use.
> Switch the functions that take the indexes as an argument to use the
> enum.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/1d15010c349a26640e8f2495

cheers
