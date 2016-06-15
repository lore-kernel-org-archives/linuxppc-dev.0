Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV5cb2f7rzDqjK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 22:37:03 +1000 (AEST)
In-Reply-To: <1465395958-21349-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2, 02/10] powerpc/mm/radix: Update to tlb functions ric argument
Message-Id: <3rV5cb1MMwz9t1T@ozlabs.org>
Date: Wed, 15 Jun 2016 22:37:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-06 at 14:25:50 UTC, "Aneesh Kumar K.V" wrote:
> Radix invalidate control (RIC) is used to control which cache to flush
> using tlb instructions. When doing a PID flush, we currently flush
> everything including page walk cache. For address range flush, we flush
> only the TLB. In the later patch, we add support for flushing only
> page walk cache.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/36194812a4063dd2a72070aec3

cheers
