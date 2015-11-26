Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4E181A0373
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:15:57 +1100 (AEDT)
In-Reply-To: <87lha4fwrc.fsf@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Campbell <ian.campbell@citrix.com>,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc: IRQF_NO_SUSPEND not IRQF_TIMER for non-timer
Message-Id: <20151126121557.58BA614031E@ozlabs.org>
Date: Thu, 26 Nov 2015 23:15:57 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-11-11 at 14:15:03 UTC, John Ogness wrote:
> Since gpio1 is not a timer, it also should not use IRQF_TIMER.
> 
> Similar to commit ba461f094bab ("powerpc: Use IRQF_NO_SUSPEND not
> IRQF_TIMER for non-timer interrupts").
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6c3082151e13846fd872cc21

cheers
