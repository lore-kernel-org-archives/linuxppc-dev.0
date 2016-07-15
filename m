Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTvV6pGDzDqyg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:42 +1000 (AEST)
In-Reply-To: <1459762201-183136-1-git-send-email-anna-maria@linutronix.de>
To: Anna-Maria Gleixner <anna-maria@linutronix.de>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Anna-Maria Gleixner <anna-maria@linutronix.de>, rt@linutronix.de
Subject: Re: powerpc/pmac/smp: Add missing FROZEN hotplug notifier transitions
Message-Id: <3rrTvV41TWz9sC4@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-04-04 at 09:30:01 UTC, Anna-Maria Gleixner wrote:
> The FROZEN transitions are used when a CPU suspends/resumes. In case
> of a suspend/resume, only the up prepare (CPU_UP_PREPARE_FROZEN) is
> handled. The error handling transition CPU_UP_CANCELED_FROZEN as well
> as the CPU_ONLINE_FROZEN transition are not handled.
> 
> Masking the switch case action argument with ~CPU_TASKS_FROZEN, to
> handle all FROZEN tasks the same way than the corresponding non frozen
> tasks.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c011926fcbeb9565599f278148

cheers
