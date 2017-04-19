Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7bd05qWkzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 08:04:20 +1000 (AEST)
In-Reply-To: <1492111101-12127-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/radix: Use mm->task_size for boundary checking instead
 of addr_limit
Message-Id: <3w7bd04k01z9s7n@ozlabs.org>
Date: Thu, 20 Apr 2017 08:04:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-13 at 19:18:21 UTC, "Aneesh Kumar K.V" wrote:
> We don't init addr_limit correctly for 32 bit applications. So default to using
> mm->task_size for boundary condition checking. We use addr_limit to only control
> free space search. This makes sure that we do the right thing with 32 bit
> applications.
> 
> We should consolidate the usage of TASK_SIZE/mm->task_size and
> mm->context.addr_limit later.
> 
> Partially reverts: fbfef9027c2a7ad (powerpc/mm: Switch some TASK_SIZE checks to use
> mm_context addr_limit)
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/be77e999e3937322b7e15274b8fc7d

cheers
