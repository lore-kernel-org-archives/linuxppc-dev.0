Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F9AA1A0CB4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 18:14:10 +1000 (AEST)
Message-ID: <55C85D51.5080903@ozlabs.org>
Date: Mon, 10 Aug 2015 16:14:09 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/5] powerpc/cell: Drop support for 64K local store on
 4K kernels
References: <1438928387-6454-1-git-send-email-mpe@ellerman.id.au>
 <1438928387-6454-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1438928387-6454-2-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> Back in the olden days we added support for using 64K pages to map the
> SPU (Synergistic Processing Unit) local store on Cell, when the main
> kernel was using 4K pages.
> 
> This was useful at the time because distros were using 4K pages, but
> using 64K pages on the SPUs could reduce TLB pressure there.
> 
> However these days the number of Cell users is approaching zero, and
> supporting this option adds unpleasant complexity to the memory
> management code.
> 
> So drop the option, CONFIG_SPU_FS_64K_LS, and all related code.

Yep, I'd be happy to drop this - impact should be little to none.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy
