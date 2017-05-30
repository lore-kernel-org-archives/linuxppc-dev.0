Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcSXH375tzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 19:11:27 +1000 (AEST)
In-Reply-To: <20170519054641.12406-1-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Add HAVE_IRQ_TIME_ACCOUNTING
Message-Id: <3wcSXG6k2gz9s7h@ozlabs.org>
Date: Tue, 30 May 2017 19:11:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-05-19 at 05:46:41 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> Allow us to enable IRQ_TIME_ACCOUNTING. Even though we currently
> use VIRT_CPU_ACCOUNTING_NATIVE, that option is quite heavy
> weight and IRQ_TIME_ACCOUNTING might be better in some cases.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/518470fe962e23ca69a818e1e507eb

cheers
