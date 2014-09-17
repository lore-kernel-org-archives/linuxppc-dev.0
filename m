Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D45D1A0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 22:08:23 +1000 (EST)
Date: Wed, 17 Sep 2014 22:08:22 +1000
From: Anton Blanchard <anton@samba.org>
To: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [PATCH 3/5] powerpc: Remove superfluous bootmem includes
Message-ID: <20140917220822.30daa277@kryten>
In-Reply-To: <54194B21.6050105@Freescale.com>
References: <1410933504-28564-1-git-send-email-anton@samba.org>
 <1410933504-28564-3-git-send-email-anton@samba.org>
 <54194B21.6050105@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Emil,

> While building corenet64_smp I get this:
> 
> > ../arch/powerpc/mm/pgtable_64.c: In function 'early_alloc_pgtable':
> > ../arch/powerpc/mm/pgtable_64.c:77:95: error: 'MAX_DMA_ADDRESS'
> > undeclared (first use in this
> > function) ../arch/powerpc/mm/pgtable_64.c:77:95: note: each
> > undeclared identifier is reported only once for each function it
> > appears in
> 
> Adding '#include <asm/dma.h>' seems to fix it
> 
> Other than that, for the entire set:
> 
> Tested-by: Emil Medve <Emilian.Medve@Freescale.com>

Thanks for testing! I'll respin the patch with that include added.

Anton
