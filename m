Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wh9pg1f68zDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 20:21:47 +1000 (AEST)
In-Reply-To: <20170310103701.850816799B@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/8xx: fix mpc8xx_get_irq() return on no irq
Message-Id: <3wh9pg11fbz9s7B@ozlabs.org>
Date: Mon,  5 Jun 2017 20:21:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-10 at 10:37:01 UTC, Christophe Leroy wrote:
> IRQ 0 is a valid HW interrupt. So get_irq() shall return 0 when
> there is no irq, instead of returning irq_linear_revmap(... ,0)
> 
> Fixes: f2a0bd3753dad ("[POWERPC] 8xx: powerpc port of core CPM PIC")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3c29b6038828c1f4c9ecbfec14d4fc

cheers
