Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV5cd0TvTzDqjK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 22:37:05 +1000 (AEST)
In-Reply-To: <1465395958-21349-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2,
 07/10] powerpc/hash: Use the correct ppp mask when updating hpte
Message-Id: <3rV5cc5xBZz9t1P@ozlabs.org>
Date: Wed, 15 Jun 2016 22:37:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-06 at 14:25:55 UTC, "Aneesh Kumar K.V" wrote:
> With commit: e58e87adc8bf9 ("powerpc/mm: Update _PAGE_KERNEL_RO") we
> now use all the three PPP bits. The top bit is now used to have a
> PPP value of 0b110 which will be mapped to kernel read only. When
> updating the hpte entry use right mask such that we update the
> 63rd bit (top 'P' bit) too.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8550e2fa34f077c8a87cf1ba24

cheers
