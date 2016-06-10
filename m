Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQndh2H2rzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 13:26:32 +1000 (AEST)
In-Reply-To: <1463644472-10158-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [4/6] powerpc/mm/hash: Compute the segment size correctly for ISA
 3.0
Message-Id: <3rQndh1BTCz9sdQ@ozlabs.org>
Date: Fri, 10 Jun 2016 13:26:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-19-05 at 07:54:30 UTC, "Aneesh Kumar K.V" wrote:
> PowerISA 3.0 encodes the segment size in the second half of hash page
> table entry. Update hpte_decode accordingly.
> 
> Fixes: 50de596de8be ("powerpc/mm/hash: Add support for Power9 Hash")
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/3b6d1eb7ea65f4aa64115cf9ba

cheers
