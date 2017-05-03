Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHJ2FRTzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:18:52 +1000 (AEST)
In-Reply-To: <1487152194-19382-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: dja@axtens.net
Subject: Re: powerpc: Document irq enable/disable toggle in migrate_irqs()
Message-Id: <3wJCHJ0Q4Xz9s0Z@ozlabs.org>
Date: Thu,  4 May 2017 08:18:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-15 at 09:49:54 UTC, Michael Ellerman wrote:
> This code is undocumented and unclear, and we've already had one patch
> sent to remove it because it's "paradoxical and unnecessary". So
> document it to save our future selves from puzzling over it.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/687b8f24f14db842c8c3f8cb8b24c9

cheers
