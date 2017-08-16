Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTFN4d1SzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:30:00 +1000 (AEST)
In-Reply-To: <20170815034636.29898-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm/nohash: add definition of PGALLOC_GFP
Message-Id: <3xXTFN2wnDz9t5V@ozlabs.org>
Date: Wed, 16 Aug 2017 22:30:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-15 at 03:46:36 UTC, Balbir Singh wrote:
> fixes
> (de3b876 powerpc/mm/book(e)(3s)/64: Add page table accounting)
> 
> I missed adding PGALLOC_GFP for nohash/64
> 
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5b6c133e0801007117cf4a466cb56d

cheers
