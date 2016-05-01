Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qySJf21VLzDqB3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 May 2016 23:02:26 +1000 (AEST)
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com,
 Doug Ledford <dledford@redhat.com>, Sean Hefty <sean.hefty@intel.com>,
 Hal Rosenstock <hal.rosenstock@gmail.com>, linux-rdma@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: Re: [v3,
 01/70] IB/qib: Use cache inhibitted and guarded mapping on powerpc
Message-Id: <3qySJd6HqVz9t3w@ozlabs.org>
Date: Sun,  1 May 2016 23:02:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-29-04 at 13:25:24 UTC, Michael Ellerman wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> The driver was requesting for a writethrough mapping. But with those
> flags we will end up with an SAO mapping because we now have memory
> conherence always enabled. ie, the existing mapping will end up with a
> WIMG value 0b1110 which is Strong Access Order.
> 
> Update this to use cache inhibitted guarded mapping.
> 
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Sean Hefty <sean.hefty@intel.com>
> Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Acked-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/8ffb4103f5e28d7e7890ed4774

cheers
