Return-Path: <alistair@popple.id.au>
Received: from ipmail03.adl2.internode.on.net (ipmail03.adl2.internode.on.net
 [150.101.137.141])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zxkwC5XzMzF1qS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 19:59:23 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH v3] powerpc/npu-dma.c: Fix deadlock in mmio_invalidate
Date: Thu, 08 Mar 2018 19:59:15 +1100
Message-ID: <12675054.vRa3gNARmY@new-mexico>
In-Reply-To: <87bmfzdlib.fsf@concordia.ellerman.id.au>
References: <20180302051845.26844-1-alistair@popple.id.au>
 <1790107.80T5BVHxd3@new-mexico> <87bmfzdlib.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, 8 March 2018 7:22:52 PM AEDT Michael Ellerman wrote:
> Alistair Popple <alistair@popple.id.au> writes:
> 
> > Michael,
> >
> > This won't apply cleanly on top of Balbir's MMIO ATSD Flushing patch
> > (https://patchwork.ozlabs.org/patch/848343/). I will resend a v4 which applies
> > cleanly on top of that as the rebase/merge is non-trivial.
> 
> I have this (v3) merged in my testing branch (for next), so it might be
> better to send me a new version of Balbir's patch which applies on top
> of this.

Will do. Thanks!

- Alistair

> cheers
> 
