Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkKq70KhGzDqk0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 23:29:55 +1000 (AEST)
In-Reply-To: <1502432577-5911-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, stable@vger.kernel.org,
 arbab@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, sbaskaran@nvidia.com,
 fbarrat@linux.vnet.ibm.com
Subject: Re: [1/2] powerpc/powernv/npu: Move tlb flush before launching ATSD
Message-Id: <3xkKq607C8z9t2d@ozlabs.org>
Date: Fri,  1 Sep 2017 23:29:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-08-11 at 06:22:56 UTC, Alistair Popple wrote:
> The nest mmu tlb flush needs to happen before the GPU translation shootdown
> is launched to avoid the GPU refilling its tlb with stale nmmu translations
> prior to the nmmu flush completing.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Cc: stable@vger.kernel.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bab9f954aaf352127725a9b7920226

cheers
