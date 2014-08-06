Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98FFA1A0445
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 06:46:25 +1000 (EST)
Message-ID: <1407357967.3073.103.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/nohash: Split __early_init_mmu() into boot
 and secondary
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 07 Aug 2014 06:46:07 +1000
In-Reply-To: <1407355754.7427.36.camel@snotra.buserror.net>
References: <1406948861-11322-1-git-send-email-scottwood@freescale.com>
 <1406948861-11322-2-git-send-email-scottwood@freescale.com>
 <1407213410.19150.65.camel@pasglop>
 <1407286090.7427.19.camel@snotra.buserror.net>
 <1407301138.3073.68.camel@pasglop>
 <1407355754.7427.36.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-06 at 15:09 -0500, Scott Wood wrote:
> BTW, is there a particular reason why we need to use
> memblock_enforce_memory_limit() on FSL_BOOK3E, rather than relying on
> memblock_set_current_limit()?  I see that when
> memblock_enforce_memory_limit() was added to __early_init_mmu(),
> memblock_set_current_limit() did not exist.  On 32-bit fsl booke uses
> memblock_set_current_limit() for this.

I don't remember. I don't even know what the difference is, I can
have a look later if you want but I'd rather you did :-)

Cheers,
Ben.
