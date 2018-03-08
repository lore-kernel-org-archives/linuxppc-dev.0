Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxk671wcgzF1j7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 19:22:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>,
 Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH v3] powerpc/npu-dma.c: Fix deadlock in mmio_invalidate
In-Reply-To: <1790107.80T5BVHxd3@new-mexico>
References: <20180302051845.26844-1-alistair@popple.id.au>
 <1790107.80T5BVHxd3@new-mexico>
Date: Thu, 08 Mar 2018 19:22:52 +1100
Message-ID: <87bmfzdlib.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alistair Popple <alistair@popple.id.au> writes:

> Michael,
>
> This won't apply cleanly on top of Balbir's MMIO ATSD Flushing patch
> (https://patchwork.ozlabs.org/patch/848343/). I will resend a v4 which applies
> cleanly on top of that as the rebase/merge is non-trivial.

I have this (v3) merged in my testing branch (for next), so it might be
better to send me a new version of Balbir's patch which applies on top
of this.

cheers
