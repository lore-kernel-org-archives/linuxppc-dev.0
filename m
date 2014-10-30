Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0117.outbound.protection.outlook.com [157.56.110.117])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCC441A0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 17:18:36 +1100 (AEDT)
Message-ID: <5451D416.7030300@Freescale.com>
Date: Thu, 30 Oct 2014 01:00:54 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc: Remove bootmem allocator
References: <1410956137-4824-1-git-send-email-anton@samba.org>
In-Reply-To: <1410956137-4824-1-git-send-email-anton@samba.org>
Content-Type: text/plain; charset="windows-1252"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Anton,


On 09/17/2014 07:15 AM, Anton Blanchard wrote:
> At the moment we transition from the memblock alloctor to the bootmem
> allocator. Gitting rid of the bootmem allocator removes a bunch of
> complicated code (most of which I owe the dubious honour of being
> responsible for writing).
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Tested-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>  arch/powerpc/Kconfig             |   1 +
>  arch/powerpc/include/asm/setup.h |   3 +-
>  arch/powerpc/kernel/setup_32.c   |   5 +-
>  arch/powerpc/kernel/setup_64.c   |   3 +-
>  arch/powerpc/mm/init_32.c        |   9 --
>  arch/powerpc/mm/mem.c            |  62 +----------
>  arch/powerpc/mm/numa.c           | 224 ++++++---------------------------------
>  arch/powerpc/mm/pgtable_32.c     |   3 +-
>  arch/powerpc/mm/pgtable_64.c     |   6 +-
>  9 files changed, 43 insertions(+), 273 deletions(-)

Any idea on how to move these patches forward?


Cheers,
