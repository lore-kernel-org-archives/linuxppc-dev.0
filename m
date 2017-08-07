Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQvGn4FstzDqp1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 20:41:53 +1000 (AEST)
In-Reply-To: <20170720172606.3811-1-victora@linux.vnet.ibm.com>
To: victora <victora@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: victora@br.ibm.com, mauricfo@linux.vnet.ibm.com, victora@linux.vnet.ibm.com
Subject: Re: powerpc/kernel: Avoid preemption check during iommu_range_alloc
Message-Id: <3xQvGn0rbmz9tWP@ozlabs.org>
Date: Mon,  7 Aug 2017 20:41:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-20 at 17:26:06 UTC, victora wrote:
> Replaced __this_cpu_read function call by raw_cpu_read in
> iommu_range_alloc function.
> Preemption doesn't need to be disabled since any CPU can safely
> use IOMMU pool.
> 
> Signed-off-by: Victor Aoqui <victora@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/75f327c6b75715f3a090daeb33e050

cheers
