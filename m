Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 03F09DDE30
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 02:45:36 +1000 (EST)
Message-ID: <46965B28.7000703@ru.mvista.com>
Date: Thu, 12 Jul 2007 20:47:36 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: mingo@elte.hu, tglx@linutronix.de
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: revert fix for threaded fasteoi IRQ
	handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<200705171719.34968.sshtylyov@ru.mvista.com>
In-Reply-To: <200705171719.34968.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

> Revert the change to the "fasteoi" type chips as after handle_fasteoi_irq() had
> been fixed, they've become meaningless (and even dangerous -- as was the case
> with Celleb that has been fixed earlier)...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> The patch in question wasn't even initially accepted but then was erroneously
> restored along with the TOD patch.  I've asked to revert it but to no avail,
> so here's the formal patch to revert it at last...

    Now that the -rt patch has been first release in the broken-out version, 
let me tell you that the following 3 patches in the series can be just 
annihilated:

preempt-irqs-ppc-ack-irq-fixups.patch
preempt-irqs-ppc-fix-b5.patch
preempt-irqs-ppc-fix-more-fasteoi.patch

as all that the latter two are doing is undoing the former one.

WBR, Sergei
