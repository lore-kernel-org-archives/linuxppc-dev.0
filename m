Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79A061A03E1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:15:59 +1100 (AEDT)
In-Reply-To: <874mgsoddp.fsf@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: set IRQF_NO_THREAD for xmon/cascade handlers
Message-Id: <20151126121559.64C07140316@ozlabs.org>
Date: Thu, 26 Nov 2015 23:15:59 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-11-11 at 13:48:50 UTC, John Ogness wrote:
> The xmon and cascade irq handlers must not run as threads.
> pmac_pic_lock is already a raw_spinlock, but the irq flag
> IRQF_NO_THREAD needs to be set as well.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/57f889471c0fb55cbb0db98b

cheers
