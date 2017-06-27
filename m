Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxlZJ4VLRzDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 22:28:08 +1000 (AEST)
In-Reply-To: <1497947848-4625-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, mhairgrove@nvidia.com
Subject: Re: powernv/npu-dma.c: Add explicit flush when sending an ATSD
Message-Id: <3wxlZJ2vYCz9s74@ozlabs.org>
Date: Tue, 27 Jun 2017 22:28:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-20 at 08:37:28 UTC, Alistair Popple wrote:
> NPU2 requires an extra explicit flush to an active GPU PID when sending
> address translation shoot downs (ATSDs) to reliably flush the GPU TLB. This
> patch adds just such a flush at the end of each sequence of ATSDs.
> 
> We can safely use PID 0 which is always reserved and active on the GPU. PID
> 0 is only used for init_mm which will never be a user mm on the GPU. To
> enforce this we add a check in pnv_npu2_init_context() just in case someone
> tries to use PID 0 on the GPU.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bbd5ff50afffcf4a01d05367524736

cheers
