Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYVLF5Qq8zDqhy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 23:22:29 +1000 (AEST)
In-Reply-To: <1495227395-13721-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: sbaskaran@nvidia.com, shailendras@nvidia.com,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: powernv/npu-dma.c: Fix opal_npu_destroy_context call
Message-Id: <3wYVLF4hDZz9s8V@ozlabs.org>
Date: Thu, 25 May 2017 23:22:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-05-19 at 20:56:35 UTC, Alistair Popple wrote:
> opal_npu_destroy_context() should be called with the NPU PHB, not the
> PCIe PHB.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/415ba3c157b9de7edc59468d19d48c

cheers
