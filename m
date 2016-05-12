Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r59p36w60zDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 21:32:43 +1000 (AEST)
In-Reply-To: <1463032030-38974-3-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [kernel,2/2] powerpc/powernv/npu: Add PE to PHB's list
Message-Id: <3r59p35T8Zz9vKN@ozlabs.org>
Date: Thu, 12 May 2016 21:32:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-05 at 05:47:10 UTC, Alexey Kardashevskiy wrote:
> Before 3e68dc57 "powerpc/powernv: Remove DMA32 PE list", NPU PEs
> were linked to the NPU PHB via phb->ioda.pe_dma_list; after that fix,
> the phb->ioda.pe_list is used.
> 
> During the pe_dma_list removal, list_add_tail(&phb->ioda.pe_dma_list)
> was removed, however no list_add() was added so does this patch.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1d4e89cf0a4e819fbde428e9e5

cheers
