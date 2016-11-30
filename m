Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTWJF4V2RzDvpJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 06:51:25 +1100 (AEDT)
In-Reply-To: <b8a934c7-899f-a320-31d5-5f2889f77d6c@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/radix/mm: Fixup storage key mm fault
Message-Id: <3tTWJF28vWz9snk@ozlabs.org>
Date: Thu,  1 Dec 2016 06:51:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-30 at 00:35:36 UTC, Balbir Singh wrote:
> Aneesh/Ben reported that the change to do_page_fault() needs
> to handle the case where CPU_FTR_COHERENT_ICACHE is missing
> but we have CPU_FTR_NOEXECUTE. In those cases the check
> added for SRR1_ISI_N_OR_G might trigger a false positive.
> 
> This patch checks for CPU_FTR_COHERENT_ICACHE in addition
> to the MSR value
> 
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0ab5171b8971282d7562b77f9b1413

cheers
